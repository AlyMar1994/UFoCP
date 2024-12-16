///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/RSkinGloss.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Rigid matrix-palette skinning.
	2x Diffuse+Spec lighting.
	Spec is modulated by alpha channel of the texture (gloss).

	
*/

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_PROC = "RSkin";
string _ALAMO_VERTEX_TYPE = "alD3dVertRSkinNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
int _ALAMO_BONES_PER_VERTEX = 1;


#include "AlamoEngineSkinning.fxh"
#include "Gloss.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////

VS_OUTPUT sph_do_shading(VS_INPUT_SKIN In,float3 P,float3 N)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;
	Out.Pos = mul(float4(P,1.0),m_viewProj);

	// Given world-space position and normal, compute the shading
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	float3 spec_light = Compute_Specular_Light(P,N);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(N);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse.rgb * diff_light * m_lightScale.rgb + Emissive, m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);

    return Out;
}

VS_OUTPUT min_do_shading(VS_INPUT_SKIN In,float3 P,float3 N)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;
	Out.Pos = mul(float4(P,1.0),m_viewProj);

	// Given world-space position and normal, compute the shading
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(N);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse.rgb * diff_light * m_lightScale.rgb + Emissive, m_lightScale.a);

    return Out;
}

VS_OUTPUT sph_vs_main(VS_INPUT_SKIN In)
{
    // Look up the transform for this vertex
    //int4 indices = D3DCOLORtoUBYTE4(In.BlendIndices);
    int index = In.Normal.w;
    float4x3 transform = m_skinMatrixArray[index];

	// Transform position and normal to world space
	float3 P = mul(In.Pos,transform);
	float3 N = normalize(mul(In.Normal.xyz,(float3x3)transform));

	VS_OUTPUT Out = sph_do_shading(In,P,N);

    // copy the input texture coordinate through
    Out.Tex0  = Unpack_UV(In.Tex0);
    
    // Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}

VS_OUTPUT vs_max_main(VS_INPUT_SKIN In)
{
	// Transform position and normal to world space
	// In MAX we skip the skinning stuff since it rebuilds the mesh for
	// us each frame.
	float3 P = mul(In.Pos,m_world);
	float3 N = normalize(mul(In.Normal.xyz,(float3x3)m_world));

	VS_OUTPUT Out = sph_do_shading(In,P,N);

    // copy the input texture coordinate through
    Out.Tex0  = In.Tex0;

    return Out;
}

// Compiled shader programs
vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
pixelshader gloss_ps_main_bin = compile ps_1_1 gloss_ps_main();


//////////////////////////////////////
// Techniques specs follow
//////////////////////////////////////
technique max_viewport
{
    pass max_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;

        SB_END        

		// shader programs
        VertexShader = (vs_max_main_bin);
    	PixelShader = (gloss_ps_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
    }
}

technique sph_t1
<
	string LOD="DX8";
>
{
    pass sph_t1_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;

        SB_END        

		// shader programs
		VertexShader = (sph_vs_main_bin);
    	PixelShader = (gloss_ps_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
    }
}

technique sph_t0
<
	string LOD="FIXEDFUNCTION";
	bool CPUSKIN=true;
>
{
    pass sph_t0_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    
            // fixed function pixel pipeline
    		ColorOp[0]=MODULATE2X;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=DIFFUSE;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;
    

        SB_END        

   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
		MaterialAmbient = (Diffuse);
        MaterialDiffuse = (float4(Diffuse.rgb*m_lightScale.rgb,m_lightScale.a));
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;

		VertexShader = NULL; 
    	PixelShader = NULL;
		Texture[0]=(BaseTexture);
    }
}


