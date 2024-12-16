//--------------------------------------------------------------//
// TerrainRenderBump.fx
//--------------------------------------------------------------//

#include "../AlamoEngine.fxh"

string RenderPhase = "Terrain";


//////////////////////////////////
// Texture Coordinate Generation
//////////////////////////////////
float4 diffuseTexU = { 0.01, 0.0,  0.0, 0.0 };
float4 diffuseTexV = { 0.0,  0.01, 0.0, 0.0 };

float2 blendTexScale = { 0.01, 0.01 };
float2 blendTexOffset = { 0.0, 0.0 };

//////////////////////////
// Material Properties
//////////////////////////
texture diffuseTexture;
texture blendTexture;
texture normalTexture;

float4 materialDiffuse = {1.0f, 1.0f, 1.0f, 1.0f};
float4 materialSpecular = {0.7f, 0.7f, 0.7f, 1.0f};
float shininess = 32.0;


//------------------------------------
sampler TextureSampler = sampler_state 
{
    texture = (diffuseTexture);
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};

sampler BlendSampler = sampler_state 
{
    texture = (blendTexture);
    AddressU  = CLAMP;        
    AddressV  = CLAMP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};

sampler NormalSampler = sampler_state
{
    Texture   = (normalTexture);
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};

sampler CloudSampler = sampler_state
{
	Texture	= (m_cloudTexture);     // from AlamoEngine.fxh
    AddressU  = WRAP;        
    AddressV  = WRAP;
    AddressW  = CLAMP;
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};


//------------------------------------
struct VS_INPUT 
{
    float3 Pos					: POSITION;
    float3 Normal				: NORMAL;
    float3 diffuse				: COLOR0;
};

struct VS_OUTPUT_BUMP 
{
    float4 Pos					: POSITION;
    float2 texCoordBlend		: TEXCOORD0;
    float2 texCoordDiffuse		: TEXCOORD1;
    float2 texCoordCloud		: TEXCOORD2;
    float3 LightVector 			: TEXCOORD3; //in tangent space
    float3 HalfAngleVector 		: TEXCOORD4; //in tangent space
    float4 Diff					: COLOR0;
    float4 Spec				: COLOR1;
    float  Fog		: FOG;
};

struct VS_OUTPUT_NOBUMP
{
    float4 Pos					: POSITION;
    float2 texCoordBlend		: TEXCOORD0;
    float2 texCoordDiffuse		: TEXCOORD1;
    float2 texCoordCloud		: TEXCOORD2;
    float4 Diff					: COLOR0;
    float4 Spec					: COLOR1;
    float  Fog					: FOG;
};


//------------------------------------


VS_OUTPUT_BUMP vs_main_bump(VS_INPUT In) 
{
	VS_OUTPUT_BUMP Out = (VS_OUTPUT_BUMP)0;
	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);

	// texture coordinate generation
	Out.texCoordDiffuse.x = dot(diffuseTexU,float4(In.Pos.xyz,1.0));
	Out.texCoordDiffuse.y = dot(diffuseTexV,float4(In.Pos.xyz,1.0));
	Out.texCoordBlend = blendTexScale*In.Pos.xy + blendTexOffset;
	Out.texCoordCloud.x = dot(m_cloudTexU,float4(In.Pos.xyz,1.0));
	Out.texCoordCloud.y = dot(m_cloudTexV,float4(In.Pos.xyz,1.0));
	
	// tangent space generation
	float ooNz = (1.0f / In.Normal.z);
	float3 Nxy = float3(In.Normal.x,In.Normal.y,0.0f);
	float3 T = float3(diffuseTexU.x,diffuseTexU.y,0.0f);
	T.z = -dot(Nxy,T) * ooNz;
	T = normalize(T);
	float3 B = float3(diffuseTexV.x,diffuseTexV.y,0.0f);
	B.z = -dot(Nxy,B) * ooNz;
	B = normalize(B);
	float3x3 to_tangent_matrix = Compute_To_Tangent_Matrix(T,B,In.Normal);

	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);
	Out.HalfAngleVector = Compute_Tangent_Space_Half_Vector(In.Pos,m_eyePosObj,m_light0ObjVector,to_tangent_matrix);

	// Fill lighting is applied per-vertex.  This must be computed in
	// world space for spherical harmonics to work.
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * materialDiffuse, 1);
    Out.Spec = float4(0,0,0,1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	return Out;
}


//-----------------------------------
half4 ps_main_bump(VS_OUTPUT_BUMP In): COLOR
{
	half4 diffuseTexel = tex2D( TextureSampler, In.texCoordDiffuse );
	half4 blendTexel = tex2D( BlendSampler, In.texCoordBlend );
	half4 normalTexel = tex2D( NormalSampler, In.texCoordDiffuse );
	half4 cloudTexel = tex2D( CloudSampler, In.texCoordCloud );
	
	// compute lighting
	half3 norm_vec = 2.0f*(normalTexel.rgb - 0.5f);
	half3 light_vec = 2.0f*(In.LightVector - 0.5f);
	half3 half_vec = 2.0f*(In.HalfAngleVector - 0.5f);
	
	//half_vec = normalize(half_vec);
	//light_vec = normalize(light_vec);
	
	// (gth) just taking out the multiply by In.specCol.r (occlusion) makes this
	// shader fit in ps1.4...  TODO: squeeze it back!  
	// (gth) acutally, In.Spec.r is no longer being initialized. 
	half ndotl = saturate(/*In.Spec.r */ dot(norm_vec,light_vec));
	half ndoth = saturate(/*In.Spec.r */ dot(norm_vec,half_vec));

	half3 diff = diffuseTexel.rgb * (ndotl*materialDiffuse*m_light0Diffuse + In.Diff.rgb) * 2.0;
	half3 spec = m_light0Specular*materialSpecular*pow(ndoth,16)*diffuseTexel.a;

//return float4(blendTexel.a,blendTexel.a,blendTexel.a,1);

	return half4((diff + spec)*cloudTexel.rgb, blendTexel.a);
}

//------------------------------------
VS_OUTPUT_NOBUMP vs_main_nobump(VS_INPUT In) 
{
	VS_OUTPUT_NOBUMP Out = (VS_OUTPUT_NOBUMP)0;
	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);

	// texture coordinate generation
	Out.texCoordDiffuse.x = dot(diffuseTexU,float4(In.Pos.xyz,1.0));
	Out.texCoordDiffuse.y = dot(diffuseTexV,float4(In.Pos.xyz,1.0));
	Out.texCoordBlend = blendTexScale*In.Pos.xy + blendTexOffset;
	Out.texCoordCloud.x = dot(m_cloudTexU,float4(In.Pos.xyz,1.0));
	Out.texCoordCloud.y = dot(m_cloudTexV,float4(In.Pos.xyz,1.0));
	
	// Lighting in view space:
    float3 world_pos = mul(In.Pos, m_world);
    float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
    float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);
    float3 spec_light = Compute_Specular_Light(world_pos,world_normal);

    // Output final vertex lighting colors:
    Out.Diff = float4(materialDiffuse * diff_light, 1);
    Out.Spec = float4(materialSpecular * spec_light, 1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	return Out;
}

//-----------------------------------
float4 ps_main_nobump(VS_OUTPUT_NOBUMP In): COLOR
{
	float4 diffuseTexel = tex2D( TextureSampler, In.texCoordDiffuse );
	float4 blendTexel = tex2D( BlendSampler, In.texCoordBlend );
	float4 cloudTexel = tex2D( CloudSampler, In.texCoordCloud );

	float3 diff = In.Diff.rgb * diffuseTexel.rgb * 2.0;
	float3 spec = In.Spec.rgb * diffuseTexel.a;	

	return float4((diff + spec)*cloudTexel.rgb, blendTexel.a);
}


vertexshader vs_main_bump_bin = compile vs_1_1 vs_main_bump();
vertexshader vs_main_nobump_bin = compile vs_1_1 vs_main_nobump();
pixelshader ps_main_bump_bin = compile ps_1_4 ps_main_bump();
pixelshader ps_main_nobump_bin = compile ps_1_1 ps_main_nobump();


//-----------------------------------


technique bump
< 
	string LOD="DX8ATI";
>
{
    pass bump_p0 
    {		
        SB_START

    		ZEnable=true;
        	ZWriteEnable=true;
    		ZFunc=lessequal;

        SB_END        

        VertexShader = (vs_main_bump_bin);
        PixelShader  = (ps_main_bump_bin);

    }
}

technique nobump
< 
	string LOD="DX8";
>
{
    pass nobump_p0 
    {		
        SB_START

    		ZEnable=true;
        	ZWriteEnable=true;
    		ZFunc=lessequal;

        SB_END        

        VertexShader = (vs_main_nobump_bin);
        PixelShader  = (ps_main_nobump_bin);

    }
}

technique t3
<
	string LOD="FIXEDFUNCTION";
>
{
	pass t3_p0
	{
        SB_START

    		// General Render States
    		ZEnable=true;
    		ZWriteEnable=true;
    		ZFunc=lessequal;
    		
    		// Blend Texture
    		MinFilter[0]=LINEAR;
    		MagFilter[0]=LINEAR;
    		MipFilter[0]=LINEAR;

    		TexCoordIndex[0] = CAMERASPACEPOSITION;
    		TextureTransformFlags[0] = COUNT2;
    		
    		ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    				
    		// Diffuse+Gloss Texture
    		MinFilter[0]=LINEAR;
    		MagFilter[0]=LINEAR;
    		MipFilter[0]=LINEAR;
    
    		TexCoordIndex[1] = CAMERASPACEPOSITION;
    		TextureTransformFlags[1] = COUNT2;
    		
    		ColorOp[1]=MODULATE2X;
    		ColorArg1[1]=DIFFUSE;
    		ColorArg2[1]=TEXTURE;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=CURRENT;
    		
    		ColorOp[2]=Disable;
    		AlphaOp[2]=Disable;
    		
    		/* 
            Attempt at gloss-masked specular...
    		ColorOp[2]=MODULATEALPHA_ADDCOLOR;
    		ColorArg1[2]=CURRENT;
    		ColorArg2[2]=SPECULAR;
    		AlphaOp[2]=SELECTARG1;
    		AlphaArg1[2]=CURRENT;
    		*/

        SB_END        

        VertexShader = NULL;
        PixelShader = NULL;

		Texture[0] = (blendTexture);
		TextureTransform[0] = 
		(
			mul(
				m_viewInv,
				float4x4(
					float4(blendTexScale.x,0,0,0),
					float4(0,blendTexScale.y,0,0),
					float4(0,0,1,0),
					float4(blendTexOffset.x,blendTexOffset.y,0,1))
				)
		);

		Texture[1] = (diffuseTexture);
		TextureTransform[1] = 
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
		MaterialAmbient = (materialDiffuse);
		MaterialDiffuse = (materialDiffuse);
		MaterialEmissive = (float4(0,0,0,0));
		MaterialSpecular = (materialSpecular);
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
