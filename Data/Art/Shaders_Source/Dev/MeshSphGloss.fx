///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Dev/MeshSphGloss.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	2x Diffuse+Spec lighting
	Spec is modulated by alpha channel of the texture (gloss)

	_ALAMO_VERTEX_TYPE = alD3dVertNU2
	_ALAMO_TANGENT_SPACE = 0
	_ALAMO_SHADOW_VOLUME = 0
	
*/

string RenderPhase = "Opaque";

// Matrices
float4x4 m_world : WORLD;
float4x4 m_worldView  : WORLDVIEW;
float4x4 m_worldViewProj : WORLDVIEWPROJECTION;

// Lighting
float3 m_lightAmbient : GLOBAL_AMBIENT = {0.2f, 0.2f, 0.2f}; // light ambient
float3 m_light0Vector : DIR_LIGHT_VIEW_VEC_0 = {0.7f, 0.0f, 0.7f};  //light vector
float3 m_light0Diffuse : DIR_LIGHT_DIFFUSE_0 = {1.0f, 1.0f, 1.0f}; // Light Diffuse
float3 m_light0Specular : DIR_LIGHT_SPECULAR_0 = {1.0f, 1.0f, 1.0f}; // light specular

float3 m_light1Vector : DIR_LIGHT_VIEW_VEC_1 = {-0.7f, 0.0f, -0.7f};  //light vector
float3 m_light1Diffuse : DIR_LIGHT_DIFFUSE_1 = {0.1f, 0.1f, 0.1f}; // Light Diffuse

float3 m_light2Vector : DIR_LIGHT_VIEW_VEC_2 = {0.7f, 0.0f, -0.7f};  //light vector
float3 m_light2Diffuse : DIR_LIGHT_DIFFUSE_2 = {0.1f, 0.1f, 0.1f}; // Light Diffuse

float4x4 m_sphRed : SPH_LIGHT_RED;
float4x4 m_sphGreen : SPH_LIGHT_GREEN;
float4x4 m_sphBlue : SPH_LIGHT_BLUE;

// Simple fogging, linear equation based on view space distance to the point
// f = fogslope * dist + fogoffset
// To compute fogslope and fogoffset given a near and far fog distance use the following:
// fogslope = 1.0 / (near - far);
// fogoffset = -far / (near - far);
float m_fogSlope : FOG_SLOPE = -0.005f;
float m_fogOffset : FOG_OFFSET = 200.0f;

// material parameters
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float3 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float  Shininess < string UIName="Shininess"; > = 32.0f;

// texture
texture BaseTexture 
< 
	string texture_filename = "gh_gravel00.jpg";
	string UIName = "BaseTexture";
	string UIType = "bitmap"; 
>;

sampler BaseSampler = sampler_state
{
    Texture   = (BaseTexture);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
};

///////////////////////////////////////////////////////
//
// Shader Programs
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float3 Norm : NORMAL;
    float2 Tex  : TEXCOORD0;
};

struct VS_OUTPUT
{
    float4 Pos  : POSITION;
    float4 Diff : COLOR0;
    float4 Spec : COLOR1;
    float2 Tex  : TEXCOORD0;
    float  Fog	: FOG;
};


VS_OUTPUT vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex = In.Tex;

	// Spherical Harmonics lighting
    float4 world_normal = float4(normalize(mul(In.Norm, (float3x3)m_world)),1); 
	float3 diffuse;
	
	diffuse.x = dot(world_normal,mul(m_sphRed,world_normal));
	diffuse.y = dot(world_normal,mul(m_sphGreen,world_normal));
	diffuse.z = dot(world_normal,mul(m_sphBlue,world_normal));

	Out.Diff = float4(diffuse,1);
/*
    // Lighting in view space:
    float3 P = mul(In.Pos, m_worldView);					   // position (view space)
    float3 N = normalize(mul(In.Norm, (float3x3)m_worldView)); // normal (view space)
    float3 L = m_light0Vector;								   // light vector (view space)
	float3 E = -normalize(P); // vector from vert to eye (eye is at 0,0,0 in view space)
	float3 H = normalize(E + L); //half angle vector
	
	float  diff = max(0 , dot(N,L));
	float  spec = pow( max(0 , dot(N,H) ) , Shininess );
	if( diff <= 0 )
	{
		spec = 0;
	}

	float3 ambColor = Diffuse * m_lightAmbient;
	float3 diffColor = Diffuse * diff * m_light0Diffuse;
	float3 specColor = Specular * spec * m_light0Specular;

	// Fill Light 1:
	diff = max(0,dot(N,m_light1Vector));
	diffColor += Diffuse * diff * m_light1Diffuse;

	// Fill Light 2:
	diff = max(0,dot(N,m_light2Vector));
	diffColor += Diffuse * diff * m_light2Diffuse;

	// Output final vertex lighting colors:
    diffColor = diffColor + ambColor + Emissive;
    Out.Diff = float4(diffColor, 1);
    Out.Spec = float4(specColor, 1);

	// Output fog
	float fog = length(Out.Pos.xyz);
	Out.Fog = clamp(m_fogSlope * fog + m_fogOffset,0,1);
*/
    return Out;
}

float4 ps_main(VS_OUTPUT In) : COLOR
{
return In.Diff;

    float4 texel = tex2D(BaseSampler,In.Tex);
    float4 pixel = texel * In.Diff * 2.0;
    pixel.rgb += In.Spec.rgb * texel.a * 2.0;

    return pixel;
}

///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique T0
{
    pass P0
    {
		// blend mode
		ZWriteEnable = TRUE;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		
        // shaders
        VertexShader = compile vs_1_1 vs_main();
        PixelShader  = compile ps_1_1 ps_main();
    }  
}



