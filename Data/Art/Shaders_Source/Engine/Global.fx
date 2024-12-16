///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/Global.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Global FX file, pass 0 is applied at the start of each frame.  Used to set any default states.

*/


#include "../AlamoEngine.fxh"


sampler DefaultSampler = sampler_state
{
    AddressU                = Wrap;
    AddressV                = Wrap;
    AddressW                = Wrap;
    BorderColor             = 0;
    MagFilter               = LINEAR;
    MaxAnisotropy           = 1;
    //MaxMipLevel             = 0;
    MinFilter               = LINEAR;
    MipFilter               = LINEAR;
    MipMapLodBias           = 0.0f;
    SRGBTexture             = false;
    //ElementIndex            = 0;
    //DMapOffset              = 256; 
};


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
    
		// Light states
		LightEnable[0] = FALSE;
		LightEnable[1] = FALSE;
		LightEnable[2] = FALSE;
		LightEnable[3] = FALSE;
		LightEnable[4] = FALSE;
		LightEnable[5] = FALSE;
		LightEnable[6] = FALSE;
		LightEnable[7] = FALSE;
		
		// Material states
		MaterialAmbient=(float4(0,0,0,1));
		MaterialDiffuse=(float4(0,0,0,1));
		MaterialEmissive=(float4(0,0,0,1));
		MaterialPower=1.0f;
		MaterialSpecular=(float4(0,0,0,1));
		
        //Fill Mode
        //FillMode=wireframe;
        FillMode=solid;

		//Render states
		ColorWriteEnable=RED|GREEN|BLUE;
		AlphaBlendEnable=false;
		AlphaTestEnable=false;
		DestBlend = ZERO;
		SrcBlend = ONE;
		DepthBias=0.0f;
		SlopeScaleDepthBias=0.0f;
		ShadeMode=gouraud;
		StencilEnable=false;
		ZEnable=true;
		ZWriteEnable=true;
		ZFunc=LESSEQUAL;
		
		// Vertex Pipeline:
		Ambient=(float4(0,0,0,0));
		SpecularEnable=false;
		AmbientMaterialSource=MATERIAL;
		DiffuseMaterialSource=MATERIAL;
		EmissiveMaterialSource=MATERIAL;
		SpecularMaterialSource=MATERIAL;		
		Clipping=true;
		ClipPlaneEnable=0;
		ColorVertex=false;
		//CullMode=ccw;	// this is set by the code, depends on whether the camera is reflected or not
		//FogColor=0xFFFFFFFF;	// code sets fog and expects it to be left alone
		//FogDensity=(0.5f);	// code sets fog and expects it to be left alone
		//FogStart=(600.0f);	// code sets fog and expects it to be left alone
		//FogEnd=(1500.0f);		// code sets fog and expects it to be left alone
		FogTableMode=NONE;
		FogVertexMode=LINEAR;
		RangeFogEnable=TRUE;
		IndexedVertexBlendEnable=false;
		Lighting=false;
		LocalViewer=false;
		MultiSampleAntiAlias=true;
		MultiSampleMask=0xFFFFFFFF;
		NormalizeNormals=true;
		VertexBlend=disable;		
		
		// Sampler States
        Sampler[0]              = (DefaultSampler);
        Sampler[1]              = (DefaultSampler);
        Sampler[2]              = (DefaultSampler);
        Sampler[3]              = (DefaultSampler);
        Sampler[4]              = (DefaultSampler);
        Sampler[5]              = (DefaultSampler);
        Sampler[6]              = (DefaultSampler);
        Sampler[7]              = (DefaultSampler);
        Sampler[8]              = (DefaultSampler);
        Sampler[9]              = (DefaultSampler);
        Sampler[10]             = (DefaultSampler);
        Sampler[11]             = (DefaultSampler);
        Sampler[12]             = (DefaultSampler);
        Sampler[13]             = (DefaultSampler);
        Sampler[14]             = (DefaultSampler);
        Sampler[15]             = (DefaultSampler);
		
		Texture[0]=NULL;
		Texture[1]=NULL;
		Texture[2]=NULL;
		Texture[3]=NULL;
		Texture[4]=NULL;
		Texture[5]=NULL;
		Texture[6]=NULL;
		Texture[7]=NULL;
		
		TexCoordIndex[0]=0;
		TexCoordIndex[1]=1;
		TexCoordIndex[2]=2;
		TexCoordIndex[3]=3;
		TexCoordIndex[4]=4;
		TexCoordIndex[5]=5;
		TexCoordIndex[6]=6;
		TexCoordIndex[7]=7;
		
		TextureTransformFlags[0]=disable;
		TextureTransformFlags[1]=disable;
		TextureTransformFlags[2]=disable;
		TextureTransformFlags[3]=disable;
		TextureTransformFlags[4]=disable;
		TextureTransformFlags[5]=disable;
		TextureTransformFlags[6]=disable;
		TextureTransformFlags[7]=disable;

		AlphaOp[0]=DISABLE;
		ColorOp[0]=DISABLE;

        SB_END

		VertexShader = 0;
		PixelShader = 0;
	}
}
