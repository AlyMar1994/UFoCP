///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshGloss.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse+Spec lighting
	Spec is modulated by alpha channel of the texture (gloss)

*/

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
	

#include "Gloss.fxh"

///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

VS_OUTPUT sph_vs_main(VS_INPUT_MESH In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;

	// World-space lighting
    float3 world_pos = mul(In.Pos, m_world);	
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world)); 
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse.rgb * diff_light * m_lightScale.rgb + Emissive, m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

vertexshader sph_vs_main_1_1 = compile vs_1_1 sph_vs_main();
pixelshader ps_main_1_1 = compile ps_1_1 gloss_ps_main();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////
technique max_viewport
{
    pass max_viewport_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
        SB_END        

        // shaders
        VertexShader = (sph_vs_main_1_1); 
        PixelShader  = (ps_main_1_1); 
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


        // shaders
        VertexShader = (sph_vs_main_1_1);
        PixelShader  = (ps_main_1_1); 
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 

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
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
            // fixed function pixel pipeline
    		Lighting=true;
    		
    		ColorOp[0]=MODULATE2X;
    		ColorArg1[0]=DIFFUSE;
    		ColorArg2[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=DIFFUSE;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;

        SB_END        

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL; 

   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 

		MaterialAmbient = (Diffuse);
        MaterialDiffuse = (float4(Diffuse.rgb*m_lightScale.rgb,m_lightScale.a));
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;
		 
		Texture[0]=(BaseTexture);
    }  
}


