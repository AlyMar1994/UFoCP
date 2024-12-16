///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/RSkinShadowVolume.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shadow volume generated from a skinned mesh.

*/

string _ALAMO_RENDER_PHASE = "Shadow";
string _ALAMO_VERTEX_PROC = "RSkinShadowVolume";
string _ALAMO_VERTEX_TYPE = "alD3dVertRSkinNU2";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = true;
int _ALAMO_BONES_PER_VERTEX = 1;


#include "AlamoEngineSkinning.fxh"
#include "AlamoEngine.fxh"

float m_extrusion : SHADOW_EXTRUSION_DISTANCE = 100.0f;

// material parameters, for visualizing the volume we'll use this solid color
float4 DebugColor < string UIName="DebugColor"; string UIType = "ColorSwatch"; > = {0.0f, 1.0f, 1.0f, 1.0f};

///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos : POSITION;
    float4 Normal : NORMAL; // Normal.w = skin binding
};

struct VS_OUTPUT
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	// Do everthing in "object space".  Note that we need Orthogonal matrices
	// in order to be able to use the transpose of the skinning matrix...
	int index = In.Normal.w; //int4 indices = D3DCOLORtoUBYTE4(In.BlendIndices);
    float4x3 skin_transform = m_skinMatrixArray[index];
	float3x3 skin_rotation = (float3x3)skin_transform;
	skin_rotation = transpose(skin_rotation);

	float3 P = mul(In.Pos,skin_transform);
	float3 obj_light_vec = mul(m_light0Vector,(float3x3)skin_rotation);
	float ndotl = dot(normalize(In.Normal.xyz), obj_light_vec);         // careful, input normal is not unit length!
	
	Out.Diff = DebugColor;
	if (ndotl < 0.0)
	{
		P -= m_extrusion * m_light0Vector;
		Out.Diff = 0.2*DebugColor;
	} 
		
    Out.Pos  = mul(float4(P,1), m_viewProj); 
	return Out;
}

VS_OUTPUT vs_max_main(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	float3 obj_pos = In.Pos.xyz;
	float3 obj_light_vec = m_light0ObjVector;
	float ndotl = dot(normalize(In.Normal.xyz), obj_light_vec);
	
	Out.Diff = DebugColor;
	if (ndotl < 0.0)
	{
		//obj_pos -= m_extrusion * obj_light_vec;
		Out.Diff = 0.3*DebugColor;
	} 	
	Out.Pos  = mul(float4(obj_pos,1), m_worldViewProj);
	
	return Out;
}

float4 ps_main(VS_OUTPUT In) : COLOR
{
    return In.Diff;
}

// Compiled shader programs
vertexshader vs_main_bin = compile vs_1_1 vs_main();
vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();
pixelshader ps_main_bin = compile ps_1_1 ps_main();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique max_viewport
{
    pass P0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    		CullMode = CW;

        SB_END        
				
        // shaders
        VertexShader = (vs_max_main_bin);
        PixelShader  = (ps_main_bin);
    }  
}


#if (ALAMO_USE_ZFAIL_SHADOW_VOLUMES)

technique t0_zfail
<
	string LOD="DX8";
>
{
    pass t0_zfail_p0
    {
        SB_START

    		// Stencil settings
            ColorWriteEnable = 0;
            ZFunc            = Less;
            ZWriteEnable     = False;
    
            StencilEnable    = True;
    		StencilRef       = 1;
            StencilMask      = 0x3f;
            StencilWriteMask = 0x3f;
    		
    		CullMode=none;
    		TwoSidedStencilMode = True;
            StencilFunc      = Always;
    		StencilPass 	 = Keep;
    		StencilZFail     = Incr;
    		StencilFail      = Keep;		
    		
    		Ccw_StencilFunc   = Always;
    		Ccw_StencilPass   = Keep;
    		Ccw_StencilZFail  = Decr;
    		Ccw_StencilFail   = Keep;

        SB_END        
		
        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (ps_main_bin);
    }  
}

technique t0_2pass_zfail
<
	string LOD="DX8";
>
{
    pass t0_2pass_zfail_p0
    {
        SB_START

    		// Stencil settings
            ColorWriteEnable = 0;
            ZFunc            = Less;
            ZWriteEnable     = False;
            StencilEnable    = True;
    		StencilRef       = 1;
            StencilMask      = 0x3f;
            StencilWriteMask = 0x3f;
    		
    		CullMode=CCW;
            StencilFunc      = Always;
    		StencilPass 	 = Keep;
    		StencilZFail     = Incr;
    		StencilFail      = Keep;

        SB_END        

        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (ps_main_bin);
    }  

    pass t0_2pass_zfail_p1
    {
        SB_START

    		// Stencil settings
    		CullMode=CW;
    		StencilZFail=Decr;

        SB_END        

        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (ps_main_bin);
    }  
}

#else //ALAMO_USE_ZFAIL_SHADOW_VOLUMES

technique t0_zpass
<
	string LOD="DX8";
>
{
    pass t0_zpass_p0
    {
        SB_START

    		// Stencil settings
            ColorWriteEnable = 0;
            ZFunc            = Less;
            ZWriteEnable     = False;
    
            StencilEnable    = True;
    		StencilRef       = 1;
            StencilMask      = 0x3f;
            StencilWriteMask = 0x3f;
    		
    		CullMode=none;
    		TwoSidedStencilMode = True;
            StencilFunc      = Always;
    		StencilPass 	 = Incr;
    		StencilZFail     = Keep;
    		StencilFail      = Keep;		
    		
    		Ccw_StencilFunc   = Always;
    		Ccw_StencilPass   = Decr;
    		Ccw_StencilZFail  = Keep;
    		Ccw_StencilFail   = Keep;

        SB_END        
		
        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (ps_main_bin);
    }  
}

technique t0_2pass_zpass
<
	string LOD="DX8";
>
{
    pass t0_2pass_zpass_p0
    {
        SB_START

    		// Stencil settings
            ColorWriteEnable = 0; //0xffffffff;
            
            ZFunc            = Less;
            ZWriteEnable     = False;
            AlphaBlendEnable = False;
            
            StencilEnable    = True;
    		StencilRef       = 0x1;
            StencilMask      = 0x3f;
            StencilWriteMask = 0x3f;
    		
    		CullMode         = CW;
            StencilFunc      = Always;
    		StencilPass 	 = Incr;
    		StencilZFail     = Keep;
    		StencilFail      = Keep;

        SB_END        

        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (ps_main_bin);
    }  

    pass t0_2pass_zpass_p1
    {
        SB_START

    		// Stencil settings
    		CullMode       = CCW;
    		StencilPass    = Decr;

        SB_END        

        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (ps_main_bin);
    }
}

#endif //ALAMO_USE_ZFAIL_SHADOW_VOLUMES



