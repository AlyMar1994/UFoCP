///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars_Steam/FOC/Art/Shaders/Engine/PrimDecalBumpAlpha.fx $
//          $Author: Brian_Hayes $
//          $DateTime: 2017/03/22 10:16:16 $
//          $Revision: #1 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Bump mapping for decals.  The tangent space basis is formed from the Z axis
    of the view transform and a vector passed in as the diffuse color of the vertex.
	
*/

string _ALAMO_RENDER_PHASE = "Transparent";	// not really needed for this shader

#include "../AlamoEngine.fxh"


/////////////////////////////////////////////////////////////////////
//
// Material parameters
//
/////////////////////////////////////////////////////////////////////

// material parameters (not exposed)
float3 Emissive < string UIName="Emissive"; string UIType = "ColorSwatch"; > = {0.0f, 0.0f, 0.0f };
float4 Diffuse < string UIName="Diffuse"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f };
float4 Specular < string UIName="Specular"; string UIType = "ColorSwatch"; > = {1.0f, 1.0f, 1.0f, 1.0f };

sampler NormalSampler : register(s0);


///////////////////////////////////////////////////////
//
// Bump mapped particle shader:
// - the diffuse color for each vertex contains the tangent vector
//
///////////////////////////////////////////////////////

struct VS_INPUT
{
    float4 Pos  : POSITION;
    float3 Norm : NORMAL;
    float2 Tex  : TEXCOORD0;
    float4 Diff	: COLOR0;
};


struct VS_OUTPUT
{
    float4  Pos     : POSITION;
    float4  Diff	: COLOR0;
    float4	Spec	: COLOR1;
    float2  Tex0    : TEXCOORD0;
	float3  LightVector: TEXCOORD2;
	float3  HalfAngleVector: TEXCOORD3;
	float  Fog		: FOG;
};

VS_OUTPUT particle_bump_vs_main(VS_INPUT In)
{
    VS_OUTPUT Out = (VS_OUTPUT)0;

   	Out.Pos = mul(In.Pos,m_worldViewProj);
    Out.Tex0 = In.Tex;
    Out.Diff = float4(1,1,1,In.Diff.a);
    Out.Spec = float4(0,0,0,1);

    // Build the tangent space basis.  
    float3 normal = In.Norm;          
    float3 tangent = 2.0f*(In.Diff.rgb - 0.5f);
    float3 bitangent = cross(normal,tangent);

	// Compute the tangent-space light vector and half-angle vector for per-pixel lighting
	// Note that we are doing everything in object space here.
	float3x3 to_tangent_matrix;
	to_tangent_matrix = Compute_To_Tangent_Matrix(tangent,bitangent,normal);
	Out.LightVector = Compute_Tangent_Space_Light_Vector(m_light0ObjVector,to_tangent_matrix);
	Out.HalfAngleVector = Compute_Tangent_Space_Half_Vector(In.Pos,m_eyePosObj,m_light0ObjVector,to_tangent_matrix);

	// Output final vertex lighting colors:
    Out.Diff = float4(1,1,1,In.Diff.a);  
    Out.Spec = float4(0,0,0,1);

    // Distance fading
    Out.Diff.a *= Compute_Distance_Fade(Out.Pos.xyz);

	// Output fog
	Out.Fog = Compute_Fog(Out.Pos.xyz);


    return Out;
}

float4 bump_ps_main(VS_OUTPUT In) : COLOR
{
	// sample the textures
    float4 norm_texel = tex2D(NormalSampler,In.Tex0);

	// diffuse bump lighting
	float3 norm_vec = 2.0f*(norm_texel.rgb - 0.5f);
	float3 light_vec = 2.0f*(In.LightVector - 0.5f);

    // Compute the bumpped N*L and the non-bumpped N*L
	float ndotl = saturate(dot(norm_vec,light_vec)); //(normalize(norm_vec),normalize(light_vec)));  
    float flat_ndotl = light_vec.z;

    // Now, subtract the two so we get negative numbers where the 
    // bumpped lighting is darker and positive where the bumpped lighting is brighter
    ndotl = ndotl - flat_ndotl;

    // Compute the "relative lighting"
    float3 lighting = ndotl * m_light0Diffuse;
    
    // Scale the effect by the alpha channel of the bump map (artist control + solves edge case)
    lighting *= norm_texel.a * In.Diff.a;
    
    // And bias so that 0.5 is the 'zero point'
    lighting += float3(0.5,0.5,0.5);

    return float4(lighting, In.Diff.a);
}


vertexshader particle_bump_vs_main_bin = compile vs_1_1 particle_bump_vs_main();
pixelshader bump_ps_main_bin = compile ps_2_0 bump_ps_main();


///////////////////////////////////////////////////////
//
// Techniques
//
///////////////////////////////////////////////////////
technique t1
<
	string LOD="DX9";
>
{
    pass t1_p0
    {
        SB_START

    		// Blend Mode
            // Essentially we want 2*src*dest so we can darken or brighten (0.5 = no change)

    		ZWriteEnable=false; //true;
    		ZFunc = LESSEQUAL;
    		AlphaBlendEnable = TRUE;
    		DestBlend = SRCCOLOR;
    		SrcBlend = DESTCOLOR;
    		AlphaTestEnable = FALSE;
    		
            // shaders
            VertexShader = (particle_bump_vs_main_bin);
            PixelShader  = (bump_ps_main_bin);

        SB_END        
    }  
}



