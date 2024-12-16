///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PrimParticleBumpAlpha.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Bump mapping for particles.  The tangent space basis is formed from the Z axis
    of the view transform and a vector passed in as the diffuse color of the vertex.
	
*/

string _ALAMO_RENDER_PHASE = "Transparent";	// not really needed for this shader

#include "../AlamoEngine.fxh"


/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////

// material parameters (not exposed)
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float4 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f };
float4 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f };

sampler BaseSampler : register(s0);
sampler NormalSampler : register(s1);


///////////////////////////////////////////////////////
//
// Bump mapped particle shader:
// - particle geometry is assumed to be billboarded (facing the camera)
// - particles can rotate in the view plane, the diffuse color
//   for each vertex contains the tangent vector for the particle
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float3 Norm : NORMAL;
    float2 Tex  : TEXCOORD0;
    float4 Diff	: COLOR0;
};


struct VS_OUTPUT
{
    float4  Pos     : POSITION;
    float4  Diff	: COLOR0;
    float4	Spec	: COLOR1;
    float2  Tex0    : TEXCOORD0;
    float2	Tex1	: TEXCOORD1;
	float3  LightVector: TEXCOORD2;
	float3  HalfAngleVector: TEXCOORD3;
	float  Fog		: FOG;
};

VS_OUTPUT particle_bump_vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;
    Out.Tex1 = In.Tex;
    Out.Diff = float4(1,1,1,In.Diff.a);
    Out.Spec = float4(0,0,0,1);

    // Build the tangent space basis.  
    float3 normal = (float3)m_worldViewInv[2];          
    float3 tangent = mul(2.0f*(In.Diff.rgb - 0.5f), m_viewInv); 
    float3 bitangent = cross(normal,tangent);

	// Compute the tangent-space light vector and half-angle vector for per-pixel lighting
	// Note that we are doing everything in object space here.
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(tangent,bitangent,normal);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);
	Out.HalfAngleVector = Compute_Tangent_Space_Half_Vector(In.Pos,m_eyePosObj,m_light0ObjVector,to_tangent_matrix);

	// Fill lighting is applied per-vertex.  This must be computed in
	// world space for spherical harmonics to work.
	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse + Emissive, In.Diff.a);  
    Out.Spec = float4(0,0,0,1);

    // Distance fading
    Out.Diff.a *= Compute_Distance_Fade(Out.Pos.xyz);
    
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}


float4 bump_spec_ps_main(VS_OUTPUT In): COLOR
{

	float4 base_texel = tex2D(BaseSampler,In.Tex0);
	float4 normal_texel = tex2D(NormalSampler,In.Tex1);

	// surface color
	float3 surface_color = base_texel.rgb;
	
	// compute lighting
	float3 norm_vec = 2.0f*(normal_texel.rgb - 0.5f);
	float3 light_vec = 2.0f*(In.LightVector - 0.5f);
	float3 half_vec = 2.0f*(In.HalfAngleVector - 0.5f);
	//half_vec = normalize(half_vec);
	//light_vec = normalize(light_vec);
	
	float ndotl = saturate(dot(norm_vec,light_vec));
	float ndoth = saturate(dot(norm_vec,half_vec));
    ndoth = ndoth*ndoth*ndoth*ndoth*ndoth;
    
	// put it all together
	float3 diff = surface_color * (ndotl*Diffuse*m_light0Diffuse + In.Diff.rgb) * 2.0;
	float3 spec = m_light0Specular*Specular*ndoth*normal_texel.a;
	return float4(diff + spec, In.Diff.a*base_texel.a);
}

float4 bump_ps_main(VS_OUTPUT In) : COLOR
{
	// sample the textures
    float4 base_texel = tex2D(BaseSampler,In.Tex0);
    float4 norm_texel = tex2D(NormalSampler,In.Tex1);
	
	// surface color
	float3 surface_color = base_texel.rgb;
	
	// diffuse bump lighting
	float3 norm_vec = 2.0f*(norm_texel.rgb - 0.5f);
	float3 light_vec = 2.0*(In.LightVector - 0.5);
	float ndotl = saturate(dot(norm_vec,light_vec));  

	// put it all together
	float3 diffuse = surface_color * (ndotl*Diffuse*m_light0Diffuse + In.Diff) * 2.0;
	float3 specular = In.Spec * norm_texel.a;
	return float4(diffuse + specular,In.Diff.a*base_texel.a);
}


vertexshader particle_bump_vs_main_bin = compile vs_1_1 particle_bump_vs_main();
pixelshader bump_spec_ps_main_bin = compile ps_1_4 bump_spec_ps_main();
pixelshader bump_ps_main_bin = compile ps_1_1 bump_ps_main();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique t2
<
	string LOD="DX8ATI";
>
{
    pass t2_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable=true;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = TRUE;
    		AlphaRef = 0x00000008;
    		AlphaFunc = Greater;
    
        SB_END        

        // shaders
        VertexShader = (particle_bump_vs_main_bin);
        PixelShader  = (bump_spec_ps_main_bin);

    }  
}

technique t1
<
	string LOD="DX8";
>
{
    pass t1_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable=true;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = TRUE;
    		AlphaRef = 0x00000008;
    		AlphaFunc = Greater;
    
        SB_END        

        // shaders
        VertexShader = (particle_bump_vs_main_bin);
        PixelShader  = (bump_ps_main_bin);

    }  
}

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
    		ZWriteEnable=false;
    	
    		// fixed function vertex pipeline
    		Lighting = TRUE;
    		MaterialPower = 32.0f;
    		
    		// vertex colors
    		ColorVertex = true;
            DiffuseMaterialSource = COLOR1;

    		// fixed function pixel pipeline
    		ColorOp[0]=MODULATE2X;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=MODULATE;
    		AlphaArg1[0]=TEXTURE;
    		AlphaArg2[0]=DIFFUSE;
    		
    		ColorOp[1]=DISABLE;
    		AlphaOp[1]=DISABLE;

            // no shaders
            VertexShader = NULL;
            PixelShader = NULL;

        SB_END        
        
        MaterialAmbient = (Diffuse);
        MaterialDiffuse = (Diffuse);
        MaterialSpecular = (Specular);
        MaterialEmissive = (Emissive);

	}

/* Not currently supported by the Prim code (this cleanup is done in code)
    pass t0_p1
    <
        bool AlamoCleanup=true;
    >
    {
        ColorVertex = false;
        DiffuseMaterialSource = MATERIAL;
    }
*/

}


