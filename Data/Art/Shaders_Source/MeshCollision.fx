///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshCollision.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Solid color alpha blend shader.  Initial motivation is to have a minimal shader to apply to
	collision meshes.

	
*/

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertN";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = false;


#include "AlamoEngine.fxh"

// material parameters, we just have color that can scale the texture
float4 Color < string UIName="Color"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 1.0f, 0.5f};


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float3 Pos  : POSITION;
};

struct VS_OUTPUT
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float  Fog	: FOG;
};


VS_OUTPUT VS(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    Out.Pos  = mul(float4(In.Pos, 1), m_worldViewProj);             // position (projected)
    Out.Diff = Color * m_lightScale;

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

float4 PS(VS_OUTPUT In) : COLOR
{
    return In.Diff;
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
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = FALSE;
    		
        SB_END        

        // shaders
        VertexShader = compile vs_1_1 VS();
        PixelShader  = compile ps_1_1 PS();

    }  
}

technique t1
<
	string LOD="FIXEDFUNCTION";
>
{
	pass t1_p1
	{
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = FALSE;
    
    		// fixed function vertex pipeline
    		Lighting = false;
    		
    		// fixed function pixel pipeline
    		ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TFACTOR;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TFACTOR;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;

        SB_END        

        // shaders
        VertexShader = NULL;
        PixelShader = NULL;
    		
		TextureFactor=(Color * m_lightScale);
	}
}
