///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Dev/MeshAdditiveBloom.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
    Additive Bloom shader for rigid meshes
    
	Additive blending that goes into a render phase right before blooming and marks pixels
	for blooming.
	
*/

string _ALAMO_RENDER_PHASE = "Transparent";  // after the water but before blooming
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = true;


#include "AdditiveBloom.fxh"


// A color that can be multiplied with the texture
float4 Color < string UIName="Color"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f};


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float3 Pos  : POSITION;
    float2 Tex  : TEXCOORD0;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    Out.Pos  = mul(float4(In.Pos, 1), m_worldViewProj);             // position (projected)
    Out.Diff = Color;
    Out.Tex  = In.Tex + m_time*UVScrollRate;

	// Output fog
	Out.Fog = 1.0f; //Compute_Fog(Out.Pos.xyz);

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
		// blend mode
		ZWriteEnable = FALSE;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = TRUE;
		DestBlend = ONE;
		SrcBlend = ONE;
		AlphaTestEnable = FALSE;
		
        // shaders
        VertexShader = compile vs_1_1 vs_main();
        PixelShader  = compile ps_1_1 additive_ps_main();
    }  
}


technique t1
<
	string LOD="FIXEDFUNCTION";
>
{
	pass t1_p0
	{
		// blend mode
		ZWriteEnable = FALSE;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = TRUE;
		DestBlend = ONE;
		SrcBlend = ONE;
		AlphaTestEnable = FALSE;
		
        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
        
        // fixed function vertex pipeline
        Lighting = true;
        FogEnable = false;
        
		MaterialAmbient=(float4(0,0,0,1));
		MaterialDiffuse=(float4(0,0,0,1));
		MaterialEmissive=(Color);
		MaterialPower=1.0f;
		MaterialSpecular=(float4(0,0,0,1));
        
        // fixed function pixel pipeline
        Texture[0]=(BaseTexture);
		MinFilter[0]=LINEAR;
		MagFilter[0]=LINEAR;
		MipFilter[0]=LINEAR;
        
        ColorOp[0]=MODULATE;
		ColorArg1[0]=TEXTURE;
		ColorArg2[0]=DIFFUSE;
		AlphaOp[0]=SELECTARG1;
		AlphaArg1[0]=TEXTURE;

		ColorOp[1]=DISABLE;
		AlphaOp[1]=DISABLE;
	}

    pass t1_p1
    <
        bool AlamoCleanup = true;
    >
    {
        FogEnable = true;
    }
}

