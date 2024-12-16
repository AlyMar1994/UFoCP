///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshAdditiveReflection.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse + Cube Reflection, colorization.
	First directional light does dot3 diffuse bump mapping.
	Spec reflection from a cube-map sample is modulated by spec color and alpha channel of the bump map(gloss)
	Colorization mask is in the alpha channel of the base texture (as always!).
    
*/

string _ALAMO_RENDER_PHASE = "TerrainMesh";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2C";
bool _ALAMO_TANGENT_SPACE = false; 
bool _ALAMO_SHADOW_VOLUME = false;


#include "AdditiveReflection.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shaders
//
///////////////////////////////////////////////////////
VS_OUTPUT additive_reflect_vs_main(VS_INPUT_MESH In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);

	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));

	// Output the world-space reflection vector
	float3 v = normalize(m_eyePos-world_pos);
	float3 r = -v + 2.0f*dot(v,world_normal)*world_normal;
    Out.ReflectionVector = normalize(r);

	// Output final vertex lighting colors:
    Out.Diff = In.Diff;
    Out.Diff.xyz *= Color;

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

vertexshader additive_reflect_vs_main_bin = compile vs_1_1 additive_reflect_vs_main();
pixelshader additive_reflect_ps11_main_bin = compile ps_1_1 additive_reflect_ps11_main();


//////////////////////////////////////
// Techniques follow
//////////////////////////////////////

technique sph_t2
<
	string LOD="DX8";
>
{
    pass sph_t2_p0
    {
        // blend mode
        ZWriteEnable = false;
        ZFunc = LESSEQUAL;
        DestBlend = ONE;
        SrcBlend = ONE;
        AlphaBlendEnable = true; 
    		
        // shaders 
        VertexShader = (additive_reflect_vs_main_bin);
        PixelShader  = (additive_reflect_ps11_main_bin);
    }  
}


