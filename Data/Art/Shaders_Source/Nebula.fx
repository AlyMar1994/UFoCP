///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Nebula.fx $
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


float DistortionScale < string UIName="DistortionScale"; > = { 25.0f };
float SFreq < string UIName="SFreq"; > = { 0.002f };
float TFreq < string UIName="TFreq"; > = { 0.05f };


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float3 Pos  : POSITION;
    float4 Normal : NORMAL;
    float2 Tex  : TEXCOORD0;
    float4 Color: COLOR0;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    float3 world_pos = mul(float4(In.Pos,1),m_world);
    float3 obj_pos = In.Pos;

    float SPATIAL_FREQ = SFreq;
    float TIME_FREQ = TFreq; 
    float SCALE = DistortionScale; 
    
    float3 offset;
    offset.x = sin(2.0f*3.14f * frac(SPATIAL_FREQ * world_pos.x + TIME_FREQ * m_time) );
    offset.y = sin(2.0f*3.14f * frac(SPATIAL_FREQ * world_pos.y + TIME_FREQ * m_time) );
    offset.z = sin(2.0f*3.14f * frac(SPATIAL_FREQ * world_pos.z + TIME_FREQ * m_time) );
    obj_pos += SCALE * offset;
      
    Out.Pos  = mul(float4(obj_pos, 1), m_worldViewProj);             // position (projected)
    Out.Tex  = In.Tex + m_time*UVScrollRate*3;                                       

    Out.Diff.rgb = In.Color.rgb * m_lightScale.rgb;
    Out.Diff.rgb *= m_lightScale.a;                       // fade out proportionally to m_lightScale.a
    Out.Diff.a = 1.0f;

    // edge fade
    float3 view_norm = normalize(mul(In.Normal, (float3x3)m_worldView));
    float scale = offset.x;
    float edge = 0.9 *view_norm.z + 0.1 * scale;
    Out.Diff *= pow(view_norm.z,8)*2 + 0.1f; // * view_norm.z*view_norm.z; //*view_norm.z*view_norm.z*view_norm.z;
    
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
            CullMode = NONE;
    		
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

        SB_END        
    }
        
}

