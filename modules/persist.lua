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
			[1] = { key = "stick", count = 3 },
			[2] = false,
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
				health = 12,
				strength = 1,
				defense = 1,
				agility = 2,
				wonder = 1,
				terra = 1
			},
			[2] = false,
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