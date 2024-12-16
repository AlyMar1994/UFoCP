///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/FrameEffectWipe.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Shader used to implement the typical StarWars "wipe" transition.  This looks like 
    a "feathered" edge that wipes across the screen revealing the next scene.

*/

#include "../AlamoEngine.fxh"

/////////////////////////////////////////////////////////////////////
//
// Parameters
//
/////////////////////////////////////////////////////////////////////

texture PrevSceneTexture < string UIName="PrevSceneTexture"; >;
texture GradientTexture < string UIName="GradientTexture"; >;
float WipeFraction < string UIName="WipeFraction"; >;
float3 WipeDirection < string UIName="WipeDirection"; >;

float4 UVec < string UIName="UVec"; > = { 1,0,0,0 };
float4 VVec < string UIName="VVec"; > = { 0,1,0,0 };

const float znear = 0.01f;
const float zfar = 10.0f;

const float texture_scale = 1.0f;


#if 0
sampler DistortionSampler : register(s0) = 
sampler_state 
{ 
    Texture = (DistortionTexture); 
};

sampler SceneSampler : register(s1) = 
sampler_state 
{ 
    Texture = (SceneTexture); 
};     


struct VS_INPUT
{
    float2 Pos  : POSITION;
};

struct VS_OUTPUT
{
	float4 Pos		: POSITION;
	float2 Tex0		: TEXCOORD0;
	float2 Tex1		: TEXCOORD1;
    float  Fog		: FOG;
};


VS_OUTPUT vs_main_11(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

    Out.Pos.xy = In.Pos.xy;
	Out.Pos.z = 0.5f;
	Out.Pos.w = 1.0f;
	Out.Tex0 = float2(0.5f, -0.5f) * In.Pos.xy + float2(0.5f,0.5f);
    Out.Tex0.x += m_resolutionConstants.z;  // half-pixel
    Out.Tex0.y += m_resolutionConstants.w;

    Out.Tex1 = Out.Tex0;
    Out.Tex1.x += 10.0*m_resolutionConstants.z;
    Out.Tex1.y += 10.0*m_resolutionConstants.w;
    
	Out.Fog = 1.0f; //no fog please

    return Out;
}


half4 ps_main_11(VS_OUTPUT In) : COLOR
{
    half4 prev_scene_pixel = tex2D(DistortionSampler,In.Tex0);
    half4 gradient_pixel = DistortionAmount * 2.0 * (distortion_pixel - 0.5);
    half4 scene_pixel = tex2D(SceneSampler,In.Tex0 + distortion.xy);

    //return half4(1,0,0,1);
    //return distortion_pixel;
    return scene_pixel; 
}

#endif //0


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////

technique t0
<
	string LOD="FIXEDFUNCTION";	// minmum LOD
>
{
    pass t0_p0
    {
        SB_START
        
    		ZFunc = ALWAYS;
    		ZWriteEnable = FALSE;
    		AlphaBlendEnable = TRUE;
    		DestBlend = INVSRCALPHA;
    		SrcBlend = SRCALPHA;
    		AlphaTestEnable = FALSE;
            
            // fixed function vertex pipeline
            Lighting = false;
    
            // fixed function pixel pipeline
            AddressU[1]=CLAMP;
            AddressV[1]=CLAMP;
            
            ColorOp[0]=SELECTARG1;
    		ColorArg1[0]=TEXTURE;   
    		AlphaOp[0]=SELECTARG1;
    		AlphaArg1[0]=TEXTURE;
    		
    		ColorOp[1]=SELECTARG1;  
    		ColorArg1[1]=CURRENT; 
    		AlphaOp[1]=SELECTARG1; 
    		AlphaArg1[1]=TEXTURE;
    
    		ColorOp[2]=DISABLE; 
    		AlphaOp[2]=DISABLE;
    
            // Texture Coordinates
    		TexCoordIndex[1] = CAMERASPACEPOSITION;
    		TextureTransformFlags[1] = COUNT2;

        SB_END

        // shaders
        VertexShader = NULL;
        PixelShader  = NULL;

        Texture[0]=(PrevSceneTexture);
        Texture[1]=(GradientTexture);
        
        TextureTransform[1] =
        (
            mul
            (

              float4x4( texture_scale*UVec.x, texture_scale*VVec.x, 0.0f, 0.0f,
                        texture_scale*UVec.y, texture_scale*VVec.y, 0.0f, 0.0f,
                        texture_scale*UVec.z, texture_scale*VVec.z, 1.0f, 0.0f,
                        texture_scale*UVec.w, texture_scale*VVec.w, 0.0f, 1.0f ),

              float4x4( 0.5f, 0.0f, 0.0f, 0.0f,
                        0.0f,-0.5f, 0.0f, 0.0f,
                        0.0f, 0.0f, 1.0f, 0.0f,
                        0.5f, 0.5f, 0.0f, 1.0f )
            )
        );
	}

    pass t0_cleanup
    <
        bool AlamoCleanup = true;
    >
    {
        SB_START

            Lighting = true;
            AddressU[0] = WRAP;
            AddressV[0] = WRAP;
      		TextureTransformFlags[0]=disable;
    		TexCoordIndex[0]=0;
      		TextureTransformFlags[1]=disable;
    		TexCoordIndex[1]=1;

        SB_END
    }

}
