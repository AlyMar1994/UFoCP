///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PrimOpaque.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Opaque shader
	  
*/

#include "..\AlamoEngine.fxh"

string _ALAMO_RENDER_PHASE = "Opaque";



///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique t0
<
	string LOD="FIXEDFUNCTION";
>
{
    pass t0_p0
    {
        SB_START

    		// blend mode
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    		AlphaTestEnable = FALSE;
            ZWriteEnable = TRUE;
    
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



