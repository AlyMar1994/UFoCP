///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars/Art/Shaders/Engine/DepthSprite.fx $
//          $Author: Greg_Hjelstrom $
//          $DateTime: 2004/07/09 19:04:15 $
//          $Revision: #6 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Depth Sprite Shaders, uses values in a second texture to offset the depth of each pixel

	_ALAMO_VERTEX_TYPE = alPrimVert
	_ALAMO_TANGENT_SPACE = 0
	_ALAMO_SHADOW_VOLUME = 0
	_ALAMO_Z_SORT = 0


	Notes:
	------
	For PS1.x, the various registers have different valid ranges.
	c# - constants, [-1 , +1]
	r# - temporaries, [-PixelShader1xMaxValue, PixelShader1xMaxValue]
	t# - texture, [-MaxTextureRepeat, +MaxTextureRepeat]
	v# - 2 vertex colors [0 , 1]
	
	On my 5700, PixelShader1xMaxValue = 2 and MaxTextureRepeat = 8192
	On a GeForce3, PixelShader1xMaxValue = 1 and MaxTextureRepeat = 8192
	On Jason's 9800SE, PixelShader1xMaxValue was 10^38, MaxTextureRepeat = 2048
	Kearns 9600, PS1xMaxValue was 10^38, MaxTextureRepeat = 2048
	
	For PS2.x:
	v# - 2 vertex colors [0 , 1]
	r# - 12-32 temporaries [floating point]
	c# - 32 constants [floating point]
	i# - 16 integer constants for looping/flow control
	b# - 16 boolean constants for for looping/flow control
	p0 - predicate [boolean]
	t# - 8 texture registers [floating point]
	  
*/

#include "../AlamoEngine.fxh"


/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////

// DepthScale is in world space units (same units as camera znear,zfar)
float DepthScale : DEPTH_SCALE = 0.05f;
 
sampler BaseSampler : register(s0);
sampler DepthSampler : register(s1);


//////////////////////////////////////////////////////////////////////
//
// Vertex Shader programs shared by all of the depth sprite shaders
//
//////////////////////////////////////////////////////////////////////
struct VS_INPUT
{
    float3 Pos  : POSITION;
    float2 Tex  : TEXCOORD0;
    float4 Color : COLOR0;
};


///////////////////////////////////////////////////////
// VS2.0 Depth Sprite Shader
///////////////////////////////////////////////////////
struct VS_OUTPUT_PS20
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float2 Tex0 : TEXCOORD0;
    float3 Tex1 : TEXCOORD1;
    float3 Tex2 : TEXCOORD2;
};

VS_OUTPUT_PS20 vs_depth_sprite_ps20(VS_INPUT In)
{
	VS_OUTPUT_PS20 Out = (VS_OUTPUT_PS20)0;

	Out.Pos  = mul(float4(In.Pos, 1), m_worldViewProj);             // position (projected)
	Out.Diff = In.Color;
	Out.Tex0 = In.Tex; 

	Out.Tex1 = float3(DepthScale * m_projection[2][2],0,Out.Pos.z);
	Out.Tex2 = float3(-DepthScale * m_projection[3][2],0,Out.Pos.w);    
	return Out;                                      
}

vertexshader vs_depth_sprite_ps20_bin = compile vs_2_0 vs_depth_sprite_ps20();


///////////////////////////////////////////////////////
// PS1.4 (Ati) Depth Sprite Shader
///////////////////////////////////////////////////////
struct VS_OUTPUT_PS14
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float2 Tex0 : TEXCOORD0;
    float3 Tex1 : TEXCOORD1;
    float3 Tex2 : TEXCOORD2;
};

VS_OUTPUT_PS14 vs_depth_sprite_ps14(VS_INPUT In)
{
    VS_OUTPUT_PS14 Out = (VS_OUTPUT_PS14)0;

    Out.Pos  = mul(float4(In.Pos, 1), m_worldViewProj);             // position (projected)
    Out.Diff = In.Color;
    Out.Tex0 = In.Tex; 

	// output depth sprite parameters
	Out.Tex1.x = -DepthScale * m_projection[2][2];
	Out.Tex1.y = 0.0f; //Out.Tex2.x * (1.0f/256.0f);
	Out.Tex1.z = Out.Pos.z; //dot(float4(In.Pos,1), m_worldViewProj._m02_m12_m22_m32); 

	Out.Tex2.x = -DepthScale * m_projection[3][2];
	Out.Tex2.y = 0.0f; //Out.Tex2.x * (1.0f/256.0f);
	Out.Tex2.z = Out.Pos.w; //dot(float4(In.Pos,1), m_worldViewProj._m03_m13_m23_m33);

    return Out;
}

vertexshader vs_depth_sprite_ps14_bin = compile vs_1_1 vs_depth_sprite_ps14();

///////////////////////////////////////////////////////
// PS1.3 (nVidia) Depth Sprite Shaders
///////////////////////////////////////////////////////
struct VS_OUTPUT_PS13
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float2 Tex0 : TEXCOORD0;
    float2 Tex1 : TEXCOORD1;
    float3 Tex2 : TEXCOORD2;
    float3 Tex3 : TEXCOORD3;
};

VS_OUTPUT_PS13 vs_depth_sprite_ps13(VS_INPUT In)
{
	VS_OUTPUT_PS13 Out = (VS_OUTPUT_PS13)0;
	
	Out.Pos  = mul(float4(In.Pos, 1), m_worldViewProj);             // position (projected)
	Out.Diff = In.Color;
	Out.Tex0 = In.Tex;                                       
	Out.Tex1 = In.Tex;
	 
	// output depth sprite parameters
	Out.Tex2.x = -DepthScale * m_projection[2][2];
	Out.Tex2.y = 0.0f; //Out.Tex2.x * (1.0f/256.0f);
	Out.Tex2.z = Out.Pos.z; //dot(float4(In.Pos,1), m_worldViewProj._m02_m12_m22_m32);

	Out.Tex3.x = -DepthScale * m_projection[3][2];
	Out.Tex3.y = 0.0f; //Out.Tex2.x * (1.0f/256.0f);
	Out.Tex3.z = Out.Pos.w; //dot(float4(In.Pos,1), m_worldViewProj._m03_m13_m23_m33);

    return Out;
}

vertexshader vs_depth_sprite_ps13_bin = compile vs_1_1 vs_depth_sprite_ps13();


////////////////////////////////////////////////////////////////
// Fallback shaders for hardware with no depth sprite support
////////////////////////////////////////////////////////////////
struct VS_OUTPUT_NODEPTH
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float2 Tex0 : TEXCOORD0;
};

VS_OUTPUT_NODEPTH vs_depth_sprite_nodepth(VS_INPUT In)
{
    VS_OUTPUT_NODEPTH Out = (VS_OUTPUT_NODEPTH)0;
    Out.Pos  = mul(float4(In.Pos, 1), m_worldViewProj);   
    Out.Diff = In.Color;
    Out.Tex0 = In.Tex;                                       
    return Out;
}

vertexshader vs_depth_sprite_nodepth_bin = compile vs_1_1 vs_depth_sprite_nodepth();


