///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/FillRateTest.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Fill Rate Test Shader, originally based on MeshBumpColorize.fx
    This is a 'representative' shader for EAW-FOC, and is used to benchmark the graphics
    card fill rate performance.
    
*/

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_PROC = "Mesh";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2U3U3";
bool _ALAMO_TANGENT_SPACE = true; 
bool _ALAMO_SHADOW_VOLUME = false;


#include "AlamoEngine.fxh"



/////////////////////////////////////////////////////////////////////
//
// Material parameters
// Colors set to black so we end up rendering black!
//
/////////////////////////////////////////////////////////////////////
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float3 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float  Shininess < string UIName="Shininess"; > = 32.0f;
float4 Colorization < string UIName="Colorization"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f, 1.0f};
float4 UVOffset < string UIName="UVOffset"; > = {0.0f, 0.0f, 0.0f, 0.0f};

texture BaseTexture 
< 
	string UIName = "BaseTexture";
	string UIType = "bitmap"; 
>;

texture NormalTexture
<
	string UIName = "NormalTexture";
	string UIType = "bitmap";
	bool DiscardableBump = true;
>;


/////////////////////////////////////////////////////////////////////
//
// Samplers
//
/////////////////////////////////////////////////////////////////////
sampler BaseSampler = sampler_state
{
    Texture   = (BaseTexture);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
    AddressU  = WRAP;        
    AddressV  = WRAP;
};

sampler NormalSampler = sampler_state
{
    Texture   = (NormalTexture);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
    AddressU  = WRAP;        
    AddressV  = WRAP;
};


/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////
struct VS_INPUT_MESH
{
	float4 Pos  : POSITION;
	float3 Normal : NORMAL;
	float2 Tex  : TEXCOORD0;
	float3 Tangent : TANGENT0;
	float3 Binormal : BINORMAL0;
};

struct VS_OUTPUT
{
	float4  Pos     	: POSITION;
	float4  Diff		: COLOR0;
	float4	Spec		: COLOR1;
	float2  Tex0    	: TEXCOORD0;
	float2	Tex1		: TEXCOORD1;
	float3  LightVector	: TEXCOORD2;
	float3  HalfAngleVector	: TEXCOORD3;
	float  Fog		: FOG;
};


/////////////////////////////////////////////////////////////////////
//
// Pixel Shaders
//
/////////////////////////////////////////////////////////////////////
half4 bump_spec_colorize_ps_main(VS_OUTPUT In): COLOR
{
	half4 baseTexel = tex2D(BaseSampler,In.Tex0);
	half4 normalTexel = tex2D(NormalSampler,In.Tex1);

	// lerp the colorization
	half3 surface_color = lerp(baseTexel.rgb,Colorization*baseTexel.rgb,baseTexel.a);
	
	// compute lighting
	half3 norm_vec = 2.0f*(normalTexel.rgb - 0.5f);
	half3 light_vec = 2.0f*(In.LightVector - 0.5f);
	half3 half_vec = 2.0f*(In.HalfAngleVector - 0.5f);
	//half_vec = normalize(half_vec);
	//light_vec = normalize(light_vec);
	
	half ndotl = saturate(dot(norm_vec,light_vec));
	half ndoth = saturate(dot(norm_vec,half_vec));

	// put it all together
	half3 diff = surface_color * (ndotl*Diffuse*m_light0Diffuse*m_lightScale.rgb + In.Diff.rgb) * 2.0;
	half3 spec = m_light0Specular*Specular*pow(ndoth,16)*normalTexel.a;
	return half4(diff + spec, In.Diff.a);
}

half4 bump_spec_colorize_ps14_main(VS_OUTPUT In): COLOR
{
	half4 baseTexel = tex2D(BaseSampler,In.Tex0);
	half4 normalTexel = tex2D(NormalSampler,In.Tex1);

	// lerp the colorization
	half3 surface_color = lerp(baseTexel.rgb,Colorization*baseTexel.rgb,baseTexel.a);
	
	// compute lighting
	half3 norm_vec = 2.0f*(normalTexel.rgb - 0.5f);
	half3 light_vec = 2.0f*(In.LightVector - 0.5f);
	half3 half_vec = 2.0f*(In.HalfAngleVector - 0.5f);
	//half_vec = normalize(half_vec);
	//light_vec = normalize(light_vec);
	
	half ndotl = saturate(dot(norm_vec,light_vec));
	half ndoth = saturate(dot(norm_vec,half_vec));

	// put it all together
	half3 diff = surface_color * (ndotl*Diffuse*m_light0Diffuse*m_lightScale.rgb + In.Diff.rgb) * 2.0;
	half3 spec = m_light0Specular*Specular*pow(ndoth,4)*normalTexel.a;
	return half4(diff + spec, In.Diff.a);
}

half4 bump_colorize_ps11_main(VS_OUTPUT In) : COLOR
{
	// sample the textures
    half4 base_texel = tex2D(BaseSampler,In.Tex0);
    half4 norm_texel = tex2D(NormalSampler,In.Tex1);
	
	// lerp the colorization
	half3 surface_color = lerp(base_texel.rgb,Colorization*base_texel.rgb,base_texel.a);
	
	// diffuse bump lighting
	half3 norm_vec = 2.0f*(norm_texel.rgb - 0.5f);
	half3 light_vec = 2.0f*(In.LightVector - 0.5f);
	half ndotl = saturate(dot(norm_vec,light_vec));  

	// put it all together
	half3 diffuse = surface_color * (ndotl*Diffuse*m_light0Diffuse*m_lightScale.rgb + In.Diff.rgb) * 2.0;
	half3 specular = In.Spec * norm_texel.a;
	return half4(diffuse + specular, In.Diff.a);
}


///////////////////////////////////////////////////////
//
// Vertex Shaders
//
///////////////////////////////////////////////////////
VS_OUTPUT sph_bump_spec_vs_main(VS_INPUT_MESH In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex + UVOffset;                                       
	Out.Tex1 = In.Tex + UVOffset;

	// Compute the tangent-space light vector and half-angle vector for per-pixel lighting
	// Note that we are doing everything in object space here.
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(In.Tangent,In.Binormal,In.Normal);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);
	Out.HalfAngleVector = Compute_Tangent_Space_Half_Vector(In.Pos,m_eyePosObj,m_light0ObjVector,to_tangent_matrix);

	// Fill lighting is applied per-vertex.  This must be computed in
	// world space for spherical harmonics to work.
	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse.rgb * m_lightScale.rgb + Emissive, m_lightScale.a);  
    Out.Spec = float4(0,0,0,1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

VS_OUTPUT sph_bump_vs_main(VS_INPUT_MESH In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex + UVOffset;                                       
 	Out.Tex1 = In.Tex + UVOffset;

	// Compute the tangent-space light vector
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(In.Tangent,In.Binormal,In.Normal);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);

    // Vertex lighting, diffuse fill lights + spec for main light
	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(world_normal);
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse.rgb * m_lightScale.rgb + Emissive, m_lightScale.a);
    Out.Spec = float4(spec_light * Specular, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
    
    return Out;
}


vertexshader sph_bump_spec_vs_main_bin = compile vs_1_1 sph_bump_spec_vs_main();
vertexshader sph_bump_vs_main_bin = compile vs_1_1 sph_bump_vs_main();
pixelshader bump_spec_colorize_ps_main_bin = compile ps_2_0 bump_spec_colorize_ps_main();
pixelshader bump_spec_colorize_ps14_main_bin = compile ps_1_4 bump_spec_colorize_ps14_main();
pixelshader bump_colorize_ps11_main_bin = compile ps_1_1 bump_colorize_ps11_main();


//////////////////////////////////////
// Techniques follow
//////////////////////////////////////

technique t3
<
	string LOD="DX9";
>
{
    pass p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
       		//AlphaBlendEnable = false; 
    		
        SB_END        

        // shaders 
        VertexShader = (sph_bump_spec_vs_main_bin);
        PixelShader  = (bump_spec_colorize_ps_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 

    }  
}

technique t2
<
	string LOD="DX8ATI";
>
{
    pass p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
        SB_END        

        // shaders
        VertexShader = (sph_bump_spec_vs_main_bin);
        PixelShader  = (bump_spec_colorize_ps14_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 

    }  
}


technique t1
<
	string LOD="DX8";
>
{
    pass p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
        SB_END        

        // shaders
        VertexShader = (sph_bump_vs_main_bin);
        PixelShader  = (bump_colorize_ps11_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 

    }  
}

technique t0
<
	string LOD="FIXEDFUNCTION";
>
{
    pass p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
            // fixed function pixel pipeline
    		Lighting=true;
    		 
    		MinFilter[0]=LINEAR;
    		MagFilter[0]=LINEAR;
    		MipFilter[0]=LINEAR;
    		AddressU[0]=wrap;
    		AddressV[0]=wrap;
    		TexCoordIndex[0]=0;
    
    		ColorOp[0]=BLENDTEXTUREALPHA;
    		ColorArg1[0]=TFACTOR;
    		ColorArg2[0]=TEXTURE; 
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
    		ColorOp[1]=MODULATE2X;
    		ColorArg1[1]=DIFFUSE;
    		ColorArg2[1]=CURRENT;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=DIFFUSE;
    		
    		ColorOp[2] = DISABLE;
    		AlphaOp[2] = DISABLE;

        SB_END        

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
        
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
		MaterialAmbient = (Diffuse);
		MaterialDiffuse = (float4(Diffuse.rgb*m_lightScale.rgb,m_lightScale.a));
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;
		Texture[0]=(BaseTexture);
		TextureFactor=(Colorization);
    }  
}


