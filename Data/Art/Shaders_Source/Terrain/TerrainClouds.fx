//--------------------------------------------------------------//
// TerrainClouds.fx
//--------------------------------------------------------------//

#include "../AlamoEngine.fxh"

//------------------------------------
texture cloudTexture : DiffuseMap
<
	string Name = "W_Clouds00.tga";
>;

float4 texU = { 100.01, 0.0,  0.0, 0.0 };
float4 texV = { 0.0,  100.01, 0.0, 0.0 };


//------------------------------------
struct vertexInput {
    float3 position				: POSITION;
    float3 normal				: NORMAL;
    float2 texcoord				: TEXCOORD0;
};

struct vertexOutput {
    float4 Pos			: POSITION;
    float2 Tex0			: TEXCOORD0;
    float Fog			: FOG;
};

//------------------------------------
vertexOutput VS_TransformAndTexture(vertexInput IN) 
{
	vertexOutput OUT;
	OUT.Pos = mul( float4(IN.position.xyz , 1.0) , m_worldViewProj);

	// texture coordinate generation
	OUT.Tex0.x = dot(texU,float4(IN.position.xyz,1.0));
	OUT.Tex0.y = dot(texV,float4(IN.position.xyz,1.0));
	
	// Output fog
	OUT.Fog = Compute_Fog(OUT.Pos.xyz);

	return OUT;
}

//------------------------------------
sampler TextureSampler = sampler_state 
{
    texture = <cloudTexture>;
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};


//-----------------------------------
float4 PS_Textured( vertexOutput IN): COLOR
{
	return tex2D(TextureSampler,IN.Tex0);
}


//-----------------------------------
technique t0
< 
	string LOD="DX8";
>
{
    pass t0_p0 
    {		
        SB_START

    		ZWriteEnable=FALSE;
    		ZFunc=lessequal;
    		AlphaBlendEnable=TRUE;
    		SrcBlend=DESTCOLOR;
    		DestBlend=ZERO;
    		
        SB_END        

        VertexShader = compile vs_1_1 VS_TransformAndTexture();
        PixelShader  = compile ps_1_1 PS_Textured();
    }
}

technique t1
<
	string LOD="FIXEDFUNCTION";
>
{
	pass t1_p0
	{
        SB_START

    		ZWriteEnable=false;
    		ZFunc=lessequal;	
    		AlphaBlendEnable=true;
    		SrcBlend=DESTCOLOR;
    		DestBlend=zero;
    		
    		// FF Vertex pipeline
    		Lighting=false;
    		
    		// FF Pixel pipeline
    		TexCoordIndex[0] = CAMERASPACEPOSITION;
    		TextureTransformFlags[0] = COUNT2;
    		
    		ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    				
    		ColorOp[1]=Disable;
    		AlphaOp[1]=Disable;

        SB_END        

        VertexShader = NULL;
        PixelShader = NULL;
        
		Texture[0] = (cloudTexture);
		TextureTransform[0] = 
		(
			mul(
				m_viewInv,
				float4x4(
					float4(texU.x,texV.x,0,0),
					float4(texU.y,texV.y,0,0),
					float4(0,0,1,0),
					float4(0,0,0,1))
				)
		);
	}

	
	// cleanup pass
	pass t3_cleanup < bool AlamoCleanup = true; >
	{
        SB_START

    		TexCoordIndex[0] = 0;
    		TextureTransformFlags[0] = DISABLE;

        SB_END        
	}

}	