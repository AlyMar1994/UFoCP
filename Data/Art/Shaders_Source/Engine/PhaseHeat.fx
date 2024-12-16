///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PhaseHeat.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	FX file which wraps the Heat render phase.  
	Pass 0 is applied before rendering all heat render tasks.
	Pass 1 is aplied after rendering all heat render tasks.

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
        SB_START
        
       		// No blending
    		AlphaBlendEnable = FALSE;
    		AlphaTestEnable = FALSE;
    
            // normal depth testing but no depth writing
        	ZEnable=true;
        	ZWriteEnable=false;
    		ZFunc=LESSEQUAL;
    
            // Clamp the uv's for the scene texture
            AddressU[1] = CLAMP;
            AddressV[1] = CLAMP;

        SB_END

	}

	pass t0_p1
	{
        SB_START
            AddressU[1] = WRAP;
            AddressV[1] = WRAP;
        SB_END
	}
}
