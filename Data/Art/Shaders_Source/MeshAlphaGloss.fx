///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshAlphaGloss.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse+Spec lighting with alpha blending.
	Alpha Blending is taken from the alpha channel of the base texture texture
	Spec is modulated by the red channel of the gloss texture (assumed greyscale)
	
	
*/

string _ALAMO_RENDER_PHASE = "Transparent";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;


#include "AlphaGloss.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float3 Norm : NORMAL;
    float2 Tex  : TEXCOORD0;
};

VS_OUTPUT sph_vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;
	Out.Tex1 = In.Tex;	

	// World-space lighting
    float3 world_pos = mul(In.Pos, m_world);	
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world)); 
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light * m_lightScale.rgb + Emissive, Diffuse.a * m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;
	Out.Tex1 = In.Tex;	

	// World-space lighting
    float3 world_pos = mul(In.Pos, m_world);	
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world)); 
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light * m_lightScale.rgb + Emissive, Diffuse.a * m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
vertexshader vs_main_bin = compile vs_1_1 vs_main();
pixelshader alpha_gloss_ps_main_bin = compile ps_1_1 alpha_gloss_ps_main();


//////////////////////////////////////
// Techniques specs follow
//////////////////////////////////////
technique max_viewport
{
    pass max_viewport_p0
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
        VertexShader = (vs_main_bin);
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

technique t0
<
	string LOD="DX8";
>
{
    pass t0_p0
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
        VertexShader = (vs_main_bin);
        PixelShader = (alpha_gloss_ps_main_bin);

    }
}

technique sph_t1
<
	string LOD="FIXEDFUNCTION";
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
    		
    		Lighting=true;
    		 
            // fixed function pixel pipeline
            MinFilter[0]=LINEAR;
    		MagFilter[0]=LINEAR;
    		MipFilter[0]=LINEAR;
            MinFilter[1]=LINEAR;
    		MagFilter[1]=LINEAR;
    		MipFilter[1]=LINEAR;
    		AddressU[0]=wrap;
    		AddressV[0]=wrap;
    		
            ColorOp[0]=MODULATE2X;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=MODULATE;
    		AlphaArg1[0]=TEXTURE;
    		AlphaArg2[0]=DIFFUSE;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;

        SB_END        
        
        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
            
		MaterialAmbient = (Diffuse);
		MaterialDiffuse = (Diffuse * m_lightScale);
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;
        Texture[0]=(BaseTexture);
    }  
}

