//--------------------------------------------------------------//
// TerrainBrush.fx
//--------------------------------------------------------------//

#include "../AlamoEngine.fxh"

texture brushTexture : DiffuseMap
<
	string Name = "i_circle00.tga";
>;

float4 brushColor = { 0.0, 0.3, 0.0, 0.0 };
float4 texU = { 0.01, 0.0,  0.0, 0.0 };
float4 texV = { 0.0,  0.01, 0.0, 0.0 };


//------------------------------------
struct vertexInput {
    float3 Pos			: POSITION;
    float3 Normal		: NORMAL;
};

struct vertexOutput {
    float4 Pos			: POSITION;
    float2 Tex0			: TEXCOORD0;
    float  Fog			: FOG;
};


//------------------------------------
vertexOutput VS_TransformAndTexture(vertexInput IN) 
{
	vertexOutput OUT;
	OUT.Pos = mul( float4(IN.Pos , 1.0) , m_worldViewProj);

	// texture coordinate generation
	OUT.Tex0.x = dot(texU,float4(IN.Pos,1.0));
	OUT.Tex0.y = dot(texV,float4(IN.Pos,1.0));
	
	// Output fog
	float fog = length(OUT.Pos.xyz);
	OUT.Fog = clamp(m_fogSlope * fog + m_fogOffset,0,1);

	return OUT;
}


//------------------------------------
sampler TextureSampler = sampler_state 
{
    texture = <brushTexture>;
    AddressU  = CLAMP;        
    AddressV  = CLAMP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
};


//-----------------------------------
float4 PS_Textured( vertexOutput IN): COLOR
{
	return brushColor * tex2D(TextureSampler,IN.Tex0);
}


//-----------------------------------
technique textured
< 
	string LOD="DX8";
>
{
    pass p0 
    {		
		ZWriteEnable=false;
		ZFunc=lessequal;
		AlphaBlendEnable=true;
		SrcBlend=one;
		DestBlend=one;
		
		//VertexShader=NULL;
		//PixelShader=NULL;
		//fvf = XYZ | NORMAL | DIFFUSE | TEX1;

		VertexShader = compile vs_1_1 VS_TransformAndTexture();
		PixelShader  = compile ps_1_1 PS_Textured();
    }
}