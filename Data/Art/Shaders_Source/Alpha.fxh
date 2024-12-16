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
    float4  Pos     : POSITION;
    float4  Diff	: COLOR0;
    float4	Spec	: COLOR1;
    float2  Tex0    : TEXCOORD0;
    float  Fog		: FOG;
};

float4 alpha_ps_main(VS_OUTPUT In) : COLOR
{
    float4 texel = tex2D(BaseSampler,In.Tex0);
    float4 pixel;
    pixel.rgb = texel.rgb * In.Diff * 2.0f;
    pixel.a = texel.a * In.Diff.a;
    pixel.rgb += In.Spec.rgb;
    return pixel;
}
