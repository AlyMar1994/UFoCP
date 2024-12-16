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
	
	Shared HLSL code for the Gloss shaders
	
	2x Diffuse+Spec lighting.
	Spec is modulated by alpha channel of the texture (gloss).

*/


#include "AlamoEngine.fxh"


/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////
// material parameters
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float3 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
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
    MIPFILTER = LINEAR;
    MINFILTER = LINEAR;
    MAGFILTER = LINEAR;
};

/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////

struct VS_INPUT_SKIN
{
    float4  Pos             : POSITION;
    float4  Normal          : NORMAL;		// Normal.w contains skin binding
    float2  Tex0            : TEXCOORD0;
};

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
    float4  Spec	: COLOR1;
    float2  Tex0    : TEXCOORD0;
    float  Fog		: FOG;
};


/////////////////////////////////////////////////////////////////////
//
// Shared Shader Code
//
/////////////////////////////////////////////////////////////////////

float4 gloss_ps_main(VS_OUTPUT In) : COLOR
{
	float4 base_texel = tex2D(BaseSampler,In.Tex0);
	float3 diffuse = In.Diff.rgb * base_texel.rgb * 2.0;
	float3 specular = In.Spec.rgb * base_texel.a;
	return float4(diffuse + specular,In.Diff.a);
}
