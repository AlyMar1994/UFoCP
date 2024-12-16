///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PrimDiffuseAlpha.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse lighting with alpha blending.  
	Initial use is for decals whose lighting needs to match the terrain lighting.  This FX
	file purposely does not set textures since the "primitive" rendering system allows the
	user to set the textures.
	
*/

string _ALAMO_RENDER_PHASE = "Transparent";	// not really needed for this shader

#include "../AlamoEngine.fxh"


/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////

// material parameters (not currently exposed)
float3 Emissive = { 0.0f, 0.0f, 0.0f };
float3 Diffuse = { 1.0f, 1.0f, 1.0f };
float3 Specular = { 0.15f, 0.15f, 0.15f };
float  Shininess = 32.0f;

sampler BaseSampler : register(s0);


/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////
struct VS_INPUT_MESH
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
    float  Fog		: FOG;
};

///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////
VS_OUTPUT vs_main(VS_INPUT_MESH In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;

	// World-space lighting
    float3 world_pos = mul(In.Pos, m_world);	
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world)); 
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(In.Diff.rgb * Diffuse * diff_light, In.Diff.a);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

float4 ps_main(VS_OUTPUT In) : COLOR
{
	float4 base_texel = tex2D(BaseSampler,In.Tex0);
	float3 diffuse = In.Diff.rgb * base_texel.rgb * 2.0;
	float3 specular = In.Spec.rgb;
	return float4(diffuse + specular,base_texel.a * In.Diff.a);
}

vertexshader vs_main_1_1 = compile vs_1_1 vs_main();
pixelshader ps_main_1_1 = compile ps_1_1 ps_main();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////
/*
technique t1
<
	string LOD="DX8";
>
{
    pass t1_p0
    {
        SB_START

    		// blend mode
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;
    
        SB_END        

        VertexShader = (vs_main_1_1); 
        PixelShader  = (ps_main_1_1); 

    }  
}
*/

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

        SB_END        

        // no shaders
        VertexShader = NULL;
        PixelShader = NULL;
        
        MaterialAmbient = (Diffuse);
        MaterialDiffuse = (Diffuse);
        MaterialSpecular = (Specular);
        MaterialEmissive = (Emissive);

	}

/* Not currently used by the 'Prim' system
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


