///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Grass.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/09/12 08:51:59 $
//          $Revision: #2 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2xDiffuse+Spec lighting with Alpha blending
    Alpha of the vertex is scaled by dot(N,V) so that edge on polygons fade out
	
*/

string _ALAMO_RENDER_PHASE = "SemiOpaque";
string _ALAMO_VERTEX_PROC = "Grass";    
string _ALAMO_VERTEX_TYPE = "alD3dVertGrass";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = true;
bool _ALAMO_BILLBOARDS = true;

#include "AlamoEngine.fxh"


#define GEOMETRY_MODS_DISABLED  0
#define GEOMETRY_MODS_ENABLED   1


/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////

// material parameters
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float4 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f };
float4 Diffuse1 < string UIName="Diffuse1"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f };
float BendScale < string UIName="BendScale"; > = 1.0f;


texture BaseTexture
<
	string Name = "gh_gravel00.jpg";
	string UIName = "BaseTexture";
	string UIType = "bitmap";
	string UIHelp = "Diffuse, Alpha";
>;

sampler BaseSampler = sampler_state 
{
    texture = (BaseTexture);
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};


sampler FOWSampler = sampler_state
{
    texture = (m_FOWTexture);
};

///////////////////////////////////////////////////////
//
// Shader Programs
//
// Properties of the grass shader:
// - vertex normals are always (0,0,1)
// - x-y vertex positions are perturbed using a combination
//   of sine waves
// - z-axis billboarding in the vertex shader, build all
//   polygons in the x-z plane and the shader will spin
//   them about their z-axis to face the camera.
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float2 Tex  : TEXCOORD0;
    float2 ClumpCenter : TEXCOORD1;    // x,y center of each billboard polygon
};

struct VS_OUTPUT
{
    float4  Pos     : POSITION;
    float4  Diff	: COLOR0;
    float2  Tex0    : TEXCOORD0;
    float2  TexFOW  : TEXCOORD1;        // FOW texture coordinate
    float   Fog		: FOG;
};


// TODO: Optimize this once we get the bottleneck off the cpu!!!

VS_OUTPUT grass_vs_main(VS_INPUT In,uniform int DO_GEOMETRY_MODS)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;
    Out.Tex0 = Unpack_UV(In.Tex);

    /////////////////////////////////////////////////////////
    // z-axis billboarding
    // 'up' is constrained to 0,0,1, the x axis is the normalized cross product of the
    // view direction vector and the up vector.  Since 'up' is 0,0,1 we can skip
    // some math here. 
    /////////////////////////////////////////////////////////
    float3 view_vec = (float3)m_worldViewInv[2];          
    float3 x_vec = float3(-view_vec.y,view_vec.x,0.0f);   // left-handed perp?
    x_vec = normalize(x_vec);
    
    // Now we can build the billboard transform that rotates the xy offset for each vertex.
    float2x2 billboard_tm;
    billboard_tm[0] = float2(x_vec.x,x_vec.y);
    billboard_tm[1] = float2(-x_vec.y,x_vec.x);           // left-handed 2d perp again?

    /////////////////////////////////////////////////////////
    // Wind effects
    /////////////////////////////////////////////////////////
    float3 wind_dir = m_windGrassVector.xyz;
    float wind_speed = m_windGrassVector.w; 

    // Time is scaled based on wind strength so that the grass waves faster in a strong wind
    // In StarWars 10.0 is a strong wind.  
    const float FAST_WIND_SPEED = 10.0f;
    const float MIN_TIME_SCALE = 0.125f;
    const float MAX_TIME_SCALE = 1.0f;
    const float SPATIAL_WAVELENGTH = 1.0f/20.0f;
    
    // Compute 'anim_parameter' which is going to oscillate between 0..1 based on time, position, and wind speed
    float normalized_wind_speed = BendScale * wind_speed * (1.0f / FAST_WIND_SPEED);
    float time_scale = MIN_TIME_SCALE + (MAX_TIME_SCALE - MIN_TIME_SCALE) * normalized_wind_speed;
    float anim_parameter = 0.5f + 0.5f*sin(6.28*frac(time_scale*m_time + SPATIAL_WAVELENGTH*In.Pos.x + SPATIAL_WAVELENGTH*In.Pos.y));

    // The amount of bend is biased and scaled based on wind strength too.
    const float BEND_MIN = 10.0f;
    const float BEND_MAX = 20.5f;
    const float BEND_BIAS = 10.0f;

    float bend_bias = BEND_BIAS * normalized_wind_speed;
    float bend_anim_scale = BEND_MIN + (BEND_MAX - BEND_MIN) * normalized_wind_speed;
    
    /////////////////////////////////////////////////////////
    // Billboard and distort the geometry
    /////////////////////////////////////////////////////////
    if (DO_GEOMETRY_MODS)
    {
        float2 xy_center = In.ClumpCenter; 
        float2 xy_offset = In.Pos - xy_center;
    
        float2 xy_pos = xy_center + mul(xy_offset,billboard_tm); 
        float4 bb_obj_pos = float4(xy_pos,In.Pos.z,1.0f); 
    
        float4 world_pos = mul(bb_obj_pos,m_world);
        world_pos.xyz += (1.0f - Out.Tex0.y) * (bend_bias + bend_anim_scale*anim_parameter) * wind_dir;

        // Fog-of-War Texture Coordinates
        Out.TexFOW.x = dot(m_FOWTexU,world_pos);
        Out.TexFOW.y = dot(m_FOWTexV,world_pos);

        Out.Pos = mul(world_pos,m_viewProj);
    }
    else
    {
        float4 world_pos = mul(In.Pos,m_world);
        
        // Fog-of-War Texture Coordinates
        Out.TexFOW.x = dot(m_FOWTexU,world_pos);
        Out.TexFOW.y = dot(m_FOWTexV,world_pos);

        Out.Pos = mul(In.Pos,m_viewProj);
    }

    /////////////////////////////////////////////////////////
    // Lighting - for grass all object space vertex normals are treated as (0,0,1)
    /////////////////////////////////////////////////////////
   	float3 world_normal = normalize(mul(float3(0,0,1), (float3x3)m_world)); // TODO: optimize this!
   	float3 diffuse_light = Sph_Compute_Diffuse_Light_All(world_normal);
    float3 diffuse_mtl = lerp(Diffuse.rgb,Diffuse1.rgb,anim_parameter);
    diffuse_mtl *= m_lightScale.rgb;
    
    Out.Diff = float4(diffuse_light * diffuse_mtl + Emissive, Diffuse.a * m_lightScale.a);
    Out.Diff.a *= Compute_Distance_Fade(Out.Pos.xyz);
    
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

float4 grass_ps_main(VS_OUTPUT In) : COLOR
{
//return half4(1,0,0,1);
//return In.Diff.a;

    float4 texel = tex2D(BaseSampler,In.Tex0);
    float4 fow_texel = tex2D(FOWSampler,In.TexFOW);

    // (gth) ok the instructions here could be much more compact/simple but for some reason
    // arranging them this way gives the desired result while other combinations make the
    // grass more transparent or give compiler warnings about literals being clamped to +/-1
    // BE CAREFUL if you touch this code!
    half4 pixel = texel * fow_texel; 
    pixel.rgb = pixel.rgb * In.Diff.rgb * 2.0f; 
    pixel.a = texel.a * In.Diff.a;

    return pixel;
}

vertexshader max_grass_vs_main_bin = compile vs_1_1 grass_vs_main(GEOMETRY_MODS_DISABLED);
vertexshader grass_vs_main_bin = compile vs_1_1 grass_vs_main(GEOMETRY_MODS_ENABLED);
pixelshader grass_ps_main_bin = compile ps_2_0 grass_ps_main();

///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique max_viewport
{
    pass max_viewport_p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable=true;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
            // shaders
            VertexShader = (max_grass_vs_main_bin);
            PixelShader  = (grass_ps_main_bin);

        SB_END        
    }  
}

technique sph_t0
<
	string LOD="DX8";
>
{
    pass sph_t0_p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable=TRUE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = TRUE;
    		AlphaRef = 0x00000008;
    		AlphaFunc = Greater;
    
            // shaders
            VertexShader = (grass_vs_main_bin);
            PixelShader  = (grass_ps_main_bin);

        SB_END        
    }  

    pass sph_t0_p1
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START
            MinFilter[0]=LINEAR;
            MagFilter[0]=LINEAR;
        SB_END        
    }

}

/*  NO FIXED FUNCTION GRASS...  (can't billboard on GPU, and old cards can't handle the fillrate anyway)
technique sph_t1
<
	string LOD="FIXEDFUNCTION";
>
{
    pass sph_t1_p0 
    {
		// blend mode
		ZWriteEnable = FALSE    ;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = TRUE;
		DestBlend = INVSRCALPHA;
		SrcBlend = SRCALPHA;
		AlphaTestEnable = FALSE;
		
        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
        
        // fixed function vertex pipeline
        Lighting = true;

		MaterialAmbient = (Diffuse0);
		MaterialDiffuse = (Diffuse0);
		MaterialSpecular = (float4(0,0,0,0));
		MaterialEmissive = (Emissive);
		MaterialPower = 1.0f;

        // fixed function pixel pipeline
        Texture[0]=(BaseTexture);

        ColorOp[0]=MODULATE2X;
		ColorArg1[0]=TEXTURE;
		ColorArg2[0]=DIFFUSE;
		AlphaOp[0]=MODULATE;
		AlphaArg1[0]=TEXTURE;
		AlphaArg2[0]=DIFFUSE;
		
		ColorOp[1]=DISABLE;
		AlphaOp[1]=DISABLE;
    }  
}
*/
