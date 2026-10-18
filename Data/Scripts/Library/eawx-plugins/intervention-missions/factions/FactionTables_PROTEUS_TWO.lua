return {
	Missions = {
		["BUILDSTRUCTURESGROUND"] = {difficulty = 2, active = false, chance = 12},
		["BUILDSTRUCTURESSPACE"] = {difficulty = 2, active = false, chance = 12},
		["CREDITINCOME"] = {difficulty = 1, active = false, chance = 4},
		["CREWINCOME"] = {difficulty = 1, active = false, chance = 4},
		["HUNTTARGETA"] = {difficulty = 2, active = false, chance = 12},
		["HUNTTARGETB"] = {difficulty = 2, active = false, chance = 12},
		--["RAISE_INFLUENCE"] = {difficulty = 2, active = false, chance = 8},
		["RAISEINFRASTRUCTURE"] = {difficulty = 2, active = false, chance = 8},
		["RECON"] = {difficulty = 1, active = false, chance = 12},
		["TAKEPLANETANY"] = {difficulty = 3, active = false, chance = 12},
		["TAKEPLANETENEMY"] = {difficulty = 3, active = false, chance = 12},
	},
	RewardGroups = {
		"IMPERIAL_PROTEUS",
		"IMPERIAL_PROTEUS",
		"IMPERIAL_PROTEUS",
		"IMPERIAL_PROTEUS",
		"PDF"
	},
	RewardGroupDetails = {
		["IMPERIAL_PROTEUS"] = {
			DialogName = "IMPERIAL_PROTEUS",
			RewardName = "ERA",
			GroupSupport = "LEGITIMACY",
			SupportArg = 1,
			SupportArgLoss = 1
		},
		["PDF"] = {
			DialogName = "PDF",
			RewardName = "PDF"
		}
	}
}
