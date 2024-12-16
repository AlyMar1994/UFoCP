//--------------------------------------------------------------//
// TerrainRenderBaked.fx
//--------------------------------------------------------------//

#include "../AlamoEngine.fxh"

string RenderPhase = "Terrain";


//////////////////////////////////
// Texture Coordinate Generation
//////////////////////////////////
float4 diffuseTexU = { 0.01, 0.0,  0.0, 0.0 };
float4 diffuseTexV = { 0.0,  0.01, 0.0, 0.0 };

//////////////////////////
// Material Properties
//////////////////////////
texture diffuseTexture;

//------------------------------------
sampler TextureSampler = sampler_state 
{
    texture = (diffuseTexture);
};

//------------------------------------
struct VS_INPUT 
{
    float3 Pos					: POSITION;
    float3 Normal				: NORMAL;
    float3 diffuse				: COLOR0;
};


struct VS_OUTPUT
{
    float4 Pos					: POSITION;
    float2 texCoordDiffuse		: TEXCOORD0;
    float2 texCoordCloud		: TEXCOORD1;
    float4 Diff					: COLOR0;
    float  Fog					: FOG;
};



//------------------------------------
VS_OUTPUT vs_main_nobump(VS_INPUT In) 
{
	VS_OUTPUT Out = (VS_OUTPUT)0;
	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);

	// texture coordinate generation
	Out.texCoordDiffuse.x = dot(diffuseTexU,float4(In.Pos.xyz,1.0));
	Out.texCoordDiffuse.y = dot(diffuseTexV,float4(In.Pos.xyz,1.0));
	
	// Lighting in view space:
    float3 world_pos = mul(In.Pos, m_world);
    float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
    float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(diff_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	return Out;
}

//-----------------------------------
float4 ps_main_nobump(VS_OUTPUT In): COLOR
{
//return float4(1,0,0,1);

	float4 diffuseTexel = tex2D( TextureSampler, In.texCoordDiffuse );

	float3 diff = In.Diff.rgb * diffuseTexel.rgb * 2.0;

	return float4(diff,1);
}


vertexshader vs_main_nobump_bin = compile vs_1_1 vs_main_nobump();
pixelshader ps_main_nobump_bin = compile ps_1_1 ps_main_nobump();


//-----------------------------------


technique t0
< 
	string LOD="DX8";
>
{
    pass t0_p0 
    {		
        SB_START

    		ZEnable=true;
        	ZWriteEnable=true;
    		ZFunc=lessequal;
            AddressU[0] = CLAMP;
            AddressV[0] = CLAMP;
        SB_END        

        VertexShader = (vs_main_nobump_bin);
        PixelShader  = (ps_main_nobump_bin);

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

    		// General Render States
    		ZEnable=true;
    		ZWriteEnable=true;
    		ZFunc=lessequal;
    		
            AddressU[0] = CLAMP;
            AddressV[0] = CLAMP;

    		TexCoordIndex[0] = CAMERASPACEPOSITION;
    		TextureTransformFlags[0] = COUNT2;
    		
    		ColorOp[0]=MODULATE2X;
    		ColorArg1[0]=DIFFUSE;
    		ColorArg2[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    		
    		ColorOp[1]=Disable;
    		AlphaOp[1]=Disable;

        SB_END        

        VertexShader = NULL;
        PixelShader = NULL;

		Texture[0] = (diffuseTexture);
		TextureTransform[0] = 
		(
			mul(
				m_viewInv,
				float4x4(   float4(diffuseTexU.x,diffuseTexV.x,0,0),
                            float4(diffuseTexU.y,diffuseTexV.y,0,0),
                            float4(diffuseTexU.z,diffuseTexV.z,1,0),
                            float4(diffuseTexU.w,diffuseTexV.w,0,1))
				)
		);
        
		// Material colors
		MaterialAmbient = (float4(1,1,1,1)); //materialDiffuse);
		MaterialDiffuse = (float4(1,1,1,1)); //materialDiffuse);
		MaterialEmissive = (float4(0,0,0,0));
		MaterialSpecular = (float4(0,0,0,0)); //materialSpecular);
		MaterialPower = (16.0f);

	}
	
	// cleanup pass
	pass t3_cleanup < bool AlamoCleanup = true; >
	{
        SB_START

    		TexCoordIndex[0] = 0;
    		TexCoordIndex[1] = 1;
    		TextureTransformFlags[0] = DISABLE;
    		TextureTransformFlags[1] = DISABLE;

        SB_END        
	}
}
