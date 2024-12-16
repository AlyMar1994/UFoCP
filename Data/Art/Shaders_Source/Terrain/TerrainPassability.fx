///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Terrain/TerrainPassability.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////

#include "../AlamoEngine.fxh"


//////////////////////////
// Material Properties
//////////////////////////
float4 materialDiffuse : MaterialDiffuse
<
    string UIType = "Surface Color";
> = {1.0f, 1.0f, 1.0f, 1.0f};

float4 materialSpecular : MaterialSpecular
<
	string UIType = "Surface Specular";
> = {0.7f, 0.7f, 0.7f, 1.0f};

float shininess : Power
<
    string UIType = "slider";
    float UIMin = 1.0;
    float UIMax = 128.0;
    float UIStep = 1.0;
    string UIName = "specular power";
> = 32.0;



//////////////////////////
// Techniques
//////////////////////////

technique t1
<
	string LOD="FIXEDFUNCTION";
>
{
	pass t1_p0
	{
        SB_START

    		ZEnable=true;
        	ZWriteEnable=true;
    		ZFunc=lessequal;
    		FillMode=SOLID;
    		
    		ColorVertex=true;
    		AmbientMaterialSource = COLOR1;
    		DiffuseMaterialSource = COLOR1;
    		
    		// No Texture
    		Texture[0] = NULL;
    
    		ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=DIFFUSE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=DIFFUSE;
    				
    		ColorOp[1]=Disable;
    		AlphaOp[1]=Disable;

        SB_END        

        VertexShader = NULL;
        PixelShader = NULL;
    		
   		// Material colors
		MaterialAmbient = (materialDiffuse);
		MaterialDiffuse = (materialDiffuse);
		MaterialEmissive = (float4(0.3f,0.3f,0.3f,0.0f));
		MaterialSpecular = (materialSpecular);
		MaterialPower = (16.0f);
	}
	
    pass t1_p1
    {
        SB_START

        	FillMode=WIREFRAME;
    
            MaterialAmbient = (float4(0,0,0,0));
    		MaterialDiffuse = (float4(0,0,0,0));
    		MaterialEmissive = (float4(0,0,0,0));
    		MaterialSpecular = (float4(0,0,0,0));
    		MaterialPower = (1.0f);
    		ColorVertex=false;
       		
            ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=DIFFUSE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=DIFFUSE;
    				
    		ColorOp[1]=Disable;
    		AlphaOp[1]=Disable;

        SB_END        
    }
    
	pass t1_cleanup < bool AlamoCleanup = true; >
	{
        SB_START

    		FillMode=SOLID;
            ColorVertex=false;

        SB_END        
	}
}
	