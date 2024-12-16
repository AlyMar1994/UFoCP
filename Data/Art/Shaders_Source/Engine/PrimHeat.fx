///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PrimHeat.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse lighting with alpha blending.  
	Initial use is for decals whose lighting needs to match the terrain lighting.  This FX
	file purposely does not set textures since the "primitive" rendering system allows the
	user to set the textures.
	
*/

string _ALAMO_RENDER_PHASE = "Heat";	// This shader should only be used in the "heat" render phase

#include "../AlamoEngine.fxh"


/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////
texture SceneTexture : HEAT_TEXTURE;

sampler BaseSampler : register(s0);
sampler SceneSampler : register(s1) = 
sampler_state 
{ 
    Texture = (SceneTexture); 
};     

float DistortionAmount = 0.01;

/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////
struct VS_INPUT_MESH
{
    float4 Pos  : POSITION;
    float4 Color: COLOR0;
    float2 Tex  : TEXCOORD0;
};

struct VS_OUTPUT
{
    float4  Pos     : POSITION;
    float2  Tex0    : TEXCOORD0;
    float3  Tex1    : TEXCOORD1;
    float   Fog		: FOG;
};

struct VS_OUTPUT11
{
    float4  Pos     : POSITION;
    float2  Tex0    : TEXCOORD0;
    float2  Tex1    : TEXCOORD1;
    float2  Tex2    : TEXCOORD2;
    float   Fog		: FOG;
};


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////
VS_OUTPUT vs_main_ati(VS_INPUT_MESH In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;
    
    // Screen space mapping for Tex1
    Out.Tex1.x = Out.Pos.x/Out.Pos.w;
    Out.Tex1.y = -Out.Pos.y/Out.Pos.w;
    Out.Tex1.xy = 0.5f*Out.Tex1.xy + 0.5f;
    
    // offset by half-pixel so we line up texels to pixels
    Out.Tex1.x += m_resolutionConstants.z;      
    Out.Tex1.y += m_resolutionConstants.w;      
    Out.Tex1.z = In.Color.a;
    
	// Output fog
	Out.Fog = 1.0f; //heat rendering ignores fog (just distorting the existing image)

    return Out;
}

float4 ps_main_ati(VS_OUTPUT In) : COLOR
{
    float4 base_texel = tex2D(BaseSampler,In.Tex0);
    float2 distort = 2.0f * (base_texel.xy - 0.5f);
    float attenuation = base_texel.a * In.Tex1.z;
    float4 out_texel = tex2D(SceneSampler,In.Tex1.xy + attenuation*DistortionAmount * distort);
    return out_texel;	
}


VS_OUTPUT11 vs_main_11(VS_INPUT_MESH In)
{
    VS_OUTPUT11 Out = (VS_OUTPUT11)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;
    
    // Screen space mapping for Tex1
    Out.Tex1.x = Out.Pos.x/Out.Pos.w;
    Out.Tex1.y = -Out.Pos.y/Out.Pos.w;
    Out.Tex1.xy = 0.5f*Out.Tex1.xy + 0.5f;
    
    // offset by half-pixel so we line up texels to pixels
    Out.Tex1.x += m_resolutionConstants.z;      
    Out.Tex1.y += m_resolutionConstants.w;      

    Out.Tex2 = Out.Tex0;
    
	// Output fog
	Out.Fog = 1.0f; //heat rendering ignores fog (just distorting the existing image)

    return Out;
}

pixelshader ps_main_11_bin = asm
{
	ps.1.1
	
	tex t0;			// bump map for EMBM
    texbem t1,t0 	// perturbed reflection texel
    tex t2;         // base texture again to get alpha mask

    mov r0,t1;
    mov r0.a,t2.a;

};

vertexshader vs_main_ati_bin = compile vs_1_1 vs_main_ati();
pixelshader ps_main_ati_bin = compile ps_1_4 ps_main_ati();

vertexshader vs_main_11_bin = compile vs_1_1 vs_main_11();
//pixelshader ps_main_11_bin = compile ps_1_1 ps_main_11();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique t2
<
	string LOD="DX8ATI";
>
{
    pass t2_p0
    {
        SB_START

       		AlphaBlendEnable = FALSE;
    		AlphaTestEnable = FALSE;
    
        SB_END        

        VertexShader = (vs_main_ati_bin); 
        PixelShader  = (ps_main_ati_bin); 

    }  
}

technique t1
<
    string LOD="DX8";
>
{
    pass t1_p0
    {
        SB_START

       		AlphaBlendEnable = TRUE;
            SrcBlend = SRCALPHA;
            DestBlend = INVSRCALPHA;
    		AlphaTestEnable = FALSE;
    
            BumpEnvMat00[1] = 0.02f;
            BumpEnvMat01[1] = 0.0f;
            BumpEnvMat10[1] = 0.0f;
            BumpEnvMat11[1] = 0.01f;
            
        SB_END        

        VertexShader = (vs_main_11_bin); 
        PixelShader  = (ps_main_11_bin); 

        Texture[1]=(SceneTexture);
    }
}
    
/*
technique t0
<
	string LOD="FIXEDFUNCTION";
>
{
	pass t0_p0
	{
        SB_START

    		// fixed function vertex pipeline
    		Lighting = FALSE;
    		
    		// fixed function pixel pipeline
    		ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;

        SB_END        

        // no shaders
        VertexShader = NULL;
        PixelShader = NULL;
        
	}
}
*/

