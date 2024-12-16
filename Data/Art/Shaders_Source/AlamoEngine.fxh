///////////////////////////////////////////////////////////////////////////////////////////////////
// Petroglyph Confidential Source Code -- Do Not Distribute
///////////////////////////////////////////////////////////////////////////////////////////////////
//
//          $File: //depot/Projects/StarWars/Art/Shaders/RSkinBumpColorize.fx $
//          $Author: Greg_Hjelstrom $
//          $DateTime: 2004/04/14 15:29:37 $
//          $Revision: #3 $
//
///////////////////////////////////////////////////////////////////////////////////////////////////
/*
	
	Alamo engine parameters.  Using this shared HLSL file will keep all of the shader
	code consistent (using the same names for various matrices, etc)
	 
*/


#define ALAMO_STATE_BLOCKS 0
#define ALAMO_USE_ZFAIL_SHADOW_VOLUMES 1

#if (ALAMO_STATE_BLOCKS)
#define SB_START	StateBlock = stateblock_state {
#define SB_END   	};
#else
#define SB_START  
#define SB_END
#endif


// Matrices
float4x4 m_projection : PROJECTION;
float4x4 m_world : WORLD;
float4x4 m_worldView : WORLDVIEW;
float4x4 m_worldViewProj : WORLDVIEWPROJECTION;
float4x4 m_viewProj : VIEWPROJECTION;
float4x4 m_view : VIEW;
float4x4 m_worldInv : WORLDINVERSE;
float4x4 m_viewInv : VIEWINVERSE;
float4x4 m_worldViewInv : WORLDVIEWINVERSE;
float4 m_eyePos : EYE_POSITION;
float4 m_eyePosObj : EYE_OBJ_POSITION;
float4 m_resolutionConstants : RESOLUTION_CONSTANTS;  //x,y=width,height, z,w=half-pixel width, half-pixel height

// Lighting
float4 m_lightAmbient : GLOBAL_AMBIENT = {0.2f, 0.2f, 0.2f, 1.0f}; // light ambient
float4 m_light0Vector : DIR_LIGHT_VEC_0 = {0.7f, 0.0f, 0.7f, 1.0f};  //light vector
float3 m_light0ObjVector : DIR_LIGHT_OBJ_VEC_0 = {0.7f, 0.0f, 0.7f};  
float4 m_light0Diffuse : DIR_LIGHT_DIFFUSE_0 = {1.0f, 1.0f, 1.0f, 1.0f}; // Light Diffuse
float4 m_light0Specular : DIR_LIGHT_SPECULAR_0 = {1.0f, 1.0f, 1.0f, 0.0f}; // light specular

/* Obsolete, we use light0 + sph now
float3 m_light1Vector : DIR_LIGHT_VEC_1 = {-0.7f, 0.0f, -0.7f};  //light vector
float3 m_light1ObjVector : DIR_LIGHT_OBJ_VEC_1 = {-0.7f, 0.0f, -0.7f}; 
float4 m_light1Diffuse : DIR_LIGHT_DIFFUSE_1 = {0.1f, 0.1f, 0.1f, 1.0f}; // Light Diffuse

float3 m_light2Vector : DIR_LIGHT_VEC_2 = {0.7f, 0.0f, -0.7f};  //light vector
float3 m_light2ObjVector : DIR_LIGHT_OBJ_VEC_2 = {0.7f, 0.0f, -0.7f};  
float4 m_light2Diffuse : DIR_LIGHT_DIFFUSE_2 = {0.1f, 0.1f, 0.1f, 1.0f}; // Light Diffuse
*/

float4x4 m_sphAll[3] : SPH_LIGHT_ALL = 
{
	{
    0.0910,   -0.0478,    0.2403,   -0.1495,
   -0.0478,   -0.0910,   -0.1126,    0.2021,
    0.2403,   -0.1126,   -0.1157,   -0.1738,
   -0.1495,    0.2021,   -0.1738,    0.7379
  	},
  	{
   -0.0233,   -0.0218,    0.0920,   -0.0285,
   -0.0218,    0.0233,   -0.0961,    0.1790,
    0.0920,   -0.0961,   -0.0704,   -0.0933,
   -0.0285,    0.1790,   -0.0933,    0.4108
   },
   {
   -0.1303,   -0.0525,    0.0597,    0.0048,
   -0.0525,    0.1303,   -0.2037,    0.3095,
    0.0597,   -0.2037,   -0.1095,   -0.1378,
    0.0048,    0.3095,   -0.1378,    0.5165
   }
};


float4x4 m_sphFill[3] : SPH_LIGHT_FILL =
{
	{
    0.0910,   -0.0478,    0.2403,   -0.1495,
   -0.0478,   -0.0910,   -0.1126,    0.2021,
    0.2403,   -0.1126,   -0.1157,   -0.1738,
   -0.1495,    0.2021,   -0.1738,    0.7379
  	},
  	{
   -0.0233,   -0.0218,    0.0920,   -0.0285,
   -0.0218,    0.0233,   -0.0961,    0.1790,
    0.0920,   -0.0961,   -0.0704,   -0.0933,
   -0.0285,    0.1790,   -0.0933,    0.4108
   },
   {
   -0.1303,   -0.0525,    0.0597,    0.0048,
   -0.0525,    0.1303,   -0.2037,    0.3095,
    0.0597,   -0.2037,   -0.1095,   -0.1378,
    0.0048,    0.3095,   -0.1378,    0.5165
   }
};

// 'LightScale' is passed in by the engine, used to brighten or dim things and fade them out
// the alpha value should be used to make the shader disappear as it approaches zero.
float4 m_lightScale : LIGHT_SCALE = { 1.0f, 1.0f, 1.0f, 1.0f };	

// Simple fogging, linear equation based on view space distance to the point
// m_fogVals.x = slope, m_fogVals.y = offset
// f = m_fogVals.x * dist + m_fogVals.y
// To compute fogslope and fogoffset given a near and far fog distance use the following:
// m_fogVals.x = 1.0 / (near - far);
// m_fogVals.y = -far / (near - far);
float2 m_fogVals : FOG_VALS = { -0.005f, 200.0f };

// Distance fade support, similar to fog, used to alpha fade objects in the distance for 
// smooth LOD culling
float2 m_distanceFadeVals : DISTANCE_FADE_VALS = { -0.0001,1000.0f };


// Time
float m_time : TIME;

// Textures
texture m_skyCubeTexture : SKY_CUBE_TEXTURE < string Type = "Cube"; >;
texture m_FOWTexture : FOW_TEXTURE;
texture m_cloudTexture : CLOUD_TEXTURE;

// Texture coordinate generation for the fog-of-war map
float4 m_FOWTexU : FOW_TEX_U = { 100.01, 0.0,  0.0, 0.0 };
float4 m_FOWTexV : FOW_TEX_V = { 0.0,  100.01, 0.0, 0.0 };

// Texture coordinate generation for the cloud shadows
float4 m_cloudTexU : CLOUD_TEX_U = { 100.01, 0.0,  0.0, 0.0 };
float4 m_cloudTexV : CLOUD_TEX_V = { 0.0,  100.01, 0.0, 0.0 };

// Tree/Plant bending.  (x,y,z) are a 3d world space offset (z=0 normally), w = 1/h^2, h=height at wich you offset 100%
float4 m_bendVector : WIND_BEND_VECTOR = { 1.0f, 0.0f, 0.0f, 0.01f };

// wind vector used by the Grass shader, (length stuffed in w)
float4 m_windGrassVector : WIND_GRASS_PARAMS = { 0.0f, 0.0f, 0.0f, 0.0f };




//////////////////////////////////////////////////////////
// Fog calculation
//////////////////////////////////////////////////////////
float Compute_Fog(float3 proj_position)
{
	float fog = length(proj_position.xyz);
	return saturate(m_fogVals.x * fog + m_fogVals.y);
}

//////////////////////////////////////////////////////////
// Distance Fade calculation
//////////////////////////////////////////////////////////
float Compute_Distance_Fade(float3 proj_position)
{
	float dist = length(proj_position.xyz);
	return clamp(m_distanceFadeVals.x * dist + m_distanceFadeVals.y,0,1);
}


//////////////////////////////////////////////////////////
// Vertex Diffuse Lighting
// These functions will compute the diffuse vertex
// ighting using various combinations of the lights
//////////////////////////////////////////////////////////
float3 Sph_Compute_Diffuse_Light_All(float3 world_normal)
{
	float3 diff_light = (float3)0;
	float4 tmp_normal = float4(world_normal,1);
	diff_light.x = dot(tmp_normal,mul(m_sphAll[0],tmp_normal));
	diff_light.y = dot(tmp_normal,mul(m_sphAll[1],tmp_normal));
	diff_light.z = dot(tmp_normal,mul(m_sphAll[2],tmp_normal));
	return diff_light;
}

float3 Sph_Compute_Diffuse_Light_Fill(float3 world_normal)
{
	float3 diff_light = (float3)0;
	float4 tmp_normal = float4(world_normal,1);
	diff_light.x = dot(tmp_normal,mul(m_sphFill[0],tmp_normal));
	diff_light.y = dot(tmp_normal,mul(m_sphFill[1],tmp_normal));
	diff_light.z = dot(tmp_normal,mul(m_sphFill[2],tmp_normal));
	return diff_light;
}

/*
float3 Compute_Diffuse_Light_Fill(float3 world_normal)
{
	float ndotl;
	float3 diff_light = m_lightAmbient;

	// Fill Light 1:
	ndotl = max(0,dot(world_normal,m_light1Vector));
	diff_light += ndotl * m_light1Diffuse;

	// Fill Light 2:
	ndotl = max(0,dot(world_normal,m_light2Vector));
	diff_light += ndotl * m_light2Diffuse;
	
	return diff_light;
}

float3 Compute_Diffuse_Light_All(float3 world_normal)
{
	float ndotl;
	float3 diff_light = Compute_Diffuse_Light_Fill(world_normal);
	
	ndotl = max(0 , dot(world_normal,m_light0Vector));
	diff_light += ndotl * m_light0Diffuse;
	
	return diff_light;
}
*/

//////////////////////////////////////////////////////////
// Vertex Specular Lighting
// This function will compute the specular vertex lighting
//////////////////////////////////////////////////////////
float3 Compute_Specular_Light(float3 world_pos,float3 world_normal)
{
    float3 P = world_pos;
    float3 N = world_normal;
    float3 L = m_light0Vector;
	float3 E = normalize(m_eyePos - P); 	// vector from vert to eye 
	float3 H = normalize(E + L);		// half angle vector
	
	float  spec = pow( max(0 , dot(N,H) ) , 16 );
	return spec * m_light0Specular;
}

//////////////////////////////////////////////////////////
//
// Compute_From_Tangent_Matrix
// Compute_To_Tangent_Matrix
//
// Utility functions for computing matrices that take
// us to and from tangent-space.
//////////////////////////////////////////////////////////
float3x3 Compute_From_Tangent_Matrix(float3 tangent,float3 binormal,float3 normal)
{
	float3x3 tm;
    tm[0] = tangent;
    tm[1] = binormal;
    tm[2] = normal;
	return tm;
}

float3x3 Compute_To_Tangent_Matrix(float3 tangent,float3 binormal,float3 normal)
{
	float3x3 tm = Compute_From_Tangent_Matrix(tangent,binormal,normal);
	tm = transpose(tm);
	return tm;
}

//////////////////////////////////////////////////////////
//
// Compute_Tangent_Space_Light_Vector - light vector in tangent space
// Compute_Tangent_Space_Half_Vector - half-angle vector in tangent space
// Compute_Tangent_Space_View_Vector - vector from point to eye in tangent space
//
// Utility functions for computing the tangent-space 
// light vector and half-angle-vector.  As with all of
// these functions, make sure everything is in a consistent
// coordinate system!
//////////////////////////////////////////////////////////
float3 Compute_Tangent_Space_Light_Vector(float3 in_light,float3x3 in_to_tangent)
{
	float3 LightVector = (float3)0;

	LightVector = mul(in_light,in_to_tangent);
	LightVector = normalize(LightVector);
	LightVector = (0.5f*LightVector)+0.5f;
	return LightVector;	
}

float3 Compute_Tangent_Space_Half_Vector(float3 in_pos,float3 in_eye,float3 in_light,float3x3 in_to_tangent)
{
	float3 HalfAngleVector = (float3)0;

	// Compute half-angle vector in the given space
	float3 P = in_pos;  
	float3 E = normalize(in_eye - P); // vector from vert to eye 
	float3 L = in_light;
	float3 H = normalize(E + L);		// half angle vector

	// Transform half-angle vector into tangent space
	HalfAngleVector = mul(H,in_to_tangent);
	HalfAngleVector = normalize(HalfAngleVector);
	HalfAngleVector = (0.5f*HalfAngleVector)+0.5f;

	return HalfAngleVector;
}

float3 Compute_Tangent_Space_View_Vector(float3 in_pos,float3 in_eye,float3x3 in_to_tangent)
{
	float3 ViewVector = (float3)0;
	float3 E = normalize(in_eye - in_pos);
	ViewVector = mul(E,in_to_tangent);
	ViewVector = (0.5f*ViewVector)+0.5f;
	return ViewVector;	 
}

//////////////////////////////////////////////////////////
// 
// Vertex attribute packing support.  
// 
//////////////////////////////////////////////////////////
float2 Unpack_UV(float2 uv)
{
	return uv * (1.0f / 4096.0f);	// we pack uv's by scaling up and storing in shorts.
}

float3 Unpack_Normal(float3 norm)
{
	return norm * (1.0f / 16384.0f);
}

//////////////////////////////////////////////////////////
// 
// Depth-of-Field support
// 
//////////////////////////////////////////////////////////
float Compute_DOF_Alpha_WS(float3 world_pos)
{

}

float Compute_DOF_Alpha_OS(float3 obj_pos)
{

}


