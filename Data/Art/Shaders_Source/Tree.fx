///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Tree.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Tree shader, incorporates wind-swaying,
	Was trying specular bump mapping but it didn't seem worth it so its commented out...

*/

string _ALAMO_RENDER_PHASE = "Transparent";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2";
bool _ALAMO_TANGENT_SPACE = true;
bool _ALAMO_SHADOW_VOLUME = false;
	

#include "AlamoEngine.fxh"


// material parameters
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float3 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float  Shininess < string UIName="Shininess"; > = 32.0f;
float  BendScale < string UIName="BendScale"; > = 1.0;

texture BaseTexture 
< 
	string UIName = "BaseTexture";
	string UIType = "bitmap"; 
>;

texture NormalTexture
<
	string UIName = "NormalTexture";
	string UIType = "bitmap";
>;

sampler BaseSampler = sampler_state
{
    Texture   = (BaseTexture);
    MIPFILTER = ANISOTROPIC;
    MinFilter = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};

sampler NormalSampler = sampler_state
{
    Texture   = (NormalTexture);
    MIPFILTER = ANISOTROPIC;
    MinFilter = ANISOTROPIC;
    MagFilter = ANISOTROPIC;
	MaxAnisotropy = 16;
};


///////////////////////////////////////////////////////
//
// MeshGloss shader.  Using this for now since the
// fancy shader seems too slown.
//
///////////////////////////////////////////////////////

struct VS_INPUT_GLOSS
{
    float4 Pos  : POSITION;
    float3 Norm : NORMAL;
    float2 Tex  : TEXCOORD0;
};

struct VS_OUTPUT_GLOSS
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float4 Spec : COLOR1;
    float2 Tex  : TEXCOORD0;
    float  Fog	: FOG;
};


VS_OUTPUT_GLOSS sph_vs_main_gloss(VS_INPUT_GLOSS In)
{
    VS_OUTPUT_GLOSS Out = (VS_OUTPUT_GLOSS)0;

	// Transform into world space   
   	float3 world_pos = mul(In.Pos,m_world);
   	float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world));
   	
   	// Bend the tree based on object-space Z (need pivot of the mesh placed
   	// at the base with the z-axis pointing up for this to work)
	world_pos.xyz += BendScale*m_bendVector.xyz * (In.Pos.z*In.Pos.z*m_bendVector.w);

	// Output position and texcoords
   	Out.Pos = mul(float4(world_pos,1),m_viewProj);
    Out.Tex = In.Tex;

	// Given world-space position and normal, compute the shading
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse.rgb * diff_light * m_lightScale.rgb + Emissive, m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

float4 ps_main_gloss(VS_OUTPUT_GLOSS In) : COLOR
{
    float4 texel = tex2D(BaseSampler,In.Tex);
    float4 pixel;
    pixel.rgb = texel.rgb * In.Diff.rgb * 2.0;
    pixel.rgb += In.Spec.rgb * texel.a * 2.0;
	pixel.a = texel.a * In.Diff.a;
    return pixel;
}

///////////////////////////////////////////////////////////////////
//
// Max viewport shader, Max doesn't seem to support some of the
// transforms I'm using above
// 
///////////////////////////////////////////////////////////////////
VS_OUTPUT_GLOSS vs_max_main(VS_INPUT_GLOSS In)
{
    VS_OUTPUT_GLOSS Out = (VS_OUTPUT_GLOSS)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex = In.Tex;

   	// Given world-space position and normal, compute the shading
    float3 world_pos = mul(In.Pos, m_world);	
    float3 world_normal = normalize(mul(In.Norm, (float3x3)m_world)); 
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(Diffuse.rgb * diff_light * m_lightScale.rgb + Emissive, m_lightScale.a);
    Out.Spec = float4(Specular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}


vertexshader sph_vs_main_gloss_bin = compile vs_1_1 sph_vs_main_gloss();
vertexshader vs_max_main_bin = compile vs_1_1 vs_max_main();

PixelShader ps_main_gloss_bin = compile ps_1_1 ps_main_gloss();

//////////////////////////////////////
// Techniques follow
//////////////////////////////////////

technique max_viewport
{
    pass max_viewport_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    		AlphaTestEnable = TRUE;
    		AlphaRef = 0x00000080;
    		AlphaFunc = Greater;

        SB_END        

        // shaders
        VertexShader = (vs_max_main_bin);
        PixelShader  = (ps_main_gloss_bin);
    }  
}

technique sph_t1
<
	string LOD="DX8";
>
{
    pass sph_t1_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = TRUE;
    		AlphaRef = 0x00000080;
    		AlphaFunc = Greater;

        SB_END        

        // shaders
        VertexShader = (sph_vs_main_gloss_bin);
        PixelShader  = (ps_main_gloss_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
    } 

    pass sph_t1_p1
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            MipFilter[0]=LINEAR;
            MipFilter[1]=LINEAR;
    
            MinFilter[0]=LINEAR;
            MinFilter[1]=LINEAR;
    
            MagFilter[0]=LINEAR;
            MagFilter[1]=LINEAR;

        SB_END        
    }
 
}

technique sph_t0
<
	string LOD="FIXEDFUNCTION";
>
{
    pass sph_t0_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = TRUE;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = TRUE;
    		AlphaRef = 0x00000080;
    		AlphaFunc = Greater;
    
    		Lighting=true;
    
            // fixed function pixel pipeline
    		MinFilter[0]=LINEAR;
    		MagFilter[0]=LINEAR;
    		MipFilter[0]=LINEAR;
    		
    		ColorOp[0]=MODULATE2X;
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=MODULATE;
    		AlphaArg1[0]=TEXTURE;
    		AlphaArg2[0]=DIFFUSE;
    		
    		ColorOp[1]=MODULATEALPHA_ADDCOLOR;
    		ColorArg1[1]=CURRENT;
    		ColorArg2[1]=SPECULAR;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=CURRENT;
    		
    		ColorOp[2]=DISABLE;
    		AlphaOp[2]=DISABLE;

        SB_END        

        VertexShader = NULL;
        PixelShader  = NULL;
        
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
		MaterialAmbient = (Diffuse);
        MaterialDiffuse = (float4(Diffuse.rgb*m_lightScale.rgb,m_lightScale.a));
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;
		Texture[0]=(BaseTexture);
    }  


    pass sph_t1_p1
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            MipFilter[0]=LINEAR;
            MipFilter[1]=LINEAR;
    
            MinFilter[0]=LINEAR;
            MinFilter[1]=LINEAR;
    
            MagFilter[0]=LINEAR;
            MagFilter[1]=LINEAR;

        SB_END        
    }
}

