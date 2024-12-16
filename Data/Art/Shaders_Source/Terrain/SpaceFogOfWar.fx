///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Terrain/SpaceFogOfWar.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Fog of war shader for space mode.
	At this time, the only difference is that it is additive vs. multiplicative  
	
*/

#include "FogOfWar.fxh"

string _ALAMO_RENDER_PHASE = "Transparent";

//-----------------------------------


technique t1
<
	string LOD="FIXEDFUNCTION";
>
{
	pass t1_p0
	{
        SB_START

    		ZWriteEnable=false;
    		ZFunc=lessequal;	
    		AlphaBlendEnable=true;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
            CullMode=none;
    		
    		// FF Vertex pipeline
    		Lighting=false;
    		
    		// FF Pixel pipeline
    		AddressU[0] = CLAMP;
    		AddressV[0] = CLAMP;
    
    		AddressU[1] = WRAP;
    		AddressV[1] = WRAP;
    
            TexCoordIndex[1] = CAMERASPACEPOSITION;
    		TextureTransformFlags[1] = COUNT2;
    		ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
    		ColorOp[1]=SELECTARG1;
    		ColorArg1[1]=CURRENT;
    		ColorArg2[1]=TEXTURE;
            
            AlphaOp[1]=MODULATE;
    		AlphaArg1[1]=TEXTURE;
    		AlphaArg2[1]=CURRENT;
    				
    		ColorOp[2]=Disable;
    		AlphaOp[2]=Disable;

        SB_END        

        VertexShader = NULL;
        PixelShader = NULL;
        
		Texture[0] = (m_FOWTexture);
        Texture[1] = (GridTexture);
		TextureTransform[1] = 
		(
			mul(
				m_viewInv,
				float4x4(
					float4(200*m_FOWTexU.x,200*m_FOWTexV.x,0,0),
					float4(200*m_FOWTexU.y,200*m_FOWTexV.y,0,0),
					float4(0,0,1,0),
					float4(0,0,0,1))
				)
		);
	}
	
	// cleanup pass
	pass t1_cleanup < bool AlamoCleanup = true; >
	{
        SB_START

    		AddressU[0] = WRAP;
    		AddressV[0] = WRAP;

    		TexCoordIndex[0] = 0;
    		TextureTransformFlags[0] = DISABLE;
    		TexCoordIndex[1] = 1;
    		TextureTransformFlags[1] = DISABLE;

        SB_END        
	}

}	