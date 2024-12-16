//--------------------------------------------------------------//
// TerrainIce.fx
//--------------------------------------------------------------//

#include "../AlamoEngine.fxh"

string _ALAMO_RENDER_PHASE = "TerrainWater";

/////////////////////////////////////////
// Texture Coordinate Generation                                                                                       
/////////////////////////////////////////
float4 BaseTexU = { 0.01, 0.0,  0.0, 0.0 };
float4 BaseTexV = { 0.0,  0.01, 0.0, 0.0 };
float4 BumpTexU = { 0.01, 0.0,  0.0, 0.0 };
float4 BumpTexV = { 0.0,  0.01, 0.0, 0.0 };

// transforms for the fixed function pipeline to work
float4x4 BaseFFTM;

//////////////////////////
// Material Properties
//////////////////////////

float4 IceDiffuse = { 1.0f, 1.0f, 1.0f, 1.0f }; //,0.5f, 0.5f, 0.5f, 1.0f };
float IceReflectionDistortion = 0.5f;

texture IceTexture;
texture ReflectionTexture : REFLECTION;
texture BumpTexture;


//------------------------------------
struct VS_INPUT 
{
    float3 Pos					: POSITION;
};

struct VS_OUTPUT_BUMP_REFLECT
{
    float4 Pos					: POSITION;
    float2 TexIce 				: TEXCOORD0;
    float2 TexReflection		: TEXCOORD1;
    float2 TexFOW               : TEXCOORD2;
    float2 TexBump              : TEXCOORD3;
    float3 LightVector 			: TEXCOORD4; //in tangent space
    float4 Diff					: COLOR0;
    float4 Spec					: COLOR1;
    float  Fog					: FOG;
};

struct VS_OUTPUT_REFLECT
{
    float4 Pos					: POSITION;
    float2 TexIce 				: TEXCOORD0;
    float2 TexReflection		: TEXCOORD1;
    float2 TexFOW               : TEXCOORD2;
    float4 Diff					: COLOR0;
    float4 Spec					: COLOR1;
    float  Fog					: FOG;
};


//------------------------------------------------------------
// Vertex Shaders
//------------------------------------------------------------

VS_OUTPUT_BUMP_REFLECT vs_main_ice_bump_reflect(VS_INPUT In) 
{
	VS_OUTPUT_BUMP_REFLECT Out = (VS_OUTPUT_BUMP_REFLECT)0;
	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);

	float4 world_pos = mul( float4(In.Pos,1.0f), m_world );
	
	// Texture coordinates
	Out.TexIce.x = dot(BaseTexU,world_pos);
	Out.TexIce.y = dot(BaseTexV,world_pos);
		
	// Bump texture coordinates
    Out.TexBump.x = dot(BumpTexU,world_pos);
	Out.TexBump.y = dot(BumpTexV,world_pos);
	
    // Reflection texture coordinate generation (screen space)
	Out.TexReflection.x = 0.5f * (Out.Pos.x/Out.Pos.w + 1.0f);
	Out.TexReflection.y = 1.0f - (0.5f * (Out.Pos.y/Out.Pos.w + 1.0f));

	// FOW texture coordinates
    Out.TexFOW.x = dot(m_FOWTexU,world_pos);
    Out.TexFOW.y = dot(m_FOWTexV,world_pos);
    
	// tangent space generation
	float3 N = float3(0,0,1);
	float3 T = float3(BaseTexU.x,BaseTexU.y,0.0f);
	float3 B = float3(BaseTexV.x,BaseTexV.y,0.0f);
	T = normalize(T);
	B = normalize(B);
	
	// Compute the tangent-space light vector and half-angle vector for per-pixel lighting
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(T,B,N);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0Vector,to_tangent_matrix);
    
    // Lighting
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(float3(0,0,1));
	float3 spec_light = Compute_Specular_Light(world_pos,float3(0,0,1));

    Out.Diff = 0; //float4(diff_light, 1);
	//Out.Spec = float4(IceSpecular * spec_light, 1);
    
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}


VS_OUTPUT_REFLECT vs_main_ice_reflect(VS_INPUT In) 
{
	VS_OUTPUT_REFLECT Out = (VS_OUTPUT_REFLECT)0;
	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);

	float4 world_pos = mul( float4(In.Pos,1.0f), m_world );
	
	// Texture coordinates
	Out.TexIce.x = dot(BaseTexU,world_pos);
	Out.TexIce.y = dot(BaseTexV,world_pos);
		
	// Reflection texture coordinate generation (screen space)
	Out.TexReflection.x = 0.5f * (Out.Pos.x/Out.Pos.w + 1.0f);
	Out.TexReflection.y = 1.0f - (0.5f * (Out.Pos.y/Out.Pos.w + 1.0f));

	// FOW texture coordinates
    Out.TexFOW.x = dot(m_FOWTexU,world_pos);
    Out.TexFOW.y = dot(m_FOWTexV,world_pos);
    
    // Lighting
	float3 diff_light = Sph_Compute_Diffuse_Light_All(float3(0,0,1));
	float3 spec_light = Compute_Specular_Light(world_pos,float3(0,0,1));

    Out.Diff = float4(IceDiffuse * diff_light, 1);
	//Out.Spec = float4(IceSpecular * spec_light, 1);
    
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}

//------------------------------------------------------------
// Samplers and pixel shaders
//------------------------------------------------------------
sampler IceSampler = sampler_state { texture = (IceTexture); };
sampler ReflectionSampler = sampler_state { texture = (ReflectionTexture); }; // AddressU=clamp; AddressV=clamp; };
sampler FOWSampler = sampler_state { texture = (m_FOWTexture); };   // from AlamoEngine.fxh
sampler BumpSampler = sampler_state { texture = (BumpTexture); };


float4 ps_main_ice_bump_reflect(VS_OUTPUT_BUMP_REFLECT In): COLOR
{
    float4 ice_texel = tex2D( IceSampler, In.TexIce );
    float4 fow_texel = tex2D( FOWSampler, In.TexFOW );
	float4 bump_texel = tex2D( BumpSampler, In.TexBump );
 
	// per-pixel diffuse lighting
	float3 normal_vec = 2.0f * (bump_texel - 0.5f);
	float3 light_vec = 2.0f * (In.LightVector - 0.5f);
    float ndotl = saturate(dot(normal_vec,light_vec));
	float3 diff = ice_texel.rgb * (ndotl*m_light0Diffuse*IceDiffuse + In.Diff.rgb) * 2.0;
    
  	float4 reflection_texel = tex2D( ReflectionSampler,In.TexReflection + IceReflectionDistortion * normal_vec.xy);

    // per-pixel specular
    //float3 half_vec = 2.0f * (In.HalfAngleVector - 0.5f);
	//float ndoth = saturate(dot(normal_vec,half_vec));
	//float3 spec = CrustSpecular*m_light0Specular*ndoth*pow(ndoth,4);

    // combine ice texture and the reflection
    float3 pixel = lerp(diff, reflection_texel.rgb, ice_texel.a);
        
    // fog of war
    pixel *= fow_texel.rgb;
    return float4(pixel,1);
}


float4 ps_main_ice_reflect(VS_OUTPUT_REFLECT In): COLOR
{
    float4 ice_texel = tex2D( IceSampler, In.TexIce );
	float4 reflection_texel = tex2D( ReflectionSampler,In.TexReflection);
    float4 fow_texel = tex2D( FOWSampler, In.TexFOW );

    float3 pixel = ice_texel.rgb * In.Diff.rgb * 2.0f;
    pixel = lerp(pixel,reflection_texel,ice_texel.a) * fow_texel.rgb;
    
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
    
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;

        SB_END        

        VertexShader = compile vs_1_1 vs_main_ice_bump_reflect();
        PixelShader  = compile ps_2_0 ps_main_ice_bump_reflect();

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
    
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    
        SB_END        

        VertexShader = compile vs_1_1 vs_main_ice_reflect();
        PixelShader  = compile ps_1_1 ps_main_ice_reflect();

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
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    		AlphaTestEnable = FALSE;
    		
       		Lighting=true;
    		MaterialEmissive = (float4(0,0,0,0));
    		MaterialSpecular = (float4(0,0,0,0));
    		MaterialPower = (1.0f);
    
    		TexCoordIndex[0] = CAMERASPACEPOSITION;
    		TextureTransformFlags[0] = COUNT3;
    
            TexCoordIndex[1] = CAMERASPACEPOSITION;
            TextureTransformFlags[1] = COUNT3;
    		
    		ColorOp[0]=MODULATE2X;   // base texture, modulated by diffuse lighting
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=DIFFUSE;
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    
    		ColorOp[1]=MODULATE;    // FOW texture modulates the result
    		ColorArg1[1]=CURRENT;
    		ColorArg2[1]=TEXTURE;
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=CURRENT;
    	
            ColorOp[2]=DISABLE;
            AlphaOp[2]=DISABLE;

        SB_END        
        
        VertexShader = NULL;
        PixelShader = NULL;
            
		Texture[0] = (IceTexture);
        Texture[1] = (m_FOWTexture);    // from AlamoEngine.fxh
        MaterialAmbient = (IceDiffuse);
		MaterialDiffuse = (IceDiffuse);
		TextureTransform[0] = (transpose(BaseFFTM));    // TODO: optimize out this transpose
		TextureTransform[1] = 
		(
			mul(
				m_viewInv,
				float4x4(
					float4(m_FOWTexU.x,m_FOWTexV.x,0,0),
					float4(m_FOWTexU.y,m_FOWTexV.y,0,0),
					float4(0,0,1,0),
					float4(0,0,0,1))
				)
		);
	}
    
    pass t2_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            TexCoordIndex[0] = 1;
            TextureTransformFlags[0]=disable;
            TexCoordIndex[1] = 1;
            TextureTransformFlags[1]=disable;

        SB_END        
    }
}

