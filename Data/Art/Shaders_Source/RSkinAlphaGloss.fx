///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/RSkinAlphaGloss.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Skinning shader with alpha blending and gloss.  
	2x Diffuse+Spec lighting.
	Alpha Blending is taken from the alpha channel of the base texture texture
	Spec is modulated by the red channel of the gloss texture (assumed greyscale)
	
	
*/

string _ALAMO_RENDER_PHASE = "Transparent";
string _ALAMO_VERTEX_PROC = "RSkin";
string _ALAMO_VERTEX_TYPE = "alD3dVertRSkinNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
int _ALAMO_BONES_PER_VERTEX = 1;


#include "AlamoEngineSkinning.fxh"
#include "AlphaGloss.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shaders
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
    Out.Diff = float4(Diffuse.rgb * diff_light * m_lightScale.rgb + Emissive, Diffuse.a * m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);
	
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	 
    return Out;
}

VS_OUTPUT sph_vs_main(VS_INPUT In)
{
    // calculate the weighted transform to apply to the normal and position
    //int4 indices = D3DCOLORtoUBYTE4(In.BlendIndices);
    int index = In.Normal.w;
    float4x3 transform = m_skinMatrixArray[index];

	// Transform position and compute lighting
	float3 P = mul(In.Pos,transform);
	float3 N = normalize(mul(In.Normal.xyz,(float3x3)transform));

	VS_OUTPUT Out = sph_do_shading(In,P,N);

    // copy the input texture coordinate through
    Out.Tex0 = Unpack_UV(In.Tex0);
	Out.Tex1 = Out.Tex0;

    return Out;
}

VS_OUTPUT vs_max_main(VS_INPUT In)
{
	// Transform position and normal to world space
	// In MAX we skip the skinning stuff since it rebuilds the mesh for
	// us each frame.
	float3 P = mul(In.Pos,m_world);
	float3 N = normalize(mul(In.Normal.xyz,(float3x3)m_world));

	VS_OUTPUT Out = sph_do_shading(In,P,N);

    // copy the input texture coordinate through (in Max, its not packed into a short)
    Out.Tex0 = In.Tex0;
	Out.Tex1 = Out.Tex0;

    return Out;
}

vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
pixelshader alpha_gloss_ps_main_bin = compile ps_1_1 alpha_gloss_ps_main();

//////////////////////////////////////
// Techniques specs follow
//////////////////////////////////////

technique max_viewport 
{
    pass max_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable=false;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    
        SB_END        

        // shader programs
        VertexShader = (vs_max_main_bin);
        PixelShader = (alpha_gloss_ps_main_bin);
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
    		ZWriteEnable=false;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;
    
        SB_END        

        // shader programs
        VertexShader = (sph_vs_main_bin);
        PixelShader = (alpha_gloss_ps_main_bin);
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
    		ZWriteEnable=false;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;
    
            // fixed function pixel pipeline
            ColorOp[0]=MODULATE2X;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=MODULATE;
    		AlphaArg1[0]=TEXTURE;
    		AlphaArg2[0]=DIFFUSE;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;
    

        SB_END        

        VertexShader = NULL; 
        PixelShader = NULL;

		MaterialAmbient = (Diffuse);
		MaterialDiffuse = (Diffuse * m_lightScale);
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;
        	
        Texture[0]=(BaseTexture);
    }
}

