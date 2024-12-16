///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PhaseShadow.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	FX file for wrapping an entire render phase.  
	Pass 0 is applied before rendering all "opaque" render tasks.
	Pass 1 is aplied after rendering all opaque render tasks.

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
        
    		ZFUNC = LESS;
    		COLORWRITEENABLE = 0;

        SB_END
	}

	pass t0_p1
	{
        SB_START
        
    		// We clean up all of the states set by shadow volumes here.
    		ZFUNC=LESSEQUAL;
    
    		COLORWRITEENABLE = RED|GREEN|BLUE;
            ZFunc=lessequal;
            ZWriteEnable=TRUE;
    
            StencilEnable    = FALSE;
    		StencilRef       = 1;
            StencilMask      = 0xffffffff;
            StencilWriteMask = 0xffffffff;
    		
    		TwoSidedStencilMode = FALSE;
            StencilFunc      = Always;
    		StencilPass 	 = Keep;
    		StencilZFail     = Keep;
    		StencilFail      = Keep;		
    		
    		Ccw_StencilFunc   = Always;
    		Ccw_StencilPass   = Keep;
    		Ccw_StencilZFail  = Keep;
    		Ccw_StencilFail   = Keep;

        SB_END
	}
}
