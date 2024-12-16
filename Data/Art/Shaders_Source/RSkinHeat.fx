///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/RSkinHeat.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/09/12 08:51:59 $
//          $Revision: #2 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	This shader is for rigid skin mesh which are to generate heat distortions.  It just has to 
    alpha blend its bump texture into the full-screen distortion texture. 
	
*/

string _ALAMO_RENDER_PHASE = "Heat";
string _ALAMO_VERTEX_PROC = "RSkin";
string _ALAMO_VERTEX_TYPE = "alD3dVertRSkinNU2C";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
int	_ALAMO_BONES_PER_VERTEX = 1;


#include "AlamoEngineSkinning.fxh"
#include "Heat.fxh"


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4  Pos             : POSITION;
    float4  Normal          : NORMAL;       // Normal.w = skin binding
    float4  Color0          : COLOR0;
    float3  Tex0            : TEXCOORD0;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;
    
    // Look up the transform for this vertex
    //int4 indices = D3DCOLORtoUBYTE4(In.BlendIndices);
    int index = In.Normal.w;
    float4x3 transform = m_skinMatrixArray[index];

	// Outputs
	float3 P = mul(In.Pos,transform); 
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	Out.Diff = In.Color0;
	Out.Tex = In.Tex0 + m_time*UVScrollRate;

	// Fog
	Out.Fog = 1.0f; //Compute_Fog(Out.Pos.xyz);

	return Out;
}

VS_OUTPUT vs_max_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	// Transform position and normal to view space
	// In MAX we skip the skinning stuff since it rebuilds the mesh for
	// us each frame.
	float3 P = mul(In.Pos,m_world); 
	Out.Pos = mul(float4(P,1.0),m_viewProj);
	Out.Diff = In.Color0;
	Out.Tex = In.Tex0 + m_time*UVScrollRate;
	Out.Fog = 1.0;
	
	return Out;
}

vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
vertexshader vs_main_bin = compile vs_1_1 vs_main();
pixelshader heat_ps_main_bin = compile ps_1_1 heat_ps_main();


//////////////////////////////////////
// Techniques specs follow
//////////////////////////////////////
technique max_viewport
{
    pass max_p0
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
	
		// shader programs
        VertexShader = (vs_max_main_bin);
    	PixelShader = (heat_ps_main_bin);
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
    		ZWriteEnable = FALSE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;

        SB_END        

		// shader programs
		VertexShader = (vs_main_bin);
    	PixelShader = (heat_ps_main_bin);
    }
}

// No fixed function fallback because we don't enable heat distortions on fixed function hardware.
