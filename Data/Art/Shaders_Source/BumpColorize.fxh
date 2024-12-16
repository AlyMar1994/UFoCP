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
	
	2x Diffuse+Spec lighting, colorization.
	First directional light does dot3 diffuse bump mapping.
	Colorization mask is in the alpha channel of the base texture.
	Spec is modulated by alpha channel of the normal map (gloss)
	
	9/22/2004 - Input Vertex color (assumed grey) is plugged into the alpha component of the
	diffuse color interpolatr.  This is used in the pixel shader as an "accessibility" or
	"occlusion" term.
	
	10/20/2004 - removed vertex color support, all shaders need to suppor the diffuse
	material color so that our dimming and highlighting code works and using vertex
	colors with the fixed function pipeline is mutually exclusive to using a diffuse material color...
	
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


/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////
struct VS_INPUT_MESH
{
	float4 Pos  : POSITION;
	float3 Normal : NORMAL;
	float2 Tex  : TEXCOORD0;
	float3 Tangent : TANGENT0;
	float3 Binormal : BINORMAL0;
};

struct VS_INPUT_SKIN
{
	float4  Pos		: POSITION;
	float4  Normal		: NORMAL;		// Normal.w = skin binding
	float2  Tex		: TEXCOORD0;
	float3  Tangent		: TANGENT0;
	float3  Binormal	: BINORMAL0;
};

struct VS_OUTPUT
{
	float4  Pos     	: POSITION;
	float4  Diff		: COLOR0;
	float4	Spec		: COLOR1;
	float2  Tex0    	: TEXCOORD0;
	float2	Tex1		: TEXCOORD1;
	float3  LightVector	: TEXCOORD2;
	float3  HalfAngleVector	: TEXCOORD3;
	float  Fog		: FOG;
};


/////////////////////////////////////////////////////////////////////
//
// Shared Shader Code
//
/////////////////////////////////////////////////////////////////////
float4 bump_spec_colorize_ps_main(VS_OUTPUT In): COLOR
{
	float4 baseTexel = tex2D(BaseSampler,In.Tex0);
	float4 normalTexel = tex2D(NormalSampler,In.Tex1);

	// lerp the colorization
	float3 surface_color = lerp(baseTexel.rgb,Colorization*baseTexel.rgb,baseTexel.a);
	
	// compute lighting
	float3 norm_vec = 2.0f*(normalTexel.rgb - 0.5f);
	float3 light_vec = 2.0f*(In.LightVector - 0.5f);
	float3 half_vec = 2.0f*(In.HalfAngleVector - 0.5f);
	//half_vec = normalize(half_vec);
	//light_vec = normalize(light_vec);
	
	float ndotl = saturate(dot(norm_vec,light_vec));
	float ndoth = saturate(dot(norm_vec,half_vec));

	// put it all together
	float3 diff = surface_color * (ndotl*Diffuse*m_light0Diffuse*m_lightScale.rgb + In.Diff.rgb) * 2.0;
	float3 spec = m_light0Specular*Specular*pow(ndoth,16)*normalTexel.a;
	return float4(diff + spec, In.Diff.a);
}

half4 bump_colorize_ps_main(VS_OUTPUT In) : COLOR
{
	// sample the textures
    half4 base_texel = tex2D(BaseSampler,In.Tex0);
    half4 norm_texel = tex2D(NormalSampler,In.Tex1);
	
	// lerp the colorization
	half3 surface_color = lerp(base_texel.rgb,Colorization*base_texel.rgb,base_texel.a);
	
	// diffuse bump lighting
	half3 norm_vec = 2.0f*(norm_texel.rgb - 0.5f);
	half3 light_vec = 2.0f*(In.LightVector - 0.5f);
	half ndotl = saturate(dot(norm_vec,light_vec));  

	// put it all together
	half3 diffuse = surface_color * (ndotl*Diffuse*m_light0Diffuse*m_lightScale.rgb + In.Diff.rgb) * 2.0;
	half3 specular = In.Spec * norm_texel.a;
	return half4(diffuse + specular, In.Diff.a);
}

half4 bump_colorize_ps11_main(VS_OUTPUT In) : COLOR
{
	// sample the textures
    half4 base_texel = tex2D(BaseSampler,In.Tex0);
    half4 norm_texel = tex2D(NormalSampler,In.Tex1);
	
	// lerp the colorization
	half3 surface_color = lerp(base_texel.rgb,Colorization*base_texel.rgb,base_texel.a);
	
	// put it all together
	half3 diffuse = surface_color * In.Diff.rgb * m_lightScale.rgb * 2.0;
	half3 specular = In.Spec * norm_texel.a;
	return float4(diffuse + specular, In.Diff.a);
}

