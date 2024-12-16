///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PhaseTerrain.fx $
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
		ColorWriteEnable=RED|GREEN|BLUE;	// leave dest alpha for soft shadows
	}

	pass t0_p1
	{
        SB_START

    		TexCoordIndex[0] = 0;
    		TextureTransformFlags[0] = disable;
    		TexCoordIndex[1] = 1;
    		TextureTransformFlags[1] = disable;
    		
    		AddressU[0]=wrap;
    		AddressU[1]=wrap;
    		AddressU[2]=wrap;
    		AddressU[3]=wrap;
    
    		AddressV[0]=wrap;
    		AddressV[1]=wrap;
    		AddressV[2]=wrap;
    		AddressV[3]=wrap;

            Lighting = true;

        SB_END
	}
}
