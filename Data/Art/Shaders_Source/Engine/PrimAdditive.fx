///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PrimAdditive.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Additive shader
	  
*/

string _ALAMO_RENDER_PHASE = "Transparent";

#include "..\AlamoEngine.fxh"

sampler TextureSampler : register(s0);


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////
struct VS_INPUT
{
    float4 Pos      : POSITION;
    float4 Color    : COLOR0;
    float2 Tex      : TEXCOORD0;
};

struct VS_OUTPUT
{
    float4  Pos     : POSITION;
    float4  Color	: COLOR0;
    float2  Tex0    : TEXCOORD0;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;
    Out.Color = In.Color;
    Out.Color *= Compute_Distance_Fade(Out.Pos.xyz);
    
    return Out;
}

half4 ps_main(VS_OUTPUT In) : COLOR
{
    half4 texel = tex2D(TextureSampler,In.Tex0);
    half4 pixel;
    pixel = texel * In.Color;
    return pixel;
}

vertexshader vs_main_bin = compile vs_1_1 vs_main();
pixelshader ps_main_bin = compile ps_1_1 ps_main();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////
/*
technique t0
<
	string LOD="DX8";
>
{
    pass t0_p0 
    {
        SB_START

    		// blend mode
    		AlphaBlendEnable = TRUE;
    		DestBlend = ONE;
    		SrcBlend = ONE;
    		AlphaTestEnable = FALSE;
            ZWriteEnable = FALSE;
    		
        SB_END        

        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (ps_main_bin);

    }  
}
*/

technique t1
<
	string LOD="FIXEDFUNCTION";
>
{
    pass t1_p0
    {
        SB_START
        
    		// blend mode
    		AlphaBlendEnable = TRUE;
    		DestBlend = ONE;
    		SrcBlend = ONE;
    		AlphaTestEnable = FALSE;
            ZWriteEnable = FALSE;
            
            // shaders
            VertexShader = NULL;
    		PixelShader = NULL;
    		
    		// Fixed function vertex pipeline
    		Lighting=false;
    		
    		// Fixed function pixel pipeline
    		ColorOp[0]=MODULATE;
    		ColorArg1[0]=DIFFUSE;
    		ColorArg2[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;

        SB_END
    }  
}



