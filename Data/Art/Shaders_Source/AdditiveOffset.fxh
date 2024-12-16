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
	
	Shared HLSL code for the Additive shaders that support texture offsetting.
	This shader is separate from MeshAdditive because it has to support uv-offsetting even
	on the min-spec (which means we are using a scripted texture transform when running
	on fixed function; this is not the most efficient thing to do so I separated this shader
	from the general "additive" shader)

*/

#include "AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////


texture BaseTexture
<
	string Name = "gh_gravel00.jpg";
	string UIName = "BaseTexture";
	string UIType = "bitmap";
>;

float4 UVOffset
< 
	string UIName="UVOffset"; 
> = { 0.0f, 0.0f, 0.0f, 0.0f };

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
    return texel * In.Diff;
}
