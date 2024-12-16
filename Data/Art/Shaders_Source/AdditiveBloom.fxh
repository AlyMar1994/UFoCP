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
	
	Shared HLSL code for the Additive Bloom shaders

	Additive blending that goes into a render phase right before blooming and marks pixels
	for blooming.

*/

#include "AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////


texture BaseTexture
<
	string UIName = "BaseTexture";
	string UIType = "bitmap";
>;

float2 UVScrollRate 
< 
	string UIName="UVScrollRate"; 
> = { 0.0f, 0.0f };

float BloomFactor
<
	string UIName="BloomFactor";
> = { 1.0f };
	
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
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float2 Tex  : TEXCOORD0;
    float  Fog	: FOG;
};

float4 additive_ps_main(VS_OUTPUT In) : COLOR
{
    float4 texel = tex2D(BaseSampler,In.Tex);
    texel.rgb = texel.rgb * In.Diff.rgb;
    texel.a = BloomFactor;
    return texel;
}
