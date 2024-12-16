///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Dev/FissureMeshGloss.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Fissures "carve" a hole into the z-buffer. Typically you'd use this shader
	on a piece of geometry that has all of its polygons facing inward.  The geometry
	technically must be convext in order to work correctly but minor concavities seem
	to look acceptable.  Fissures are drawn right after the terrain and only carve
	out of the terrain.
	
	2x Diffuse+Spec lighting
	Spec is modulated by alpha channel of the texture (gloss)

	_ALAMO_VERTEX_TYPE = alD3dVertNU2
	_ALAMO_TANGENT_SPACE = 0
	_ALAMO_SHADOW_VOLUME = 0
	
*/

string RenderPhase = "Fissure";

#include "Gloss.fxh"


///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

VS_OUTPUT sph_vs_main(VS_INPUT_MESH In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;

	// World-space lighting
    float3 world_pos = mul(In.Pos, m_world);	// position (world space)
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world)); // normal (world space)
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light + Emissive, 1);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}


VS_OUTPUT vs_main(VS_INPUT_MESH In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;

	// World-space lighting
    float3 world_pos = mul(In.Pos, m_world);	// position (world space)
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world)); // normal (world space)
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse * diff_light + Emissive, 1);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
vertexshader vs_main_bin = compile vs_1_1 vs_main();
pixelshader gloss_ps_main_bin = compile ps_1_1 gloss_ps_main();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////
technique max_viewport
{
    pass max_P0
    {
		// blend mode
		ZWriteEnable = TRUE;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		CullMode = CW;
		
        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (gloss_ps_main_bin);
    }  
}

technique sph_fissure
<
	string LOD="DX8";
>
{
	// First two passes stencil a hole into the terrain
    pass sph_fissure_p0
    {
        ColorWriteEnable = 0;

        ZFunc            = Less;
        ZWriteEnable     = False;
        AlphaBlendEnable = False;
        
        StencilEnable    = True;
		StencilRef       = 1;
        StencilMask      = 0xffffffff;
        StencilWriteMask = 0xffffffff;
		
		CullMode		=  CCW;
        StencilFunc      = Always;
		StencilPass 	 = Keep;
		StencilZFail     = Decr;
		StencilFail      = Keep;

        // shaders
        VertexShader = (sph_vs_main_bin);
        PixelShader  = (gloss_ps_main_bin);
    }  
	pass sph_fissure_p1
	{
        ColorWriteEnable = 0;

		// Stencil settings
		CullMode		= CW;
		StencilZFail    = Incr;

        // shaders
        VertexShader = (sph_vs_main_bin);
        PixelShader  = (gloss_ps_main_bin);
	}
	pass sph_fissure_p2
	{
		// Enable color writes
		// Render only on standard z test into stenciled area
		// Write zbuffer (carve the fissure into the zbuffer)
		// Clear stencil
		// Standard backface culling

        ColorWriteEnable = 0xffffffff;
		StencilEnable = true;
		StencilPass = Zero;
		StencilFail = Keep;
		StencilZFail = Keep;
		StencilMask = 0xffffffff;
		StencilFunc = EQUAL;
		StencilRef = 1;
		
		CullMode = CW;
        ZFunc            = GREATER; //LESSEQUAL;
        ZWriteEnable     = true;
        AlphaBlendEnable = false;

        // shaders
        VertexShader = (sph_vs_main_bin);
        PixelShader  = (gloss_ps_main_bin);
	}
}

technique fissure
<
	string LOD="DX8";
>
{

    // First two passes stencil a hole into the terrain
    pass fissure_p0
    {
        ColorWriteEnable = 0;

        ZFunc            = Less;
        ZWriteEnable     = False;
        AlphaBlendEnable = False;
        
        StencilEnable    = True;
		StencilRef       = 1;
        StencilMask      = 0xffffffff;
        StencilWriteMask = 0xffffffff;
		
		CullMode		=  CCW;
        StencilFunc      = Always;
		StencilPass 	 = Keep;
		StencilZFail     = Decr;
		StencilFail      = Keep;

        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (gloss_ps_main_bin);
    }  

	pass fissure_p1
	{
        ColorWriteEnable = 0;

		// Stencil settings
		CullMode		= CW;
		StencilZFail    = Incr;

        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (gloss_ps_main_bin);
	}
	pass fissure_p2
	{
		// Enable color writes
		// Render only on standard z test into stenciled area
		// Write zbuffer (carve the fissure into the zbuffer)
		// Clear stencil
		// Standard backface culling

        ColorWriteEnable = 0xffffffff;
		StencilEnable = true;
		StencilPass = Zero;
		StencilFail = Keep;
		StencilZFail = Keep;
		StencilMask = 0xffffffff;
		StencilFunc = EQUAL;
		StencilRef = 1;
		
		CullMode = CW;
        ZFunc            = GREATER; //LESSEQUAL;
        ZWriteEnable     = true;
        AlphaBlendEnable = false;

        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (gloss_ps_main_bin);
	}
}

technique debug
<
	string LOD="DX8";
>
{
    pass debug_p0
    {
		// blend mode
		ZWriteEnable = TRUE;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		CullMode = CW;
		
        // shaders
        VertexShader = (vs_main_bin);
        PixelShader  = (gloss_ps_main_bin);
    }  
}


