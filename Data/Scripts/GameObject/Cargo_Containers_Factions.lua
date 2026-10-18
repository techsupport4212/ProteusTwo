require("PGStateMachine")
require("PGStoryMode")
require("TRCommands")

function Definitions()
	Define_State("State_Init", State_Init)
end

function State_Init(message)
	if message == OnEnter then
		if Get_Game_Mode() ~= "Land" then
			ScriptExit()
		end	

		p_newrep = Find_Player("Rebel")
		p_empire = Find_Player("Empire")
		p_pentastar = Find_Player("Pentastar")
		p_zsinj = Find_Player("Zsinj_Empire")
		p_eriadu = Find_Player("Eriadu_Authority")
		p_maldrood = Find_Player("Greater_Maldrood")
		p_hapans = Find_Player("Hapes_Consortium")
		p_eoth = Find_Player("EmpireoftheHand")
		p_csa = Find_Player("Corporate_Sector")
		p_hutts = Find_Player("Hutt_Cartels")
		p_imperial_proteus = Find_Player("Imperial_Proteus")
		p_proteus_two = Find_Player("Proteus_Two")

		if EvaluatePerception("Is_Defender", p_newrep) == 1 then
			Hide_Sub_Object(Object, 1, "Container_Ridges_Generic")	 --Nothing
			Hide_Sub_Object(Object, 0, "Container_Ridges_NewRepublic") --New Republic
			Hide_Sub_Object(Object, 1, "Container_Ridges_Empire") --Imperials
			Hide_Sub_Object(Object, 1, "Container_Ridges_Hapan") --Hapes Consortium
			Hide_Sub_Object(Object, 1, "Container_Ridges_Chiss") --Empire of the Hand
			Hide_Sub_Object(Object, 1, "Container_Ridges_CSA") --CSA
		elseif EvaluatePerception("Is_Defender", p_empire) == 1 or EvaluatePerception("Is_Defender", p_empire) == 1 or EvaluatePerception("Is_Defender", p_zsinj) == 1 or EvaluatePerception("Is_Defender", p_maldrood) == 1 or EvaluatePerception("Is_Defender", p_pentastar) == 1 or EvaluatePerception("Is_Defender", p_imperial_proteus) == 1 or EvaluatePerception("Is_Defender", p_proteus_two) == 1 then
			Hide_Sub_Object(Object, 1, "Container_Ridges_Generic")	 --Nothing
			Hide_Sub_Object(Object, 1, "Container_Ridges_NewRepublic") --New Republic
			Hide_Sub_Object(Object, 0, "Container_Ridges_Empire") --Imperials
			Hide_Sub_Object(Object, 1, "Container_Ridges_Hapan") --Hapes Consortium
			Hide_Sub_Object(Object, 1, "Container_Ridges_Chiss") --Empire of the Hand
			Hide_Sub_Object(Object, 1, "Container_Ridges_CSA") --CSA
		elseif EvaluatePerception("Is_Defender", p_hapans) == 1 then
			Hide_Sub_Object(Object, 1, "Container_Ridges_Generic")	 --Nothing
			Hide_Sub_Object(Object, 1, "Container_Ridges_NewRepublic") --New Republic
			Hide_Sub_Object(Object, 1, "Container_Ridges_Empire") --Imperials
			Hide_Sub_Object(Object, 0, "Container_Ridges_Hapan") --Hapes Consortium
			Hide_Sub_Object(Object, 1, "Container_Ridges_Chiss") --Empire of the Hand
			Hide_Sub_Object(Object, 1, "Container_Ridges_CSA") --CSA
		elseif EvaluatePerception("Is_Defender", p_hutts) == 1 then
			Hide_Sub_Object(Object, 1, "Container_Ridges_Generic")	 --Nothing
			Hide_Sub_Object(Object, 1, "Container_Ridges_NewRepublic") --New Republic
			Hide_Sub_Object(Object, 1, "Container_Ridges_Empire") --Imperials
			Hide_Sub_Object(Object, 1, "Container_Ridges_Hapan") --Hapes Consortium
			Hide_Sub_Object(Object, 1, "Container_Ridges_Chiss") --Empire of the Hand
			Hide_Sub_Object(Object, 1, "Container_Ridges_CSA") --CSA
		elseif EvaluatePerception("Is_Defender", p_eoth) == 1 then
			Hide_Sub_Object(Object, 1, "Container_Ridges_Generic")	 --Nothing
			Hide_Sub_Object(Object, 1, "Container_Ridges_NewRepublic") --New Republic
			Hide_Sub_Object(Object, 1, "Container_Ridges_Empire") --Imperials
			Hide_Sub_Object(Object, 1, "Container_Ridges_Hapan") --Hapes Consortium
			Hide_Sub_Object(Object, 0, "Container_Ridges_Chiss") --Empire of the Hand
			Hide_Sub_Object(Object, 1, "Container_Ridges_CSA") --CSA
		elseif EvaluatePerception("Is_Defender", p_csa) == 1 then
			Hide_Sub_Object(Object, 1, "Container_Ridges_Generic")	 --Nothing
			Hide_Sub_Object(Object, 1, "Container_Ridges_NewRepublic") --New Republic
			Hide_Sub_Object(Object, 1, "Container_Ridges_Empire") --Imperials
			Hide_Sub_Object(Object, 1, "Container_Ridges_Hapan") --Hapes Consortium
			Hide_Sub_Object(Object, 1, "Container_Ridges_Chiss") --Empire of the Hand
			Hide_Sub_Object(Object, 0, "Container_Ridges_CSA") --CSA
		else
			Hide_Sub_Object(Object, 0, "Container_Ridges_Generic")	 --Nothing
			Hide_Sub_Object(Object, 1, "Container_Ridges_NewRepublic") --New Republic
			Hide_Sub_Object(Object, 1, "Container_Ridges_Empire") --Imperials
			Hide_Sub_Object(Object, 1, "Container_Ridges_Hapan") --Hapes Consortium
			Hide_Sub_Object(Object, 1, "Container_Ridges_Chiss") --Empire of the Hand
			Hide_Sub_Object(Object, 1, "Container_Ridges_CSA") --CSA
		end
		ScriptExit()
	end
end
