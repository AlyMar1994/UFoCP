///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/FrameEffectAlpha.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shader used to implement the typical StarWars "wipe" transition.  This looks like 
    a "feathered" edge that wipes across the screen revealing the next scene.

*/

#include "../AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Parameters
//
/////////////////////////////////////////////////////////////////////

texture PrevSceneTexture < string UIName="PrevSceneTexture"; >;


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

    		ZFunc = ALWAYS;
    		ZWriteEnable = FALSE;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;
            
            // fixed function vertex pipeline
            Lighting = false;
            DiffuseMaterialSource = COLOR1;
            ColorVertex = true;
    
            // fixed function pixel pipeline
            ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;   
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=DIFFUSE;
    
    		ColorOp[1]=DISABLE; 
    		AlphaOp[1]=DISABLE;

        SB_END

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;

        Texture[0]=(PrevSceneTexture);

	}

    pass t0_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            Lighting = true;
            DiffuseMaterialSource = MATERIAL;
            ColorVertex = false;

        SB_END
    }

}
