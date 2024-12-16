///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PhaseWater.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	FX file for the Water render phase.  
	Pass 0 is applied before rendering all "water" render tasks.
	Pass 1 is aplied after rendering all water render tasks.

*/

#include "../AlamoEngine.fxh"


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////
technique t0
<
	string LOD="FIXEDFUNCTION";	// minmum LOD
>
{
    pass t0_p0
    {
	}

	pass t0_p1
	{
        SB_START
        
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		
    		TexCoordIndex[0] = 0;
    		TexCoordIndex[1] = 1;
    		TexCoordIndex[2] = 2;
    		
    		TextureTransformFlags[0]=disable;
    		TextureTransformFlags[1]=disable;
    		TextureTransformFlags[2]=disable;

        SB_END

	}
}
