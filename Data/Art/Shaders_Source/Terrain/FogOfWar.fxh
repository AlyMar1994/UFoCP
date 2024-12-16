///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars/Art/Shaders/Terrain/SpaceFogOfWar.fx $
//          $Author: Greg_Hjelstrom $
//          $DateTime: 2004/09/13 19:01:25 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Common HLSL code shared by the fog of war shaders.  
	
*/

#include "../AlamoEngine.fxh"

texture GridTexture < string UIName = "GridTexture"; >;

// exposed so that the code can set this to match the texture resolution (it should = 0.5/texwidth)
float2 FilterKernelSize < string UIName="FilterKernelSize"; > = float2(0.5f/404.0f , 0.5f/404.0f);

const float2 FilterSamples4[4] = 
{
   -1,  0,
    0,  1,
    1,  0,
    0, -1,
};

//------------------------------------
sampler FOWSampler = sampler_state 
{
    texture = <m_FOWTexture>;
    AddressU  = CLAMP;        
    AddressV  = CLAMP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};

sampler GridSampler = sampler_state
{
    texture = <GridTexture>;
    AddressU  = WRAP;
    AddressV  = WRAP;
};

//------------------------------------
struct VS_INPUT 
{
    float3 position		: POSITION;
};


struct VS_OUTPUT_BLUR_GRID
{
    float4 Pos			: POSITION;
    float2 Tex0			: TEXCOORD0;
    float2 Tex1			: TEXCOORD1;
    float2 Tex2			: TEXCOORD2;
    float2 Tex3			: TEXCOORD3;
    float2 Tex4			: TEXCOORD4; // grid texture coordinates
    float Fog			: FOG;
};

struct VS_OUTPUT_BLUR
{
    float4 Pos			: POSITION;
    float2 Tex0			: TEXCOORD0;
    float2 Tex1			: TEXCOORD1;
    float2 Tex2			: TEXCOORD2;
    float2 Tex3			: TEXCOORD3;
    float Fog			: FOG;
};

struct VS_OUTPUT
{
    float4 Pos			: POSITION;
    float2 Tex0			: TEXCOORD0;
    float Fog			: FOG;
};

//------------------------------------
VS_OUTPUT_BLUR_GRID vs_blur_grid_main(VS_INPUT IN) 
{
	VS_OUTPUT_BLUR_GRID OUT = (VS_OUTPUT_BLUR_GRID)0;
	OUT.Pos = mul( float4(IN.position.xyz , 1.0) , m_worldViewProj);
	
	// texture coordinate generation
	float2 texcoord;
	texcoord.x = dot(m_FOWTexU,float4(IN.position.xyz,1.0));
	texcoord.y = dot(m_FOWTexV,float4(IN.position.xyz,1.0));
	
	OUT.Tex0 = texcoord + FilterKernelSize * FilterSamples4[0];
	OUT.Tex1 = texcoord + FilterKernelSize * FilterSamples4[1];
	OUT.Tex2 = texcoord + FilterKernelSize * FilterSamples4[2];
	OUT.Tex3 = texcoord + FilterKernelSize * FilterSamples4[3];
	OUT.Tex4 = texcoord*200.0f;
	
	// Output fog
	OUT.Fog = Compute_Fog(OUT.Pos.xyz); 
	
	return OUT;
}

//-----------------------------------
float4 ps_blur_grid_main( VS_OUTPUT_BLUR_GRID IN): COLOR
{
	float4 texel0 = tex2D(FOWSampler,IN.Tex0);
	float4 texel1 = tex2D(FOWSampler,IN.Tex1);
	float4 texel2 = tex2D(FOWSampler,IN.Tex2);
	float4 texel3 = tex2D(FOWSampler,IN.Tex3);
	float4 fog_texel = (texel0 + texel1 + texel2 + texel3) * 0.25f;
	
	float4 grid_texel = tex2D(GridSampler,IN.Tex4);
	fog_texel.a *= grid_texel.a;
	return fog_texel;
}


//------------------------------------
VS_OUTPUT_BLUR vs_blur_main(VS_INPUT IN) 
{
	VS_OUTPUT_BLUR OUT = (VS_OUTPUT_BLUR)0;
	OUT.Pos = mul( float4(IN.position.xyz , 1.0) , m_worldViewProj);
	
	// texture coordinate generation
	float2 texcoord;
	texcoord.x = dot(m_FOWTexU,float4(IN.position.xyz,1.0));
	texcoord.y = dot(m_FOWTexV,float4(IN.position.xyz,1.0));
	
	OUT.Tex0 = texcoord + FilterKernelSize * FilterSamples4[0];
	OUT.Tex1 = texcoord + FilterKernelSize * FilterSamples4[1];
	OUT.Tex2 = texcoord + FilterKernelSize * FilterSamples4[2];
	OUT.Tex3 = texcoord + FilterKernelSize * FilterSamples4[3];
	
	// Output fog
	OUT.Fog = Compute_Fog(OUT.Pos.xyz); 
	
	return OUT;
}

//-----------------------------------
float4 ps_blur_main( VS_OUTPUT_BLUR IN): COLOR
{
	float4 texel0 = tex2D(FOWSampler,IN.Tex0);
	float4 texel1 = tex2D(FOWSampler,IN.Tex1);
	float4 texel2 = tex2D(FOWSampler,IN.Tex2);
	float4 texel3 = tex2D(FOWSampler,IN.Tex3);
	
	return (texel0 + texel1 + texel2 + texel3) * 0.25f;
}

//------------------------------------
VS_OUTPUT vs_main(VS_INPUT IN) 
{
	VS_OUTPUT OUT = (VS_OUTPUT)0;
	OUT.Pos = mul( float4(IN.position.xyz , 1.0) , m_worldViewProj);
	
	// texture coordinate generation
	float2 texcoord;
	texcoord.x = dot(m_FOWTexU,float4(IN.position.xyz,1.0));
	texcoord.y = dot(m_FOWTexV,float4(IN.position.xyz,1.0));
	
	OUT.Tex0 = texcoord;
	
	// Output fog
	OUT.Fog = Compute_Fog(OUT.Pos.xyz); 
	
	return OUT;
}

//-----------------------------------
float4 ps_main( VS_OUTPUT IN): COLOR
{
	return tex2D(FOWSampler,IN.Tex0);
}

