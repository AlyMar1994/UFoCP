///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PhaseOpaque.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	FX file for the Opaque render phase.  
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
        
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    		AlphaTestEnable = FALSE;
    		StencilEnable = FALSE;
    		
    		// Decals and shadow blobs sometimes turn on clamp mode so make sure 
    		// its put back to wrap
    		AddressU[0]=wrap;
    		AddressU[1]=wrap;
    		AddressV[0]=wrap;
    		AddressV[1]=wrap;

            Lighting = true;
            
        SB_END
	}

	pass t0_p1
	{
	}
}
