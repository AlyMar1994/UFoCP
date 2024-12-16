//--------------------------------------------------------------//
// TerrainRenderBumpDual.fx
//
// This shader renders two layers of the terrain in one pass
// Unfortunately the length of the pixel shader makes it slower
// than rendering the two passes separately.  It also does not
// correctly handle FOG.  Fixing this problem will make the 
// pixel shader even slower...
//--------------------------------------------------------------//

#include "../AlamoEngine.fxh"

string RenderPhase = "Terrain";


//////////////////////////////////
// Texture Coordinate Generation
//////////////////////////////////
float4 TexU0 = { 0.01, 0.0,  0.0, 0.0 };
float4 TexV0 = { 0.0,  0.01, 0.0, 0.0 };

float4 TexU1 = { 0.01, 0.0,  0.0, 0.0 };
float4 TexV1 = { 0.0,  0.01, 0.0, 0.0 };

float2 blendTexScale = { 0.01, 0.01 };
float2 blendTexOffset = { 0.0, 0.0 };

//////////////////////////
// Material Properties
//////////////////////////
texture DiffuseTexture0;
texture DiffuseTexture1;

texture NormalTexture0;
texture NormalTexture1;

texture BlendTexture;

float4 MaterialDiffuse0 = {1.0f, 1.0f, 1.0f, 1.0f};
float4 MaterialDiffuse1 = {1.0f, 1.0f, 1.0f, 1.0f};

float4 MaterialSpecular0 = {0.7f, 0.7f, 0.7f, 1.0f};
float4 MaterialSpecular1 = {0.7f, 0.7f, 0.7f, 1.0f};

float Shininess = 32.0;

sampler DiffuseSampler0 = sampler_state { texture = (DiffuseTexture0); };
sampler DiffuseSampler1 = sampler_state { texture = (DiffuseTexture1); };
sampler NormalSampler0 = sampler_state { texture = (NormalTexture0); };
sampler NormalSampler1 = sampler_state { texture = (NormalTexture1); };
sampler BlendSampler = sampler_state { texture = (BlendTexture); };
sampler CloudSampler = sampler_state { Texture	= (m_cloudTexture); };      // from AlamoEngine.fxh


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

    float2 TexCoord0    		: TEXCOORD0;    // first pass texcoords (diffuse,bump)
    float2 TexCoord1	    	: TEXCOORD1;    // second pass texcoords (diffuse,bump)
    float2 TexCoordBlend		: TEXCOORD2;
    float2 TexCoordCloud		: TEXCOORD3;

    float3 LightVector0 		: TEXCOORD4;    //in tangent space
    float3 HalfAngleVector0 	: TEXCOORD5;    //in tangent space
    float3 LightVector1         : TEXCOORD6;
    float3 HalfAngleVector1     : TEXCOORD7;
    
    float4 Diff					: COLOR0;
    float4 Spec				    : COLOR1;
    float  Fog		            : FOG;
};


//------------------------------------


VS_OUTPUT_BUMP vs_main_bump(VS_INPUT In) 
{
	VS_OUTPUT_BUMP Out = (VS_OUTPUT_BUMP)0;
	Out.Pos = mul( float4(In.Pos.xyz , 1.0) , m_worldViewProj);

	// texture coordinate generation
	Out.TexCoord0.x = dot(TexU0,float4(In.Pos.xyz,1.0));
	Out.TexCoord0.y = dot(TexV0,float4(In.Pos.xyz,1.0));
	Out.TexCoord1.x = dot(TexU1,float4(In.Pos.xyz,1.0));
	Out.TexCoord1.y = dot(TexV1,float4(In.Pos.xyz,1.0));
    
	Out.TexCoordBlend = blendTexScale*In.Pos.xy + blendTexOffset;
	Out.TexCoordCloud.x = dot(m_cloudTexU,float4(In.Pos.xyz,1.0));
	Out.TexCoordCloud.y = dot(m_cloudTexV,float4(In.Pos.xyz,1.0));
	
    float3 T,B;
    float3x3 to_tangent_matrix;
	float ooNz = (1.0f / In.Normal.z);
	float3 Nxy = float3(In.Normal.x,In.Normal.y,0.0f);
    
	// tangent space generation for pass0
	T = float3(TexU0.x,TexU0.y,0.0f);
	T.z = -dot(Nxy,T) * ooNz;
	T = normalize(T);
	B = float3(TexV0.x,TexV0.y,0.0f);
	B.z = -dot(Nxy,B) * ooNz;
	B = normalize(B);
	to_tangent_matrix = Compute_To_Tangent_Matrix(T,B,In.Normal);

	Out.LightVector0 = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);
	Out.HalfAngleVector0 = Compute_Tangent_Space_Half_Vector(In.Pos,m_eyePosObj,m_light0ObjVector,to_tangent_matrix);

	// tangent space generation for pass1
	T = float3(TexU1.x,TexU1.y,0.0f);
	T.z = -dot(Nxy,T) * ooNz;
	T = normalize(T);
	B = float3(TexV1.x,TexV1.y,0.0f);
	B.z = -dot(Nxy,B) * ooNz;
	B = normalize(B);
	to_tangent_matrix = Compute_To_Tangent_Matrix(T,B,In.Normal);

	Out.LightVector1 = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);
	Out.HalfAngleVector1 = Compute_Tangent_Space_Half_Vector(In.Pos,m_eyePosObj,m_light0ObjVector,to_tangent_matrix);

	// Fill lighting is applied per-vertex.  This must be computed in
	// world space for spherical harmonics to work.
	float3 world_normal = normalize(mul(In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_Fill(world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light,0); //float4(diff_light * materialDiffuse, 1);
    Out.Spec = float4(0,0,0,1);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);
	return Out;
}


//---------------------------------------------------
//
// Two alpha blended passes collapsed together:
//
// P0 = (1-a0)*FB + a0*c0
// P1 = (1-a1)*P1 + a1*c1
//
// P1 = (1-a1)*((1-a0)*FB + a0*c0) + a1*c1
// P1 = (1-a1)*(1-a0)*FB + (1-a1)*a0*c0 + a1*c1
//
// Therefore:
// output_color = (1-a1)*a0*c0 + a1*c1
// output_alpha = (1-a1)*(1-a0)
//
// Blend Mode:
// DestBlend = SRC_ALPHA
// SrcBlend = ONE
//
//---------------------------------------------------


half4 ps_main_bump(VS_OUTPUT_BUMP In): COLOR
{
	half4 DiffuseTexel0 = tex2D( DiffuseSampler0, In.TexCoord0 );
	half4 NormalTexel0 = tex2D( NormalSampler0, In.TexCoord0 );
	half4 DiffuseTexel1 = tex2D( DiffuseSampler1, In.TexCoord1 );
	half4 NormalTexel1 = tex2D( NormalSampler1, In.TexCoord1 );
	half4 BlendTexel = tex2D( BlendSampler, In.TexCoordBlend );
	half4 CloudTexel = tex2D( CloudSampler, In.TexCoordCloud );

	// compute lighting
    half3 norm_vec;
    half3 light_vec;
    half3 half_vec;
    half3 diff;
    half3 spec;
    half ndotl;
    half ndoth;
    
	norm_vec = 2.0f*(NormalTexel0.rgb - 0.5f);
	light_vec = 2.0f*(In.LightVector0 - 0.5f);
	half_vec = 2.0f*(In.HalfAngleVector0 - 0.5f);
    ndotl = saturate(dot(norm_vec,light_vec));
	ndoth = saturate(dot(norm_vec,half_vec));
	diff = DiffuseTexel0.rgb * (ndotl*MaterialDiffuse0*m_light0Diffuse + MaterialDiffuse0*In.Diff.rgb) * 2.0;
	spec = m_light0Specular*MaterialSpecular0*pow(ndoth,16)*DiffuseTexel0.a;

    half3 color0 = (diff + spec) * CloudTexel.rgb;

	norm_vec = 2.0f*(NormalTexel1.rgb - 0.5f);
	light_vec = 2.0f*(In.LightVector1 - 0.5f);
	half_vec = 2.0f*(In.HalfAngleVector1 - 0.5f);
    ndotl = saturate(dot(norm_vec,light_vec));
	ndoth = saturate(dot(norm_vec,half_vec));
	diff = DiffuseTexel1.rgb * (ndotl*MaterialDiffuse1*m_light0Diffuse + MaterialDiffuse1*In.Diff.rgb) * 2.0;
	spec = m_light0Specular*MaterialSpecular1*pow(ndoth,16)*DiffuseTexel1.a;

    half3 color1 = (diff + spec) * CloudTexel.rgb;

    // combine the two passes:
    half a0 = BlendTexel.r;
    half a1 = BlendTexel.g;
        
    half3 output_color = BlendTexel.b * color0 + a1*color1;    //(1-a1)*a0*color0 + a1*color1;
    half output_alpha = BlendTexel.a;                          //(1.0f-a1)*(1.0f-a0);

    return half4(output_color,output_alpha);
}


vertexshader vs_main_bump_bin = compile vs_1_1 vs_main_bump();
pixelshader ps_main_bump_bin = compile ps_2_0 ps_main_bump();


//-----------------------------------


technique bump
< 
	string LOD="DX9";
>
{
    pass bump_p0 
    {		
        SB_START

    		ZEnable=true;
        	ZWriteEnable=true;
    		ZFunc=lessequal;

            AlphaBlendEnable=TRUE; //FALSE;
            DestBlend=SRCALPHA;
            SrcBlend=ONE;

        SB_END        

        VertexShader = (vs_main_bump_bin);
        PixelShader  = (ps_main_bump_bin);

    }
}

