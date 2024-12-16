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
	
	Alamo engine skinning parameters.  Using this shared HLSL file will keep all of the shader
	code consistent (using the same names for various matrices, etc)
	 
*/



// Matrices
static const int MAX_BONES = 24;
float4x3 m_skinMatrixArray[MAX_BONES] : SKINMATRIXARRAY : register(vs, c0);  // NOTE, code is now assuming register c0!


