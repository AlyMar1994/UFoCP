///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Dev/SkinGloss.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Matrix-palette skinning.
	2x Diffuse+Spec lighting, colorization.
	Spec is modulated by alpha channel of the texture (gloss).
	Colorization mask is in the rgb channel (assumed greyscale) of the base texture.

	_ALAMO_VERTEX_TYPE = alD3dVertB4I4NU2
	_ALAMO_TANGENT_SPACE = 0
	_ALAMO_SHADOW_VOLUME = 0
	_ALAMO_BONES_PER_VERTEX = 3
	
*/

string RenderPhase = "Opaque";

#include "Gloss.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////

VS_OUTPUT sph_do_shading(VS_INPUT_SKIN In,float3 P,float3 N)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	// Given world-space position and normal, compute the shading
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	float3 spec_light = Compute_Specular_Light(P,N);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(N);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light + Emissive, 1);
    Out.Spec = float4(Specular * spec_light, 1);
	
    // copy the input texture coordinate through
    Out.Tex0  = In.Tex0.xy;
    
    return Out;
}

VS_OUTPUT do_shading(VS_INPUT_SKIN In,float3 P,float3 N)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	// Given world-space position and normal, compute the shading
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	float3 spec_light = Compute_Specular_Light(P,N);
	float3 diff_light = Compute_Diffuse_Light_All(N);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light + Emissive, 1);
    Out.Spec = float4(Specular * spec_light, 1);
	
    // copy the input texture coordinate through
    Out.Tex0  = In.Tex0.xy;
    
    return Out;
}


VS_OUTPUT sph_vs_main(VS_INPUT_SKIN In)
{
    // Compensate for lack of UBYTE4 on Geforce3
    int4		indices = D3DCOLORtoUBYTE4(In.BlendIndices);

    // calculate the weighted transform to apply to the normal and position
    float4x3 weighted_transform;
	weighted_transform = In.BlendWeights[0] * m_skinMatrixArray[indices[0]];
	weighted_transform += In.BlendWeights[1] * m_skinMatrixArray[indices[1]];
	weighted_transform += In.BlendWeights[2] * m_skinMatrixArray[indices[2]];
	//weighted_transform += In.BlendWeights[3] * m_skinMatrixArray[indices[3]];

	// Transform position and compute lighting
	float3 P = mul(In.Pos,weighted_transform);
	float3 N = normalize(mul(In.Normal,(float3x3)weighted_transform));

	VS_OUTPUT Out = sph_do_shading(In,P,N);

    // Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}

VS_OUTPUT vs_main(VS_INPUT_SKIN In)
{
    // Compensate for lack of UBYTE4 on Geforce3
    int4		indices = D3DCOLORtoUBYTE4(In.BlendIndices);

    // calculate the weighted transform to apply to the normal and position
    float4x3 weighted_transform;
	weighted_transform = In.BlendWeights[0] * m_skinMatrixArray[indices[0]];
	weighted_transform += In.BlendWeights[1] * m_skinMatrixArray[indices[1]];
	weighted_transform += In.BlendWeights[2] * m_skinMatrixArray[indices[2]];
	//weighted_transform += In.BlendWeights[3] * m_skinMatrixArray[indices[3]];

	// Transform position and compute lighting
	float3 P = mul(In.Pos,weighted_transform);
	float3 N = normalize(mul(In.Normal,(float3x3)weighted_transform));

	VS_OUTPUT Out = do_shading(In,P,N);

    // Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}

VS_OUTPUT vs_max_main(VS_INPUT_SKIN In)
{
	// Transform position and normal to view space
	// In MAX we skip the skinning stuff since it rebuilds the mesh for
	// us each frame.
	float3 P = mul(In.Pos,m_world);
	float3 N = normalize(mul(In.Normal,(float3x3)m_world));

	return do_shading(In,P,N);
}

vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
vertexshader vs_main_bin = compile vs_1_1 vs_main();
vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
pixelshader gloss_ps_main_bin = compile ps_1_1 gloss_ps_main();


//////////////////////////////////////
// Techniques specs follow
//////////////////////////////////////
technique max_viewport
{
    pass max_p0
    {
		// blend mode
		ZWriteEnable = TRUE;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;

		// shader programs
        VertexShader = (vs_max_main_bin);
    	PixelShader = (gloss_ps_main_bin);
    }
}

technique sph_t0
<
	string LOD="DX8";
>
{
    pass sph_t0_p0
    {
		// blend mode
		ZWriteEnable = TRUE;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;

		// shader programs
		VertexShader = (sph_vs_main_bin);
    	PixelShader = (gloss_ps_main_bin);
    }
}

technique t0
<
	string LOD="DX8";
>
{
    pass t0_p0
    {
		// blend mode
		ZWriteEnable = TRUE;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;

		// shader programs
		VertexShader = (vs_main_bin);
    	PixelShader = (gloss_ps_main_bin);
    }
}

technique sph_t1
<
	string LOD="FIXEDFUNCTION";
>
{
    pass sph_t1_p0
    {
		// blend mode
		ZWriteEnable = TRUE;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;

		// shader programs
		VertexShader = NULL;
    	PixelShader = NULL;
    	
		MaterialAmbient = (Diffuse);
		MaterialDiffuse = (Diffuse);
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;
		 
        // fixed function pixel pipeline
		Texture[0]=(BaseTexture);
		MinFilter[0]=LINEAR;
		MagFilter[0]=LINEAR;
		MipFilter[0]=LINEAR;
		
		ColorOp[0]=MODULATE2X;
		ColorArg1[0]=TEXTURE;
		ColorArg2[0]=DIFFUSE;
		AlphaOp[0]=SELECTARG1;
		AlphaArg1[0]=TEXTURE;
		
		ColorOp[1]=MODULATEALPHA_ADDCOLOR;
		ColorArg1[1]=CURRENT;
		ColorArg2[1]=SPECULAR;
		AlphaOp[1]=SELECTARG1;
		AlphaArg1[1]=CURRENT;
		
		ColorOp[2]=DISABLE;
		AlphaOp[2]=DISABLE;
    }
}
