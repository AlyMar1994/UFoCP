/*
	
	alMissingShader.fx
	created: 10:25am Feb 24, 2004
	author: Greg Hjelstrom
	
	Shader we'll use if the desired shader isn't found or isn't supported on the current
	hardware.  Renders solid red.

	_ALAMO_VERTEX_TYPE = alD3dVertNU2
	_ALAMO_TANGENT_SPACE = 0
	_ALAMO_SHADOW_VOLUME = 0
	
*/

// Matrices
float4x4 m_world      : WORLD;
float4x4 m_view       : VIEW;
float4x4 m_projection : PROJECTION;
float4x4 m_worldView  : WORLDVIEW;

// material parameters
float4 m_solidColor  = {0.0f, 1.0f, 0.0f, 1.0f};


technique TNoShader
{
    pass P0
    {
        // transforms
        WorldTransform[0]   = (m_world);
        ViewTransform       = (m_view);
        ProjectionTransform = (m_projection);

        // material (just using emissive)
		MaterialAmbient  = (m_solidColor); 
      	MaterialDiffuse  = (m_solidColor); 
      	MaterialSpecular = (m_solidColor);
      	MaterialEmissive = (m_solidColor); 
      	       
        Lighting       = TRUE;
        LightEnable[0] = FALSE;
        SpecularEnable = FALSE;
        
        // texture stages
        ColorOp[0]   = SELECTARG1;
        ColorArg1[0] = DIFFUSE;
        ColorArg2[0] = DIFFUSE;
        AlphaOp[0]   = SELECTARG1;
        AlphaArg1[0] = DIFFUSE;
        AlphaArg2[0] = DIFFUSE;

        ColorOp[1]   = DISABLE;
        AlphaOp[1]   = DISABLE;
			
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		
        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
    }
}

