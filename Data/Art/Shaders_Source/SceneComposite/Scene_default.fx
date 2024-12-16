//-----------------------------------------------------------------------------
//           DEFAULT TERRAIN: HEAT AND BLOOM
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

texture inputTexture4 : RENDERCOLORTARGET
<
	float2 ViewPortDimensions = { 1.0, 1.0 };
    string format = "A8R8G8B8";
>; 

texture inputTexture5 : RENDERCOLORTARGET
<
	float2 ViewPortDimensions = { 1.0, 1.0 };
    string format = "A8R8G8B8";
>; 


//Need to create a sampler for each texture you create
sampler Sampler0 = sampler_state
{
    Texture   = (inputTexture0);
	MIPFILTER = ANISOTROPIC;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};

sampler Sampler1 = sampler_state
{
    Texture   = (inputTexture1);
	MIPFILTER = ANISOTROPIC;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};

sampler Sampler2 = sampler_state
{
    Texture   = (inputTexture2);
	MIPFILTER = ANISOTROPIC;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};
sampler Sampler3 = sampler_state
{
    Texture   = (inputTexture3);
	MIPFILTER = ANISOTROPIC;
	MINFILTER = ANISOTROPIC;
	MAGFILTER = ANISOTROPIC;
	MaxAnisotropy = 16;
};
sampler Sampler4 = sampler_state
{
    Texture   = (inputTexture4);
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

const float blurAmt = 0.005;
const float lowball	= 0.90;
const float highball = 0.901;
const float bloomscale = 1.f;

float4 myps( VS_OUT IN ): COLOR
{
	float offsetAMT = 0.01;
	float4 off = tex2D(Sampler1,IN.texture0);
	float2 nTexCoord = IN.texture0;
	nTexCoord.x += off.x*offsetAMT;
	nTexCoord.y += off.y*offsetAMT;
	
	float4 color = tex2D( Sampler0, nTexCoord);

    return color;
}

float4 highpass(float2 texCoord: TEXCOORD) : COLOR
{
   float4 sum = tex2D(Sampler2, texCoord);
   float4 lum = float4(0.3, 0.59, 0.11,0);
   sum = dot(sum,lum);
	float4 high = float4(smoothstep(lowball,highball,sum.x),
						smoothstep(lowball,highball,sum.y),
						smoothstep(lowball,highball,sum.z),
						1.f);
   return high*sum;
}


const float2 samples[12] = {
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

float4 blur0(float2 texCoord: TEXCOORD) : COLOR
{
   float4 sum = tex2D(Sampler3, texCoord);

   for (int i = 0; i < 12; i++){
      sum += tex2D(Sampler3, texCoord + blurAmt* samples[i]);
   }
   return sum / 13;
}
float4 combine(float2 texCoord: TEXCOORD) : COLOR
{
	float4 sum = tex2D(Sampler2, texCoord);
	float4 spec = tex2D(Sampler4, texCoord);
	float4 final = spec*bloomscale+ (sum);
	return final;
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
		string RenderPhase="PHASE_OPAQUE PHASE_TERRAIN PHASE_TRANSPARENT PHASE_SHADOW PHASE_FISSURE";
		float4 ClearColor = {0.f,0.f,1.f,1.f};
    > 
    { } 

    pass Pass1  
    <
		int PassType =1;
		int DoFSAA=0;
		string ColorRenderTarget="inputTexture1";
		string RenderPhase="PHASE_HEAT";
		float4 ClearColor = {0.f,0.f,1.f,1.f};
    >  
    { }
    pass Pass2
     <
		int PassType =0;
		string ColorRenderTarget="inputTexture2";
		string BindTargetTextures="inputTexture0 inputTexture1";
		float4 ClearColor = {1.f,1.f,0.f,1.f};
	>
    {
		PixelShader  = compile ps_2_0 myps();
    }
    pass Pass3
    <
		int PassType=0;
		string ColorRenderTarget="inputTexture3";
		string BindTargetTextures="inputTexture2";
	>
	{
		PixelShader = compile ps_2_0 highpass();
	}
    pass Pass4
    <
		int PassType=0;
		string ColorRenderTarget="inputTexture4";
		string BindTargetTextures="inputTexture3";
	>
	{
		PixelShader = compile ps_2_0 blur0();
	} 
	pass Pass5
    <
		int PassType=0;
		string ColorRenderTarget="inputTexture5";
		string BindTargetTextures="inputTexture4 inputTexture2";
	>
	{
		PixelShader = compile ps_2_0 combine();
	}
    
 
   //Now do specular blur

}

