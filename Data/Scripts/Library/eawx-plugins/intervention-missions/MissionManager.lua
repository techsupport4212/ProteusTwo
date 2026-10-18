require("deepcore/std/class")
require("eawx-plugins/intervention-missions/MissionHandlerHuman")
require("eawx-plugins/intervention-missions/MissionHandlerAI")

---@class MissionManager
MissionManager = class()

function MissionManager:new(gc, id)
	local is_ftgu = false
	if id == "FTGU" or GlobalValue.Get("PROGRESSIVE_INFINITY") then
		is_ftgu = true
	end

	self.p_eoth = Find_Player("Empireofthehand")
	self.p_hapes = Find_Player("Hapes_Consortium")
	self.p_hutts = Find_Player("Hutt_Cartels")
	self.p_newrep = Find_Player("Rebel")
	self.p_empire = Find_Player("Empire")
	self.p_eriadu = Find_Player("Eriadu_Authority")
	self.p_maldrood = Find_Player("Greater_Maldrood")
	self.p_pentastar = Find_Player("Pentastar")
	self.p_zsinj = Find_Player("Zsinj_Empire")
	self.p_proteus = Find_Player("Imperial_Proteus")
	self.p_proteus_two = Find_Player("Proteus_Two")

	self.p_human = Find_Player("local")

	if self.p_human == self.p_eoth then
		self.EotHMissions = MissionHandlerHuman(gc,self.p_eoth,is_ftgu)
	-- else
		-- self.EotHMissions = MissionHandlerAI(gc,self.p_eoth)
	end

	if self.p_human == self.p_hapes then
		self.HapesMissions = MissionHandlerHuman(gc,self.p_hapes,is_ftgu)
	-- else
		-- self.HapesMissions = MissionHandlerAI(gc,self.p_hapes)
	end

	if self.p_human == self.p_hutts then
		self.HuttMissions = MissionHandlerHuman(gc,self.p_hutts,is_ftgu)
	-- else
		-- self.HuttMissions = MissionHandlerAI(gc,self.p_hutts)
	end

	if self.p_human == self.p_newrep then
		self.NewRepMissions = MissionHandlerHuman(gc,self.p_newrep,is_ftgu)
	-- else
		-- self.NewRepMissions = MissionHandlerAI(gc,self.p_newrep)
	end

	if self.p_human == self.p_empire then
		self.EmpireMissions = MissionHandlerHuman(gc,self.p_empire,is_ftgu)
	-- else
		-- self.EmpireMissions = MissionHandlerAI(gc,self.p_empire)
	end

	if self.p_human == self.p_eriadu then
		self.EriaduMissions = MissionHandlerHuman(gc,self.p_eriadu,is_ftgu)
	-- else
		-- self.EriaduMissions = MissionHandlerAI(gc,self.p_eriadu)
	end

	if self.p_human == self.p_maldrood then
		self.MaldroodMissions = MissionHandlerHuman(gc,self.p_maldrood,is_ftgu)
	-- else
		-- self.MaldroodMissions = MissionHandlerAI(gc,self.p_maldrood)
	end

	if self.p_human == self.p_pentastar then
		self.PentastarMissions = MissionHandlerHuman(gc,self.p_pentastar,is_ftgu)
	-- else
		-- self.PentastarMissions = MissionHandlerAI(gc,self.p_pentastar)
	end

	if self.p_human == self.p_zsinj then
		self.ZsinjMissions = MissionHandlerHuman(gc,self.p_zsinj,is_ftgu)
	-- else
		-- self.ZsinjMissions = MissionHandlerAI(gc,self.p_zsinj)
	end
	
	if self.p_human == self.p_proteus then
		self.ProteusMissions = MissionHandlerHuman(gc,self.p_proteus,is_ftgu)
	-- else
		-- self.Imperial_ProteusMissions = MissionHandlerAI(gc,self.p_proteus)
	end

	if self.p_human == self.p_proteus_two then
		self.ProteusMissions = MissionHandlerHuman(gc,self.p_proteus_two,is_ftgu)
	-- else
		-- self.Imperial_ProteusMissions = MissionHandlerAI(gc,self.p_proteus)
	end
end

function MissionManager:update()
	--Logger:trace("entering MissionManager:Update")

	if self.p_human == self.p_eoth then
		self.EotHMissions:update()
	end

	if self.p_human == self.p_hapes then
		self.HapesMissions:update()
	end

	if self.p_human == self.p_hutts then
		self.HuttMissions:update()
	end

	if self.p_human == self.p_newrep then
		self.NewRepMissions:update()
	end

	if self.p_human == self.p_empire then
		self.EmpireMissions:update()
	end

	if self.p_human == self.p_eriadu then
		self.EriaduMissions:update()
	end

	if self.p_human == self.p_maldrood then
		self.MaldroodMissions:update()
	end

	if self.p_human == self.p_pentastar then
		self.PentastarMissions:update()
	end

	if self.p_human == self.p_zsinj then
		self.ZsinjMissions:update()
	end
	
	if self.p_human == self.p_proteus then
		self.ProteusMissions:update()
	end

	if self.p_human == self.p_proteus_two then
		self.ProteusMissions:update()
	end

end

return MissionManager
