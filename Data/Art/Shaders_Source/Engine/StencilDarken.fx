///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/StencilDarken.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Stencil darkening effect, used to darken the pixels determined to be in shadow

*/

string RenderPhase = "Shadow";


#include "../AlamoEngine.fxh"


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

    		LIGHTING = FALSE;
    		COLORWRITEENABLE = RED | GREEN | BLUE | ALPHA;
    
    		STENCILENABLE = TRUE;
    		STENCILPASS = KEEP;
    		STENCILFAIL = KEEP;
    		STENCILZFAIL = KEEP;
    		STENCILMASK = 0x4f;
    		STENCILWRITEMASK = 0;
    		STENCILFUNC = NOTEQUAL;
    		STENCILREF = 0;
    		ZWRITEENABLE = FALSE;
    		ZFUNC = ALWAYS;
    		
    		ALPHABLENDENABLE = TRUE;
    		DESTBLEND=SRCCOLOR;
    		SRCBLEND=ZERO;

        SB_END        

        VertexShader = 0;
        PixelShader = 0;
	}
}
