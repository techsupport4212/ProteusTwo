require("PGStateMachine")
require("PGStoryMode")
require("eawx-util/MissionUtil")

function Definitions()
	Define_State("State_Init", State_Init)
end

function State_Init(message)
	if Get_Game_Mode() ~= "Land" then
		ScriptExit()
	end	

	local p_defender = MissionUtil.Find_Defending_Player()
	if not TestValid(p_defender) then
		ScriptExit()
	end

	if p_defender == Find_Player("Rebel") then
		Hide_Sub_Object(Object, 1, "banners")	 --Nothing
		Hide_Sub_Object(Object, 0, "banners_01") --New Republic
	end
	if p_defender == Find_Player("Empire")
	or p_defender == Find_Player("Pentastar") 
	or p_defender == Find_Player("Zsinj_Empire") 
	or p_defender == Find_Player("Eriadu_Authority") 
	or p_defender == Find_Player("Greater_Maldrood") 
	or p_defender == Find_Player("Proteus_Two")
	or p_defender == Find_Player("Imperial_Proteus") then
		Hide_Sub_Object(Object, 1, "banners")	 --Nothing
		Hide_Sub_Object(Object, 0, "banners_02") --Imperials
	end
	if p_defender == Find_Player("Hapes_Consortium") then
		Hide_Sub_Object(Object, 1, "banners")	 --Nothing
		Hide_Sub_Object(Object, 0, "banners_03") --Hapes Consortium
	end
	if p_defender == Find_Player("Hutt_Cartels") then
		Hide_Sub_Object(Object, 1, "banners")	 --Nothing
		Hide_Sub_Object(Object, 0, "banners_04") --Hutts
	end
	if p_defender == Find_Player("EmpireoftheHand") then
		Hide_Sub_Object(Object, 1, "banners")	 --Nothing
		Hide_Sub_Object(Object, 0, "banners_05") --Empire of the Hand
	end
	if p_defender == Find_Player("Corporate_Sector") then
		Hide_Sub_Object(Object, 1, "banners")	 --Nothing
		Hide_Sub_Object(Object, 0, "banners_06") --CSA
	end
	ScriptExit()
end
