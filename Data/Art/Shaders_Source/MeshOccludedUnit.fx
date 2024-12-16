///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshOccludedUnit.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	"Occluded Mesh" shader.  This shader renders
	the parts of an object that are occluded in a solid alpha-blended color.
	For example, when a player's unit is behind a building this shader is how
    we make it show through the building.
	
*/

string _ALAMO_RENDER_PHASE = "Occluded";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
bool _ALAMO_Z_SORT = false;


#include "OccludedUnit.fxh"


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
};

VS_OUTPUT occluded_vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

vertexshader occluded_vs_main_bin = compile vs_1_1 occluded_vs_main();
pixelshader occluded_ps_main_bin = compile ps_1_1 occluded_ps_main();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique sph_t0
<
	string LOD="DX8";
>
{
    pass sph_t0_p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable = FALSE;
    		ZFunc = GREATER;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;

    		// stencil testing to prevent multiple overlaps
            StencilEnable    = True;
            StencilRef       = 0x40;
            StencilMask      = 0x40;
            StencilWriteMask = 0x40;
            StencilFunc      = NotEqual;
       		StencilPass 	 = Replace;
            StencilZFail     = Keep;
            StencilFail      = Keep;		
            
        SB_END        

        // shaders
        VertexShader = (occluded_vs_main_bin);
        PixelShader  = (occluded_ps_main_bin);

    }  

    pass t0_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        StencilEnable = false;
    }
}


technique t1
<
	string LOD="FIXEDFUNCTION";
>
{
    pass t1_p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable = FALSE;
    		ZFunc = GREATER;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;

    		// stencil testing to prevent multiple overlaps
            StencilEnable    = True;
            StencilRef       = 0x40;
            StencilMask      = 0x40;
            StencilWriteMask = 0x40;
            StencilFunc      = NotEqual;
       		StencilPass 	 = Replace;
            StencilZFail     = Keep;
            StencilFail      = Keep;		
    		
            // fixed function vertex pipeline
            Lighting = false;
    
            // fixed function pixel pipeline
            Texture[0]=NULL;
    
            ColorOp[0]=MODULATE;
    		ColorArg1[0]=TFACTOR;
    		ColorArg2[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TFACTOR;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;

        SB_END        

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
            
        TextureFactor=(Color);        
    }  

    pass t1_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        Lighting = true;
        StencilEnable = false;
    }
}


