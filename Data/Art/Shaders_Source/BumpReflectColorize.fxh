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
	
	Shared HLSL code for the BumpColorize shaders
	
	2x Diffuse + Cube Reflection, colorization.
	First directional light does dot3 diffuse bump mapping.
	Spec reflection from a cube-map sample is modulated by spec color and alpha channel of the bump map(gloss)
	Colorization mask is in the alpha channel of the base texture (as always!).
	
*/

#include "AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float3 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float  Shininess < string UIName="Shininess"; > = 32.0f;
float4 Colorization < string UIName="Colorization"; string UIType = "ColorSwatch"; > = {0.0f, 1.0f, 0.0f, 1.0f};
float4 UVOffset < string UIName="UVOffset"; > = {0.0f, 0.0f, 0.0f, 0.0f};

texture BaseTexture 
< 
	string UIName = "BaseTexture";
	string UIType = "bitmap"; 
>;

texture NormalTexture
<
	string UIName = "NormalTexture";
	string UIType = "bitmap";
	bool DiscardableBump = true;
>;


/////////////////////////////////////////////////////////////////////
//
// Samplers
//
/////////////////////////////////////////////////////////////////////
sampler BaseSampler = sampler_state
{
    Texture   = (BaseTexture);
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    AddressU  = WRAP;        
    AddressV  = WRAP;
};

sampler NormalSampler = sampler_state
{
    Texture   = (NormalTexture);
    MipFilter = LINEAR;
    MinFilter = LINEAR;
    MagFilter = LINEAR;
    AddressU  = WRAP;        
    AddressV  = WRAP;
};

samplerCUBE SkyCubeSampler = sampler_state 
{ 
    texture = (m_skyCubeTexture); 
};


/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////
struct VS_INPUT_MESH
{
	float4 Pos : POSITION;
	float3 Normal : NORMAL;
	float2 Tex : TEXCOORD0;
	float3 Tangent : TANGENT0;
	float3 Binormal : BINORMAL0;
};

struct VS_INPUT_SKIN
{
	float4  Pos : POSITION;
	float4  Normal : NORMAL;		// Normal.w = skin binding
	float2  Tex : TEXCOORD0;
	float3  Tangent : TANGENT0;
	float3  Binormal : BINORMAL0;
};

struct VS_OUTPUT
{
	float4  Pos : POSITION;
	float4  Diff : COLOR0;
	float4	Spec : COLOR1;
	float2  Tex0 : TEXCOORD0;
	float2	Tex1 : TEXCOORD1;
	float3  LightVector : TEXCOORD2;	// light in tangent space
	float3	ReflectionVector : TEXCOORD3;	// reflection vector in world space
	float  Fog : FOG;
};


/////////////////////////////////////////////////////////////////////
//
// Shared Shader Code
//
/////////////////////////////////////////////////////////////////////
float4 bump_reflect_colorize_ps11_main(VS_OUTPUT In): COLOR
{
	float4 baseTexel = tex2D(BaseSampler,In.Tex0);
	float4 normalTexel = tex2D(NormalSampler,In.Tex1);

	// lerp the colorization
	float3 surface_color = lerp(baseTexel.rgb,Colorization*baseTexel.rgb,baseTexel.a);
	
	// compute lighting
	float3 norm_vec = 2.0f*(normalTexel.rgb - 0.5f);
	float3 light_vec = 2.0f*(In.LightVector - 0.5f);
	float ndotl = saturate(dot(norm_vec,light_vec));
	float3 diff = surface_color * (ndotl*Diffuse*m_light0Diffuse + In.Diff.rgb) * 2.0;

	// reflection
	float3 reflect_pixel = texCUBE(SkyCubeSampler,In.ReflectionVector);

	float3 spec = reflect_pixel*Specular*normalTexel.a;
	return float4(diff + spec, In.Diff.a);
}


