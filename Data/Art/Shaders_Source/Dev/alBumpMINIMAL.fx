/*
	
	alBumpMINIMAL.fx
	created: 10:25pm Feb 11, 2004
	author: Greg Hjelstrom
	
	Basic Dot3 diffuse bump-mapping shader.  

	_ALAMO_VERTEX_TYPE = alD3dVertNU2U3U3
	_ALAMO_TANGENT_SPACE = 1
	_ALAMO_SHADOW_VOLUME = 0
	
*/

// Matrices
float4x4 m_world      : WORLD;
float4x4 m_view       : VIEW;
float4x4 m_projection : PROJECTION;
float4x4 m_worldView  : WORLDVIEW;
float4x4 m_worldInv   : WORLDINVERSE;
float4x4 m_worldViewInv : WORLDVIEWINVERSE;
float4x4 m_worldViewProj : WORLDVIEWPROJECTION;

// light
float3 m_lightVec : DIR_LIGHT_VEC_0
<
	string UIObject = "PointLight";
	string Space = "World";
> = {0.707, 0.0, 0.707};

float4 m_lightAmbient : GLOBAL_AMBIENT = { 0.5f, 0.5f, 0.5f, 1.0f};
float4 m_lightDiffuse : DIR_LIGHT_DIFFUSE_0 = {1.0f, 1.0f, 1.0f, 1.0f};
float4 m_lightSpecular : DIR_LIGHT_SPECULAR_0 = { 1.0f, 1.0f, 1.0f, 1.0f};

// material parameters
float4 m_materialDiffuse < string UIName="m_materialDiffuse"; string UIType = "ColorSwatch"; > = {0.8f, 0.8f, 0.8f, 1.0f};
float4 m_materialSpecular < string UIName="m_materialSpecular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f};
float  m_shininess < string UIName="m_shininess"; > = 32.0f;

// texture
texture m_diffuseTexture 
< 
	string texture_filename = "gh_gravel00.jpg";
	string UIName = "m_diffuseTexture";
	string UIType = "bitmap"; 
>;

// normal map
texture m_normalTexture
<
	string texture_filename = "FieldstoneBumpDOT3.tga";
	string UIName = "m_normalTexture";
	string UIType = "bitmap";
>;

///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float3 Pos  : POSITION;
    float3 Normal : NORMAL;
    float2 Tex  : TEXCOORD0;
    float3 Tangent : TANGENT0;
    float3 Binormal : BINORMAL0;
    
};

struct VS_OUTPUT
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float4 Spec : COLOR1;
    float2 Tex0 : TEXCOORD0;
    float2 Tex1 : TEXCOORD1;
    float3 LightVector : TEXCOORD2;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

    float3 P = mul(float4(In.Pos, 1), (float4x3)m_worldView);  // position (view space)
    Out.Pos  = mul(float4(P, 1), m_projection);             // position (projected)

    // TODO: use Half Vector instead of reflection vector?
    float3 L = m_lightVec;
    float3 N = mul(In.Normal, (float3x3)m_worldView); // normal (view space)
	N = normalize(N);
    float3 R = 2 * dot(N, L) * N - L;          // reflection vector (view space)
    R = normalize(R);
    float3 V = -normalize(P);                             // view direction (view space)

    Out.Diff = m_lightAmbient*m_materialDiffuse; // + m_lightDiffuse*m_materialDiffuse*max(0, dot(N, L)); // diffuse + ambient
    Out.Spec = m_lightSpecular*m_materialSpecular*pow(max(0, dot(R, V)), m_shininess);   // specular
    Out.Tex0 = In.Tex;                                       
	Out.Tex1 = In.Tex;
	
	float3 objLightVec = mul(m_lightVec, (float3x3)m_worldViewInv);

	Out.LightVector.x = dot(objLightVec,In.Tangent);
	Out.LightVector.y = dot(objLightVec,In.Binormal);
	Out.LightVector.z = dot(objLightVec,In.Normal);
	Out.LightVector = normalize(Out.LightVector);
	
	// For pixel shader 1.1-1.3 it seems you have to put your outputs
	// into the 0..1 range and expand them back out in the pixel shader...
	Out.LightVector = (0.5f*Out.LightVector)+0.5f;

    return Out;
}

VS_OUTPUT vs_max_main(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

    float3 P = mul(float4(In.Pos, 1), (float4x3)m_worldView);  // position (view space)
    Out.Pos  = mul(float4(P, 1), m_projection);             // position (projected)

    // TODO: use Half Vector instead of reflection vector?
    float3 L = m_lightVec;
    L.z = -L.z;
    float3 N = mul(In.Normal, (float3x3)m_worldView); // normal (view space)
	N = normalize(N);
    float3 R = 2 * dot(N, L) * N - L;          // reflection vector (view space)
    R = normalize(R);
    float3 V = -normalize(P);                             // view direction (view space)

    Out.Diff = m_lightAmbient*m_materialDiffuse; // + m_lightDiffuse*m_materialDiffuse*max(0, dot(N, L)); // diffuse + ambient
    Out.Spec = m_lightSpecular*m_materialSpecular*pow(max(0, dot(R, V)), m_shininess);   // specular
    Out.Tex0 = In.Tex;                                       
	Out.Tex1 = In.Tex;
	
	float3 objLightVec = mul(m_lightVec, (float3x3)m_worldInv);

	Out.LightVector.x = dot(objLightVec,In.Tangent);
	Out.LightVector.y = dot(objLightVec,In.Binormal);
	Out.LightVector.z = dot(objLightVec,In.Normal);
	Out.LightVector = normalize(Out.LightVector);
	
	// For pixel shader 1.1-1.3 it seems you have to put your outputs
	// into the 0..1 range and expand them back out in the pixel shader...
	Out.LightVector = (0.5f*Out.LightVector)+0.5f;

    return Out;
}


sampler diffuseSampler = sampler_state
{
    Texture   = (m_diffuseTexture);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};

sampler normalSampler = sampler_state
{
    Texture   = (m_normalTexture);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};


float4 ps_main(VS_OUTPUT In) : COLOR
{
    float4 diff_texel = tex2D(diffuseSampler,In.Tex0);
	float4 norm_texel = 2.0f * (tex2D(normalSampler, In.Tex1) - 0.5f);
	float3 light_vec = 2.0*(In.LightVector-0.5);
	
	float4 pixel;
	pixel.rgb = diff_texel.rgb * dot(norm_texel.rgb,light_vec) + In.Diff;
	pixel.a = 1.0;
	
    return pixel + In.Spec*diff_texel.a;	// alpha-channel gloss mask
}

//////////////////////////////////////
// Techniques follow
//////////////////////////////////////
technique max_viewport
{
    pass max_p0
    {
		// blend mode
		ZWriteEnable = true;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;

		// shaders
        VertexShader = compile vs_1_1 vs_max_main();
    	PixelShader = compile ps_1_1 ps_main();
    }
}

technique TVertexAndPixelShader
{
    pass p0
    {
		// blend mode
		ZWriteEnable = true;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		
        // shaders
        VertexShader = compile vs_1_1 vs_main();
        PixelShader  = compile ps_1_1 ps_main();
    }  
}

