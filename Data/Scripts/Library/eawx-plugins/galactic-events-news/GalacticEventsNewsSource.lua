require("deepcore/std/class")
require("deepcore/std/Observable")

CONSTANTS = ModContentLoader.get("GameConstants")

---@class GalacticEventsNewsSource : Observable
GalacticEventsNewsSource = class(Observable)

---@param planet_owner_changed_event PlanetOwnerChangedEvent
function GalacticEventsNewsSource:new(
    planet_owner_changed_event,
    galactic_hero_killed_event,
    galactic_ssd_killed_event,
    galactic_ssd_damaged_event,
    galactic_ssd_repaired_event,
    incoming_fleet_event,
    blockade_attrition_unit_killed,
    influence_unrest_growing,
    influence_revolt_occured,
    structure_swap_warning,
    structure_swapped,
    no_taxes_warning,
    infrastructure_entered,
    victory_handler_shipyards_available,
    victory_handler_conquest_available
    )

    planet_owner_changed_event:attach_listener(self.on_planet_owner_changed, self)
    galactic_hero_killed_event:attach_listener(self.on_galactic_hero_killed, self)
    galactic_ssd_killed_event:attach_listener(self.on_galactic_ssd_killed, self)
    galactic_ssd_damaged_event:attach_listener(self.on_galactic_ssd_damaged, self)
    galactic_ssd_repaired_event:attach_listener(self.on_galactic_ssd_repaired, self)
    incoming_fleet_event:attach_listener(self.on_incoming_fleet, self)
    blockade_attrition_unit_killed:attach_listener(self.on_blockade_unit_killed, self)
    influence_unrest_growing:attach_listener(self.on_unrest_growing, self)
    influence_revolt_occured:attach_listener(self.on_revolt_occured, self)
    structure_swap_warning:attach_listener(self.on_structure_swap_warning, self)
    structure_swapped:attach_listener(self.on_structure_swapped, self)
    no_taxes_warning:attach_listener(self.no_taxes_warning, self)
    infrastructure_entered:attach_listener(self.on_infrastructure_entered, self)
    victory_handler_shipyards_available:attach_listener(self.on_shipyard_victory_available, self)
    victory_handler_conquest_available:attach_listener(self.on_conquest_victory_available, self)

    crossplot:subscribe("FACTION_DISPLAY_NAME_CHANGE", self.faction_display_name_change, self)
    self.first_planet_conquest = false
end

---@param planet Planet
---@param new_owner_name string (must be XML faction name)
function GalacticEventsNewsSource:on_planet_owner_changed(planet,new_owner_name)
    --Logger:trace("entering GalacticEventsNewsSource:on_planet_owner_changed")
    if self.first_planet_conquest == false or new_owner_name == "PROTEUS_TWO" then
        local display_name_variable = "PROTEUS_CURRENT_DISPLAY_NAME"
        if new_owner_name == "PROTEUS_TWO" then
            display_name_variable = "PROTEUS_TWO_CURRENT_DISPLAY_NAME"
        end

        local proteus_current_display_name = GlobalValue.Get(display_name_variable)
        if proteus_current_display_name and CONSTANTS.ALL_FACTION_NAMES[new_owner_name] == "REPORT_THIS_PROTEUS_BUG_B" then
            self:faction_display_name_change(new_owner_name, proteus_current_display_name)
        end
        self.first_planet_conquest = true
    end

    self:notify {
        headline = CONSTANTS.ALL_FACTION_NAMES[new_owner_name] .. " has conquered " .. planet:get_readable_name(),
        var = nil,
        color = CONSTANTS.FACTION_COLORS[new_owner_name]
    }
end

---@param hero_name string
---@param owner_name string (must be XML faction name)
function GalacticEventsNewsSource:on_galactic_hero_killed(hero_name, owner_name)
    --Logger:trace("entering GalacticEventsNewsSource:on_galactic_hero_killed")
    if hero_name == "DARK_EMPIRE_CLONING_FACILITY" then
        self:notify {
            headline = "The Emperor's Cloning Facility has been destroyed – and with it, the Emperor!",
            color = {r = 255, g = 0, b = 0}
        }
        return
    end

    self:notify {
        headline = "TEXT_NEWS_HERO_KILLED_GALACTIC",
        var = Find_Object_Type(hero_name),
        color = CONSTANTS.FACTION_COLORS[owner_name]
    }
end

---@param short_name string
---@param owner_name string (must be XML faction name)
function GalacticEventsNewsSource:on_galactic_ssd_killed(short_name, owner_name)
    --Logger:trace("entering GalacticEventsNewsSource:on_galactic_ssd_killed")
    self:notify {
        headline = CONSTANTS.ALL_FACTION_NAMES[owner_name] .. "'s "..short_name.." has been destroyed!",
        var = nil,
        color = CONSTANTS.FACTION_COLORS[owner_name]
    }
end

---@param short_name string
---@param new_health number
function GalacticEventsNewsSource:on_galactic_ssd_damaged(short_name, new_health)
    --Logger:trace("entering GalacticEventsNewsSource:on_galactic_ssd_repaired")
    local text = "Your "..short_name.." has been damaged and has "..tostring(new_health).."% hull left"

    self:notify {
        headline = text,
        var = nil,
        color = {r = 255, g = 255, b = 255}
    }
end

---@param short_name string
---@param new_health number
---@param heal_fee number
function GalacticEventsNewsSource:on_galactic_ssd_repaired(short_name, new_health, heal_fee)
    --Logger:trace("entering GalacticEventsNewsSource:on_galactic_ssd_repaired")
    local text = "Your "..short_name.." has been repaired to "..tostring(new_health).."% hull for "..tostring(heal_fee).." credits"

    self:notify {
        headline = text,
        var = nil,
        color = {r = 255, g = 255, b = 255}
    }
end

---@param planet Planet
function GalacticEventsNewsSource:on_incoming_fleet(planet)
    if not planet:get_owner().Is_Human() then
        return
    end
    --Logger:trace("entering GalacticEventsNewsSource:on_incoming_fleet")
    self:notify {
        headline = "TEXT_NEWS_ENEMY_FLEET_INCOMING",
        duration = 20,
        var = planet:get_game_object(),
        color = {r = 255, g = 0, b = 0}
    }
end

---@param planet Planet
---@param unit_owner_name string (must be XML faction name)
function GalacticEventsNewsSource:on_blockade_unit_killed(planet, unit, unit_owner_name)
    if not Find_Player(unit_owner_name).Is_Human() then
        return
    end
    --Logger:trace("entering GalacticEventsNewsSource:on_blockade_unit_killed")
    self:notify {
        headline = "%s has been destroyed by a ground-to-space cannon over " .. tostring(planet:get_readable_name()),
        duration = 20,
        var = unit.Get_Type(),
        color = {r = 255, g = 0, b = 0}
    }
end

---@param planet Planet
---@param unrest number
function GalacticEventsNewsSource:on_unrest_growing(planet, unrest)
    --Logger:trace("entering GalacticEventsNewsSource:on_unrest_growing")
    self:notify {
        headline = "Unrest has grown on " .. tostring(planet:get_readable_name()) .." to "..tostring(unrest),
        duration = 20,
        var = planet:get_game_object(),
        color = {r = 255, g = 0, b = 0}
    }
end

---@param planet Planet
function GalacticEventsNewsSource:on_revolt_occured(planet)
    --Logger:trace("entering GalacticEventsNewsSource:on_revolt_occured")
    self:notify {
        headline = "A revolt has occured on ".. tostring(planet:get_readable_name()),
        duration = 20,
        var = planet:get_game_object(),
        color = {r = 255, g = 0, b = 0}
    }
end

---@param planet Planet
---@param new_structure string
---@param structure_type string
function GalacticEventsNewsSource:on_structure_swap_warning(planet, new_structure, structure_type)
    --Logger:trace("entering GalacticEventsNewsSource:on_structure_swap_warning")
    self:notify {
        headline = "Queued "..structure_type.." category station will replace an existing %s on ".. tostring(planet:get_readable_name()),
        duration = 20,
        var = Find_Object_Type(new_structure),
        color = {r = 255, g = 255, b = 255}
    }
end

---@param planet Planet
function GalacticEventsNewsSource:no_taxes_warning(planet)
    --Logger:trace("entering GalacticEventsNewsSource:no_taxes_warning")
    self:notify {
        headline = "Queued Tax Agency on "..tostring(planet:get_readable_name()).." will provide no income",
        duration = 20,
        var = nil,
        color = {r = 255, g = 255, b = 100}
    }
end

---@param planet Planet
---@param new_structure string
---@param structure_type string
function GalacticEventsNewsSource:on_structure_swapped(planet, new_structure, structure_type)
    --Logger:trace("entering GalacticEventsNewsSource:on_structure_swapped")
    self:notify {
        headline = "A new %s has replaced an existing structure of the "..structure_type.." category on ".. tostring(planet:get_readable_name()),
        duration = 20,
        var = Find_Object_Type(new_structure),
        color = {r = 255, g = 255, b = 255}
    }
end

---@param status string
function GalacticEventsNewsSource:on_infrastructure_entered(status)
    --Logger:trace("entering GalacticEventsNewsSource:on_deficit_entered")
    local messages = {
        ["INFRASTRUCTURE_DEFICIT_SEVERE"] = {
            "TEXT_INFRASTRUCTURE_DEFICIT_SEVERE",
            {r = 255, g = 0, b = 0}
        },
        ["INFRASTRUCTURE_DEFICIT_SMALL"] = {
            "TEXT_INFRASTRUCTURE_DEFICIT_SMALL",
            {r = 255, g = 0, b = 0}
        },
        ["INFRASTRUCTURE_NORMAL"] = {
            "TEXT_INFRASTRUCTURE_NORMAL",
            {r = 255, g = 255, b = 255}
        },
        ["INFRASTRUCTURE_SURPLUS"] = {
            "TEXT_INFRASTRUCTURE_SURPLUS",
            {r = 0, g = 255, b = 0}
        },
        ["CHEAT_DUMMY_INFRA_AND_DISCOUNT"] = {
            "TEXT_CHEAT_DUMMY_INFRA_AND_DISCOUNT",
            {r = 217, g = 2, b = 125}
        },
    }

    --infrastructure notices from debug dummies handled in OptionsHandler
    if messages[status] == nil then
        return
    end

    local headline = messages[status][1]
    local color = messages[status][2]

    self:notify {
        headline = headline,
        duration = 20,
        var = nil,
        color = color
    }
end

function GalacticEventsNewsSource:on_shipyard_victory_available()
    --Logger:trace("entering GalacticEventsNewsSource:on_shipyard_victory_available")
    self:notify {
        headline = "Your faction has conquered all major shipyards – you may declare victory from the political options tab",
        duration = 80,
        var = nil,
        color = {r = 255, g = 255, b = 100}
    }
end

function GalacticEventsNewsSource:on_conquest_victory_available()
    --Logger:trace("entering GalacticEventsNewsSource:on_conquest_victory_available")
    self:notify {
        headline =  "You have defeated all opponents – you may declare victory from the political options tab",
        duration = 80,
        var = nil,
        color = {r = 255, g = 255, b = 100}
    }
end

---@param player_name string (must be XML faction name)
---@param new_display_name string
---@param new_particle string (must be XML particle name)
function GalacticEventsNewsSource:faction_display_name_change(player_name, new_display_name, new_particle)
    if new_display_name then
        CONSTANTS.ALL_FACTION_TEXTS[player_name] = new_display_name
        CONSTANTS.ALL_FACTION_NAMES[player_name] = new_display_name
    end

    if new_particle then
        CONSTANTS.PARTICLES[player_name] = new_particle
    end
end
