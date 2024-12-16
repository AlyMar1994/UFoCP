///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/TerrainMeshGloss.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse+Spec lighting
	Spec is modulated by alpha channel of the texture (gloss)
	Terrain clouds are multiplied in 
	
*/

string _ALAMO_RENDER_PHASE = "TerrainMesh";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
	

#include "AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////
// material parameters
float4 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f, 1.0f };
float4 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; bool FowDimAllowed = false; > = {1.0f, 1.0f, 1.0f, 1.0f };
float4 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; bool FowDimAllowed = false; > = {1.0f, 1.0f, 1.0f, 1.0f };
float  Shininess < string UIName="Shininess"; > = 32.0f;

texture BaseTexture
<
	string UIName = "BaseTexture";
	string UIType = "bitmap";
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

sampler CloudSampler = sampler_state 
{
    texture = (m_cloudTexture);
};

sampler FOWSampler = sampler_state
{
    texture = (m_FOWTexture);
};


stateblock TerrainMeshGlossStates = stateblock_state
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
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////

struct VS_INPUT_MESH
{
    float4 Pos  : POSITION;
    float3 Norm : NORMAL;
    float2 Tex  : TEXCOORD0;
};

struct VS_OUTPUT
{
    float4  Pos     : POSITION;
    float4  Diff	: COLOR0;
    float4	Spec	: COLOR1;
    float2  Tex0    : TEXCOORD0;
    float2	Tex1	: TEXCOORD1;
    float2  TexFOW  : TEXCOORD2;
    float  	Fog		: FOG;
};

///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

VS_OUTPUT sph_vs_main(VS_INPUT_MESH In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;

	// Given world-space position and normal, compute the shading
    float3 world_pos = mul(In.Pos, m_world);	
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world)); 
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light + Emissive, m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);

	// Cloud texture coordinates
	Out.Tex1.x = dot(m_cloudTexU,float4(world_pos,1.0));
	Out.Tex1.y = dot(m_cloudTexV,float4(world_pos,1.0));

    // Fog-of-War Texture Coordinates
    Out.TexFOW.x = dot(m_FOWTexU,float4(world_pos,1.0));
    Out.TexFOW.y = dot(m_FOWTexV,float4(world_pos,1.0));
    
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

float4 ps_main(VS_OUTPUT In) : COLOR
{
	float4 base_texel = tex2D(BaseSampler,In.Tex0);
	float4 cloud_texel = tex2D(CloudSampler,In.Tex1);
    float4 fow_texel = tex2D(FOWSampler,In.TexFOW);
    
	float3 diffuse = In.Diff.rgb * base_texel.rgb * 2.0;
	float3 specular = In.Spec.rgb * base_texel.a * 2.0;
   	float3 final_color = (diffuse + specular) * cloud_texel.rgb * fow_texel.rgb;
    return float4(final_color,1);
}

vertexshader sph_vs_main_1_1 = compile vs_1_1 sph_vs_main();
pixelshader ps_main_1_1 = compile ps_1_1 ps_main();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique max_viewport
{
    pass max_viewport_p0
    {
        VertexShader = (sph_vs_main_1_1); 
        PixelShader  = (ps_main_1_1); 
        StateBlock = (TerrainMeshGlossStates);
    }  
}

technique sph_t1
<
	string LOD="DX8";
>
{
    pass sph_t1_p0
    {
        VertexShader = (sph_vs_main_1_1); 
        PixelShader  = (ps_main_1_1); 
        StateBlock = (TerrainMeshGlossStates);
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
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    		
            // fixed function pixel pipeline
    		Lighting=true;
    		 
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

        // shaders
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

