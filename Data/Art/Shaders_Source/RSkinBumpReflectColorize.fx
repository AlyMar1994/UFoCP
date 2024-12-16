///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/RSkinBumpReflectColorize.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	RIGID_SKINNING (1 bone per vertex)
	2x Diffuse + Cube Reflection, colorization.
	First directional light does dot3 diffuse bump mapping.
	Spec reflection from a cube-map sample is modulated by spec color and alpha channel of the bump map(gloss)
	Colorization mask is in the alpha channel of the base texture (as always!).
    
*/

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_PROC = "RSkin";
string _ALAMO_VERTEX_TYPE = "alD3dVertRSkinNU2U3U3";
bool _ALAMO_TANGENT_SPACE = true;
bool _ALAMO_SHADOW_VOLUME = false;
int _ALAMO_BONES_PER_VERTEX = 1;


#include "AlamoEngineSkinning.fxh"
#include "BumpReflectColorize.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shaders
//
///////////////////////////////////////////////////////
VS_OUTPUT sph_bump_reflect_colorize_vs_shading(float2 tex,float3 P,float3 T,float3 B,float3 N)
{
    VS_OUTPUT   Out = (VS_OUTPUT)0;
     
	// compute projected position
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	
    // copy the input texture coordinates through
    Out.Tex0 = tex + UVOffset;
	Out.Tex1 = tex + UVOffset;
	
	// Compute the tangent-space light vector and view vector
	// Note that we are working in world space here
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(T,B,N);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0Vector,to_tangent_matrix);

    // Lighting in world space:
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(N);

	// Output the world-space reflection vector
	float3 v = normalize(m_eyePos-P);
	float3 r = -v + 2.0f*dot(v,N)*N;
    Out.ReflectionVector = normalize(r);

	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse.rgb * m_lightScale.rgb + Emissive, m_lightScale.a);  
    Out.Spec = float4(0,0,0,1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

VS_OUTPUT min_vs_shading(float2 tex,float3 P,float3 N)
{
    VS_OUTPUT   Out = (VS_OUTPUT)0;
     
	// compute view space and projected position
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	
    // copy the input texture coordinates through
    Out.Tex0 = tex + UVOffset;
	
    // Lighting in world space:
	float3 diff_light = Sph_Compute_Diffuse_Light_All(N);

	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse.rgb * m_lightScale.rgb + Emissive, m_lightScale.a);  

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}


VS_OUTPUT sph_bump_reflect_vs_main(VS_INPUT_SKIN In)
{
    // Look up the transform for this vertex
    //int4 indices = D3DCOLORtoUBYTE4(In.BlendIndices);
    int index = In.Normal.w;
    float4x3 transform = m_skinMatrixArray[index];

	// Transform position and compute lighting
	float3 P = mul(In.Pos,transform);
	float3 N = normalize(mul(In.Normal.xyz,(float3x3)transform));
	float3 B = mul(In.Binormal,(float3x3)transform);
	float3 T = mul(In.Tangent,(float3x3)transform);

	return sph_bump_reflect_colorize_vs_shading(In.Tex,P,T,B,N);
}


VS_OUTPUT min_vs_main(VS_INPUT_SKIN In)
{
    // Look up the transform for this vertex
    //int4 indices = D3DCOLORtoUBYTE4(In.BlendIndices);
    int index = In.Normal.w;
    float4x3 transform = m_skinMatrixArray[index];

	// Transform position and compute lighting
	float3 P = mul(In.Pos,transform);
	float3 N = normalize(mul(In.Normal.xyz,(float3x3)transform));

	return min_vs_shading(In.Tex,P,N);
}


VS_OUTPUT vs_max_main(VS_INPUT_MESH In)
{
	// Transform position, normal, and tangent vectors to view space
	// In MAX we skip the skinning stuff since it rebuilds the mesh for
	// us each frame.
	float3 P = mul(In.Pos,m_world);
	float3 N = normalize(mul(In.Normal.xyz,(float3x3)m_world));
	float3 B = mul(In.Binormal,(float3x3)m_world);
	float3 T = mul(In.Tangent,(float3x3)m_world);
	
	return sph_bump_reflect_colorize_vs_shading(In.Tex,P,T,B,N);
}

vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
vertexshader sph_bump_reflect_vs_main_bin = compile vs_1_1 sph_bump_reflect_vs_main();
pixelshader bump_reflect_colorize_ps11_main_bin = compile ps_1_1 bump_reflect_colorize_ps11_main();


//////////////////////////////////////
// Techniques specs follow
//////////////////////////////////////
technique max_viewport
{
    pass max_p0
    {
        SB_START

            // blend mode
    		ZWriteEnable = true;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;

        SB_END        

		// shader programs
        VertexShader = (vs_max_main_bin);
    	PixelShader = (bump_reflect_colorize_ps11_main_bin);
    	AlphaBlendEnable = (m_lightScale.w < 1.0f); 
    }
}

technique sph_t2
<
	string LOD="DX8";
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

        SB_END        
		
		// shader programs
        VertexShader = (sph_bump_reflect_vs_main_bin);
    	PixelShader = (bump_reflect_colorize_ps11_main_bin);
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
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
            // fixed function pixel pipeline
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


