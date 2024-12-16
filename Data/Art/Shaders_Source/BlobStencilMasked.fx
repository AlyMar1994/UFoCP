///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/BlobStencilMasked.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shader for selection blobs.  Renders in two passes, first pass uses alpha test and 
    writes into the z-buffer but not the color buffer.  
    The second pass uses alpha blending and ZFunc=LESS.  
    This results in the second pass being "masked" out of anywhere that was rendered in
    the first pass. 
	  
*/

string _ALAMO_RENDER_PHASE = "Transparent";

#include "AlamoEngine.fxh"


// z-buffer mask, alpha-tested, color channels ignored
texture Texture0
<
	string UIName = "Texture0";
	string UIType = "bitmap";
>;

// alpha blended blob, center is masked out by Texture0's alpha channel
texture Texture1
<
	string UIName = "Texture1";
	string UIType = "bitmap";
>;


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
    // First pass drops an alpha-tested 'cutout' into the stencil-buffer
    // to kill the inner overlapping parts of the selection circles
    pass t0_p0
    {
    SB_START
        // blend mode
        AlphaBlendEnable = FALSE; 
        AlphaTestEnable = TRUE;
        AlphaRef = 0x00000080;
        AlphaFunc = Greater;

        ZWriteEnable = FALSE;
        ZFunc = LESSEQUAL;
        ColorWriteEnable = 0;

        // Each pixel that passes Alpha-Test gets written into the stencil buffer
        StencilEnable    = True;
        StencilRef       = 0x80;
        StencilMask      = 0x80;
        StencilWriteMask = 0x80;
        StencilFunc      = Always;
   		StencilPass 	 = Replace;
        StencilZFail     = Keep;
        StencilFail      = Keep;		

        // shaders
        VertexShader = NULL;
        PixelShader = NULL;
        
        // Fixed function vertex pipeline
        Lighting=false;
    
        // Fixed function pixel pipeline
        ColorOp[0]=SELECTARG1;
        ColorArg1[0]=TEXTURE;
        AlphaOp[0]=SELECTARG1;
        AlphaArg1[0]=TEXTURE;
        
        ColorOp[1]=DISABLE;
        AlphaOp[1]=DISABLE;

        AddressU[0]=CLAMP;
        AddressV[0]=CLAMP;
    SB_END

        Texture[0]=(Texture0);
    }  

    // Second pass draws the alpha blended texture
    pass t0_p1
    {
    SB_START
		// blend mode
		AlphaBlendEnable = TRUE;
		DestBlend = INVSRCALPHA;
		SrcBlend = SRCALPHA;
		AlphaTestEnable = FALSE;
        ZWriteEnable = FALSE;
        ZFunc = LESSEQUAL;

        COLORWRITEENABLE = RED|GREEN|BLUE;

        // Stencil buffer is checked for the masks written in the previous pass
        StencilEnable    = True;
        StencilRef       = 0x80;
        StencilMask      = 0x80;
        StencilWriteMask = 0x80;
        StencilFunc      = NOTEQUAL;
   		StencilPass 	 = Keep;
        StencilZFail     = Keep;
        StencilFail      = Keep;		

        // shaders
        VertexShader = NULL;
		PixelShader = NULL;
		
		// Fixed function vertex pipeline
		Lighting=false;

		// Fixed function pixel pipeline
		ColorOp[0]=SELECTARG1;
		ColorArg1[0]=TEXTURE;
		ColorArg2[0]=DIFFUSE;
		AlphaOp[0]=MODULATE;
		AlphaArg1[0]=TEXTURE;
		AlphaArg2[0]=DIFFUSE;
		
		ColorOp[1]=DISABLE;
		AlphaOp[1]=DISABLE;
    SB_END

		Texture[0]=(Texture1);
    }  

    pass t0_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        StencilEnable    = False;
        ZFunc = LESSEQUAL;
        COLORWRITEENABLE = RED|GREEN|BLUE;
        AddressU[0]=WRAP;
        AddressV[0]=WRAP;
    }
}

