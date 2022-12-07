--------------------------------------------------------------------------------
-- DEPENDENCIES
--------------------------------------------------------------------------------

local m_defsave = require "defsave.defsave"
local m_utility = require "modules.utility"

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
		text_speed = 45,
		text_fade = 0,
		music_volume = 0,
		sound_volume = 0,
		fullscreen = false
	},
	profile =
	{
		map_id = 1,
		tile_x = 12,
		tile_y = 8,
		direction = 3,
		inventory =
		{
			{ key = "stick", count = 1 },
			{ key = "apple", count = 2 },
			{ key = "stick", count = 1 },
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false,
			false
		},
		party =
		{
			{
				key = "klayton",
				health_level = 10,
				strength_level = 2,
				defense_level = 1,
				agility_level = 1,
				wonder_level = 1,
				terra_level = 1,
				health_equipment = 2,
				strength_equipment = 2,
				defense_equipment = 1,
				agility_equipment = 0,
				wonder_equipment = 0,
				terra_equipment = 0,
				health_buffer = 0,
				strength_buffer = 0,
				defense_buffer = 0,
				agility_buffer = 0,
				wonder_buffer = 0,
				terra_buffer = 0,
				health_total = 11,
				strength_total = 4,
				defense_total = 2,
				agility_total = 1,
				wonder_total = 1,
				terra_total = 1,
				health_current = 10,
				strength_current = 4,
				defense_current = 2,
				agility_current = 1,
				wonder_current = 1,
				terra_current = 1,
				hands_key = false,
				head_key = false,
				torso_key = false,
				trunk_key = false,
				feet_key = false,
				ring_key = false,
				bracelet_key = false,
				necklace_key = false
			},
			false,
			false
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

function p_persist.get_text_speed()
	return m_defsave.get("settings", "text_speed")
end

function p_persist.set_text_speed(speed)
	m_defsave.set("settings", "text_speed", speed)
	m_defsave.save("settings")
end

function p_persist.get_text_fade()
	return m_defsave.get("settings", "text_fade")
end

function p_persist.set_text_fade(fade)
	m_defsave.set("settings", "text_fade", fade)
	m_defsave.save("settings")
end

function p_persist.get_fullscreen()
	return m_defsave.get("settings", "fullscreen")
end

function p_persist.set_fullscreen(flag)
	m_defsave.set("settings", "fullscreen", flag)
	m_defsave.save("settings")
end

function p_persist.get_music_volume()
	return m_defsave.get("settings", "music")
end

function p_persist.set_music_volume(volume)
	volume = m_utility.clamp(volume, 0, 100)
	m_defsave.set("settings", "music", volume)
	m_defsave.save("settings")
end

function p_persist.get_sound_volume()
	return m_defsave.get("settings", "sound")
end

function p_persist.set_sound_volume(volume)
	volume = m_utility.clamp(volume, 0, 100)
	m_defsave.set("settings", "sound", volume)
	m_defsave.save("settings")
end

function p_persist.save_profile()
	m_defsave.save("profile")
end

function p_persist.get_location()
	return
	{
		map_id = m_defsave.get("profile", "map_id"),
		tile_x = m_defsave.get("profile", "tile_x"),
		tile_y = m_defsave.get("profile", "tile_y")
	}
end

function p_persist.set_location(map_id, tile_x, tile_y)
	m_defsave.set("profile", "map_id", map_id)
	m_defsave.set("profile", "tile_x", tile_x)
	m_defsave.set("profile", "tile_y", tile_y)
end

function p_persist.get_inventory()
	return m_defsave.get("profile", "inventory")
end

function p_persist.get_inventory_section_count()
	local inventory = m_defsave.get("profile", "inventory")
	return math.floor(#inventory / 12)
end

function p_persist.set_inventory_item(inventory_index, item_key, item_count)
	local inventory = m_defsave.get("profile", "inventory")
	if inventory[inventory_index] then
		local item = inventory[inventory_index]
		item.key = item_key
		item.count = item_count
	else
		local item = { key = item_key, count = item_count }
		inventory[inventory_index] = item
	end
	m_defsave.set("profile", "inventory", inventory)
end

function p_persist.set_inventory_item_count(inventory_index, item_count)
	local inventory = m_defsave.get("profile", "inventory")
	if item_count > 0 then
		local item = inventory[inventory_index]
		item.count = item_count
	else
		inventory[inventory_index] = false
	end
	m_defsave.set("profile", "inventory", inventory)
end

function p_persist.swap_inventory_items(index_1, index_2)
	local inventory = m_defsave.get("profile", "inventory")
	m_utility.swap(inventory, index_1, index_2)
	m_defsave.set("profile", "inventory", inventory)
end

function p_persist.get_party()
	return m_defsave.get("profile", "party")
end

function p_persist.set_party_stat(party_index, stat_key, stat_suffix, stat_value)
	local party = m_defsave.get("profile", "party")
	local player = party[party_index]
	player[stat_key .. stat_suffix] = stat_value
	m_defsave.set("profile", "party", party)
end

function p_persist.set_party_equipment(party_index, equip_key, item_key)
	local party = m_defsave.get("profile", "party")
	local player = party[party_index]
	player[equip_key .. "_key"] = item_key
	m_defsave.set("profile", "party", party)
end

return p_persist