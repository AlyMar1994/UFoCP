///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PrimDepthSpriteAlpha.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Depth Sprite Shaders, uses values in a second texture to offset the depth of each pixel

	  
*/

string _ALAMO_RENDER_PHASE = "Transparent";

#include "PrimDepthSprite.fxh"


///////////////////////////////////////////////////////
// PS2.0 Depth Sprite Shaders
///////////////////////////////////////////////////////
struct PS_OUTPUT_PS20
{
	float4 Color : COLOR0;
	float Depth : DEPTH;
};

PS_OUTPUT_PS20 ps20_depth_sprite(VS_OUTPUT_PS20 In)
{
	PS_OUTPUT_PS20 Out = (PS_OUTPUT_PS20)0;
	float4 texel = tex2D(BaseSampler,In.Tex0);
	float4 depth_texel = tex2D(DepthSampler,In.Tex0);
	
	float new_z = dot(In.Tex1,depth_texel.rgb);
	float new_w = dot(In.Tex2,depth_texel.rgb);
	
	Out.Color = texel*In.Diff;	// Alpha Mode: multiply vertex color and texture color
	Out.Depth = new_z/new_w;
	return Out;
}

pixelshader ps20_depth_sprite_bin = compile ps_2_0 ps20_depth_sprite();


///////////////////////////////////////////////////////
// PS1.4 (Ati) Depth Sprite Shaders
///////////////////////////////////////////////////////
float4 ps14_test(VS_OUTPUT_PS14 In) : COLOR
{
	float4 texel = tex2D(BaseSampler,In.Tex0);
	return texel;
}

pixelshader ps14_depth_sprite_bin = asm
{
	ps.1.4

	texld r1,t0;      	// Sample from depth texture (stage 1) using texcoord t0
	texcrd r2.rgb,t1	// Load first col of 3x2 matrix
	texcrd r3.rgb,t2	// Load second col of 3x2 matrix
	dp3 r5.r,r2,r1		// compute z + z_offset
	dp3 r5.g,r3,r1		// compute w + w_offset
	
	phase

	texdepth r5		// Calculate pixel depth as r5.r / r5.g
	texld r0,t0;	// Sample from texture stage 0 using texcoord t0
	mul r0,r0,v0;	// Alpha Mode: multiply vertex color and texture color
};


///////////////////////////////////////////////////////
// PS1.3 (nVidia) Depth Sprite Shaders
///////////////////////////////////////////////////////
pixelshader ps13_depth_sprite_bin = asm
{
	ps.1.3
	
	tex t0	// decal texture
	tex t1	// r8g8b8 depth map with depth in red, green=0, and blue=1
	
	texm3x2pad   t2, t1     // Z dot product
	texm3x2depth t3, t1     // W dot product
	// depth value is replaced with Z / W

	// output pixel color
	mul r0,v0,t0
};


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////
technique Depth_Sprite_PS20
<
	string LOD="DX9";
>
{
    pass Depth_Sprite_PS20_P0
    {
        SB_START
        
    		// blend mode
    		AlphaBlendEnable = TRUE;
    		DestBlend=INVSRCALPHA;
    		SrcBlend=SRCALPHA;
    		AlphaTestEnable=FALSE;

        SB_END
        
        // Shaders
        VertexShader = (vs_depth_sprite_ps20_bin); 
        PixelShader = (ps20_depth_sprite_bin); 
    }  
}

technique Depth_Sprite_PS14
<
	string LOD="DX8ATI";
    int VENDOR_FILTER_0 = 0x10DE;     // don't use on nvidia hardware
>
{
	// PS.1.4 technique for rendering depth sprites.
	// See the docs on texdepth
    pass Depth_Sprite_PS14_P0
    {
        SB_START
        
    		// blend mode
    		AlphaBlendEnable = TRUE;
    		DestBlend=INVSRCALPHA;
    		SrcBlend=SRCALPHA;
    		AlphaTestEnable=FALSE;

        SB_END
        
        // Shaders
        VertexShader = (vs_depth_sprite_ps14_bin);
        PixelShader = (ps14_depth_sprite_bin);
    }  
}

technique Depth_Sprite_PS13
<
	string LOD="DX8";
    int VENDOR_FILTER_0 = 0x10DE;     // don't use on nvidia hardware
>
{
	// PS.1.3 technique for rendering depth sprites.
	// See the docs on texm3x2depth
    pass Depth_Sprite_PS13_P0
    {
        SB_START
        
    		// blend mode
    		AlphaBlendEnable = TRUE;
    		DestBlend=INVSRCALPHA;
    		SrcBlend=SRCALPHA;
    		AlphaTestEnable=FALSE;

        SB_END

        // shaders
        VertexShader = (vs_depth_sprite_ps13_bin); 
        PixelShader = (ps13_depth_sprite_bin);
    }  
}

technique No_Depth
<
	string LOD="FIXEDFUNCTION";
>
{
    pass No_Depth_P0
    {
        SB_START
        
    		// blend mode
    		AlphaBlendEnable = TRUE;
    		DestBlend=INVSRCALPHA;
    		SrcBlend=SRCALPHA;
    		AlphaTestEnable=FALSE;
    		
    		// Fixed function vertex pipeline
    		Lighting=false;
    		
    		// Fixed function pixel pipeline
    		ColorOp[0]=MODULATE;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;

            // shaders
            VertexShader = NULL;
            PixelShader = NULL;

        SB_END

    }  
}



