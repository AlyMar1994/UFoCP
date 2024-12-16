///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshHeat.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	This shader is for meshes which are to generate heat distortions.  It just has to 
    alpha blend its bump texture into the full-screen distortion texture. 
	
*/

string _ALAMO_RENDER_PHASE = "Heat";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2C";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = false;

#include "Heat.fxh"



///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float3 Pos  : POSITION;
    float2 Tex  : TEXCOORD0;
    float4 Color: COLOR0;
};


VS_OUTPUT heat_vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    Out.Pos  = mul(float4(In.Pos, 1), m_worldViewProj);             // position (projected)
    Out.Diff = In.Color;
    Out.Tex  = In.Tex + m_time*UVScrollRate;                                       

	// Output fog
	Out.Fog = 1.0f; 

    return Out;
}

///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique t0
<
	string LOD="DX8";
>
{
    pass t0_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = FALSE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;
    		
        SB_END        

        VertexShader = compile vs_1_1 heat_vs_main();
        PixelShader  = compile ps_1_1 heat_ps_main();

    }  
}


