/*
	
	alDefault.fx
	created: 11:45am Feb 8, 2004
	author: Greg Hjelstrom
	
	Simple default shader, texturing with diffuse lighting.  

	_ALAMO_VERTEX_TYPE = alD3dVertNU2
	_ALAMO_TANGENT_SPACE = 0
	_ALAMO_SHADOW_VOLUME = 0
	
*/

// Matrices
float4x4 m_world      : WORLD;
float4x4 m_view       : VIEW;
float4x4 m_projection : PROJECTION;
float4x4 m_worldView  : WORLDVIEW;

// Lighting
float3 m_lightAmbient : GLOBAL_AMBIENT = {0.5f, 0.5f, 0.5f}; // light ambient
float3 m_light0Vector : DIR_LIGHT_VIEW_VEC_0 = {0.7f, 0.0f, 0.7f};  //light vector
float3 m_light0Diffuse : DIR_LIGHT_DIFFUSE_0 = {1.0f, 1.0f, 1.0f}; // Light Diffuse
float3 m_light0Specular : DIR_LIGHT_SPECULAR_0 = {1.0f, 1.0f, 1.0f}; // light specular

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

///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float3 Pos  : POSITION;
    float3 Norm : NORMAL;
    float2 Tex  : TEXCOORD0;
};

struct VS_OUTPUT
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float4 Spec : COLOR1;
    float2 Tex  : TEXCOORD0;
};

VS_OUTPUT VS(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    float3 L = m_light0Vector;

    float3 P = mul(float4(In.Pos, 1), (float4x3)m_worldView);  // position (view space)
    float3 N = normalize(mul(In.Norm, (float3x3)m_worldView)); // normal (view space)
	
    float3 R = normalize(2 * dot(N, L) * N - L);          // reflection vector (view space)
    float3 V = -normalize(P);                             // view direction (view space)

    Out.Pos  = mul(float4(P, 1), m_projection);             // position (projected)
    Out.Diff.rgb = m_lightAmbient.rgb*m_materialDiffuse + m_light0Diffuse*m_materialDiffuse.rgb*max(0, dot(N, L)); // diffuse + ambient
    Out.Diff.a = m_materialDiffuse.a;
    Out.Spec.rgb = m_light0Specular.rgb*m_materialSpecular*pow(max(0, dot(R, V)), m_shininess);   // specular
    Out.Spec.a = 1.0f;
    Out.Tex  = In.Tex;                                       

    return Out;
}

sampler Sampler = sampler_state
{
    Texture   = (m_diffuseTexture);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};

float4 PS(
    float4 Diff : COLOR0,
    float4 Spec : COLOR1,
    float2 Tex  : TEXCOORD0) : COLOR
{
    float4 texel = tex2D(Sampler,Tex);
    return texel * Diff + Spec * texel[3];		// alpha-channel gloss mask
}

technique TVertexAndPixelShader
{
    pass P0
    {
		// blend mode
		ZWriteEnable = true;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		
        // shaders
        VertexShader = compile vs_1_1 VS();
        PixelShader  = compile ps_1_1 PS();
    }  
}

technique TVertexShaderOnly
{
    pass P0
    {
		// blend mode
		ZWriteEnable = true;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		
        // lighting
        Lighting       = FALSE;
        SpecularEnable = TRUE;

        // samplers
        Sampler[0] = (Sampler);

        // texture stages
        ColorOp[0]   = MODULATE;
        ColorArg1[0] = TEXTURE;
        ColorArg2[0] = DIFFUSE;
        AlphaOp[0]   = MODULATE;
        AlphaArg1[0] = TEXTURE;
        AlphaArg2[0] = DIFFUSE;

        ColorOp[1]   = DISABLE;
        AlphaOp[1]   = DISABLE;

		// shaders
        VertexShader = compile vs_1_1 VS();
        PixelShader  = NULL;
    }
}

technique TNoShader
{
    pass P0
    {
		// blend mode
		ZWriteEnable = true;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		
        // transforms
        WorldTransform[0]   = (m_world);
        ViewTransform       = (m_view);
        ProjectionTransform = (m_projection);

        // material
        MaterialAmbient  = (m_materialDiffuse); 
        MaterialDiffuse  = (m_materialDiffuse); 
        MaterialSpecular = (m_materialSpecular); 
        MaterialPower    = (m_shininess);
        
        // lighting
        LightType[0]      = DIRECTIONAL;
        LightAmbient[0]   = (m_lightAmbient);
        LightDiffuse[0]   = (m_light0Diffuse);
        LightSpecular[0]  = (m_light0Specular); 
        LightDirection[0] = (-m_light0Vector);
        LightRange[0]     = 100000.0f;

        LightEnable[0] = TRUE;
        Lighting       = TRUE;
        SpecularEnable = TRUE;
        
        // samplers
        Sampler[0] = (Sampler);
        
        // texture stages
        ColorOp[0]   = MODULATE;
        ColorArg1[0] = TEXTURE;
        ColorArg2[0] = DIFFUSE;
        AlphaOp[0]   = MODULATE;
        AlphaArg1[0] = TEXTURE;
        AlphaArg2[0] = DIFFUSE;

        ColorOp[1]   = DISABLE;
        AlphaOp[1]   = DISABLE;

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;
    }
}


