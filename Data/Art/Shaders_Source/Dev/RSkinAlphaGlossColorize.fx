///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Dev/RSkinAlphaGlossColorize.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Skinning shader with alpha blending, gloss and colorization.  
	Base texture is diffuse and alpha channel.
	Colorize texture uses the red channel to lerp between base texture and colorization.
	Gloss is taken from the alpha channel of the colorize texture.
	
	_ALAMO_VERTEX_TYPE = alD3dVertB4I4NU2
	_ALAMO_TANGENT_SPACE = 0
	_ALAMO_SHADOW_VOLUME = 0
	_ALAMO_BONES_PER_VERTEX = 1
	
*/

string RenderPhase = "Transparent";

#include "AlphaGlossColorize.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shaders
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4  Pos             : POSITION;
    float4  BlendWeights    : BLENDWEIGHT;
    float4  BlendIndices    : BLENDINDICES;
    float3  Normal          : NORMAL;
    float2  Tex0            : TEXCOORD0;
};

VS_OUTPUT sph_do_shading(VS_INPUT In,float3 P,float3 N)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	// Given world-space position and normal, compute the shading
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	float3 spec_light = Compute_Specular_Light(P,N);
	float3 diff_light = Compute_Diffuse_Light_All(N);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light + Emissive, Diffuse.a);
    Out.Spec = float4(Specular * spec_light, 1);
	
    // copy the input texture coordinate through
    Out.Tex0 = In.Tex0;
	Out.Tex1 = In.Tex0;
	
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	 
    return Out;
}

VS_OUTPUT do_shading(VS_INPUT In,float3 P,float3 N)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	// Given world-space position and normal, compute the shading
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	float3 spec_light = Compute_Specular_Light(P,N);
	float3 diff_light = Compute_Diffuse_Light_All(N);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light + Emissive, Diffuse.a);
    Out.Spec = float4(Specular * spec_light, 1);
	
    // copy the input texture coordinate through
    Out.Tex0 = In.Tex0;
	Out.Tex1 = In.Tex0;
	
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	 
    return Out;
}

VS_OUTPUT sph_vs_main(VS_INPUT In)
{
    // Compensate for lack of UBYTE4 on Geforce3
    int4		indices = D3DCOLORtoUBYTE4(In.BlendIndices);

    // calculate the weighted transform to apply to the normal and position
    float4x3 transform = m_skinMatrixArray[indices[0]];

	// Transform position and compute lighting
	float3 P = mul(In.Pos,transform);
	float3 N = normalize(mul(In.Normal,(float3x3)transform));

	return sph_do_shading(In,P,N);
}

VS_OUTPUT vs_main(VS_INPUT In)
{
    // Compensate for lack of UBYTE4 on Geforce3
    int4		indices = D3DCOLORtoUBYTE4(In.BlendIndices);

    // calculate the weighted transform to apply to the normal and position
    float4x3 transform = m_skinMatrixArray[indices[0]];

	// Transform position and compute lighting
	float3 P = mul(In.Pos,transform);
	float3 N = normalize(mul(In.Normal,(float3x3)transform));

	return do_shading(In,P,N);
}

VS_OUTPUT vs_max_main(VS_INPUT In)
{
	// Transform position and normal to world space
	// In MAX we skip the skinning stuff since it rebuilds the mesh for
	// us each frame.
	float3 P = mul(In.Pos,m_world);
	float3 N = normalize(mul(In.Normal,(float3x3)m_world));

	return do_shading(In,P,N);
}

vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
vertexshader vs_main_bin = compile vs_1_1 vs_main();
vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
pixelshader alpha_gloss_colorize_ps_main_bin = compile ps_1_1 alpha_gloss_colorize_ps_main();

//////////////////////////////////////
// Techniques specs follow
//////////////////////////////////////

technique max_viewport 
{
    pass max_p0
    {
		// blend mode
		ZWriteEnable=false;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = TRUE;
		DestBlend = INVSRCALPHA;
		SrcBlend = SRCALPHA;

        // shader programs
        VertexShader = (vs_max_main_bin);
    	PixelShader = (alpha_gloss_colorize_ps_main_bin);
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
		ZWriteEnable=false;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = TRUE;
		DestBlend = INVSRCALPHA;
		SrcBlend = SRCALPHA;

		// shader programs
        VertexShader = (sph_vs_main_bin);
    	PixelShader = (alpha_gloss_colorize_ps_main_bin);
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
		ZWriteEnable=false;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = TRUE;
		DestBlend = INVSRCALPHA;
		SrcBlend = SRCALPHA;

		// shader programs
        VertexShader = (vs_main_bin); 
    	PixelShader = (alpha_gloss_colorize_ps_main_bin);
    }
}

technique sph_t1 
<
	string LOD="DX8";
>
{
    pass sph_t1_p0
    {
		// blend mode
		ZWriteEnable=false;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = TRUE;
		DestBlend = INVSRCALPHA;
		SrcBlend = SRCALPHA;

		// shader programs
        VertexShader = NULL;
    	PixelShader = NULL;
    	
		Lighting=true;
		MaterialAmbient = (Diffuse);
		MaterialDiffuse = (Diffuse);
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;
		 
        // fixed function pixel pipeline
        Texture[0]=(BaseTexture);
		Texture[1]=(ColorizeTexture);
 		TextureFactor=(Colorization);
        MinFilter[0]=LINEAR;
		MagFilter[0]=LINEAR;
		MipFilter[0]=LINEAR;
        MinFilter[1]=LINEAR;
		MagFilter[1]=LINEAR;
		MipFilter[1]=LINEAR;
		
        ColorOp[0]=MODULATE2X;
		ColorArg1[0]=TEXTURE;
		ColorArg2[0]=DIFFUSE;
		AlphaOp[0]=MODULATE;
		AlphaArg1[0]=TEXTURE;
		AlphaArg2[0]=DIFFUSE;
		
		ColorOp[1]=MULTIPLYADD;
		ColorArg0[1]=CURRENT;
		ColorArg1[1]=TFACTOR;
		ColorArg2[1]=TEXTURE;
		
		AlphaOp[1]=SELECTARG1;
		AlphaArg1[1]=CURRENT;
		
		ColorOp[2]=DISABLE;
		AlphaOp[2]=DISABLE;
    }
}

