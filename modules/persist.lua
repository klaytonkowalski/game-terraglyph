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
			[1] = { name = "stick", count = 1 },
			[2] = { name = "", count = 0 },
			[3] = { name = "", count = 0 },
			[4] = { name = "", count = 0 },
			[5] = { name = "", count = 0 },
			[6] = { name = "", count = 0 },
			[7] = { name = "", count = 0 },
			[8] = { name = "", count = 0 },
			[9] = { name = "", count = 0 },
			[10] = { name = "stick", count = 3 },
			[11] = { name = "", count = 0 },
			[12] = { name = "", count = 0 },
			[13] = { name = "", count = 0 },
			[14] = { name = "", count = 0 },
			[15] = { name = "", count = 0 },
			[16] = { name = "", count = 0 }
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

return persist