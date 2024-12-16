//-----------------------------------------------------------------------------
//           LAME PENCIL SKETCH SHADER
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
texture pencil0Texture
<
	string ResourceName = "pencil1.jpg";
>;
texture pencil1Texture
<
	string ResourceName = "pencil2.jpg";
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
sampler pencil0Sampler = sampler_state
{
    Texture   = (pencil0Texture);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};
sampler pencil1Sampler = sampler_state
{
    Texture   = (pencil1Texture);
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

//-----------------------------------------------------------------------------
// PASS 0 PIXEL SHADER
//-----------------------------------------------------------------------------

float ColorIntensity=0.75f;
float Sketchoffset1=1.f;
float BrightIntensity=0.52f;
float Sketchoffset2=-1.f;
float inc=20;

float4 myps( float2 texCoord:TEXCOORD0): COLOR
{
	float4 sample = tex2D(Sampler, texCoord);
	float4 slerpt = float4(smoothstep(0.5,0.625,sample.x),
					smoothstep(0.5,0.625,sample.y),
					smoothstep(0.5,0.625,sample.z),1.f);

	float4 dlum = dot(slerpt,float4(0.3,0.59,0.11,0.0));
	dlum+=BrightIntensity;

	

	float4 p1 = tex2D(pencil0Sampler,texCoord*inc ) *dlum *Sketchoffset1;
	float4 p2 = tex2D(pencil1Sampler,texCoord*inc ) * (1-dlum) *Sketchoffset2;

	return sample*dlum*ColorIntensity+(p1+p2);//(p1+p2) + sample*slerpt*ColorIntensity;


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
		string BindTargetTextures="inputTexture0 pencil0Texture pencil1Texture";
		float4 ClearColor = {1.f,1.f,0.f,1.f};
	>
    {
		PixelShader  = compile ps_2_0 myps();
    }
   
    
}

