//-----------------------------------------------------------------------------
//COLOR CONTROLS!!
//			Author: Colt "MainRoach" McAnlis
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Effect File Variables
//-----------------------------------------------------------------------------
//Textures - Limited to the hardware.
texture inputTexture0 : RENDERCOLORTARGET
<
	float2 ViewPortDimensions = { 1.0, 1.0 };
    string format = "A8R8G8B8";
>; 
texture inputTexture1 : RENDERCOLORTARGET
<
	float2 ViewPortDimensions = { 1.0, 1.0 };
    string format = "A8R8G8B8";
>; 


//Need to create a sampler for each texture you create
sampler Sampler = sampler_state
{
    Texture   = (inputTexture0);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};



//-----------------------------------------------------------------------------
// Structure Definitions
//	Leave these alone. Because of the nature of the composite image, these will never change.
//-----------------------------------------------------------------------------


struct VS_OUT
{
    float4 hposition : POSITION;
	float2 texture0  : TEXCOORD0;
};


//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////UNIQUE PIXEL SHADERS ///////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
float Brightness=8.5;
float Contrast=0.3;
float Saturation=0.8;
float4 TintColor={1.f,0.85f,0.85f,1.f};
float AvgLum=0.0;
float Gamma=3.1;
//-----------------------------------------------------------------------------
// PASS 0 PIXEL SHADER
//-----------------------------------------------------------------------------


const float3 lumCoeff = float3(0.2125,0.7154,0.0721);

float4 myps(float2 texCoord: TEXCOORD) : COLOR
 {
	float4 diffuse = tex2D(Sampler,texCoord);

	//SATURATION
	float3 intensity = dot(diffuse ,lumCoeff);
	float3 color = lerp(intensity,diffuse,Saturation);
	float4 sat = float4(color,1);

	//	GAMMA CONVERSION
	sat = pow(sat , Gamma);

	//BRIGHTNESS / CONTRAST
	float3 cont= lerp(AvgLum,sat ,Contrast);
	float4 bright_cont = float4(cont,1.0);
	
	float4 output = bright_cont*TintColor *Brightness;
	

	return  output;
}




//-----------------------------------------------------------------------------
// Simple Effect (1 technique with 1 pass)
//-----------------------------------------------------------------------------

technique SceneComposite
{
    pass Pass0
    <
		int PassType =1;
		int DoFSAA=1;
		string ColorRenderTarget="inputTexture0";
		string RenderPhase="PHASE_ALL";
		float4 ClearColor = {0.f,0.f,1.f,1.f};
    >
    { }
    pass Pass1
     <
		int PassType =0;
		string ColorRenderTarget="inputTexture1";
		string BindTargetTextures="inputTexture0";
		float4 ClearColor = {1.f,1.f,0.f,1.f};
	>
    {
		PixelShader  = compile ps_2_0 myps();
    }
   
    
}

