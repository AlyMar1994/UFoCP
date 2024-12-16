///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshAdditiveVColor.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Simple additive shader

	
*/

string _ALAMO_RENDER_PHASE = "Transparent";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2C";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = true;


#include "Additive.fxh"

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

VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    Out.Pos  = mul(float4(In.Pos, 1), m_worldViewProj);             // position (projected)
    Out.Tex  = In.Tex + m_time*UVScrollRate;                                       

    Out.Diff.rgb = In.Color.rgb * m_lightScale.rgb;
    Out.Diff.rgb *= m_lightScale.a;                       // fade out proportionally to m_lightScale.a
    Out.Diff.a = 1.0f;
     
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
        SB_START

    		// blend mode
    		ZWriteEnable = FALSE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = ONE;
    		SrcBlend = ONE;
    		AlphaTestEnable = FALSE;
    		
        SB_END        

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
        SB_START

    		// blend mode
    		ZWriteEnable = FALSE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = ONE;
    		SrcBlend = ONE;
    		AlphaTestEnable = FALSE;
    		
            // fixed function vertex pipeline
            Lighting = true;
    		MaterialAmbient=(float4(0,0,0,1));
    		MaterialDiffuse=(float4(0,0,0,1));
    		MaterialEmissive=(float4(0,0,0,1));
    		MaterialPower=1.0f;
    		MaterialSpecular=(float4(0,0,0,1));
            EmissiveMaterialSource = COLOR1;
            ColorVertex = true;
            FogEnable = false;
                                   
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

        SB_END        

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
            
        Texture[0]=(BaseTexture);

	}
    
    pass t1_p1
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            EmissiveMaterialSource = MATERIAL;
            ColorVertex = false;
            //FogEnable = true;     // alamo code now saves and restores fog state around each effect

        SB_END        
    }
        
}

