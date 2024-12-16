///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshLightVisualize.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Spherical Harmonics lighting visualization
	
	
*/

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;


#include "AlamoEngine.fxh"


///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////

struct VS_OUTPUT
{
    float4  Pos     : POSITION;
    float4  Diff	: COLOR0;
    float2  Tex0    : TEXCOORD0;
};

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float3 Norm : NORMAL;
};

VS_OUTPUT sph_vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);

    // Lighting in view space:
    float3 world_pos = mul(In.Pos, m_world);
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world));
    float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);
    float3 spec_light = Compute_Specular_Light(world_pos,world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(diff_light, 1);

    return Out;
}

float4 sph_ps_main(VS_OUTPUT In) : COLOR
{
	return 2.0f * In.Diff;
}


vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
pixelshader sph_ps_main_bin = compile ps_1_1 sph_ps_main();


//////////////////////////////////////
// Techniques follow
//////////////////////////////////////
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
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    
        SB_END        

        // shader programs
        VertexShader = (sph_vs_main_bin);
        PixelShader = (sph_ps_main_bin);
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
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    
            // fixed function pixel pipeline
    		Lighting=true;
    		
    		ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=DIFFUSE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=DIFFUSE;
    
    		ColorOp[1] = DISABLE;
    		AlphaOp[1] = DISABLE;

        SB_END        

        VertexShader = NULL;
        PixelShader = NULL;

        MaterialAmbient = (float4(0,0,0,0));
		MaterialDiffuse = (float4(1,1,1,1));
		MaterialSpecular = (float4(0,0,0,0));
		MaterialEmissive = (float4(0,0,0,0));
		MaterialPower = 32.0f;
    }
}

