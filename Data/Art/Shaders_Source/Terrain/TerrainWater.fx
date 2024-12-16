//--------------------------------------------------------------//
// TerrainWater.fx
//--------------------------------------------------------------//

#include "../AlamoEngine.fxh"

string _ALAMO_RENDER_PHASE = "TerrainWater";


/////////////////////////////////////////
// Texture Coordinate Generation                                                                                       
/////////////////////////////////////////
float4 BaseTexU = { 0.01, 0.0,  0.0, 0.0 };
float4 BaseTexV = { 0.0,  0.01, 0.0, 0.0 };
float4 Bump0TexU = { 0.01, 0.0,  0.0, 0.0 };
float4 Bump0TexV = { 0.0,  0.01, 0.0, 0.0 };
float4 Bump1TexU = { 0.01, 0.0,  0.0, 0.0 };
float4 Bump1TexV = { 0.0,  0.01, 0.0, 0.0 };

float4x4 m_texOffset = 
{ 
    float4(0.5,0,0,0),
    float4(0,-0.5,0,0),
    float4(0,0,0.5,0),
    float4(0.5,0.5,0.5,1.0)
};

// transforms for the fixed function pipeline to work
float4x4 BaseFFTM;
float4x4 Bump0FFTM;
float4x4 Bump1FFTM;
float4x4 ReflectionFFTM;


//////////////////////////
// Material Properties
//////////////////////////
float4 WaterColor = { 1.0f, 1.0f, 1.0f, 1.0f };
float4 WaterReflectC = { 1.0f, 1.0f, 1.0f, 1.0f };
float4 WaterRefractC = { 1.0f, 1.0f, 1.0f, 1.0f };

float2 ReflectionDistortionScale = { 0.00f, 0.00f }; //1f;//5f;
float2 RefractionDistortionScale = { 0.00f, 0.00f }; //0.0f;//2f;//6f;

texture BaseTexture;
texture Bump0Texture;
texture Bump1Texture;
texture ReflectionTexture : REFLECTION;
texture RefractionTexture : REFRACTION;


//------------------------------------
struct VS_INPUT 
{
    float3 Pos					: POSITION;
    float4 Color                : COLOR0;
};

struct VS_OUTPUT_REFLECT_REFRACT
{
    float4 Pos					: POSITION;
    float2 TexBump0				: TEXCOORD0;
    float2 TexBump1				: TEXCOORD1;
    float4 TexReflection		: TEXCOORD2;
    float4 TexRefraction		: TEXCOORD3;
    float2 TexFOW               : TEXCOORD4;
    float3 LightVector 			: TEXCOORD5; //points to the light in tangent space
    float3 ViewVector   		: TEXCOORD6; //points to the viewer in tangent space
    float4 Diff					: COLOR0;
    float4 Spec					: COLOR1;
    float  Fog					: FOG;
};

struct VS_OUTPUT_REFLECT_ONLY
{
    float4 Pos					: POSITION;
    float2 TexBump				: TEXCOORD0;
    float2 TexReflection		: TEXCOORD1;
    float2 TexFOW				: TEXCOORD2;
    float4 Diff					: COLOR0;
    float4 Spec					: COLOR1;
    float  Fog					: FOG;
};



//------------------------------------------------------------
// Reflection+Refraction Vertex Shader
//------------------------------------------------------------

VS_OUTPUT_REFLECT_REFRACT vs_main_reflect_refract(VS_INPUT In) 
{
	VS_OUTPUT_REFLECT_REFRACT Out = (VS_OUTPUT_REFLECT_REFRACT)0;
	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);

	float4 world_pos = mul( float4(In.Pos,1.0f), m_world );
	
	// Reflection texture coordinate generation (screen space)
	Out.TexReflection = mul( Out.Pos, m_texOffset );
	Out.TexRefraction = Out.TexReflection;

#if 0 // perspective divide in vertex shader
	Out.TexReflection.x = 0.5f * (Out.Pos.x/Out.Pos.w + 1.0f);
	Out.TexReflection.y = 1.0f - (0.5f * (Out.Pos.y/Out.Pos.w + 1.0f));
	Out.TexRefraction = Out.TexReflection;
#endif

	// Bump texture coordinates
	Out.TexBump0.x = dot(Bump0TexU,world_pos); //float4(In.Pos,1));
	Out.TexBump0.y = dot(Bump0TexV,world_pos); //float4(In.Pos,1));
	Out.TexBump1.y = dot(Bump1TexU,world_pos);
	Out.TexBump1.x = dot(Bump1TexV,world_pos);
		
	// FOW texture coordinates
    Out.TexFOW.x = dot(m_FOWTexU,world_pos);
    Out.TexFOW.y = dot(m_FOWTexV,world_pos);
    
    // tangent space generation
	float3 P = world_pos.xyz;
	float3 N = float3(0,0,1);
	float3 T = float3(BaseTexU.x,BaseTexU.y,0.0f);
	float3 B = float3(BaseTexV.x,BaseTexV.y,0.0f);
	T = normalize(T);
	B = normalize(B);
	
	// Compute the tangent-space light vector and half-angle vector for per-pixel lighting
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(T,B,N);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0Vector,to_tangent_matrix);

    // compute the tangent-space view vector
    Out.ViewVector = normalize(mul(m_eyePos-world_pos.xyz,to_tangent_matrix));

    Out.Diff = In.Color;
    
	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}

//------------------------------------------------------------
// Samplers and pixel shader for Reflection+Refraction
//------------------------------------------------------------
sampler Bump0Sampler = sampler_state { texture = (Bump0Texture); };
sampler Bump1Sampler = sampler_state { texture = (Bump1Texture); };
sampler ReflectionSampler = sampler_state { texture = (ReflectionTexture); AddressU=clamp; AddressV=clamp; };
sampler BaseSampler = sampler_state { texture = (BaseTexture); };
sampler RefractionSampler = sampler_state { texture = (RefractionTexture); AddressU=clamp; AddressV=clamp; };
sampler FOWSampler = sampler_state { texture = (m_FOWTexture); }; // from AlamoEngine.fxh
samplerCUBE SkyCubeSampler = sampler_state { texture = (m_skyCubeTexture); };


float4 ps_main_reflect_refract(VS_OUTPUT_REFLECT_REFRACT In): COLOR
{
	float4 bump0_texel = tex2D( Bump0Sampler, In.TexBump0 );
	float4 bump1_texel = tex2D( Bump1Sampler, In.TexBump1 );

	// Compute the normal vector, light vector and half vector
	float3 normal_vec = 2.0f * (bump0_texel - 0.5f) + 2.0f * (bump1_texel - 0.5f);

	float3 light_vec = 2.0f * (In.LightVector - 0.5f);
	
	// Sample the rendered texture(s)
	float4 reflection_uv = In.TexReflection;
    reflection_uv.xy += 200*ReflectionDistortionScale * normal_vec.xy;
	float4 reflection_texel = tex2Dproj( ReflectionSampler, reflection_uv);

	float4 refraction_uv = In.TexRefraction;
    refraction_uv.xy += 200*RefractionDistortionScale * normal_vec.xy;
	float4 refraction_texel = tex2Dproj( RefractionSampler, refraction_uv);

	float4 pixel = WaterRefractC*refraction_texel + WaterReflectC*reflection_texel;

    //Cube map reflections, we need the view vector instead of the half-angle vector
    normal_vec.z *= 15.0f;
    normal_vec = normalize(normal_vec);

    float3 v = In.ViewVector;
    float3 r = -v + 2.0f*dot(v,normal_vec)*normal_vec;
    pixel *= texCUBE(SkyCubeSampler,r); 

    // blend the fog of war
    float4 fow_texel = tex2D(FOWSampler, In.TexFOW);
    pixel = pixel * fow_texel;

    pixel.a = In.Diff.a;
    
    return pixel;
}

//------------------------------------------------------------
// vertex shader for "Reflection Only"
//------------------------------------------------------------
VS_OUTPUT_REFLECT_ONLY vs_main_reflect_only(VS_INPUT In) 
{
	VS_OUTPUT_REFLECT_ONLY Out = (VS_OUTPUT_REFLECT_ONLY)0;
	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);

	float4 world_pos = mul( float4(In.Pos,1.0f), m_world );
	
	// Reflection texture coordinate generation (screen space)
	Out.TexReflection.x = 0.5f * (Out.Pos.x/Out.Pos.w + 1.0f);
	Out.TexReflection.y = 1.0f - (0.5f * (Out.Pos.y/Out.Pos.w + 1.0f));

	// Bump texture coordinates
	Out.TexBump.x = dot(Bump0TexU,world_pos); //float4(In.Pos,1));
	Out.TexBump.y = dot(Bump0TexV,world_pos); //float4(In.Pos,1));
		
	// FOW texture coordinates
    Out.TexFOW.x = dot(m_FOWTexU,world_pos);
    Out.TexFOW.y = dot(m_FOWTexV,world_pos);
	
    // Lighting
	float3 world_normal = float3(0,0,1);
	float3 spec_light = Compute_Specular_Light(world_pos,world_normal);
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);

    // Output final vertex lighting colors:
    Out.Diff = WaterColor;
    Out.Spec = 0; //float4(spec_light, 0);  // causes the water to saturate to white too much
	Out.Diff.a *= In.Color.a;

    // (gth) HACK! editor needs separate settings for the different water LOD's OR more consistent
    // behavior between the LOD's.  Unfortunately we're about to ship EAW and the middle LOD for water
    // always looks bad, this evil hack seems to improve the appearence significantly.
    Out.Diff *= float4(0.7,0.7,0.7,0.95);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}

//------------------------------------------------------------
// Pixel shader for "Reflection Only"
//------------------------------------------------------------
pixelshader ps_main_reflect_only_bin = asm
{
	ps.1.1

	tex t0;		    // bump map for EMBM
    texbem t1,t0; 	// perturbed reflection texel
	tex t2;			// FOW texel
	mad r0,v0,t1,v1;	// multiply by diffuse and add specular
    mul r0.rgb,r0,t2;   // modulate by FOW
};


//------------------------------------------------------------
// "perfect_reflect" demonstrates per-pixel correct texture
// projection (using tex2Dproj).  Keeping this code for future
// reference.  Can't seem to get EMBM with this on older HW.  
//------------------------------------------------------------

VS_OUTPUT_REFLECT_REFRACT vs_perfect_reflect(VS_INPUT In) 
{
	VS_OUTPUT_REFLECT_REFRACT Out = (VS_OUTPUT_REFLECT_REFRACT)0;
	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);

	// Reflection texture coordinate generation (screen space)
	Out.TexReflection = mul( Out.Pos, transpose(m_texOffset) );
	Out.TexRefraction = Out.TexReflection;

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);

	return Out;
}

float4 ps_perfect_reflect(VS_OUTPUT_REFLECT_REFRACT In): COLOR
{
    return tex2Dproj( ReflectionSampler, In.TexReflection); 
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
    
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    
        SB_END        

        VertexShader = compile vs_1_1 vs_main_reflect_refract();
        PixelShader  = compile ps_2_0 ps_main_reflect_refract();

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

    		ZEnable = true;
    		ZWriteEnable = true;
    		ZFunc = lessequal;
    		
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		
    	    AddressU[1] = CLAMP;
            AddressV[1] = CLAMP;	

        SB_END        

        VertexShader = compile vs_1_1 vs_main_reflect_only();
        PixelShader = (ps_main_reflect_only_bin);
    
		Texture[0] = (Bump0Texture);
		Texture[1] = (ReflectionTexture);
		Texture[2] = (m_FOWTexture);
    }

    pass t1_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            AddressU[1] = WRAP;
            AddressV[1] = WRAP;

        SB_END        
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

    		ZWriteEnable=false;
    		ZFunc=lessequal;	
    		AlphaBlendEnable=true;
    		SrcBlend=SRCALPHA;
    		DestBlend=INVSRCALPHA;

    		// FF Vertex pipeline
    		Lighting=false;

    		// FF Pixel pipeline
    		TexCoordIndex[0] = CAMERASPACEPOSITION;
    		TextureTransformFlags[0] = COUNT2;

            TexCoordIndex[1] = CAMERASPACEPOSITION;
            TextureTransformFlags[1] = COUNT2;
            EmissiveMaterialSource=COLOR1;

    		ColorOp[0]=MODULATE;    // color = base_texel * water_color
    		ColorArg1[0]=TEXTURE;
    		ColorArg2[0]=TFACTOR;
    		AlphaOp[0]=MODULATE;    // alpha = base_texel.a * water_color.a
    		AlphaArg1[0]=TEXTURE;
    		AlphaArg2[0]=TFACTOR;
    
    		ColorOp[1]=MODULATE;    // color *= FOW_texel
    		ColorArg1[1]=CURRENT;
    		ColorArg2[1]=TEXTURE;
    		AlphaOp[1]=MODULATE;    // alpha *= Vertex.a
    		AlphaArg1[1]=CURRENT;
            AlphaArg2[1]=DIFFUSE;
                	
            ColorOp[2]=DISABLE;
            AlphaOp[2]=DISABLE;

        SB_END        
        
        VertexShader = NULL;
        PixelShader = NULL;
        
		Texture[0] = (BaseTexture);
		TextureTransform[0] = (transpose(BaseFFTM));    // todo: optimize out this transpose
        Texture[1] = (m_FOWTexture);
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
        TextureFactor=(WaterColor);
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

            DiffuseMaterialSource=MATERIAL;
            Lighting=true;
        SB_END        
    }
}


