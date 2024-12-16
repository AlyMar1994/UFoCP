//--------------------------------------------------------------//
// TerrainRender.fx
//--------------------------------------------------------------//

#include "..\AlamoEngine.fxh"

string RenderPhase = "Terrain";


//////////////////////////
// Material Properties
//////////////////////////
texture diffuseTexture : DiffuseMap
<
	string Name = "gh_gravel00.jpg";
>;

texture blendTexture 
<
	string Name = "gh_gravel00.jpg";
>;

float4 materialDiffuse : MaterialDiffuse
<
    string UIType = "Surface Color";
> = {1.0f, 1.0f, 1.0f, 1.0f};

float4 materialSpecular : MaterialSpecular
<
	string UIType = "Surface Specular";
> = {0.7f, 0.7f, 0.7f, 1.0f};

float shininess : Power
<
    string UIType = "slider";
    float UIMin = 1.0;
    float UIMax = 128.0;
    float UIStep = 1.0;
    string UIName = "specular power";
> = 32.0;


//////////////////////////////////
// Texture Coordinate Generation
//////////////////////////////////
float4 diffuseTexU = { 0.01, 0.0,  0.0, 0.0 };
float4 diffuseTexV = { 0.0,  0.01, 0.0, 0.0 };

float2 blendTexScale = { 0.01, 0.01 };
float2 blendTexOffset = { 0.0, 0.0 };


//------------------------------------
struct VS_INPUT 
{
    float3 position				: POSITION;
    float3 normal				: NORMAL;
    float3 diffuse				: COLOR0;
};

struct VS_OUTPUT 
{
    float4 Pos					: POSITION;
    float2 texCoordDiffuse		: TEXCOORD0;
    float2 texCoordBlend		: TEXCOORD1;
    float4 diffAmbColor			: COLOR0;
    float4 specCol				: COLOR1;
    float  Fog		: FOG;
};


//------------------------------------
VS_OUTPUT VS_TransformAndTexture(VS_INPUT In) 
{
	VS_OUTPUT Out = (VS_OUTPUT)0;
	Out.Pos = mul( float4(In.position.xyz , 1.0) , m_worldViewProj);

	// texture coordinate generation
	Out.texCoordDiffuse.x = dot(diffuseTexU,float4(In.position.xyz,1.0));
	Out.texCoordDiffuse.y = dot(diffuseTexV,float4(In.position.xyz,1.0));
	Out.texCoordBlend = blendTexScale*In.position.xy + blendTexOffset;
	
	//Light0: compute diffuse and specular lighting
	//calculate our vectors N, E, L, and H
	float3 worldEyePos = m_viewInv[3].xyz;
	float3 worldVertPos = mul(In.position, m_world).xyz;
	float4 N = mul(In.normal, m_world); //normal vector
	float3 E = normalize(worldEyePos - worldVertPos); //eye vector
	float3 L = m_light0Vector; //light vector
	float3 H = normalize(E + L); //half angle vector

	float  diff = max(0 , dot(N,L) * In.diffuse.x);
	float  spec = pow( max(0 , dot(N,H) * In.diffuse.x ) , shininess );
	if( diff <= 0 )
	{
		spec = 0;
	}
	
	float3 ambColor = materialDiffuse * m_lightAmbient;
	float3 diffColor = materialDiffuse * diff * m_light0Diffuse;
	float3 specColor = materialSpecular * spec * m_light0Specular;

	// Light1: add in diffuse contribution 
	diff = max(0,dot(N,m_light1Vector));
	diffColor = diffColor + materialDiffuse * diff * m_light1Diffuse;

	// Light2: add in diffuse contribution	
	diff = max(0,dot(N,m_light2Vector));
	diffColor = diffColor + materialDiffuse * diff * m_light2Diffuse;
	
	//output diffuse
	Out.diffAmbColor = float4(diffColor + ambColor,1);

	//output specular
	Out.specCol = float4(specColor,1);
	
	// Output fog
	float fog = length(Out.Pos.xyz);
	Out.Fog = clamp(m_fogSlope * fog + m_fogOffset,0,1);

	return Out;
}


//------------------------------------
sampler TextureSampler = sampler_state 
{
    texture = <diffuseTexture>;
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
};

sampler BlendSampler = sampler_state 
{
    texture = <blendTexture>;
    AddressU  = CLAMP;        
    AddressV  = CLAMP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
};


//-----------------------------------
float4 PS_Textured(VS_OUTPUT In): COLOR
{
	float4 diffuseTexel = tex2D( TextureSampler, In.texCoordDiffuse );
	float4 blendTexel = tex2D( BlendSampler, In.texCoordBlend );
	float3 diff = In.diffAmbColor.rgb * diffuseTexel.rgb * 2.0;
	float3 spec = In.specCol.rgb * diffuseTexel.a * 2.0;	

	return float4(diff + spec, blendTexel.a);
}


//-----------------------------------
technique textured
< 
	string LOD="DX8";
>
{
    pass p0 
    {		
		ZEnable=true;
    	ZWriteEnable=true;
		ZFunc=lessequal;

		VertexShader = compile vs_1_1 VS_TransformAndTexture();
		PixelShader  = compile ps_1_1 PS_Textured();
    }
}