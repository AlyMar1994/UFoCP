//-----------------------------------------------------------------------------
//           MISSING COMPOSITE
//			Author: Colt "MainRoach" McAnlis
//			This is an external version of the file that's loaded when there's a
//				composite loading error
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
texture inputTexture2 : RENDERCOLORTARGET
<
	float2 ViewPortDimensions = { 1.0, 1.0 };
    string format = "A8R8G8B8";
>; 
texture inputTexture3 : RENDERCOLORTARGET
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
sampler shadowSampler = sampler_state
{
    Texture   = (inputTexture1);
    MIPFILTER = ANISOTROPIC;
    MINFILTER = ANISOTROPIC;
    MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};
sampler blurSampler = sampler_state
{
    Texture   = (inputTexture2);
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
float blurAmt = 0.002f;

const float2 samples12[12] = {
   -0.326212, -0.405805,
   -0.840144, -0.073580,
   -0.695914,  0.457137,
   -0.203345,  0.620716,
    0.962340, -0.194983,
    0.473434, -0.480026,
    0.519456,  0.767022,
    0.185461, -0.893124,
    0.507431,  0.064425,
    0.896420,  0.412458,
   -0.321940, -0.932615,
   -0.791559, -0.597705,
};

const float2 samples4[4] = {
   -0.88,  0,
    0,  0.88,
    0.88,  0,
    0, -0.88,
};

float4 blur0(float2 texCoord: TEXCOORD) : COLOR
{
	float numSamples=4.0;
   float4 sum = tex2D(shadowSampler, texCoord);

   for (int i = 0; i < numSamples; i++){
      sum += tex2D(shadowSampler, texCoord + blurAmt* samples4[i]);
   }
   return sum / (numSamples+1);
}

float4 myps( VS_OUT IN ): COLOR
{
	float4 color = tex2D( Sampler, IN.texture0 );
	float4 shadow = tex2D( blurSampler, IN.texture0);

	return color*shadow;

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
		string RenderPhase="PHASE_OPAQUE PHASE_TRANSPARENT PHASE_TERRAIN PHASE_FISSURE";
		float4 ClearColor = {0.f,0.f,1.f,1.f};
    >
    { }
    pass Pass4
    <
		int PassType =1;
		int DoFSAA=1;
		int DoZClear=1;
		string ColorRenderTarget="inputTexture1";
		string RenderPhase="PHASE_SHADOW";
		float4 ClearColor = {1.f,1.f,1.f,1.f};
    >
    { }
    pass Passblur
     <
		int PassType =0;
		string ColorRenderTarget="inputTexture2";
		string BindTargetTextures="inputTexture1";
		float4 ClearColor = {1.f,1.f,0.f,1.f};
	>
    {
		PixelShader  = compile ps_2_0 blur0();
    }
    pass Pass1
     <
		int PassType =0;
		string ColorRenderTarget="inputTexture3";
		string BindTargetTextures="inputTexture0 inputTexture2";
		float4 ClearColor = {1.f,1.f,0.f,1.f};
	>
    {
		PixelShader  = compile ps_2_0 myps();
    }
   
    
}

