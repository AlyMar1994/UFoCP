///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/RSkinOccludedUnit.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	"Occluded rigid skin" shader.  This shader renders
	the parts of an object that are occluded in a solid alpha-blended color.
	For example, when a player's unit is behind a building this shader is how
    we make it show through the building.

*/

string _ALAMO_RENDER_PHASE = "Occluded";
string _ALAMO_VERTEX_PROC = "RSkin";
string _ALAMO_VERTEX_TYPE = "alD3dVertRSkinNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;
int _ALAMO_BONES_PER_VERTEX = 1;
	

#include "AlamoEngineSkinning.fxh"
#include "OccludedUnit.fxh"


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4  Pos             : POSITION;
    float4  Normal          : NORMAL;       // Normal.w = skin binding
    float3  Tex0            : TEXCOORD0;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    // Look up the transform for this vertex
    //int4 indices = D3DCOLORtoUBYTE4(In.BlendIndices);
    int index = In.Normal.w;
    float4x3 transform = m_skinMatrixArray[index];

	float3 wpos = mul(In.Pos,transform);
   	Out.Pos = mul(float4(wpos,1.0),m_viewProj);
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}

VS_OUTPUT vs_max_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

vertexshader vs_main_bin = compile vs_1_1 vs_main();
vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
pixelshader occluded_ps_main_bin = compile ps_1_1 occluded_ps_main();

//////////////////////////////////////
// Techniques specs follow
//////////////////////////////////////
technique max_viewport
{
    pass max_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = FALSE;
    		ZFunc = GREATER;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;

        SB_END        
		
		// shader programs
        VertexShader = (vs_max_main_bin);
    	PixelShader = (occluded_ps_main_bin);
    }
}

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

		// shader programs
		VertexShader = (vs_main_bin);
    	PixelShader = (occluded_ps_main_bin);
    }
}


technique sph_t1
<
	string LOD="FIXEDFUNCTION";
	bool CPUSKIN=true;
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
            ColorOp[0]=MODULATE;
    		ColorArg1[0]=TFACTOR;
    		ColorArg2[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TFACTOR;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;

        SB_END        

        VertexShader = NULL;
        PixelShader  = NULL;
        Texture[0]=NULL;
        TextureFactor=(Color);        
    }  

    pass t1_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        Lighting = true;
    }
}


