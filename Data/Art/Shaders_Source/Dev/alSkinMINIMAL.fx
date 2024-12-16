/*
	
	alSkinMinmal.fx
	created: 9:43am Jan 3, 2004
	author: Greg Hjelstrom
	
	Shader that does just the geometry part of skinning.

	_ALAMO_VERTEX_TYPE = alD3dVertB4I4NU2
	_ALAMO_TANGENT_SPACE = 0
	_ALAMO_SHADOW_VOLUME = 0
	
*/

// Matrices
static const int MAX_BONES = 26;
float4x3 m_skinMatrixArray[MAX_BONES] : SKINMATRIXARRAY;
float4x4 m_projection : PROJECTION;
float4x4 m_worldView : WORLDVIEW;
float4x4 m_worldViewProj : WORLDVIEWPROJECTION;

///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////
struct VS_INPUT
{
    float4  Pos             : POSITION;
    float4  BlendWeights    : BLENDWEIGHT;
    float4  BlendIndices    : BLENDINDICES;
};

struct VS_OUTPUT
{
    float4  Pos     : POSITION;
};


VS_OUTPUT vs_main(VS_INPUT i)
{
    VS_OUTPUT   o = (VS_OUTPUT)0;
     
    // Compensate for lack of UBYTE4 on Geforce3
    int4		indices = D3DCOLORtoUBYTE4(i.BlendIndices);

    // calculate the weighted transform to apply to the normal and position
    float4x3 weighted_transform;
	weighted_transform = i.BlendWeights[0] * m_skinMatrixArray[indices[0]];
	weighted_transform += i.BlendWeights[1] * m_skinMatrixArray[indices[1]];
	weighted_transform += i.BlendWeights[2] * m_skinMatrixArray[indices[2]];
	weighted_transform += i.BlendWeights[3] * m_skinMatrixArray[indices[3]];

	float3 view_pos = mul(i.Pos,weighted_transform);
	o.Pos = mul(float4(view_pos,1.0),m_projection);

	// We expect the assembly to be something like this.  In FX Composer
	// it is much worse but looking at the output from FXC.exe indicates
	// that with optimzations enabled, the HLSL compiler is doing a good job.
	//
	// v0 = input_pos
	// v1 = input_weights
	// v2 = input_indices
	// weighted_transform => r2,r3,r4
	//
	// def c82 765.01,1,0,0
	// mov r0, [weights]
	// mul r1, [indices].zyxw, c82.xxxx
	// mov a0.x, r1.x;
	// mul r2,r0.x,c[a0.x + 0 + matrix_palette_base];
	// mul r3,r0.x,c[a0.x + 1 + matrix_palette_base];
	// mul r4,r0.x,c[a0.x + 2 + matrix_palette_base];
	// mov a0.x, r1.y;
	// mad r2,r0.y,c[a0.x + 0 + matrix_palette_base];
	// mad r3,r0.y,c[a0.x + 1 + matrix_palette_base];
	// mad r4,r0.y,c[a0.x + 2 + matrix_palette_base];
	// mov a0.x, r1.z;
	// mad r2,r0.z,c[a0.x + 0 + matrix_palette_base];
	// mad r3,r0.z,c[a0.x + 1 + matrix_palette_base];
	// mad r4,r0.z,c[a0.x + 2 + matrix_palette_base];
	// mov a0.x, r1.w;
	// mad r2,r0.w,c[a0.x + 0 + matrix_palette_base];
	// mad r3,r0.w,c[a0.x + 1 + matrix_palette_base];
	// mad r4,r0.w,c[a0.x + 2 + matrix_palette_base];
	// dp4 r0.x, r2, v0		// transform to view space
	// dp4 r0.y, r3, v0
	// dp4 r0.z, r4, v0
	// mov r0.w, c82.y
	// dp4 oPos.x, [project_0], r0	// project
	// dp4 oPos.y, [project_1], r0
	// dp4 oPos.z, [project_2], r0
	// dp4 oPos.w, [project_3], r0
	
    return o;
}

VS_OUTPUT vs_max_main(VS_INPUT i)
{
    VS_OUTPUT   o = (VS_OUTPUT)0;
	float3 view_pos = mul(i.Pos,m_worldView);
	o.Pos = mul(float4(view_pos,1.0),m_projection);
    return o;
}

float4 ps_main(VS_OUTPUT i) : COLOR
{
	return float4(1,0,0,1);
}

technique max_viewport
{
	pass max_viewport_p0
	{
		CullMode=none;
		
		// blend mode
		ZWriteEnable = TRUE;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		
		VertexShader = compile vs_1_1 vs_max_main();
		PixelShader = compile ps_1_1 ps_main();
	}
}

technique t0
{
    pass t0_p0
    {
		// blend mode
		ZWriteEnable = TRUE;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;

        VertexShader = compile vs_1_1 vs_main();
    	PixelShader = compile ps_1_1 ps_main();
    }
}
