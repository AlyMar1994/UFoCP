///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/StencilDarkenFinalBlur.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Stencil darkening effect, used to darken the pixels determined to be in shadow

*/

#include "../AlamoEngine.fxh"


texture shadowquad;
sampler sampler0;
sampler sampler1;
sampler sampler2;
sampler sampler3;

const float2 samples4[4] = 
{
   -1,  0,
    0,  1,
    1,  0,
    0, -1,
};
float blurAmt = 0.0015f;

///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float4 VertexColor: COLOR0;
    float2 Tex  : TEXCOORD0;
};

struct VS_OUTPUT
{
	float4 Pos : POSITION;
	float4 VertexColor : COLOR0;
    float2 Tex0 : TEXCOORD0;
    float2 Tex1 : TEXCOORD1;
    float2 Tex2 : TEXCOORD2;
    float2 Tex3 : TEXCOORD3;
};


VS_OUTPUT vs_main_11(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;
	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex + blurAmt* samples4[0];
    Out.Tex1 = In.Tex + blurAmt* samples4[1];
    Out.Tex2 = In.Tex + blurAmt* samples4[2];
    Out.Tex3 = In.Tex + blurAmt* samples4[3];
    Out.VertexColor = In.VertexColor;
    Out.VertexColor.a = 0.0f;	// 
    return Out;
}

half4 ps_main_11(VS_OUTPUT In) : COLOR
{
	half4 texel0 = tex2D(sampler0, In.Tex0);
	half4 texel1 = tex2D(sampler1, In.Tex1);
	half4 texel2 = tex2D(sampler2, In.Tex2);
	half4 texel3 = tex2D(sampler3, In.Tex3);
	half shadow = (texel0.a + texel1.a + texel2.a + texel3.a)/4.0f;

	// lerp between white and In.VertexColor based on 'shadow'
	// always outputing alpha=0 so that this pass also serves to clear the alpha channel
	// of the frame buffer.
	return lerp(In.VertexColor,float4(1,1,1,0),shadow);
}

///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique t1
<
	string LOD="DX9";
>
{
    pass t1_p0
    {
        SB_START

    		LIGHTING = FALSE;
    		COLORWRITEENABLE = RED | GREEN | BLUE | ALPHA;
    		
    		ALPHABLENDENABLE = TRUE;
    		DESTBLEND=SRCCOLOR;
    		SRCBLEND=ZERO;
    		ALPHATESTENABLE = FALSE;
    
    		STENCILENABLE = FALSE;
    		ZWRITEENABLE = FALSE;
    		ZFUNC = ALWAYS;

        SB_END        

        VertexShader = compile vs_1_1 vs_main_11();
        PixelShader = compile ps_2_0 ps_main_11();		// (gth) FX5900 cards are not executing this 1.1 shader...
	}
}

