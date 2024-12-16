///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshBumpColorize.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse+Spec lighting, colorization.
	First directional light does dot3 diffuse bump mapping.
	Colorization mask is in the alpha channel of the base texture.
	Spec is modulated by alpha channel of the normal map (gloss)
    
*/

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2U3U3";
bool _ALAMO_TANGENT_SPACE = true; 
bool _ALAMO_SHADOW_VOLUME = false;


#include "BumpColorize.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shaders
//
///////////////////////////////////////////////////////
VS_OUTPUT sph_bump_spec_vs_main(VS_INPUT_MESH In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex + UVOffset;                                       
	Out.Tex1 = In.Tex + UVOffset;

	// Compute the tangent-space light vector and half-angle vector for per-pixel lighting
	// Note that we are doing everything in object space here.
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(In.Tangent,In.Binormal,In.Normal);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);
	Out.HalfAngleVector = Compute_Tangent_Space_Half_Vector(In.Pos,m_eyePosObj,m_light0ObjVector,to_tangent_matrix);

	// Fill lighting is applied per-vertex.  This must be computed in
	// world space for spherical harmonics to work.
	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse.rgb * m_lightScale.rgb + Emissive, m_lightScale.a);  
    Out.Spec = float4(0,0,0,1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

VS_OUTPUT sph_bump_vs_main(VS_INPUT_MESH In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex + UVOffset;                                       
 	Out.Tex1 = In.Tex + UVOffset;

	// Compute the tangent-space light vector
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(In.Tangent,In.Binormal,In.Normal);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);

    // Vertex lighting, diffuse fill lights + spec for main light
	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(world_normal);
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse.rgb * m_lightScale.rgb + Emissive, m_lightScale.a);
    Out.Spec = float4(spec_light * Specular, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
    
    return Out;
}


vertexshader sph_bump_spec_vs_main_bin = compile vs_1_1 sph_bump_spec_vs_main();
vertexshader sph_bump_vs_main_bin = compile vs_1_1 sph_bump_vs_main();
pixelshader bump_spec_colorize_ps_main_bin = compile ps_2_0 bump_spec_colorize_ps_main();
pixelshader bump_colorize_ps_main_bin = compile ps_1_1 bump_colorize_ps_main();


//////////////////////////////////////
// Techniques follow
//////////////////////////////////////
technique max_viewport
{
    pass max_viewport_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    	    AlphaBlendEnable = false;
        SB_END        

        // shaders 
        VertexShader = (sph_bump_spec_vs_main_bin);
        PixelShader  = (bump_spec_colorize_ps_main_bin);
    }  
}

technique sph_t2
<
	string LOD="DX9";
>
{
    pass sph_t2_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
       		//AlphaBlendEnable = false; 
    		
        SB_END        

        // shaders 
        VertexShader = (sph_bump_spec_vs_main_bin);
        PixelShader  = (bump_spec_colorize_ps_main_bin);
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
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
        SB_END        

        // shaders
        VertexShader = (sph_bump_vs_main_bin);
        PixelShader  = (bump_colorize_ps_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 

    }  
}

technique t0
<
	string LOD="FIXEDFUNCTION";
>
{
    pass t0_p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
            // fixed function pixel pipeline
    		Lighting=true;
    		 
    		MinFilter[0]=LINEAR;
    		MagFilter[0]=LINEAR;
    		MipFilter[0]=LINEAR;
    		AddressU[0]=wrap;
    		AddressV[0]=wrap;
    		TexCoordIndex[0]=0;
    
    		ColorOp[0]=BLENDTEXTUREALPHA;
    		ColorArg1[0]=TFACTOR;
    		ColorArg2[0]=TEXTURE; 
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
    		ColorOp[1]=MODULATE2X;
    		ColorArg1[1]=DIFFUSE;
    		ColorArg2[1]=CURRENT;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=DIFFUSE;
    		
    		ColorOp[2] = DISABLE;
    		AlphaOp[2] = DISABLE;

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
		TextureFactor=(Colorization);
    }  
}


