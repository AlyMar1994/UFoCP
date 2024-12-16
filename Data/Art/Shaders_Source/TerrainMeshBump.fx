///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/TerrainMeshBump.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse+Spec lighting
	First directional light does dot3 diffuse bump mapping.
	Spec is modulated by alpha channel of the texture (gloss)
	Applys terrain cloud shadows
	
*/

string _ALAMO_RENDER_PHASE = "TerrainMesh";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2U3U3";
bool _ALAMO_TANGENT_SPACE = true;
bool _ALAMO_SHADOW_VOLUME = false;
	

#include "AlamoEngine.fxh"


/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float3 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; bool FowDimAllowed = false; > = {1.0f, 1.0f, 1.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; bool FowDimAllowed = false; > = {1.0f, 1.0f, 1.0f };
float  Shininess < string UIName="Shininess"; > = 32.0f;

texture BaseTexture 
< 
	string UIName = "BaseTexture";
	string UIType = "bitmap"; 
>;

texture NormalTexture
<
	string UIName = "NormalTexture";
	string UIType = "bitmap";
>;



stateblock TerrainMeshBumpStates = stateblock_state
{
    // blend mode
    ZWriteEnable = true;
    ZFunc = LESSEQUAL;
    DestBlend = ZERO;
    SrcBlend = ONE;
    AlphaBlendEnable = false; 
};



/////////////////////////////////////////////////////////////////////
//
// Samplers
//
/////////////////////////////////////////////////////////////////////
sampler BaseSampler = sampler_state
{
    texture = (BaseTexture);
};

sampler NormalSampler = sampler_state
{
    texture = (NormalTexture);
};

sampler CloudSampler = sampler_state 
{
    texture = (m_cloudTexture); // from AlamoEngine.fxh
};

sampler FOWSampler = sampler_state
{
    texture = (m_FOWTexture);   // from AlamoEngine.fxh
};

/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////
struct VS_INPUT_MESH
{
    float4 Pos  : POSITION;
    float3 Normal : NORMAL;
    float2 Tex  : TEXCOORD0;
    float3 Tangent : TANGENT0;
    float3 Binormal : BINORMAL0;
    
};

struct VS_OUTPUT_SPEC
{
    float4  Pos     : POSITION;
    float4  Diff	: COLOR0;
    float4	Spec	: COLOR1;
    float2  Tex0    : TEXCOORD0;	// base texture
    float2	Tex1	: TEXCOORD1;	// normal map
    float2  Tex2	: TEXCOORD2; 	// cloud shadow
    float2  TexFOW  : TEXCOORD3;    // fog-of-war texture
	float3  LightVector: TEXCOORD4;
	float3  HalfAngleVector: TEXCOORD5;
	float  Fog		: FOG;
};

struct VS_OUTPUT_GLOSS
{
    float4  Pos     : POSITION;
    float4  Diff	: COLOR0;
    float4	Spec	: COLOR1;
    float2  Tex0    : TEXCOORD0;	// base texture
    float2  Tex1	: TEXCOORD1; 	// cloud shadow
    float2  TexFOW  : TEXCOORD2;    // fog-of-war texture
	float  Fog		: FOG;
};


/////////////////////////////////////////////////////////////////////
//
// Pixel Shaders
//
/////////////////////////////////////////////////////////////////////
float4 bump_spec_ps_main(VS_OUTPUT_SPEC In): COLOR
{
	float4 base_texel = tex2D(BaseSampler,In.Tex0);
	float4 normal_texel = tex2D(NormalSampler,In.Tex1);
	float4 cloud_texel = tex2D(CloudSampler,In.Tex2);
    float4 fow_texel = tex2D(FOWSampler,In.TexFOW);
    	
    // compute lighting
	float3 surface_color = base_texel.rgb;
	float3 norm_vec = 2.0f*(normal_texel.rgb - 0.5f);
	float3 light_vec = 2.0f*(In.LightVector - 0.5f);
	float3 half_vec = 2.0f*(In.HalfAngleVector - 0.5f);
	//half_vec = normalize(half_vec);
	//light_vec = normalize(light_vec);
	
	float ndotl = dot(norm_vec,light_vec);
	float ndoth = saturate(dot(norm_vec,half_vec));
	
	if (ndotl < 0.0f) ndotl = -0.25*ndotl;
	
	float3 diff = surface_color * (ndotl*Diffuse*m_light0Diffuse + In.Diff.rgb) * 2.0;
	float3 spec = m_light0Specular*Specular*pow(ndoth,16)*base_texel.a * 2.0;
	float3 final_color = (diff + spec) * cloud_texel.rgb * fow_texel.rgb;
    return float4(final_color,In.Diff.a);
}

float4 gloss_ps_main(VS_OUTPUT_GLOSS In) : COLOR
{
	// sample the textures
    float4 base_texel = tex2D(BaseSampler,In.Tex0);
	float4 cloud_texel = tex2D(CloudSampler,In.Tex1);
	float4 fow_texel = tex2D(FOWSampler,In.TexFOW);
    
	// lerp the colorization
	float3 surface_color = base_texel.rgb;
	
	// put it all together
	float3 diffuse = surface_color * In.Diff * 2.0;
	float3 specular = In.Spec * base_texel.a * 2.0;
	float3 final_color = (diffuse + specular) * cloud_texel.rgb * fow_texel.rgb;
    return float4(final_color,1);
}



///////////////////////////////////////////////////////
//
// Vertex Shaders
//
///////////////////////////////////////////////////////

VS_OUTPUT_SPEC sph_bump_spec_vs_main(VS_INPUT_MESH In)
{
	VS_OUTPUT_SPEC Out = (VS_OUTPUT_SPEC)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;                                       
	Out.Tex1 = In.Tex;
	
	// Compute the tangent-space light vector and half-angle vector for per-pixel lighting
	// Note that we are doing everything in object space here.
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(In.Tangent,In.Binormal,In.Normal);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);
	Out.HalfAngleVector = Compute_Tangent_Space_Half_Vector(In.Pos,m_eyePosObj,m_light0ObjVector,to_tangent_matrix);

	// Fill lighting is applied per-vertex.  This must be computed in
	// world space for spherical harmonics to work.
	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse + Emissive, m_lightScale.a);
    Out.Spec = float4(0,0,0,1);

	// Cloud Texture coordinates
	Out.Tex2.x = dot(m_cloudTexU,float4(world_pos,1.0));
	Out.Tex2.y = dot(m_cloudTexV,float4(world_pos,1.0));

    // Fog-of-War Texture Coordinates
    Out.TexFOW.x = dot(m_FOWTexU,float4(world_pos,1.0));
    Out.TexFOW.y = dot(m_FOWTexV,float4(world_pos,1.0));
    
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	
    return Out;
}


VS_OUTPUT_GLOSS sph_gloss_vs_main(VS_INPUT_MESH In)
{
	VS_OUTPUT_GLOSS Out = (VS_OUTPUT_GLOSS)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;                                       
	Out.Tex1 = In.Tex;

    // Vertex lighting, diffuse fill lights + spec for main light
	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse + Emissive, m_lightScale.a);
    Out.Spec = float4(spec_light * Specular, 1);

	// Cloud Texture coordinates
	Out.Tex1.x = dot(m_cloudTexU,float4(world_pos,1.0));
	Out.Tex1.y = dot(m_cloudTexV,float4(world_pos,1.0));

    // Fog-of-War Texture Coordinates
    Out.TexFOW.x = dot(m_FOWTexU,float4(world_pos,1.0));
    Out.TexFOW.y = dot(m_FOWTexV,float4(world_pos,1.0));
    
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	
    return Out;
}

// Compiled shader programs
vertexshader sph_bump_spec_vs_main_bin = compile vs_1_1 sph_bump_spec_vs_main();
vertexshader sph_gloss_vs_main_bin = compile vs_1_1 sph_gloss_vs_main();
pixelshader bump_spec_ps_main_bin = compile ps_2_0 bump_spec_ps_main();
pixelshader gloss_ps_main_bin = compile ps_1_1 gloss_ps_main();



//////////////////////////////////////
// Techniques follow
//////////////////////////////////////

technique max_viewport
{
    pass max_viewport_p0
    {
        VertexShader = (sph_bump_spec_vs_main_bin);
        PixelShader  = (bump_spec_ps_main_bin);
        StateBlock = (TerrainMeshBumpStates);
    }  
}


technique sph_t2
<
	string LOD="DX9";
>
{
    pass sph_t2_p0
    {
        VertexShader = (sph_bump_spec_vs_main_bin);
        PixelShader  = (bump_spec_ps_main_bin);
        StateBlock = (TerrainMeshBumpStates);
    }  
}

technique sph_t1
<
	string LOD="DX8";
>
{
    pass sph_t1_p0
    {
        VertexShader = (sph_gloss_vs_main_bin);
        PixelShader  = (gloss_ps_main_bin);
        StateBlock = (TerrainMeshBumpStates);
    }  
}

technique sph_t0
<
	string LOD="FIXEDFUNCTION";
>
{
    pass sph_t0_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    		
            // fixed function pixel pipeline
    		Lighting = true;
    		
            TexCoordIndex[1] = CAMERASPACEPOSITION;
            TextureTransformFlags[1] = COUNT3;
    		
    		ColorOp[0]=MODULATE2X;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
    		ColorOp[1]=MODULATE;
    		ColorArg1[1]=CURRENT;
    		ColorArg2[1]=TEXTURE;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=CURRENT;
    		
    		ColorOp[2]=DISABLE;
    		AlphaOp[2]=DISABLE;
    

        SB_END        

        VertexShader = NULL;
        PixelShader  = NULL;
		Texture[0]=(BaseTexture);
        Texture[1]=(m_FOWTexture);
		TextureTransform[1] = 
		(
			mul(
				m_viewInv,
				float4x4(
					float4(m_FOWTexU.x,m_FOWTexV.x,0,0),
					float4(m_FOWTexU.y,m_FOWTexV.y,0,0),
					float4(m_FOWTexU.z,m_FOWTexV.z,1,0),
					float4(m_FOWTexU.w,m_FOWTexV.w,0,1))
				)
		);
		MaterialAmbient = (Diffuse);
		MaterialDiffuse = (Diffuse);
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;

    }  
    
    pass sph_t0_p0
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            TexCoordIndex[1] = 1;
            TextureTransformFlags[1]=disable;

        SB_END        
    }
}

