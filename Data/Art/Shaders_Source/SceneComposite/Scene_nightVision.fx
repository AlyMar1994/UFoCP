//-----------------------------------------------------------------------------
//          NIGHTVISION GOGGLES
//			Author: Colt "MainRoach" McAnlis
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
//Need to create a sampler for each texture you create
sampler Sampler0 = sampler_state
{
    Texture   = (inputTexture0);MIPFILTER = ANISOTROPIC;MINFILTER = ANISOTROPIC;MAGFILTER = ANISOTROPIC; MaxAnisotropy = 16;
};
sampler Sampler1 = sampler_state
{
    Texture   = (inputTexture1);MIPFILTER = ANISOTROPIC;MINFILTER = ANISOTROPIC;MAGFILTER = ANISOTROPIC; MaxAnisotropy = 16;
};
sampler Sampler2 = sampler_state
{
    Texture   = (inputTexture2);MIPFILTER = ANISOTROPIC;MINFILTER = ANISOTROPIC;MAGFILTER = ANISOTROPIC; MaxAnisotropy = 16;
};
sampler Sampler3 = sampler_state
{
    Texture   = (inputTexture3);MIPFILTER = ANISOTROPIC;MINFILTER = ANISOTROPIC;MAGFILTER = ANISOTROPIC; MaxAnisotropy = 16;
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
const float4x4 ColorTransform = {
	0.51490,	0.32440,	0.16070,	0.0,
	0.26540,	0.67040,	0.06420,	0.0,
	0.02480,	0.12480,	0.85040,	0.0,
	0.0,		0.0,		0.0,		1.0,
};
const float4 SceneColor = {0.f,0.4f,0.f,1.f};
const float Intensity = 1.0f;


float4 blur0(float2 texCoord: TEXCOORD) : COLOR
{
   float4 sum = tex2D(Sampler0, texCoord);

   for (int i = 0; i < 12; i++){
      sum += tex2D(Sampler0, texCoord + 0.003* samples[i]);
   }
   sum = sum/13;
   return float4(sum.x,sum.y,sum.z,1.f);
}
float4 blur1(float2 texCoord: TEXCOORD) : COLOR
{
   float4 sum = tex2D(Sampler0, texCoord);

   for (int i = 0; i < 12; i++){
      sum += tex2D(Sampler0, texCoord + 0.005* samples[i]);
   }
   sum = sum/13;
   return float4(sum.x,sum.y,sum.z,1.f);
}
float4 combine(float2 texCoord: TEXCOORD) : COLOR
{
	half4 blur0 = tex2D(Sampler2,texCoord);
	half4 blur1 = tex2D(Sampler1,texCoord) -blur0;

    half4 oColor = blur0 + sign(blur1) * pow(abs(blur1), 1.0/1.2);
    //convert the color to nightvision
    	half4 vColor;
    	half  nLuminance;

    	vColor = mul(ColorTransform, oColor);
    	vColor = max(vColor, half4(0.01, 0, 0, 1));
    	nLuminance = vColor.y * (1.33f * (1 + (vColor.y + vColor.z)/vColor.x) - 1.68f);

    	oColor.xyz = SceneColor * (nLuminance * Intensity);
    	oColor.w = vColor.w;

	return oColor;

}
//-----------------------------------------------------------------------------
// Simple Effect (1 technique with 1 pass)
//-----------------------------------------------------------------------------

technique SceneComposite
{
    pass Pass0
    <
		int PassType =1;
		string ColorRenderTarget="inputTexture0";
		string RenderPhase="PHASE_ALL";
		int DoFSAA=1;
		float4 ClearColor = {0.f,0.f,1.f,1.f};
    >
    { }
   pass Pass1
    <
		int PassType=0;
		string ColorRenderTarget="inputTexture1";
		string BindTargetTextures="inputTexture0";
	>
	{
		PixelShader = compile ps_2_0 blur0();
	} 
	pass Pass2
    <
		int PassType=0;
		string ColorRenderTarget="inputTexture2";
		string BindTargetTextures="inputTexture0";
	>
	{
		PixelShader = compile ps_2_0 blur1();
	} 
	pass Pass3
    <
		int PassType=0;
		string ColorRenderTarget="inputTexture3";
		string BindTargetTextures="inputTexture1 inputTexture2";
	>
	{
		PixelShader = compile ps_2_0 combine();
	} 

    
}

