-- ============================================================================
-- STAR WARS: Empire at War - Forces of Corruption Unofficial Patch Source File
-- Original Author: cha20202
--			Author: cha20202
--			Date:   11-05-2026
--		Revision:   1
-- ============================================================================
require("PGStoryMode")

function Definitions()
    DebugMessage("%s -- In Definitions", tostring(Script))
    StoryModeEvents =
    {
        Universal_Story_Start = Universal_Story_Start
    }
    ds_active = false
    death_star_object = nil
end

function Story_Mode_Service()
    if not ds_active then
        death_star_list = Find_All_Objects_Of_Type("Death_Star_II")
        if death_star_list then
            for k, object in pairs(death_star_list) do
                if TestValid(object) then
                    death_star_object = object
                    ds_active = true
                    break
                end
            end
        end
    end

    if ds_active then
        death_star_fleet = death_star_object.Get_Parent_Object()
        if not TestValid(death_star_fleet) then
            Story_Event("Death_Star_Destroyed")
            ScriptExit()
        end
    end
end