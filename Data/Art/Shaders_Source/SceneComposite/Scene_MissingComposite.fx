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

//-----------------------------------------------------------------------------
// PASS 0 PIXEL SHADER
//-----------------------------------------------------------------------------

float4 myps( VS_OUT IN ): COLOR
{
	float4 color = tex2D( Sampler, IN.texture0 );

	return color;

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

