///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/SceneHeat.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shader used to implement Heat distortions.  
    This shader is used after rendering the main scene is complete and expects two textures.
    The first texture is an image of the scene and the second texture contains all of the
    distortions composited together.  We render a fullscreen quad using this shader.

*/

#include "../AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Parameters
//
/////////////////////////////////////////////////////////////////////

texture SceneTexture;
texture DistortionTexture;
float DistortionAmount = 0.25f;

sampler DistortionSampler : register(s0) = 
sampler_state 
{ 
    Texture = (DistortionTexture); 
};

sampler SceneSampler : register(s1) = 
sampler_state 
{ 
    Texture = (SceneTexture); 
};     


/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////
struct VS_INPUT
{
    float2 Pos  : POSITION;
};

struct VS_OUTPUT
{
	float4 Pos		: POSITION;
	float2 Tex0		: TEXCOORD0;
	float2 Tex1		: TEXCOORD1;
    float  Fog		: FOG;
};


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////


VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    Out.Pos.xy = In.Pos.xy;

	Out.Pos.z = 0.5f;
	Out.Pos.w = 1.0f;
	Out.Tex0 = float2(0.5f, -0.5f) * In.Pos.xy + float2(0.5f,0.5f);

    Out.Tex0.x -= m_resolutionConstants.z;  // half pixel offset
    Out.Tex0.y -= m_resolutionConstants.w;

    Out.Tex1 = Out.Tex0;
    Out.Tex1.x += 10.0*m_resolutionConstants.z;
    Out.Tex1.y += 10.0*m_resolutionConstants.w;
    
    // Compensate for the constant offset imposed by texbem
    Out.Tex1 -= float2(DistortionAmount/2.0,DistortionAmount/2.0);
    
	Out.Fog = 1.0f; //no fog please

    return Out;
}

VS_OUTPUT vs_main_ati(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    Out.Pos.xy = In.Pos.xy;

	Out.Pos.z = 0.5f;
	Out.Pos.w = 1.0f;
	Out.Tex0 = float2(0.5f, -0.5f) * In.Pos.xy + float2(0.5f,0.5f);

    // (gth) 8/18/2006 - ati x600 gets perfect mapping with this code
    Out.Tex0.x -= m_resolutionConstants.z * 1.0f;  // half-pixel
    Out.Tex0.y -= m_resolutionConstants.w * 0.5f;  // but a quarter pixel in Y??

    Out.Tex1 = Out.Tex0;
    Out.Tex1.x += 10.0*m_resolutionConstants.z;
    Out.Tex1.y += 10.0*m_resolutionConstants.w;
    
    // Compensate for the constant offset imposed by texbem
    Out.Tex1 -= float2(DistortionAmount/2.0,DistortionAmount/2.0);
    
	Out.Fog = 1.0f; //no fog please

    return Out;
}



half4 ps_main(VS_OUTPUT In) : COLOR
{
    half4 distortion_pixel = tex2D(DistortionSampler,In.Tex0);
    half4 distortion = DistortionAmount * 2.0 * (distortion_pixel - 0.5);
    half4 scene_pixel = tex2D(SceneSampler,In.Tex0 + distortion.xy);

    return scene_pixel; 
}


pixelshader ps_main_11_bin = asm
{
	ps.1.1
	
	tex t0;			// bump map for EMBM
    texbem t1,t0   	// perturbed reflection texel
    mov r0,t1;
};


vertexshader vs_main_bin = compile vs_1_1 vs_main();
vertexshader vs_main_ati_bin = compile vs_1_1 vs_main_ati();
pixelshader ps_main_bin = compile ps_2_0 ps_main();



///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////
technique t0
<
	string LOD="DX9";	// minmum LOD  (unfortunately conditional texture reads from non-pow2 textures is unreliable on dx8 HW)
    int VENDOR_FILTER_0 = 0x1002;     // don't use on ati hardware
>
{
    pass t0_p0
    {
        SB_START

        	AlphaBlendEnable = FALSE;
    		AlphaTestEnable = FALSE;
    		ZWriteEnable = FALSE;
    		ZFunc = ALWAYS;
    
        SB_END        

        VertexShader = (vs_main_bin); 
        PixelShader  = (ps_main_bin); 
        
        Texture[0] = (DistortionTexture);
        Texture[1] = (SceneTexture);

        AddressU[1] = CLAMP;
        AddressV[1] = CLAMP;

        BumpEnvMat00[1] = (DistortionAmount);
        BumpEnvMat01[1] = 0.0f;
        BumpEnvMat10[1] = 0.0f;
        BumpEnvMat11[1] = (DistortionAmount);
    
	}

    pass t0_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        AddressU[1] = WRAP;
        AddressV[1] = WRAP;
    }
        
}

technique t1_ati
<
	string LOD="DX9";	// minmum LOD  (unfortunately conditional texture reads from non-pow2 textures is unreliable on dx8 HW)
>
{
    pass t1_p0
    {
        SB_START

        	AlphaBlendEnable = FALSE;
    		AlphaTestEnable = FALSE;
    		ZWriteEnable = FALSE;
    		ZFunc = ALWAYS;
    
        SB_END        

        VertexShader = (vs_main_ati_bin); 
        PixelShader  = (ps_main_bin); 
        
        Texture[0] = (DistortionTexture);
        Texture[1] = (SceneTexture);

        AddressU[1] = CLAMP;
        AddressV[1] = CLAMP;

        BumpEnvMat00[1] = (DistortionAmount);
        BumpEnvMat01[1] = 0.0f;
        BumpEnvMat10[1] = 0.0f;
        BumpEnvMat11[1] = (DistortionAmount);
    
	}

    pass t1_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        AddressU[1] = WRAP;
        AddressV[1] = WRAP;
    }
        
}
