///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/SceneBloom.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shaders used to implement "fake-HDR" blooming.  
	First you have to do a "bright filter" to pull stuff you want to "glow" out of the scene
	Then you do a series of "bloom" passes with the code ping-ponging between two render targets
	to blur the hotspots out.

*/

#include "../AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Parameters
//
/////////////////////////////////////////////////////////////////////

float BloomIteration = 0;
texture SceneTexture;

sampler SceneSampler0 : register(s0) = sampler_state { Texture = (SceneTexture); AddressU = CLAMP; AddressV = CLAMP; MINFILTER=LINEAR; MAGFILTER=LINEAR; };     
sampler SceneSampler1 : register(s1) = sampler_state { Texture = (SceneTexture); AddressU = CLAMP; AddressV = CLAMP; MINFILTER=LINEAR; MAGFILTER=LINEAR;};     
sampler SceneSampler2 : register(s2) = sampler_state { Texture = (SceneTexture); AddressU = CLAMP; AddressV = CLAMP; MINFILTER=LINEAR; MAGFILTER=LINEAR;};     
sampler SceneSampler3 : register(s3) = sampler_state { Texture = (SceneTexture); AddressU = CLAMP; AddressV = CLAMP; MINFILTER=LINEAR; MAGFILTER=LINEAR;};     


float BloomCutoff = 1.0f;
float BloomStrength = 0.1f;
float BloomSize = 0.25f;

/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////
struct VS_INPUT
{
    float2 Pos  : POSITION;
};

struct VS_OUTPUT_BRIGHT
{
	float4 Pos		: POSITION;
	float2 Tex0		: TEXCOORD0;
	float  Fog		: FOG;
};

struct VS_OUTPUT_BLOOM
{
    float4  Pos     : POSITION;
    float2  Tex0    : TEXCOORD0;
    float2	Tex1    : TEXCOORD1;
    float2	Tex2	: TEXCOORD2;
    float2	Tex3	: TEXCOORD3;
    float   Fog		: FOG;
};

struct VS_OUTPUT_COMBINE
{
	float4 Pos		: POSITION;
	float2 Tex0		: TEXCOORD0;
	float  Fog		: FOG;
};

///////////////////////////////////////////////////////
//
// Shader Programs
// "bright_pass" is used to filter all but the "hotspots" out of the original image
// "bloom_pass" is used to blur/smear the hotspots 
//
///////////////////////////////////////////////////////
VS_OUTPUT_BRIGHT vs_bright_filter(VS_INPUT In)
{
    VS_OUTPUT_BRIGHT Out = (VS_OUTPUT_BRIGHT)0;
	
    Out.Pos.xy = In.Pos.xy;
	Out.Pos.z = 0.5f;
	Out.Pos.w = 1.0f;
	Out.Tex0 = float2(0.5f, -0.5f) * In.Pos.xy + float2(0.5f,0.5f);
    Out.Tex0.x += m_resolutionConstants.z;  // half-pixel
    Out.Tex0.y += m_resolutionConstants.w;
	Out.Fog = 1.0f; //no fog please

    return Out;
}

half4 ps_bright_filter(VS_OUTPUT_BRIGHT In) : COLOR
{
	half4 pixel = tex2D(SceneSampler0,In.Tex0);

    // NOTE: alpha channel can pull the luminance up for this formula
    // I've cleared the frame buffer alpha and then certain objects that
    // we want to bloom are allowed to write non-zero values into it.
    half4 luminance_constant = half4(0.299f,0.587f,0.114f,0.0f);
	float luminance = dot(pixel,luminance_constant);

    if (luminance > BloomCutoff)
    {
        return pixel;
    }
    else
    {
        return pixel*pixel*pixel*pixel*pixel;
    }
}

VS_OUTPUT_BLOOM vs_bloom(VS_INPUT In)
{
    VS_OUTPUT_BLOOM Out = (VS_OUTPUT_BLOOM)0;
	
    Out.Pos.xy = In.Pos.xy;
	Out.Pos.z = 0.5f;
	Out.Pos.w = 1.0f;

    float2 half_pixel = float2(m_resolutionConstants.z,m_resolutionConstants.w);

    float2 kernel_center = float2(0.5f,-0.5f) * In.Pos.xy + float2(0.5f,0.5f);
    kernel_center += half_pixel;
    
    float2 delta = BloomSize * (half_pixel + 2.0f*BloomIteration*half_pixel);
    
	Out.Tex0 = kernel_center + delta;
    Out.Tex1 = kernel_center - delta;
    Out.Tex2 = kernel_center + float2(delta.x,-delta.y);
    Out.Tex3 = kernel_center - float2(delta.x,-delta.y);
    
	Out.Fog = 1.0f; //no fog please

    return Out;
}

half4 ps_bloom(VS_OUTPUT_BLOOM In) : COLOR
{
    half4 pixel = tex2D(SceneSampler0,In.Tex0);
    pixel += tex2D(SceneSampler1,In.Tex1);
    pixel += tex2D(SceneSampler2,In.Tex2);
    pixel += tex2D(SceneSampler3,In.Tex3);

    return pixel * 0.25f;  // * 0.275f; //brighten slightly as we blur
}

VS_OUTPUT_COMBINE vs_combine(VS_INPUT In)
{
    VS_OUTPUT_COMBINE Out = (VS_OUTPUT_COMBINE)0;

    Out.Pos.xy = In.Pos.xy;
	Out.Pos.z = 0.5f;
	Out.Pos.w = 1.0f;
	Out.Tex0 = float2(0.5f, -0.5f) * In.Pos.xy + 0.5f.xx;
    Out.Tex0.x += m_resolutionConstants.z;
    Out.Tex0.y += m_resolutionConstants.w;
	Out.Fog = 1.0f; //no fog please

    return Out;
}

half4 ps_combine(VS_OUTPUT_COMBINE In) : COLOR
{
	half4 pixel = BloomStrength * tex2D(SceneSampler0,In.Tex0);
    return pixel;
}

vertexshader vs_bright_filter_bin = compile vs_1_1 vs_bright_filter();
vertexshader vs_bloom_bin = compile vs_1_1 vs_bloom();
vertexshader vs_combine_bin = compile vs_1_1 vs_combine();

pixelshader ps_bright_filter_bin = compile ps_1_3 ps_bright_filter();
pixelshader ps_bloom_bin = compile ps_1_1 ps_bloom();
pixelshader ps_combine_bin = compile ps_1_1 ps_combine();


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

        	AlphaBlendEnable = FALSE;
    		AlphaTestEnable = FALSE;
    		ZWriteEnable = FALSE;
    		ZFunc = ALWAYS;
    		
        SB_END        

        VertexShader = (vs_bright_filter_bin); 
        PixelShader  = (ps_bright_filter_bin); 

	}

	pass t0_p1
	{
        SB_START

        	AlphaBlendEnable = FALSE;
    		AlphaTestEnable = FALSE;
    		ZWriteEnable = FALSE;
    		ZFunc = ALWAYS;
            
        SB_END        

        VertexShader = (vs_bloom_bin); 
        PixelShader  = (ps_bloom_bin); 
	}

    pass t0_p2
    {
        SB_START

        	AlphaBlendEnable = TRUE;
    		AlphaTestEnable = FALSE;
            DestBlend=INVSRCCOLOR; //ONE;   // AddSmooth!
            SrcBlend=ONE; 
    		ZWriteEnable = FALSE;
    		ZFunc = ALWAYS;
            
        SB_END        

        VertexShader = (vs_combine_bin); 
        PixelShader  = (ps_combine_bin); 

    }
}
