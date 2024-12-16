///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Planet.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Planet shader, 
    BASE TEXTURE - planet surface color with specular mask in the alpha channel
	BUMP TEXTURE - normals with city lights in the alpha channel
	CLOUD TEXTURE - alpha blended with the base texture, animates around the planet at the specified rate
	
    In addition, the base map is fogged towards an atmosphere color the more the normal points
	away from the view direction.

*/


#include "AlamoEngine.fxh"

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2U3U3";
bool _ALAMO_TANGENT_SPACE = true;
bool _ALAMO_SHADOW_VOLUME = false;

	

/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = { 0.0f, 0.0f, 0.0f };
float3 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = { 1.0f, 1.0f, 1.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = { 1.0f, 1.0f, 1.0f };
float4 Atmosphere < string UIName="Atmosphere"; string UIType = "ColorSwatch"; > = { 0.0f, 0.0f, 0.0f, 1.0f };
float3 CityColor < string UIName="CityColor"; string UIType = "ColorSwatch"; > = { 1.0f, 1.0f, 1.0f };
float AtmospherePower < string UIName="AtmospherePower"; > = 4.5f;  
float CloudScrollRate 
< 
	string UIName="CloudScrollRate"; 
	string UIType = "MaxSpinner";
	float UIMin = -1.0f;
	float UIMax = 1.0f; 
> = 0.0025f;

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

texture CloudTexture
<
    string UIName = "CloudTexture";
    string UIType = "bitmap";
>;

texture CloudNormalTexture
<
    string UIName = "CloudNormalTexture";
    string UIType = "bitmap";
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

sampler CloudSampler = sampler_state
{
	Texture   = (CloudTexture);
	MIPFILTER = ANISOTROPIC;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
	AddressU  = WRAP;        
	AddressV  = WRAP;
};

sampler CloudNormalSampler = sampler_state
{
	Texture   = (CloudNormalTexture);
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
	float4  Pos     : POSITION;
	float4  Diff	: COLOR0;
	float4	Spec	: COLOR1;
	float2  Tex0    : TEXCOORD0;        // base texture
	float2	Tex1	: TEXCOORD1;        // bumps
    float2  Tex2    : TEXCOORD2;        // clouds
	float3  LightVector: TEXCOORD3;     // light vector in tangent space
	float3  HalfAngleVector: TEXCOORD4; // half angle vector in tangent space
    float2  Factors : TEXCOORD5;        // X = atmosphere (edge/rim factor) Y = darkness (scales city lights) 
    
	float   Fog		: FOG;
};


struct VS_OUTPUT2
{
	float4  Pos     : POSITION;
	float4  Diff	: COLOR0;
	float4	Spec	: COLOR1;
	float2  Tex0    : TEXCOORD0;        // base texture
	float2	Tex1	: TEXCOORD1;        // bumps
    float2  Tex2    : TEXCOORD2;        // clouds
	float3  LightVector: TEXCOORD3;     // light vector in tangent space
    float2  Factors : TEXCOORD4;        // X = atmosphere (edge/rim factor) Y = darkness (scales city lights) 
    
	float   Fog		: FOG;
};



///////////////////////////////////////////////////////
//
// Shaders
//
///////////////////////////////////////////////////////
VS_OUTPUT sph_bump_spec_vs_main(VS_INPUT_MESH In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
	
    // base + normal uv coords just copy the inputs
    Out.Tex0 = In.Tex;                                       
	Out.Tex1 = In.Tex;
    
    // cloud uv coords scroll along the u axis
    Out.Tex2 = In.Tex;
    Out.Tex2.x += m_time * CloudScrollRate;
    
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


    // Compute the other lighting factors.
    // x = atmospheric fogging factor 
    // y = n.l for the "sun", used to control the application of city lights
    float3 world_eye_vec = normalize(m_eyePos - world_pos);
    float vdotn = dot(world_normal,world_eye_vec);
    Out.Factors.x = pow((1.0f - vdotn),AtmospherePower) * 2.0f * Atmosphere.a;
    Out.Factors.y = saturate(dot(In.Normal,-32.0f * m_light0ObjVector));
    
    // Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}

half4 bump_spec_ps_main(VS_OUTPUT In) : COLOR
{
    half4 baseTexel = tex2D(BaseSampler,In.Tex0);
	half4 normalTexel = tex2D(NormalSampler,In.Tex1);
    half4 cloudTexel = tex2D(CloudSampler,In.Tex2);
    half4 cloudNormalTexel = tex2D(CloudNormalSampler,In.Tex2);
    
    // compute lighting
	half3 norm_vec = 2.0f*(normalTexel.rgb - 0.5f);
    //half3 cloud_norm = half3(0,0,1); 
    half3 cloud_norm = 2.0f*(cloudNormalTexel.rgb - 0.5f);
	half3 light_vec = 2.0f*(In.LightVector - 0.5f);
	half3 half_vec = 2.0f*(In.HalfAngleVector - 0.5f);
    //half_vec = normalize(half_vec);
	//light_vec = normalize(light_vec);

    // bump lighting for the cloud layer
    half cloud_ndotl = saturate(dot(cloud_norm,light_vec));
    cloudTexel.rgb = (cloudTexel.rgb * cloud_ndotl * m_light0Diffuse + In.Diff.rgb)*2.0f;
//return cloudTexel;

    // planet color depends on the base texture and the atmosphere
    half atmosphere_factor = In.Factors.x;

    half3 planet_color = baseTexel.rgb; 
    half3 surface_color = planet_color + Atmosphere.rgb * atmosphere_factor; 
	
	half ndotl = saturate(dot(norm_vec,light_vec));
	half ndoth = saturate(dot(norm_vec,half_vec));

	// Apply the lighting
	half3 diff = surface_color * (ndotl*Diffuse*m_light0Diffuse + In.Diff.rgb) * 2.0;
	half3 spec = m_light0Specular*Specular*pow(ndoth,16)*normalTexel.a;

    // Add in city lights
    diff += baseTexel.a * In.Factors.y * (1.0f - cloudTexel.a) * CityColor;
    diff = lerp(diff+spec,cloudTexel.rgb,cloudTexel.a);
    return half4(diff,In.Diff.a);
}


VS_OUTPUT2 sph_bump_vs_main(VS_INPUT_MESH In)
{
	VS_OUTPUT2 Out = (VS_OUTPUT2)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
	
    // base + normal uv coords just copy the inputs
    Out.Tex0 = In.Tex;                                       
	Out.Tex1 = In.Tex;
    
    // cloud uv coords scroll along the u axis
    Out.Tex2 = In.Tex;
    Out.Tex2.x += m_time * CloudScrollRate;
    
	// Compute the tangent-space light vector and half-angle vector for per-pixel lighting
	// Note that we are doing everything in object space here.
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(In.Tangent,In.Binormal,In.Normal);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);

	// Fill lighting is applied per-vertex.  This must be computed in
	// world space for spherical harmonics to work.
	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(world_normal);
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * Diffuse.rgb * m_lightScale.rgb + Emissive, m_lightScale.a);
    Out.Spec = float4(spec_light * Specular, 1);



    // Compute the other lighting factors.
    // x = atmospheric fogging factor 
    // y = -n.l for the "sun", used to control the application of city lights
    float3 world_eye_vec = normalize(m_eyePos - world_pos);
    float vdotn = dot(world_normal,world_eye_vec);
    Out.Factors.x = pow((1.0f - vdotn),AtmospherePower) * 2.0f * Atmosphere.a;
    Out.Factors.y = saturate(dot(In.Normal,-32.0f * m_light0ObjVector));
    
    // Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

    return Out;
}


half4 bump_ps_main(VS_OUTPUT2 In) : COLOR
{
	half4 baseTexel = tex2D(BaseSampler,In.Tex0);
	half4 normalTexel = tex2D(NormalSampler,In.Tex1);
    half4 cloudTexel = tex2D(CloudSampler,In.Tex2);
    
	// planet color depends on the base texture and the atmosphere
    half atmosphere_factor = In.Factors.x;
    half3 planet_color = lerp(baseTexel.rgb,cloudTexel.rgb,cloudTexel.a);
    half3 surface_color = planet_color + Atmosphere.rgb * atmosphere_factor; 

    // compute lighting
	half3 norm_vec = 2.0f*(normalTexel.rgb - 0.5f);
	half3 light_vec = 2.0f*(In.LightVector - 0.5f);
    //half_vec = normalize(half_vec);
	//light_vec = normalize(light_vec);
	
	half ndotl = saturate(dot(norm_vec,light_vec));
	
	// Apply the lighting
	half3 diff = surface_color * (ndotl*Diffuse*m_light0Diffuse + In.Diff.rgb) * 2.0;
    half3 spec = In.Spec * normalTexel.a;
    
    // Add in city lights
    diff += baseTexel.a * In.Factors.y * cloudTexel.a * CityColor;

    return half4(diff + spec, In.Diff.a);
}

vertexshader sph_bump_spec_vs_main_bin = compile vs_1_1 sph_bump_spec_vs_main();
vertexshader sph_bump_vs_main_bin = compile vs_1_1 sph_bump_vs_main();
pixelshader bump_spec_ps_main_bin = compile ps_2_0 bump_spec_ps_main();
pixelshader bump_ps_main_bin = compile ps_1_4 bump_ps_main();



//////////////////////////////////////
// Techniques follow
//////////////////////////////////////

technique max_viewport
{
    pass max_viewport_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = true;
    		ZFunc = LESSEQUAL;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    		
        SB_END        

        // shaders 
        VertexShader = (sph_bump_spec_vs_main_bin);
        PixelShader  = (bump_spec_ps_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
    }  
}

technique sph_t3
<
	string LOD="DX9";
>
{
    pass sph_t3_p0
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
        PixelShader  = (bump_spec_ps_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
    }  
}


technique sph_t2
<
	string LOD="DX8ATI";
>
{
    pass sph_t2_p0
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
        PixelShader  = (bump_ps_main_bin);
   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
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
            TexCoordIndex[1]=0;
    		
            ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
            AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
    		ColorOp[1]=BLENDTEXTUREALPHA;
    		ColorArg1[1]=TEXTURE;
    		ColorArg2[1]=CURRENT; 
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=DIFFUSE;
            
            ColorOp[2]=MODULATE2X;
    		ColorArg1[2]=DIFFUSE;
    		ColorArg2[2]=CURRENT;
    		AlphaOp[2]=SELECTARG1;
    		AlphaArg1[2]=CURRENT;
    		
    		ColorOp[3] = DISABLE;
    		AlphaOp[3] = DISABLE;

        SB_END        

   		AlphaBlendEnable = (m_lightScale.w < 1.0f); 
		Texture[0]=(BaseTexture);
        Texture[1]=(CloudTexture);
		MaterialAmbient = (Diffuse);
	    MaterialDiffuse = (float4(Diffuse.rgb*m_lightScale.rgb,m_lightScale.a));
		MaterialSpecular = (Specular);
		MaterialEmissive = (Emissive);
		MaterialPower = 32.0f;

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
    }  

    pass t0_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        TexCoordIndex[1]=1;
    }    
}

