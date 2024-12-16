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
	
	Shared HLSL code for the AlphaGlossColorize shaders

	Alpha blending, gloss and colorization.  
	Base texture is diffuse and alpha channel.
	Colorize texture uses the red channel to lerp between base texture and colorization.
	Gloss is taken from the alpha channel of the colorize texture.
	
*/


#include "AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////

float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float4 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float  Shininess < string UIName="Shininess"; > = 32.0f;
float4 Colorization < string UIName="Colorization"; string UIType = "ColorSwatch"; > = {0.0f, 1.0f, 0.0f, 1.0f};

texture BaseTexture
<
	string Name = "gh_gravel00.jpg";
	string UIName = "BaseTexture (DA)";
	string UIType = "bitmap";
>;

texture GlossTexture 
<
	string Name = "gh_gravel00.jpg";
	string UIName = "GlossTexture (G)";
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
};

sampler ColorizeSampler = sampler_state 
{
    texture = <ColorizeTexture>;
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
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
    float2	Tex1	: TEXCOORD1;
	float  Fog		: FOG;
};

float4 alpha_gloss_colorize_ps_main(VS_OUTPUT In) : COLOR
{

   float4 base_texel = tex2D(BaseSampler,In.Tex0);
   float4 colorize_texel = tex2D(ColorizeSampler,In.Tex1);

   float3 surface_color = lerp(base_texel.rgb, base_texel.rgb*Colorization,colorize_texel.r);   
   
   float3 diffuse = In.Diff.rgb*surface_color*2.0f;
   float3 specular = In.Spec*colorize_texel.a;
   return float4(diffuse + specular,In.Diff.a * base_texel.a);
}
