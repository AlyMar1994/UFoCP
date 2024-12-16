///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/BatchMeshAlpha.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2xDiffuse+Spec lighting with Alpha blending
    Batching - FOW is done per-pixel so we can batch meshes using this shader together

*/

string _ALAMO_RENDER_PHASE = "Transparent";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = true;


#include "AlamoEngine.fxh"


/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////

// material parameters
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float4 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float  Shininess < string UIName="Shininess"; > = 32.0f;

texture BaseTexture
<
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


/////////////////////////////////////////////////////////////////////
//
// Pixel Shader Code
//
/////////////////////////////////////////////////////////////////////

struct VS_OUTPUT
{
    float4  Pos     : POSITION;
    float4  Diff	: COLOR0;
    float4	Spec	: COLOR1;
    float2  Tex0    : TEXCOORD0;
    float2  TexFOW  : TEXCOORD1;
    float  Fog		: FOG;
};

half4 alpha_ps_main(VS_OUTPUT In,uniform int DO_FOW) : COLOR
{
    half4 texel = tex2D(BaseSampler,In.Tex0);
    
    half4 pixel;
    pixel.rgb = texel.rgb * In.Diff * 2.0f;
    pixel.a = texel.a * In.Diff.a;
    pixel.rgb += In.Spec.rgb;

    if (DO_FOW == 1)
    {
      half4 fow_texel = tex2D(FOWSampler,In.TexFOW);
      pixel.rgb *= fow_texel.rgb;
    }
    
    return pixel;
}

///////////////////////////////////////////////////////
//
// Vertex Shader Code
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float3 Norm : NORMAL;
    float2 Tex  : TEXCOORD0;
};

VS_OUTPUT sph_vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;

	// Lighting
    float3 world_pos = mul(In.Pos, m_world);	
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world)); 
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light * m_lightScale.rgb + Emissive, Diffuse.a * m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);

    // Distance fading
    Out.Diff.a *= Compute_Distance_Fade(Out.Pos.xyz);
    
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    // Fog-of-War Texture Coordinates
    Out.TexFOW.x = dot(m_FOWTexU,float4(world_pos,1));
    Out.TexFOW.y = dot(m_FOWTexV,float4(world_pos,1));

    return Out;
}

vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
pixelshader alpha_ps_main_bin = compile ps_1_1 alpha_ps_main( 1 );
pixelshader max_alpha_ps_main_bin = compile ps_1_1 alpha_ps_main( 0 );

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
    		ZWriteEnable=false;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
        SB_END        

        // shaders
        VertexShader = (sph_vs_main_bin);
        PixelShader  = (max_alpha_ps_main_bin);

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
    		ZWriteEnable=false;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;
    		
        SB_END        

        // shaders
        VertexShader = (sph_vs_main_bin);
        PixelShader  = (alpha_ps_main_bin);

    }  
}

technique sph_t1
<
	string LOD="FIXEDFUNCTION";
>
{
    pass sph_t1_p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable = FALSE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;
    		
            // fixed function vertex pipeline
            Lighting = true;
    
            TexCoordIndex[1] = CAMERASPACEPOSITION;
            TextureTransformFlags[1] = COUNT3;

            // fixed function pixel pipeline
            ColorOp[0]=MODULATE2X;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=MODULATE;
    		AlphaArg1[0]=TEXTURE;
    		AlphaArg2[0]=DIFFUSE;
    		
    		ColorOp[1]=MODULATE;
    		ColorArg1[1]=CURRENT;
    		ColorArg2[1]=TEXTURE;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=CURRENT;

    		ColorOp[2]=DISABLE;
    		AlphaOp[2]=DISABLE;

        SB_END        

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
            
		MaterialAmbient = (Diffuse);
		MaterialDiffuse = (Diffuse * m_lightScale);
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 1.0f;
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
    }  
    pass sph_t1_p1
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


