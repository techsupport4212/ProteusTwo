require("PGBase")
require("PGStateMachine")
require("PGStoryMode")
require("PGSpawnUnits")
require("eawx-util/StoryUtil")
require("eawx-util/ChangeOwnerUtilities")

function Definitions()
	-- DebugMessage("%s -- In Definitions", tostring(Script))

	StoryModeEvents = {
		Trigger_Jump_Camera_Katana_Space    = State_Jump_Camera_Katana_Space,
		Trigger_Unlock_Katana_Space         = State_Unlock_Katana_Space,
		Trigger_Conquer_Katana_Space        = State_Conquer_Katana_Space,
	}
end

function State_Jump_Camera_Katana_Space(message)
	if message == OnEnter then
		local plot = Get_Story_Plot("Conquests\\Plot_Katana_Galactic.xml")
		local event = plot.Get_Event("Katana_Galactic_Intro_Speech")

		local human_name = string.upper(Find_Player("local").Get_Faction_Name())

		local loops = {
			["CHISS"]             = "Aralani_Loop",
			["CORELLIA"]          = "SalSolo_Loop",
			["CORPORATE_SECTOR"]  = "Grumby_Loop",
			["EMPIRE"]            = "Thrawn_Loop",
			["EMPIREOFTHEHAND"]   = "Parck_Loop",
			["ERIADU_AUTHORITY"]  = "Delvardus_Loop",
			["GREATER_MALDROOD"]  = "Treuten_Teradoc_Loop",
			["HAPES_CONSORTIUM"]  = "Isolder_Loop",
			["HUTT_CARTELS"]      = "Troonol_Loop",
			["KILLIK_HIVES"]      = "Saras_Loop",
			["PENTASTAR"]         = "Kaine_Loop",
			["REBEL"]             = "Karrde_Loop",
			["SSIRUUVI_IMPERIUM"] = "Ipvikkis_Loop",
			["YEVETHA"]           = "Spaar_Loop",
			["ZSINJ_EMPIRE"]      = "Zsinj_Loop",
			["IMPERIAL_PROTEUS"]  = "Imperial_Naval_Officer_Loop",
			["PROTEUS_TWO"]  = "Imperial_Naval_Officer_Loop",
		}

		event.Set_Reward_Parameter(0, "TEXT_CONQUEST_KATANA_EVENT_INTRO_"..human_name)
		event.Set_Reward_Parameter(8, loops[human_name])

		Story_Event("AI_NOTIF_KATANA_GALACTIC_INTRO_SPEECH")

		event = plot.Get_Event("Enter_Katana_Space")
		event.Set_Reward_Parameter(2, human_name)
	end
end

function State_Unlock_Katana_Space(message)
	if message == OnEnter then
		StoryUtil.SetPlanetRestricted("KATANA_SPACE", 0)
	end
end

function State_Conquer_Katana_Space(message)
	if message == OnEnter then
		local deepspace = FindPlanet("Katana_Space")
		local katana_winner = deepspace.Get_Owner()
		local katana_capture_count = GlobalValue.Get("KATANA_CAPTURES")

		--mercy
		if katana_capture_count == nil then
			katana_capture_count = 10
		elseif katana_capture_count < 10 then
			katana_capture_count = 10
		end

		local katana_spawns = {}
		for i = 1, katana_capture_count do
			table.insert(katana_spawns,"Katana_DHC")
		end

		SpawnList(katana_spawns, deepspace, katana_winner, true, false)

		if Find_Player("local") == katana_winner then
			Story_Event("AI_NOTIF_STORY_GOAL_KATANA_COMPLETED")
		else
			Story_Event("AI_NOTIF_STORY_GOAL_KATANA_REMOVE")
		end
	end
end
