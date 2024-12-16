///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/RSkinGlossColorize.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Skinning shader with gloss and colorization.  
	Base texture is diffuse and colorization mask.
	Gloss texture uses the red channel as a grey-scale specular mask.
	
*/

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_PROC = "RSkin";
string _ALAMO_VERTEX_TYPE = "alD3dVertRSkinNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
int _ALAMO_BONES_PER_VERTEX = 1;
	

#include "AlamoEngineSkinning.fxh"
#include "GlossColorize.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4  Pos             : POSITION;
    float4  Normal          : NORMAL;       // Normal.w = skin binding
    float2  Tex0            : TEXCOORD0;
};

VS_OUTPUT sph_do_shading(VS_INPUT In,float3 P,float3 N)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	// Given world-space position and normal, compute the shading
	Out.Pos = mul(float4(P,1.0),m_viewProj);
   	float3 spec_light = Compute_Specular_Light(P,N);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(N);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse.rgb * diff_light * m_lightScale.rgb + Emissive, m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);
	
    // copy the input texture coordinate through
    Out.Tex0 = Unpack_UV(In.Tex0);
	Out.Tex1 = Out.Tex0;
	
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	 
    return Out;
}

VS_OUTPUT max_do_shading(VS_INPUT In,float3 P,float3 N)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	// Given world-space position and normal, compute the shading
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(N);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse.rgb * diff_light * m_lightScale.rgb + Emissive, m_lightScale.a);
	
    // copy the input texture coordinate through
    Out.Tex0 = In.Tex0;
	Out.Tex1 = In.Tex0;
	
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	 
    return Out;
}

VS_OUTPUT sph_vs_main(VS_INPUT In)
{
    // Look up the transform for this vertex
    //int4 indices = D3DCOLORtoUBYTE4(In.BlendIndices);
    int index = In.Normal.w;
    float4x3 transform = m_skinMatrixArray[index];

	// Transform position and compute lighting
	float3 P = mul(In.Pos,transform);
	float3 N = normalize(mul(In.Normal.xyz,(float3x3)transform));

	return sph_do_shading(In,P,N);
}

VS_OUTPUT vs_max_main(VS_INPUT In)
{
	// Transform position and normal to view space
	// In MAX we skip the skinning stuff since it rebuilds the mesh for
	// us each frame.
	float3 P = mul(In.Pos,m_world);
	float3 N = normalize(mul(In.Normal.xyz,(float3x3)m_world));

	return max_do_shading(In,P,N);
}

// Compiled shader programs
vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
pixelshader gloss_colorize_ps_main_bin = compile ps_1_1 gloss_colorize_ps_main();


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
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;

        SB_END        

        // shader programs
        VertexShader = (vs_max_main_bin);
    	PixelShader = (gloss_colorize_ps_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
    }
}

technique sph_t0
<
	string LOD="DX8";
>
{
    pass sph_t0_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;

        SB_END        

		// shader programs
        VertexShader = (sph_vs_main_bin);
    	PixelShader = (gloss_colorize_ps_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
    }
}

technique sph_t1
<
	string LOD="FIXEDFUNCTION";
	bool CPUSKIN=true;
>
{
    pass sph_t1_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    
            // fixed function pixel pipeline
    		Lighting=true;
    		
    		ColorOp[0]=BLENDTEXTUREALPHA;
    		ColorArg1[0]=TFACTOR;
    		ColorArg2[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
    		ColorOp[1]=MODULATE2X;
    		ColorArg1[1]=CURRENT;
    		ColorArg2[1]=DIFFUSE;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=DIFFUSE;
    		
    		ColorOp[2] = DISABLE;
    		AlphaOp[2] = DISABLE;
    

        SB_END        

		// shader programs
        VertexShader = NULL; 
    	PixelShader = NULL;

   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
		MaterialAmbient = (Diffuse);
		MaterialDiffuse = (float4(Diffuse.rgb*m_lightScale.rgb,m_lightScale.a));
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;
		Texture[0]=(BaseTexture);
		TextureFactor=(Colorization);

    }
}

