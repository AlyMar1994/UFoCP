///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Skydome.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Sky Dome shader, 
    BASE TEXTURE - Opaque texture, background image
	CLOUD TEXTURE - Alpha blended with the base texture, animates at the specified rate
	
    In addition, the base map is fogged towards an atmosphere color the more the normal points
	away from the view direction.

*/


#include "AlamoEngine.fxh"

string _ALAMO_RENDER_PHASE = "Opaque";
string _ALAMO_VERTEX_TYPE = "alD3dVertNU2C";
bool _ALAMO_TANGENT_SPACE = false;
bool _ALAMO_SHADOW_VOLUME = false;

	

/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = { 0.0f, 0.0f, 0.0f };

float CloudScrollRate 
< 
	string UIName="CloudScrollRate"; 
	string UIType = "MaxSpinner";
	float UIMin = -1.0f;
	float UIMax = 1.0f; 
> = 0.0025f;

float CloudScale 
< 
	string UIName="CloudScale"; 
	string UIType = "MaxSpinner";
	float UIMin = 0.0f;
	float UIMax = 32.0f; 
> = 0.0025f;

texture BaseTexture 
< 
	string UIName = "BaseTexture";
	string UIType = "bitmap"; 
>;

texture CloudTexture
<
    string UIName = "CloudTexture";
    string UIType = "bitmap";
>;

/////////////////////////////////////////////////////////////////////
//
// Samplers
//
/////////////////////////////////////////////////////////////////////
sampler BaseSampler = sampler_state
{
	Texture   = (BaseTexture);
	MIPFILTER = ANISOTROPIC;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
	AddressU  = WRAP;        
	AddressV  = WRAP;
};

sampler CloudSampler = sampler_state
{
	Texture   = (CloudTexture);
	MIPFILTER = ANISOTROPIC;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
	AddressU  = WRAP;        
	AddressV  = WRAP;
};


/////////////////////////////////////////////////////////////////////
//
// Input and Output Structures
//
/////////////////////////////////////////////////////////////////////
struct VS_INPUT_MESH
{
	float4 Pos  : POSITION;
	float3 Normal : NORMAL;
	float2 Tex  : TEXCOORD0;
    float4 Color: COLOR0;               // alpha fade
};

struct VS_OUTPUT
{
	float4  Pos     : POSITION;
	float4  Diff	: COLOR0;
	float2  Tex0    : TEXCOORD0;        // base texture
    float2  Tex1    : TEXCOORD1;        // clouds
	
    float   Fog		: FOG;
};




///////////////////////////////////////////////////////
//
// Shaders
//
///////////////////////////////////////////////////////

VS_OUTPUT sph_vs_main(VS_INPUT_MESH In)
{
	VS_OUTPUT Out = (VS_OUTPUT)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
	
    // base + normal uv coords just copy the inputs
    Out.Tex0 = In.Tex;                                       
    
    // cloud uv coords scroll along the u axis
    Out.Tex1 = In.Tex;
    Out.Tex1.x += m_time * CloudScrollRate;
    Out.Tex1 *= CloudScale;
    
	// Lighting is applied per-vertex.  This must be computed in
	// world space for spherical harmonics to work.
    // Since this is intended for a sky-dome, we invert the vertex normal
	float3 world_pos = mul(In.Pos,m_world);
	float3 world_normal = normalize(mul(-In.Normal, (float3x3)m_world));
	float3 diff_light = Sph_Compute_Diffuse_Light_All(world_normal);
	
	// Output final vertex lighting colors:
    Out.Diff = float4(diff_light * In.Color.rgb + Emissive, In.Color.a);

    // Output fog
	Out.Fog = 1.0f; //Compute_Fog(Out.Pos.xyz);

    return Out;
}


half4 ps_main(VS_OUTPUT In) : COLOR
{
    half4 baseTexel = tex2D(BaseSampler,In.Tex0);
    half4 cloudTexel = tex2D(CloudSampler,In.Tex1);
    
    half3 surface_color = lerp(baseTexel.rgb,cloudTexel.rgb,cloudTexel.a * In.Diff.a); 

	// Apply the lighting
	half3 diff = surface_color * In.Diff.rgb * 2.0;
    
    return half4(diff, In.Diff.a);
}

vertexshader sph_vs_main_bin = compile vs_1_1 sph_vs_main();
pixelshader ps_main_bin = compile ps_1_1 ps_main();



//////////////////////////////////////
// Techniques follow
//////////////////////////////////////

technique sph_t2
<
	string LOD="DX8";
>
{
    pass sph_t2_p0
    {
        SB_START

    		// blend mode
    		ZWriteEnable = FALSE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = FALSE; //TRUE;
    		DestBlend = ZERO; //INVSRCALPHA;
    		SrcBlend = ONE; //SRCALPHA;

        SB_END        
		
        // shaders
        VertexShader = (sph_vs_main_bin);
        PixelShader  = (ps_main_bin);
    }  
}

technique t0
<
	string LOD="FIXEDFUNCTION";
>
{
    pass t0_p0 
    {
        SB_START

    		// blend mode
    		ZWriteEnable = FALSE;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = FALSE;
    		DestBlend = ZERO;
    		SrcBlend = ONE;
    		
            // fixed function pixel pipeline
    		Lighting=true;
    		FogEnable=false;
    		
            ColorVertex = true;
            DiffuseMaterialSource = COLOR1;
    
    		TexCoordIndex[0]=0;
            TexCoordIndex[1]=0;
    		TextureTransformFlags[1] = COUNT2;

            ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;
            AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=DIFFUSE; //TEXTURE;
    
    		ColorOp[1]=BLENDCURRENTALPHA; //BLENDTEXTUREALPHA;
    		ColorArg1[1]=TEXTURE;
    		ColorArg2[1]=CURRENT; 
    		AlphaOp[1]=SELECTARG1;
    		AlphaArg1[1]=TEXTURE;
            
            ColorOp[2]=MODULATE2X;
    		ColorArg1[2]=CURRENT;
    		ColorArg2[2]=DIFFUSE;
    		AlphaOp[2]=SELECTARG1;
    		AlphaArg1[2]=DIFFUSE;
    		
    		ColorOp[3] = DISABLE;
    		AlphaOp[3] = DISABLE;
    

        SB_END        

        VertexShader = NULL;
        PixelShader  = NULL;
        
		MaterialAmbient=(float4(0,0,0,1));
		MaterialDiffuse=(float4(0,0,0,1));
		MaterialEmissive=(float4(0,0,0,1));
		MaterialEmissive = (float4(Emissive,0));
		MaterialPower = 32.0f;

		Texture[0]=(BaseTexture);
        Texture[1]=(CloudTexture);

		TextureTransform[1] = 
		(
			float4x4(float4(CloudScale,0,0,0),float4(0,CloudScale,0,0),float4(CloudScrollRate*m_time*CloudScale,0,1,0),float4(0,0,0,1))
		);
    }  

    pass t0_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            TexCoordIndex[1]=1;
            DiffuseMaterialSource = MATERIAL;
            ColorVertex = false;

       		TextureTransformFlags[1] = DISABLE;

            //FogEnable=true; // alamo code saves and restores fog state around each effect

        SB_END        
    }    
}

