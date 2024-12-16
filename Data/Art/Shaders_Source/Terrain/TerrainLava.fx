//--------------------------------------------------------------//
// TerrainLava.fx
//--------------------------------------------------------------//

#include "../AlamoEngine.fxh"

string _ALAMO_RENDER_PHASE = "TerrainWater";

/////////////////////////////////////////
// Texture Coordinate Generation                                                                                       
/////////////////////////////////////////
float4 BaseTexU = { 0.01, 0.0,  0.0, 0.0 };
float4 BaseTexV = { 0.0,  0.01, 0.0, 0.0 };
float4 CrustTexU = { 0.01, 0.0,  0.0, 0.0 };
float4 CrustTexV = { 0.0,  0.01, 0.0, 0.0 };

// texture transforms for the fixed function pipeline
float4x4 BaseFFTM;
float4x4 CrustFFTM;

//////////////////////////
// Material Properties
//////////////////////////
texture BaseTexture;
texture CrustTexture;
texture CrustBumpTexture;

float4 LavaBrightness = { 1.0f, 1.0f, 1.0f, 1.0f };
float4 CrustSpecular = { 1.0f, 1.0f, 1.0f, 1.0f };

sampler BaseSampler = sampler_state { texture = (BaseTexture); };
sampler CrustSampler = sampler_state { texture = (CrustTexture); };
sampler CrustBumpSampler = sampler_state { texture = (CrustBumpTexture); };
sampler FOWSampler = sampler_state { texture = (m_FOWTexture); };   // from AlamoEngine.fxh


//------------------------------------
struct VS_INPUT 
{
    float3 Pos					: POSITION;
};

struct VS_OUTPUT_BUMP 
{
    float4 Pos					: POSITION;
    float2 TexBase				: TEXCOORD0;
    float2 TexCrust				: TEXCOORD1;
    float2 TexCrustBump			: TEXCOORD2;
    float2 TexFOW               : TEXCOORD3;
    float3 LightVector 			: TEXCOORD4; //in tangent space
    float3 HalfAngleVector 		: TEXCOORD5; //in tangent space
    float4 Diff					: COLOR0;
    float4 Spec					: COLOR1;
    float  Fog					: FOG;
};

struct VS_OUTPUT_GLOSS
{
    float4 Pos					: POSITION;
    float2 TexBase				: TEXCOORD0;
    float2 TexCrust				: TEXCOORD1;
    float2 TexCrustBump         : TEXCOORD2;
    float2 TexFOW               : TEXCOORD3;
    float4 Diff					: COLOR0;
    float4 Spec					: COLOR1;
    float  Fog					: FOG;
};

//------------------------------------------------------------
// Vertex Shaders
//------------------------------------------------------------
VS_OUTPUT_BUMP vs_main_bump(VS_INPUT In) 
{
	VS_OUTPUT_BUMP Out = (VS_OUTPUT_BUMP)0;

	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);
	float4 world_pos = mul( float4(In.Pos,1.0f), m_world );

	// Bump texture coordinates
	Out.TexBase.x = dot(BaseTexU,world_pos); 
	Out.TexBase.y = dot(BaseTexV,world_pos); 
	Out.TexCrust.x = dot(CrustTexU,world_pos);
	Out.TexCrust.y = dot(CrustTexV,world_pos);
	Out.TexCrustBump = Out.TexCrust;

	// FOW texture coordinates
    Out.TexFOW.x = dot(m_FOWTexU,world_pos);
    Out.TexFOW.y = dot(m_FOWTexV,world_pos);
		
	// tangent space generation
	float3 P = world_pos.xyz;
	float3 N = float3(0,0,1);
	float3 T = float3(CrustTexU.x,CrustTexU.y,0.0f);
	float3 B = float3(CrustTexV.x,CrustTexV.y,0.0f);
	T = normalize(T);
	B = normalize(B);
	
	// Compute the tangent-space light vector and half-angle vector for per-pixel lighting
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(T,B,N);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0Vector,to_tangent_matrix);
	Out.HalfAngleVector = Compute_Tangent_Space_Half_Vector(P,m_eyePos,m_light0Vector,to_tangent_matrix);
	
	// diffuse fill lighting
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(float3(0,0,1));
	Out.Diff = float4(diff_light, 1);
	Out.Spec = 0;
	
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}


VS_OUTPUT_GLOSS vs_main_gloss(VS_INPUT In) 
{
	VS_OUTPUT_GLOSS Out = (VS_OUTPUT_GLOSS)0;

	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);
	float4 world_pos = mul( float4(In.Pos,1.0f), m_world );

	// Bump texture coordinates
	Out.TexBase.x = dot(BaseTexU,world_pos); 
	Out.TexBase.y = dot(BaseTexV,world_pos); 
	Out.TexCrust.x = dot(CrustTexU,world_pos);
	Out.TexCrust.y = dot(CrustTexV,world_pos);
	Out.TexCrustBump = Out.TexCrust;

	// FOW texture coordinates
    Out.TexFOW.x = dot(m_FOWTexU,world_pos);
    Out.TexFOW.y = dot(m_FOWTexV,world_pos);
		
    // diffuse lighting
	float3 diff_light = Sph_Compute_Diffuse_Light_All(float3(0,0,1));
	float3 spec_light = Compute_Specular_Light(world_pos,float3(0,0,1));

    Out.Diff = float4(diff_light, 1);
	Out.Spec = float4(CrustSpecular * spec_light, 1);
	
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}


//------------------------------------------------------------
// Pixel shaders
//------------------------------------------------------------

float4 ps_main_bump(VS_OUTPUT_BUMP In): COLOR
{
	float4 base_texel = tex2D( BaseSampler, In.TexBase );
	float4 crust_texel = tex2D( CrustSampler, In.TexCrust );
	float4 crust_bump_texel = tex2D( CrustBumpSampler, In.TexCrustBump );
    float4 fow_texel = tex2D( FOWSampler, In.TexFOW );

	// Compute the normal vector, light vector and half vector
	float3 normal_vec = 2.0f * (crust_bump_texel - 0.5f);
	float3 light_vec = 2.0f * (In.LightVector - 0.5f);
	float3 half_vec = 2.0f * (In.HalfAngleVector - 0.5f);
		
	float ndotl = saturate(dot(normal_vec,light_vec));
	float ndoth = saturate(dot(normal_vec,half_vec));

	float3 diff = crust_texel.rgb * (ndotl*m_light0Diffuse + In.Diff.rgb) * 2.0;
	float3 spec = CrustSpecular*m_light0Specular*ndoth*pow(ndoth,4);

	float3 lava_pixel = base_texel.rgb;
	float3 crust_pixel = diff+spec;

	float3 pixel = lerp(lava_pixel, crust_pixel, crust_texel.a);
    
    // fog of war
    pixel *= fow_texel.rgb;
    return float4(pixel,1);
}

float4 ps_main_gloss(VS_OUTPUT_GLOSS In): COLOR
{
	float4 base_texel = tex2D( BaseSampler, In.TexBase );
	float4 crust_texel = tex2D( CrustSampler, In.TexCrust );
	float4 crust_bump_texel = tex2D( CrustBumpSampler, In.TexCrustBump );
    float4 fow_texel = tex2D( FOWSampler, In.TexFOW );

	float3 diff = crust_texel.rgb * In.Diff.rgb * 2.0;
	float3 spec = In.Spec * crust_bump_texel.b;     // use crust bump Z value as spec mask

	float3 lava_pixel = base_texel.rgb;
	float3 crust_pixel = diff+spec;

	float3 pixel = lerp(lava_pixel, crust_pixel, crust_texel.a);
    
    // fog of war
    pixel *= fow_texel.rgb;
    return float4(pixel,1);
}


//-----------------------------------

technique t0
<
	string LOD="DX9";
	int WaterLOD = 2;
>
{
    pass t0_p0 
    {		
        SB_START

    		ZEnable=true;
        	ZWriteEnable=true; 
    		ZFunc=lessequal;
    
    		AlphaBlendEnable=FALSE;
    		SrcBlend=srcalpha;
    		DestBlend=invsrcalpha;
    		AlphaTestEnable=FALSE;
    		
        SB_END        

        VertexShader = compile vs_1_1 vs_main_bump();
        PixelShader  = compile ps_2_0 ps_main_bump();

    }
}

technique t1
<
    string LOD="DX8";
    int WaterLOD = 1;
>
{
    pass t1_p0 
    {		
        SB_START

    		ZEnable=true;
        	ZWriteEnable=true; 
    		ZFunc=lessequal;
    
    		AlphaBlendEnable=FALSE;
    		SrcBlend=srcalpha;
    		DestBlend=invsrcalpha;
    		AlphaTestEnable=FALSE;

        SB_END        
    		
        VertexShader = compile vs_1_1 vs_main_gloss();
        PixelShader  = compile ps_1_1 ps_main_gloss();
    }
}

    
technique t2
<
	string LOD="FIXEDFUNCTION";
	int WaterLOD = 0;
>
{
	pass t2_p0
	{
        SB_START

    		ZEnable=true;
        	ZWriteEnable=true; 
    		ZFunc=lessequal;
    		
    		AlphaBlendEnable = FALSE;
    		AlphaTestEnable = FALSE;

    		// FF Vertex pipeline
    		Lighting=false;

    		// Min spec lava has no crust, just lava * FOW
    		TexCoordIndex[0] = CAMERASPACEPOSITION;
    		TextureTransformFlags[0] = COUNT3;
    
    		TexCoordIndex[1] = CAMERASPACEPOSITION;
    		TextureTransformFlags[1] = COUNT3;
    		
    		ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    		
    		ColorOp[1]=MODULATE;
    		ColorArg1[1]=CURRENT;
    		ColorArg2[1]=TEXTURE;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=CURRENT;
    		
    		ColorOp[2]=DISABLE;
    		AlphaOp[2]=DISABLE;

        SB_END        

        VertexShader = NULL;
        PixelShader = NULL;
        
        Texture[0] = (BaseTexture);
        Texture[1] = (m_FOWTexture);
		TextureTransform[0] = (transpose(BaseFFTM));    // TODO: optimize out this transpose
       	TextureTransform[1] = 
		(
			mul(
				m_viewInv,
				float4x4(   float4(m_FOWTexU.x,m_FOWTexV.x,0,0),
                            float4(m_FOWTexU.y,m_FOWTexV.y,0,0),
                            float4(m_FOWTexU.z,m_FOWTexV.z,1,0),
                            float4(m_FOWTexU.w,m_FOWTexV.w,0,1))
				)
		);
	}
    
    pass t2_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            TexCoordIndex[0] = 0;
            TextureTransformFlags[0]=disable;
            TexCoordIndex[1] = 1;
            TextureTransformFlags[1]=disable;

            Lighting=true;

        SB_END        
    }

}
