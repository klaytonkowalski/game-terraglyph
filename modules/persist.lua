--------------------------------------------------------------------------------
-- DEPENDENCIES
--------------------------------------------------------------------------------

local m_defsave = require "defsave.defsave"

--------------------------------------------------------------------------------
-- PROPERTIES
--------------------------------------------------------------------------------

local p_persist = {}

--------------------------------------------------------------------------------
-- CONSTANTS
--------------------------------------------------------------------------------

local c_default_data =
{
	settings =
	{
		music = 0,
		sound = 0,
		fullscreen = false
	},
	profile =
	{
		map_id = 1,
		tile_x = 12,
		tile_y = 8,
		inventory =
		{
			[1] = { key = "stick", count = 1 },
			[2] = { key = "apple", count = 2 },
			[3] = false,
			[4] = false,
			[5] = false,
			[6] = false,
			[7] = false,
			[8] = false,
			[9] = false,
			[10] = false,
			[11] = false,
			[12] = false
		},
		party =
		{
			[1] =
			{
				key = 1,
				name = "Klayton",
				damage = 6,
				health_level = 10,
				strength_level = 1,
				defense_level = 2,
				agility_level = 1,
				wonder_level = 2,
				terra_level = 1,
				health_buffer = 1,
				strength_buffer = 0,
				defense_buffer = 0,
				agility_buffer = 0,
				wonder_buffer = 0,
				terra_buffer = 0,
				hands_key = false,
				head_key = false,
				torso_key = false,
				trunk_key = false,
				feet_key = false,
				ring_key = false,
				bracelet_key = false,
				necklace_key = false
			},
			[2] =
			{
				key = 1,
				name = "Bosco",
				damage = 2,
				health_level = 5,
				strength_level = 2,
				defense_level = 1,
				agility_level = 2,
				wonder_level = 1,
				terra_level = 1,
				health_buffer = 0,
				strength_buffer = 0,
				defense_buffer = 0,
				agility_buffer = 0,
				wonder_buffer = 0,
				terra_buffer = 0,
				hands_key = false,
				head_key = false,
				torso_key = false,
				trunk_key = false,
				feet_key = false,
				ring_key = false,
				bracelet_key = false,
				necklace_key = false
			},
			[3] = false
		}
	}
}

--------------------------------------------------------------------------------
-- MODULE FUNCTIONS
--------------------------------------------------------------------------------

function p_persist.init()
	m_defsave.set_appname("Terraglyph")
	m_defsave.default_data = c_default_data
	m_defsave.load("settings")
	m_defsave.load("profile")
	m_defsave.save_all()
end

function p_persist.set_fullscreen(flag)
	m_defsave.set("settings", "fullscreen", flag)
	m_defsave.save("settings")
end

function p_persist.get_fullscreen()
	return m_defsave.get("settings", "fullscreen")
end

function p_persist.get_continue_data()
	return
	{
		map_id = m_defsave.get("profile", "map_id"),
		tile_x = m_defsave.get("profile", "tile_x"),
		tile_y = m_defsave.get("profile", "tile_y")
	}
end

function p_persist.get_inventory()
	return m_defsave.get("profile", "inventory")
end

function p_persist.get_party()
	return m_defsave.get("profile", "party")
end

function p_persist.set_player_equipment(party_index, item_category, item_key)
	local party = m_defsave.get("profile", "party")
	local player = party[party_index]
	player[item_category .. "_key"] = item_key
	m_defsave.set("profile", "party", party)
	m_defsave.save("profile")
end

return p_persist