///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshAdditiveOffset.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	FX file for Mesh additive shader that supports texture offsetting.
	This shader is separate from MeshAdditive because it has to support uv-offsetting even
	on the min-spec (which means we are using a scripted texture transform when running
	on fixed function; this is not the most efficient thing to do so I separated this shader
	from the general "additive" shader)

    Initial motivation for this shader was the capture point icons that "fill" over time as
    they convert to a given faction.  These are "rare" objects so the initial implementation
    just uses FX scripting to generate the texture transform for the fixed function pipe.
    
*/

string _ALAMO_RENDER_PHASE = "Transparent";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = true;


#include "AdditiveOffset.fxh"


// A color that can be multiplied with the texture
float3 Color < string UIName="Color"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f};


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
    Out.Tex  = In.Tex + UVOffset.xy;

   	Out.Diff.rgb = Color * m_lightScale.rgb;
    Out.Diff *= m_lightScale.a;
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
            FogEnable = false;    // alamo code saves and restores fog state around each effect
            
            // fixed function pixel pipeline
            ColorOp[0]=MODULATE;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=TFACTOR;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;


        SB_END        

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
        
        Texture[0]=(BaseTexture);
		TextureFactor=(float4(
                                Color.r * m_lightScale.r * m_lightScale.a,
                                Color.g * m_lightScale.g * m_lightScale.a,
                                Color.b * m_lightScale.b * m_lightScale.a,
                                1.0f
                       ));

   		TexCoordIndex[0] = 0;
   		TextureTransformFlags[0] = COUNT2;

		TextureTransform[0] = 
		(
            float4x4(
                float4(1,0,0,0),
                float4(0,1,0,0),
                float4(0,0,1,0),
                float4(UVOffset.x,UVOffset.y,0,1)
            )
		);
	}
}

