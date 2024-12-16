///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PrimAlphaScanlines.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Alpha shader with a "scanline" effect.  
    Texture0 is the base texture,
    Texture1 is added to the opaque parts of Texture0, uv-scrolling is applied to Texture1
	  
*/

#include "..\AlamoEngine.fxh"

string _ALAMO_RENDER_PHASE = "Transparent";


texture Scanlines
<
    string texture_filename="i_scan_lines_text.tga";
>;

float ScanlineScale = 5.0f;
float ScanlineSpeed = 0.4f;//20.0f;


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
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;
            ZWriteEnable = FALSE;
            
            // shaders
            VertexShader = NULL;
    		PixelShader = NULL;
    		
    		// Fixed function vertex pipeline
    		Lighting=false;
    		
    		// Fixed function pixel pipeline
    		ColorOp[0]=MODULATE;
    		ColorArg1[0]=DIFFUSE;
    		ColorArg2[0]=TEXTURE;
    		AlphaOp[0]=MODULATE;
    		AlphaArg1[0]=DIFFUSE;
    		AlphaArg2[0]=TEXTURE;

    		ColorOp[1]=ADD;
    		ColorArg1[1]=TEXTURE; 
    		ColorArg2[1]=CURRENT;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=CURRENT;

    		ColorOp[2]=DISABLE;
    		AlphaOp[2]=DISABLE;

            TexCoordIndex[1] = CAMERASPACEPOSITION;
            TextureTransformFlags[1] = COUNT2;

        SB_END

        Texture[1] = (Scanlines);
        //Texture[0] = (Scanlines);
		TextureTransform[1] = 
		(
			mul(
				m_viewInv,
				float4x4(   float4(ScanlineScale,0,0,0),
                            float4(0,ScanlineScale,0,0),
                            float4(0,0,1,0),
                            float4(0,ScanlineSpeed*m_time,0,1))
				)
		);
    }  
}



