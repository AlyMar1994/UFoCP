///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Dev/alPerPixelSpecBump.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Per-pixel specular bump mapping.  

	_ALAMO_VERTEX_TYPE = alD3dVertNU2U3U3
	_ALAMO_TANGENT_SPACE = 1
	_ALAMO_SHADOW_VOLUME = 0
	
*/

string RenderPhase = "Opaque";

// Matrices
float4x4 m_world : WORLD;
float4x4 m_worldView  : WORLDVIEW;
float4x4 m_worldViewInv : WORLDVIEWINVERSE;
float4x4 m_worldViewProj : WORLDVIEWPROJECTION;
float4x4 m_viewProj : VIEWPROJECTION;
float4x4 m_viewInv : VIEWINVERSE;

// Lighting
float3 m_lightAmbient : GLOBAL_AMBIENT = {0.2f, 0.2f, 0.2f}; // light ambient
float3 m_light0Vector : DIRECTION 
<
    string Object = "DirectionalLight";
    string Space = "VIEW";
> = { 1, 0, 0 }; //DIR_LIGHT_VIEW_VEC_0 = {0.7f, 0.0f, 0.7f};  //light vector

float3 m_light0ObjVector : DIR_LIGHT_OBJ_VEC_0 = {0.7f, 0.0f, 0.7f};  //light vector
float3 m_light0Diffuse : DIR_LIGHT_DIFFUSE_0 = {0.5f, 0.5f, 0.5f}; // Light Diffuse
float3 m_light0Specular : DIR_LIGHT_SPECULAR_0 = {0.75f, 0.75f, 0.75f}; // light specular

float3 m_light1Vector : DIR_LIGHT_VIEW_VEC_1 = {-0.7f, 0.0f, -0.7f};  //light vector
float3 m_light1Diffuse : DIR_LIGHT_DIFFUSE_1 = {0.1f, 0.1f, 0.1f}; // Light Diffuse

float3 m_light2Vector : DIR_LIGHT_VIEW_VEC_2 = {0.7f, 0.0f, -0.7f};  //light vector
float3 m_light2Diffuse : DIR_LIGHT_DIFFUSE_2 = {0.1f, 0.1f, 0.1f}; // Light Diffuse

// Simple fogging, linear equation based on view space distance to the point
// f = fogslope * dist + fogoffset
// To compute fogslope and fogoffset given a near and far fog distance use the following:
// fogslope = 1.0 / (near - far);
// fogoffset = -far / (near - far);
float m_fogSlope : FOG_SLOPE = -0.005f;
float m_fogOffset : FOG_OFFSET = 200.0f;

// Tree/Plant bending.  (x,y) are a 2d world space offset, z = height at wich you offset 100%?
float3 m_bendVector : WIND_BEND_VECTOR = { 1.0f, 0.0f, 0.0f };

// material parameters
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float3 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float3 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f };
float  Shininess < string UIName="Shininess"; > = 32.0f;

texture BaseTexture 
< 
	string texture_filename = "gh_gravel00.jpg";
	string UIName = "BaseTexture";
	string UIType = "bitmap"; 
>;

texture NormalTexture
<
	string texture_filename = "FieldstoneBumpDOT3.tga";
	string UIName = "NormalTexture";
	string UIType = "bitmap";
>;

sampler BaseSampler = sampler_state
{
    Texture   = (BaseTexture);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
};

sampler NormalSampler = sampler_state
{
    Texture   = (NormalTexture);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
};


///////////////////////////////////////////////////////
//
// Vertex Shader
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
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
    float3 LightVector : TEXCOORD2; //in tangent space
    float3 HalfAngleVector : TEXCOORD3; //in tangent space

    float  Fog	: FOG;
};

VS_OUTPUT vs_main(VS_INPUT In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

   	float3 world_pos = mul(In.Pos,m_world);
   	Out.Pos = mul(float4(world_pos,1),m_viewProj);
    Out.Tex0 = In.Tex;                                       
	Out.Tex1 = In.Tex;

	// 3x3 transform from object space to tangent space, used to set up per-pixel lighting parameters
	float3x3 objToTangentSpace;
    objToTangentSpace[0] = In.Tangent;
    objToTangentSpace[1] = In.Binormal;
    objToTangentSpace[2] = In.Normal;
	objToTangentSpace = transpose(objToTangentSpace);
	
	// Transform primary light vector into tangent space
	float3 obj_light_vector = mul(m_light0Vector,(float3x3)m_worldViewInv);
	Out.LightVector = mul(obj_light_vector,objToTangentSpace);

	// For pixel shader 1.1-1.3 you have to put your outputs into the 0..1 range 
	// and expand them back out in the pixel shader.
	Out.LightVector = (0.5f*Out.LightVector)+0.5f;

    // Lighting, TODO, optimize this!
	float3 P = mul(In.Pos, (float4x3)m_worldView);  // position (view space)
    float3 N = normalize(mul(In.Normal, (float3x3)m_worldView)); // normal (view space)
    float3 L = m_light0Vector;								   // light vector (view space)
	float3 E = -normalize(P); // vector from vert to eye (eye is at 0,0,0 in view space)
	float3 H = normalize(E + L); //half angle vector

	float3 obj_half_vector = mul(H,(float3x3)m_worldViewInv);
	Out.HalfAngleVector = mul(obj_half_vector,objToTangentSpace);
	Out.HalfAngleVector = (0.5f*Out.HalfAngleVector)+0.5f; 
	
	float  diff = 0; //max(0 , dot(N,L));
	float  spec = 0; //pow( max(0 , dot(N,H) ) , Shininess );
	if( diff <= 0 )
	{
		spec = 0;
	}
	float3 ambColor = Diffuse * m_lightAmbient;
	float3 diffColor = 0; //diffuse lighting for light0 done per-pixel
	float3 specColor = 0; //specular lighting done per-pixel

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

    return Out;
}

float4 ps_main(VS_OUTPUT In) : COLOR
{
	// sample the textures
    float4 base_texel = tex2D(BaseSampler,In.Tex0.xy);
    float4 norm_texel = tex2D(NormalSampler,In.Tex1.xy);
	
	// surface color
	float3 surface_color = base_texel.rgb;
	
	// per-pixel bump for the "primary" light
	float3 norm_vec = 2.0f*(norm_texel.rgb - 0.5f);
	float3 light_vec = 2.0f*(In.LightVector - 0.5f);
	float3 half_vec = 2.0f*(In.HalfAngleVector - 0.5f);
	half_vec = normalize(half_vec);
		
	float ndotl = saturate(dot(norm_vec,light_vec));
	float ndoth = saturate(dot(norm_vec,half_vec));

	// Put it all together
	float3 diff = surface_color * (ndotl*Diffuse*m_light0Diffuse + In.Diff) * 2.0;
	float3 spec = Specular * pow(ndoth,16) * norm_texel.a;

	return float4(diff + spec,base_texel.a);
}

//////////////////////////////////////
// Techniques follow
//////////////////////////////////////
technique t0
{
    pass t0_p0
    {
		// blend mode
		ZWriteEnable = true;
		ZFunc = LESSEQUAL;
		AlphaBlendEnable = FALSE;
		DestBlend = ZERO;
		SrcBlend = ONE;
		AlphaTestEnable = FALSE;
		AlphaRef = 0x00000080;
		AlphaFunc = Greater;
		
        // shaders
        VertexShader = compile vs_1_1 vs_main();
        PixelShader  = compile ps_2_0 ps_main();
    }  
}

