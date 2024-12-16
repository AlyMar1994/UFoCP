///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars/Art/Shaders/RSkinBumpColorize.fx $
//          $Author: Greg_Hjelstrom $
//          $DateTime: 2004/04/14 15:29:37 $
//          $Revision: #3 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shared HLSL code for the Alpha shaders

	2xDiffuse+Spec lighting with Alpha blending

*/

#include "AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////

// material parameters

float4 Color < string UIName="Color"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f };

float EdgeBrightness < string UIName="EdgeBrightness"; float UIMin = 0.0; float UIMax = 1.0; > = 0.5f;

float BaseUVScale < string UIName="BaseUVScale"; float UIMin = 0.0; float UIMax = 100.0; > = 20.0f;
float WaveUVScale < string UIName="WaveUVScale"; float UIMin = 0.0; float UIMax = 100.0; > = 1.0f;
float DistortUVScale < string UIName="DistortUVScale"; float UIMin = 0.0; float UIMax = 100.0; > = 1.0f;

float BaseUVScrollRate < string UIName="BaseUVScrollRate"; float UIMin = -10.0; float UIMax = 10.0; > = 1.0f;
float WaveUVScrollRate < string UIName="WaveUVScrollRate"; float UIMin = -10.0; float UIMax = 10.0; > = 1.0f;
float DistortUVScrollRate < string UIName="DistortUVScrollRate"; float UIMin = -10.0; float UIMax = 10.0; > = 1.0f;


texture BaseTexture
<
	string UIName = "BaseTexture";
	string UIType = "bitmap";
	string UIHelp = "Diffuse, Alpha";
>;

texture WaveTexture
<
	string UIName = "WaveTexture";
	string UIType = "bitmap";
>;

texture DistortionTexture
<
	string UIName = "DistortionTexture";
	string UIType = "bitmap";
>;

sampler BaseSampler = sampler_state 
{
    texture = (BaseTexture);
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = LINEAR;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

sampler WaveSampler = sampler_state 
{
    texture = (WaveTexture);
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = LINEAR;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

sampler DistortionSampler = sampler_state 
{
    texture = (DistortionTexture);
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = LINEAR;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};



/////////////////////////////////////////////////////////////////////
//
// Shared Shader Code
//
/////////////////////////////////////////////////////////////////////

struct VS_OUTPUT
{
    float4 Pos    	: POSITION;
    float4 Diff		: COLOR0;
    float2 Tex0    	: TEXCOORD0;
    float2 Tex1		: TEXCOORD1;
    float2 Tex2    	: TEXCOORD2;
    float  Fog		: FOG;
};

float4 distort_ps_main(VS_OUTPUT In) : COLOR
{
    float DISTORT_SCALE = 0.25f;

    // grab the distortion texture
    float4 distortion_texel = tex2D(DistortionSampler,In.Tex2);
    
    // perturb the uv-s for the energy texture
    float2 uv = In.Tex0 + distortion_texel.xy * DISTORT_SCALE;

    // grab the energy texel
    float4 texel = tex2D(BaseSampler,uv);

    // grab the line texel
    float4 wave_texel = tex2D(WaveSampler,In.Tex1);
    
    return texel * wave_texel * In.Diff;
}

