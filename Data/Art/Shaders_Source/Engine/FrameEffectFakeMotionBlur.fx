///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/FrameEffectFakeMotionBlur.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shader used to implement motion blur.  Simply alpha blends the previous frame
    with the current frame.

*/

#include "../AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Parameters
//
/////////////////////////////////////////////////////////////////////

texture PrevFrameTexture;
float BlendFactor = 0.95f; 
float RadialBlur = 0.0f;

sampler PrevFrameSampler : register(s0) = 
sampler_state 
{ 
    Texture = (PrevFrameTexture); 
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
    float  Fog		: FOG;
};


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////


VS_OUTPUT vs_main_11(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    Out.Pos.xy = In.Pos.xy;
	Out.Pos.z = 0.5f;
	Out.Pos.w = 1.0f;
	Out.Tex0 = float2(0.5f, -0.5f) * In.Pos.xy + float2(0.5f,0.5f);
    Out.Tex0.x += m_resolutionConstants.z;  // half-pixel
    Out.Tex0.y += m_resolutionConstants.w;

    // Radial blur (0 = no radial blur, 1 = Max radial blur
    Out.Tex0 = (1.0f - 0.3f*RadialBlur) * (Out.Tex0 - float2(0.5,0.5)) + float2(0.5,0.5); 
    
	Out.Fog = 1.0f; //no fog please

    return Out;
}


float4 ps_main_11(VS_OUTPUT In) : COLOR
{
    float4 prev_frame_pixel = tex2D(PrevFrameSampler,In.Tex0);
    prev_frame_pixel.a = BlendFactor;
    
    return prev_frame_pixel;
}


vertexshader vs_main_11_bin = compile vs_1_1 vs_main_11();
pixelshader ps_main_11_bin = compile ps_1_1 ps_main_11();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////
technique t0
<
	string LOD="DX8";	// minmum LOD
>
{
    pass t0_p0
    {
        SB_START

        	AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		//AlphaTestEnable = FALSE;
    		ZWriteEnable = FALSE;
    		ZFunc = ALWAYS;

        SB_END

        VertexShader = (vs_main_11_bin); 
        PixelShader  = (ps_main_11_bin); 
	}
}
