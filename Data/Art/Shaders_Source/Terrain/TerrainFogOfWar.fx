///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Terrain/TerrainFogOfWar.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Fog of war shader.  
	
*/

#include "FogOfWar.fxh"


//-----------------------------------

technique t0
< 
	string LOD="DX9";
>
{
    pass t0_p0 
    {		
        SB_START

    		ZWriteEnable=FALSE;
    		ZFunc=lessequal;
    		AlphaBlendEnable=TRUE;
    		SrcBlend = DestColor; 
    		DestBlend = Zero; 
    		
        SB_END        

        VertexShader = compile vs_2_0 vs_blur_main();
        PixelShader  = compile ps_2_0 ps_blur_main();
    }
}


technique t1
< 
	string LOD="DX8";
>
{
    pass t0_p0 
    {		
        SB_START

    		ZWriteEnable=FALSE;
    		ZFunc=lessequal;
    		AlphaBlendEnable=TRUE;
    		SrcBlend = DestColor; 
    		DestBlend = Zero; 
    		
        SB_END        

        VertexShader = compile vs_1_1 vs_main();
        PixelShader  = compile ps_1_1 ps_main();
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

    		ZWriteEnable=false;
    		ZFunc=lessequal;	
    		AlphaBlendEnable=true;
    		SrcBlend=DestColor;
    		DestBlend=Zero;
    		
    		// FF Vertex pipeline
    		Lighting=false;
    	
    		// FF Pixel pipeline
    		AddressU[0] = CLAMP;
    		AddressV[0] = CLAMP;
    		TexCoordIndex[0] = CAMERASPACEPOSITION;
    		TextureTransformFlags[0] = COUNT2;
    
    		ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    				
    		ColorOp[1]=Disable;
    		AlphaOp[1]=Disable;

        SB_END        

        VertexShader = NULL;
        PixelShader = NULL;
        
		Texture[0] = (m_FOWTexture);
		TextureTransform[0] = 
		(
			mul(
				m_viewInv,
				float4x4(   float4(m_FOWTexU.x,m_FOWTexV.x,0,0),
                            float4(m_FOWTexU.y,m_FOWTexV.y,0,0),
                            float4(m_FOWTexU.z,m_FOWTexV.z,1,0),
                            float4(m_FOWTexU.w,m_FOWTexV.w,0,1))
				)
		);
	}
	
	// cleanup pass
	pass t2_cleanup < bool AlamoCleanup = true; >
	{
        SB_START

    		TexCoordIndex[0] = 0;
    		TextureTransformFlags[0] = DISABLE;
            Lighting=true;

        SB_END        
	}

}	