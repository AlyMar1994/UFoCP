///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshShield.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shield shader
	
*/

string _ALAMO_RENDER_PHASE = "Transparent";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2C";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = true;


#include "Shield.fxh"


///////////////////////////////////////////////////////
//
// Shader Program 
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float3 Norm : NORMAL;
    float2 Tex  : TEXCOORD0;
    float4 Color: COLOR0;
};

VS_OUTPUT sph_vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = BaseUVScale * In.Tex;
    Out.Tex2 = WaveUVScale * In.Tex;
    Out.Tex1 = DistortUVScale * In.Tex;

    Out.Tex0.y += m_time*BaseUVScrollRate;
    Out.Tex1.y += m_time*DistortUVScrollRate;
    Out.Tex2.y += m_time*WaveUVScrollRate;

    // soften vertical edge
    Out.Diff = In.Color * saturate(In.Norm.z + EdgeBrightness);
    Out.Diff *= Color;
    
	// Output fog
	Out.Fog = 1.0f; //Compute_Fog(Out.Pos.xyz);

    return Out;
}

vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
pixelshader distort_ps_main_bin = compile ps_2_0 distort_ps_main();

///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique max_viewport
{
    pass max_viewport_p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable=false;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = ONE;
    		SrcBlend = ONE;
            FogEnable = false;
    		CullMode = NONE;
            
        SB_END        

        VertexShader = (sph_vs_main_bin);
        PixelShader  = (distort_ps_main_bin);
    }  
}

technique t0
<
	string LOD="DX9";
>
{
    pass t0_p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable = false;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = ONE;
    		SrcBlend = ONE;
    		AlphaTestEnable = FALSE;
            FogEnable = false;
    		CullMode = NONE;

        SB_END        

        VertexShader = (sph_vs_main_bin);
        PixelShader  = (distort_ps_main_bin);
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
    		CullMode = NONE;
    		
            // fixed function vertex pipeline
            Lighting = false;
            FogEnable = false;
            
            // fixed function pixel pipeline
    		TexCoordIndex[0] = 0;
    		TextureTransformFlags[0] = COUNT2;
    
    		TexCoordIndex[1] = 0;
    		TextureTransformFlags[1] = COUNT2;
            
            ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
            ColorOp[1]=MODULATE;
    		ColorArg1[1]=CURRENT;
    		ColorArg2[1]=TEXTURE;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=CURRENT;

            ColorOp[2]=MODULATE;
            ColorArg1[2]=CURRENT;
            ColorArg2[2]=TFACTOR;
            AlphaOp[2]=SELECTARG1;
            AlphaArg1[2]=CURRENT;
    
    		ColorOp[3]=DISABLE;
    		AlphaOp[3]=DISABLE;

        SB_END        

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
        
        Texture[0]=(BaseTexture);
        Texture[1]=(WaveTexture);

		TextureTransform[0] = 
		(
			float4x4(float4(BaseUVScale,0,0,0),float4(0,BaseUVScale,0,0),float4(0,BaseUVScrollRate*m_time,1,0),float4(0,0,0,1))
		);
   		TextureTransform[1] = 
		(
			float4x4(float4(WaveUVScale,0,0,0),float4(0,WaveUVScale,0,0),float4(0,WaveUVScrollRate*m_time,1,0),float4(0,0,0,1))
    	);
   		TextureFactor=(Color);
    }  

    pass t1_cleanup < bool AlamoCleanup = true; >
    {
        SB_START

    		TexCoordIndex[0] = 0;
    		TexCoordIndex[1] = 1;
    		TextureTransformFlags[0] = DISABLE;
    		TextureTransformFlags[1] = DISABLE;

        SB_END        
	}

}



technique t2
<
	string LOD="FIXEDFUNCTION";
>
{
    pass t2_p0 
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
    		
            // fixed function vertex pipeline
            Lighting = false;
            FogEnable = false;
            
            // fixed function pixel pipeline
    		TexCoordIndex[0] = 0;
    		TextureTransformFlags[0] = COUNT2;
    
            ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
            ColorOp[1]=MODULATE;
            ColorArg1[1]=CURRENT;
            ColorArg2[1]=TFACTOR;
            AlphaOp[1]=SELECTARG1;
            AlphaArg1[1]=CURRENT;
    
    		ColorOp[2]=DISABLE;
    		AlphaOp[2]=DISABLE;

        SB_END        

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
        
        Texture[0]=(BaseTexture);

		TextureTransform[0] = 
		(
			float4x4(float4(BaseUVScale,0,0,0),float4(0,BaseUVScale,0,0),float4(0,BaseUVScrollRate*m_time,1,0),float4(0,0,0,1))
		);
   		TextureFactor=(0.25*Color);
    }  

    pass t2_cleanup < bool AlamoCleanup = true; >
    {
        SB_START

    		TexCoordIndex[0] = 0;
    		TextureTransformFlags[0] = DISABLE;

        SB_END        
	}

}

