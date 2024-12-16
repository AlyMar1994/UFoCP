///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Dev/SkinShadowVolume.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shadow volume generated from a skinned mesh.

	_ALAMO_VERTEX_TYPE = alD3dVertB4I4NU2
	_ALAMO_TANGENT_SPACE = 0
	_ALAMO_SHADOW_VOLUME = 1
	_ALAMO_BONES_PER_VERTEX = 3
	
*/

string RenderPhase = "Shadow";

#include "AlamoEngine.fxh"

float m_extrusion : SHADOW_EXTRUSION_DISTANCE = 100.0f;

// material parameters, for visualizing the volume we'll use this solid color
float4 DebugColor < string UIName="DebugColor"; string UIType = "ColorSwatch"; > = {0.0f, 1.0f, 1.0f, 1.0f};

///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos : POSITION;
    float4 BlendWeights : BLENDWEIGHT;
    float4 BlendIndices : BLENDINDICES;
    float3 Normal : NORMAL;
};

struct VS_OUTPUT
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
};


VS_OUTPUT vs_main_skin_shadow_volume(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    // Compensate for lack of UBYTE4 on Geforce3
    int4 indices = D3DCOLORtoUBYTE4(In.BlendIndices);

    // Skin the position into view space   
    float4x3 weighted_transform;
	weighted_transform = In.BlendWeights[0] * m_skinMatrixArray[indices[0]];
	weighted_transform += In.BlendWeights[1] * m_skinMatrixArray[indices[1]];
	weighted_transform += In.BlendWeights[2] * m_skinMatrixArray[indices[2]];
	//weighted_transform += In.BlendWeights[3] * m_skinMatrixArray[indices[3]];

	float3 P = mul(In.Pos,weighted_transform);

	// Skin the normal into view space
	float3 N = normalize(mul(In.Normal,(float3x3)weighted_transform));

	// Extrude the back-facing vertices
	float ndotl = dot(N, m_light0Vector);
	Out.Diff = DebugColor;
	if (ndotl < 0.0)
	{
		P -= m_extrusion * m_light0Vector;
		Out.Diff = 0.3*DebugColor;
	}
	
	// project point 
    Out.Pos  = mul(float4(P,1), m_viewProj); 
	return Out;
}

VS_OUTPUT vs_max_main_skin_shadow_volume(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	float3 obj_pos = In.Pos.xyz;
	float3 obj_light_vec = m_light0ObjVector;
	float ndotl = dot(In.Normal, obj_light_vec);
	
	Out.Diff = DebugColor;
	if (ndotl < 0.0)
	{
		//obj_pos -= m_extrusion * obj_light_vec;
		Out.Diff = 0.3*DebugColor;
	} 	
	
	Out.Pos  = mul(float4(obj_pos,1), m_worldViewProj); // position (projected)

	return Out;
}


float4 ps_main_skin_shadow_volume(VS_OUTPUT In) : COLOR
{
    return In.Diff;
}

// Compiled shader programs
vertexshader vs_main_skin_shadow_volume_bin = compile vs_1_1 vs_main_skin_shadow_volume();
vertexshader vs_max_main_skin_shadow_volume_bin = compile vs_1_1 vs_max_main_skin_shadow_volume();
pixelshader ps_main_skin_shadow_volume_bin = compile ps_1_1 ps_main_skin_shadow_volume();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique max_viewport
{
    pass P0
    {
		// blend mode
		ZWriteEnable = TRUE;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		CullMode = CW;
				
        // shaders
        VertexShader = (vs_max_main_skin_shadow_volume_bin);
        PixelShader  = (ps_main_skin_shadow_volume_bin);
    }  
}

/*
technique testing
{
    pass P0
    {
		// blend mode
		ZWriteEnable = TRUE;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		CullMode = CW;
				
        // shaders
        VertexShader = (vs_main_skin_shadow_volume_bin);
        PixelShader  = (ps_main_skin_shadow_volume_bin);
    }  
}
*/

technique t0_2pass_zpass
<
	string LOD="DX8";
>
{
    pass t0_2pass_zpass_p0
    {
		// Stencil settings
        ColorWriteEnable = 0;
        ZFunc            = Less;
        ZWriteEnable     = False;
        StencilEnable    = True;
		StencilRef       = 1;
        StencilMask      = 0xffffffff;
        StencilWriteMask = 0xffffffff;
		
		CullMode=CCW;
        StencilFunc      = Always;
		StencilPass 	 = Incr;
		StencilZFail     = Keep;
		StencilFail      = Keep;

        // shaders
        VertexShader = (vs_main_skin_shadow_volume_bin);
        PixelShader  = (ps_main_skin_shadow_volume_bin);
    }  

    pass t0_2pass_zpass_p1
    {
		// Stencil settings
		CullMode=CW;
		StencilPass=Decr;
		
		// shaders
        VertexShader = (vs_main_skin_shadow_volume_bin);
        PixelShader  = (ps_main_skin_shadow_volume_bin);
    }  
}

technique t0_2pass 
<
	string LOD="DX8";
>
{
    pass t0_2pass_p0
    {
		// Stencil settings
        ColorWriteEnable = 0;
        ZFunc            = Less;
        ZWriteEnable     = False;
        StencilEnable    = True;
		StencilRef       = 1;
        StencilMask      = 0xffffffff;
        StencilWriteMask = 0xffffffff;
		
		CullMode=CCW;
        StencilFunc      = Always;
		StencilPass 	 = Keep;
		StencilZFail     = Incr;
		StencilFail      = Keep;

        // shaders
        VertexShader = (vs_main_skin_shadow_volume_bin);
        PixelShader  = (ps_main_skin_shadow_volume_bin);
    }  

    pass t0_2pass_p1
    {
		// Stencil settings
		CullMode=CW;
		StencilZFail=Decr;
		
		// shaders
	    VertexShader = (vs_main_skin_shadow_volume_bin);
        PixelShader  = (ps_main_skin_shadow_volume_bin);
    }  
}

