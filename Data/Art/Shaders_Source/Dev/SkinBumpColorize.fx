///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Dev/SkinBumpColorize.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse+Spec lighting, colorization.
	First directional light does dot3 diffuse bump mapping.
	Spec is modulated by alpha channel of the texture (gloss)
	Colorization mask is in the alpha channel of the normal/bump texture.

	_ALAMO_VERTEX_TYPE = alD3dVertB4I4NU2U3U3
	_ALAMO_TANGENT_SPACE = 1
	_ALAMO_SHADOW_VOLUME = 0
	_ALAMO_BONES_PER_VERTEX = 3
	
*/

string RenderPhase = "Opaque";

#include "BumpColorize.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////

VS_OUTPUT sph_do_shading(VS_INPUT_SKIN In,float3 P,float3 N,float3 B,float3 T)
{
    VS_OUTPUT   Out = (VS_OUTPUT)0;
     
	// project the point
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	
    // copy the input texture coordinates through
    Out.Tex0 = In.Tex;
	Out.Tex1 = In.Tex;
	
	// Compute the tangent-space light vector for per-pixel lighting
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(T,B,N);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0Vector,to_tangent_matrix);

    // Lighting in world space:
	float3 spec_light = Compute_Specular_Light(P,N);
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(N);

	// Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light /*+ Emissive*/, 1);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	float fog = length(Out.Pos.xyz);
	Out.Fog = clamp(m_fogSlope * fog + m_fogOffset,0,1);

    return Out;
}

VS_OUTPUT do_shading(VS_INPUT_SKIN In,float3 P,float3 N,float3 B,float3 T)
{
    VS_OUTPUT   Out = (VS_OUTPUT)0;
     
	// project the point
	Out.Pos = mul(float4(P,1.0),m_viewProj);

    // copy the input texture coordinates through
    Out.Tex0 = In.Tex;
	Out.Tex1 = In.Tex;

	// Compute the tangent-space light vector for per-pixel lighting
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(T,B,N);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0Vector,to_tangent_matrix);

    // Lighting in world space:
	float3 spec_light = Compute_Specular_Light(P,N);
	float3 diff_light = Compute_Diffuse_Light_Fill(N);

	// Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light /*+Emissive*/, 1);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

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
	float3 N = mul(In.Normal,(float3x3)weighted_transform);
	float3 B = mul(In.Binormal,(float3x3)weighted_transform);
	float3 T = mul(In.Tangent,(float3x3)weighted_transform);

	return sph_do_shading(In,P,N,B,T);
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
	float3 N = mul(In.Normal,(float3x3)weighted_transform);
	float3 B = mul(In.Binormal,(float3x3)weighted_transform);
	float3 T = mul(In.Tangent,(float3x3)weighted_transform);

	return do_shading(In,P,N,B,T);
}

VS_OUTPUT vs_max_main(VS_INPUT_SKIN In)
{
	// Transform position, normal, and tangent vectors to view space
	// In MAX we skip the skinning stuff since it rebuilds the mesh for
	// us each frame.
	float3 P = mul(In.Pos,m_world);
	float3 N = mul(In.Normal,(float3x3)m_world);
	float3 B = mul(In.Binormal,(float3x3)m_world);
	float3 T = mul(In.Tangent,(float3x3)m_world);
	
	return do_shading(In,P,N,B,T);
}


/////////////////////////////////////////////////////////////////////////////
//
// VS1.1, PS1.1 Fallback, this shader is taking too many instructions
// for the older dx8-class cards so we'll drop bump-mapping in that case
// It would be nice to find a way to share more of the HLSL code between
// the two but whatever I try seems to cause runtime branching, etc which
// is not what I want...  This may also be a case where we should write
// the shader in assembly and squeeeeeze it into vs1.1 but we'll leave that
// for later!
//
/////////////////////////////////////////////////////////////////////////////
VS_OUTPUT do_vs11_shading(VS_INPUT_SKIN In,float3 P,float3 N)
{
    VS_OUTPUT   Out = (VS_OUTPUT)0;
     
	// compute view space and projected position
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	
    // copy the input texture coordinates through
    Out.Tex0 = In.Tex;
	Out.Tex1 = In.Tex;
	
    // Lighting in world space:
	float3 spec_light = Compute_Specular_Light(P,N);
	float3 diff_light = Compute_Diffuse_Light_All(N);

	// Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light /*+Emissive*/, 1);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	float fog = length(Out.Pos.xyz);
	Out.Fog = clamp(m_fogSlope * fog + m_fogOffset,0,1);

    return Out;
}

VS_OUTPUT vs11_main(VS_INPUT_SKIN In)
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
	float3 N = mul(In.Normal,(float3x3)weighted_transform);
	return do_vs11_shading(In,P,N);
}

vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
vertexshader vs_main_bin = compile vs_1_1 vs_main();
vertexshader vs11_main_bin = compile vs_1_1 vs11_main();
vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
pixelshader bump_colorize_ps_main_bin = compile ps_1_1 bump_colorize_ps_main();
pixelshader bump_colorize_ps11_main_bin = compile ps_1_1 bump_colorize_ps11_main();


//////////////////////////////////////
// Techniques specs follow
//////////////////////////////////////
technique max_viewport
{
    pass max_p0
    {
        // blend mode
		ZWriteEnable = true;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;

		// shader programs
        VertexShader = (vs_max_main_bin);
    	PixelShader = (bump_colorize_ps_main_bin);
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
		ZWriteEnable = true;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		
		// shader programs
        VertexShader = (sph_vs_main_bin);
    	PixelShader = (bump_colorize_ps_main_bin);
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
		ZWriteEnable = true;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		
		// shader programs
        VertexShader = (vs_main_bin);
    	PixelShader = (bump_colorize_ps_main_bin);
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
		ZWriteEnable = true;
		ZFunc = LESSEQUAL;
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
		Texture[0]=(NormalTexture);
        Texture[1]=(BaseTexture);
        Texture[2]=(BaseTexture);
 		TextureFactor=(Colorization);
 		MinFilter[0]=LINEAR;
		MagFilter[0]=LINEAR;
		MipFilter[0]=LINEAR;
        MinFilter[1]=LINEAR;
		MagFilter[1]=LINEAR;
		MipFilter[1]=LINEAR;
        MinFilter[2]=LINEAR;
		MagFilter[2]=LINEAR;
		MipFilter[2]=LINEAR;


		ColorOp[0]=SELECTARG1;
		ColorArg1[0]=TEXTURE;
		AlphaOp[0]=SELECTARG1;
		AlphaArg1[0]=TEXTURE;
		
		ColorOp[1]=MODULATE2x;
		ColorArg1[1]=TEXTURE;
		ColorArg2[1]=DIFFUSE;
		AlphaOp[1]=SELECTARG1;
		AlphaArg1[1]=CURRENT;
		
/*
		ColorOp[2]=MODULATEALPHA_ADDCOLOR;
		ColorArg1[2]=CURRENT;
		ColorArg2[2]=TFACTOR;
		AlphaOp[2]=SELECTARG1;
		AlphaArg1[2]=CURRENT | COMPLEMENT;
*/
		ColorOp[2]=DISABLE;
		AlphaOp[2]=DISABLE;
    }
}
