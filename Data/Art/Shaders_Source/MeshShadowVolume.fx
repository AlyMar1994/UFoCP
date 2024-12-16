///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/MeshShadowVolume.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/09/12 08:51:59 $
//          $Revision: #2 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shadow Volume shader, extrudes the mesh in the direction of the primary light.  Requires 
	preprocessing in the tool pipeline to prepare the geometry for extrusion (split verts, add
	degenerate quads for each edge...)

*/

string _ALAMO_RENDER_PHASE = "Shadow";
string _ALAMO_VERTEX_PROC = "ShadowVolume";
string _ALAMO_VERTEX_TYPE = "alD3dVertN";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = true;
	

#include "AlamoEngine.fxh"
 
float4 m_extrusion : SHADOW_EXTRUSION_DISTANCE = 1000.0f;

// material parameters, for visualizing the volume we'll use this solid color
float4 DebugColor < string UIName="DebugColor"; string UIType = "ColorSwatch"; > = {0.0f, 1.0f, 1.0f, 1.0f};

///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float3 Normal : NORMAL;
};

struct VS_OUTPUT
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	float3 obj_pos = In.Pos.xyz;
	float3 obj_light_vec = m_light0ObjVector;
	float ndotl = dot(In.Normal, obj_light_vec);
	
	Out.Diff = DebugColor;
	if (ndotl < 0.0)
	{
		obj_pos -= m_extrusion * obj_light_vec;
		Out.Diff = 0.3*DebugColor;
	} 
		
	Out.Pos  = mul(float4(obj_pos,1), m_worldViewProj); // position (projected)

	return Out;
}

VS_OUTPUT vs_max_main(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

	float3 obj_pos = In.Pos.xyz;
	float3 obj_light_vec = m_light0ObjVector;
	float ndotl = dot(In.Normal, obj_light_vec);
	
	Out.Diff = DebugColor;
	if (ndotl < 0.0)
	{
		//obj_pos -= m_extrusion * obj_light_vec;
		Out.Diff = 0.3*DebugColor;
	} 
		
	Out.Pos  = mul(float4(obj_pos,1), m_worldViewProj); // position (projected)

	return Out;
}

float4 ps_main(VS_OUTPUT In) : COLOR
{
    return In.Diff;
}

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
    pass max_p0
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
    pass t0_2pass_p0
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
            StencilFunc      = Always;
    		StencilPass 	 = Keep;
    		StencilZFail     = Incr;
    		StencilFail      = Keep;
    				
        SB_END        

        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (ps_main_bin);

    }  

    pass t0_2pass_p1
    {
        SB_START

    		// Stencil settings
    		CullMode=none;
    		StencilZFail     = Decr;

        SB_END        
    
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

            ColorWriteEnable = 0; //0xffffffff;
            
            ZFunc            = Less;
            ZWriteEnable     = False;
            AlphaBlendEnable = False;
            
            StencilEnable    = True;
    		StencilRef       = 1;
            StencilMask      = 0x3f;
            StencilWriteMask = 0x3f;
    		
    		CullMode         = none;
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
    		CullMode        = none;
    		StencilPass     = Decr;
    
        SB_END        

        VertexShader = (vs_main_bin);
        PixelShader  = (ps_main_bin);

    }
}


#endif //ALAMO_USE_ZFAIL_SHADOW_VOLUMES
