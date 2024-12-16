///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/StencilDarkenToAlpha.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Stencil darkening effect, used to darken the pixels determined to be in shadow


*/

string _ALAMO_RENDER_PHASE = "Shadow";
string _ALAMO_VERTEX_TYPE = "alPrimVert";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = false;


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
    
    		STENCILENABLE = TRUE;
    		STENCILPASS = KEEP;
    		STENCILFAIL = KEEP;
    		STENCILZFAIL = KEEP;
    		STENCILMASK = 0x3f;             // upper two bits of stencil reserved for other effects
    		STENCILFUNC = NOTEQUAL;
    		STENCILREF = 0;
    		ZWRITEENABLE = FALSE;
    		ZFUNC = ALWAYS;
    		
    		AlphaBlendEnable = false;
    		AlphaTestEnable = false;
    		
    		// Only allow writing to the alpha channel, this creates
    		// a screen space shadow mask in the frame buffer alpha channel
    		COLORWRITEENABLE = ALPHA; //RED|GREEN|BLUE; //ALPHA;

        SB_END        

        VertexShader = 0;
        PixelShader = 0;

	}

}
