local defsave = require "defsave.defsave"

local persist = {}

local default_data =
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
			[2] = { key = "stick", count = 1 },
			[3] = false,
			[4] = false,
			[5] = false,
			[6] = false,
			[7] = false,
			[8] = false,
			[9] = { key = "stick", count = 1 },
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
				health_total = 12,
				health_equipment = 12,
				health_level = 12,
				strength_total = 1,
				strength_equipment = 1,
				strength_level = 1,
				defense_total = 2,
				defense_equipment = 2,
				defense_level = 2,
				agility_total = 2,
				agility_equipment = 2,
				agility_level = 2,
				wonder_total = 1,
				wonder_equipment = 1,
				wonder_level = 1,
				terra_total = 1,
				terra_equipment = 1,
				terra_level = 1
			},
			[2] =
			{
				key = 1,
				name = "Bosco",
				health_total = 8,
				health_equipment = 8,
				health_level = 8,
				strength_total = 3,
				strength_equipment = 3,
				strength_level = 3,
				defense_total = 1,
				defense_equipment = 1,
				defense_level = 1,
				agility_total = 1,
				agility_equipment = 1,
				agility_level = 1,
				wonder_total = 3,
				wonder_equipment = 3,
				wonder_level = 3,
				terra_total = 1,
				terra_equipment = 1,
				terra_level = 1
			},
			[3] = false
		}
	}
}

function persist.init()
	defsave.set_appname("Terraglyph")
	defsave.default_data = default_data
	defsave.load("settings")
	defsave.load("profile")
	defsave.save_all()
end

function persist.set_fullscreen(flag)
	defsave.set("settings", "fullscreen", flag)
	defsave.save("settings")
end

function persist.get_fullscreen()
	return defsave.get("settings", "fullscreen")
end

function persist.get_continue_data()
	return
	{
		map_id = defsave.get("profile", "map_id"),
		tile_x = defsave.get("profile", "tile_x"),
		tile_y = defsave.get("profile", "tile_y")
	}
end

function persist.get_inventory()
	return defsave.get("profile", "inventory")
end

function persist.get_party()
	return defsave.get("profile", "party")
end

return persist