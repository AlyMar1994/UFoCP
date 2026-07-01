-- $Id: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/UM02_DroidCrate.lua#1 $
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
-- (C) Petroglyph Games, Inc.
--
--
--  *****           **                          *                   *
--  *   **          *                           *                   *
--  *    *          *                           *                   *
--  *    *          *     *                 *   *          *        *
--  *   *     *** ******  * **  ****      ***   * *      * *****    * ***
--  *  **    *  *   *     **   *   **   **  *   *  *    * **   **   **   *
--  ***     *****   *     *   *     *  *    *   *  *   **  *    *   *    *
--  *       *       *     *   *     *  *    *   *   *  *   *    *   *    *
--  *       *       *     *   *     *  *    *   *   * **   *   *    *    *
--  *       **       *    *   **   *   **   *   *    **    *  *     *   *
-- **        ****     **  *    ****     *****   *    **    ***      *   *
--                                          *        *     *
--                                          *        *     *
--                                          *       *      *
--                                      *  *        *      *
--                                      ****       *       *
--
--/////////////////////////////////////////////////////////////////////////////////////////////////
-- C O N F I D E N T I A L   S O U R C E   C O D E -- D O   N O T   D I S T R I B U T E
--/////////////////////////////////////////////////////////////////////////////////////////////////
--
--              $File: //depot/Projects/StarWars_Steam/FOC/Run/Data/Scripts/GameObject/UM02_DroidCrate.lua $
--
--    Original Author: James Yarrow
--
--            $Author: Brian_Hayes $
--
--            $Change: 637819 $
--
--          $DateTime: 2017/03/22 10:16:16 $
--
--          $Revision: #1 $
--
--/////////////////////////////////////////////////////////////////////////////////////////////////

require("PGStateMachine")
require("JGS_FunctionLib") -- added library of commonly used functions


function Definitions()

   -- Object isn't valid at this point so don't do any operations that
   -- would require it.  State_Init is the first chance you have to do
   -- operations on Object
   
	DebugMessage("%s -- In Definitions", tostring(Script))
	Define_State("State_Init", State_Init);
	player=nil
end


function State_Init(message)

	if message == OnEnter then
		-- Register a prox event that looks for any nearby units
		empire_player = Find_Player("Empire")
		underworld_player = Find_Player("Underworld")
		Register_Prox(Object, Unit_Prox, 150, nil)
	elseif message == OnUpdate then
		-- Do nothing
	elseif message == OnExit then
		-- Do nothing
	end

end

function Unit_Prox(self_obj, trigger_obj)

	if not trigger_obj then
		DebugMessage("Warning: prox received a nil trigger_obj.")
		return
	end
	if trigger_obj.Get_Owner() == underworld_player then
		last_droid = Create_Generic_Object("Destroyer_Droid",Object.Get_Position(),empire_player)
		Create_Thread("Hunt_Underworld",{last_droid})
		self_obj.Take_Damage(10000) 
		-- self_obj.Despawn()
	end
	
end