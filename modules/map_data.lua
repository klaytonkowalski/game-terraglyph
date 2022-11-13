local map_data = {}

-- Indexed by tilesource id -> tile id.
map_data.animations =
{
	[1] =
	{
		
	}
}

-- Indexed by tilesource id -> tile id.
map_data.tilesources =
{
	[1] =
	{
		[9] = { encounter = true, grass_tall = true },
		[10] = { encounter = true, grass_tall = true },
		[11] = { encounter = true, grass_tall = true },
		[17] = { encounter = true, grass_tall = true },
		[18] = { encounter = true, grass_tall = true },
		[19] = { encounter = true, grass_tall = true },
		[76] = { footprint = true },
		[77] = { footprint = true },
		[78] = { footprint = true },
		[84] = { footprint = true },
		[85] = { footprint = true },
		[86] = { footprint = true },
		[87] = { footprint = true },
		[92] = { footprint = true },
		[93] = { footprint = true },
		[94] = { footprint = true },
		[95] = { footprint = true },
		[145] = { footprint = true },
		[146] = { footprint = true },
		[147] = { footprint = true },
		[148] = { footprint = true },
		[149] = { footprint = true },
		[153] = { footprint = true },
		[155] = { footprint = true },
		[156] = { footprint = true },
		[157] = { footprint = true },
		[161] = { footprint = true },
		[162] = { footprint = true },
		[163] = { footprint = true }
	}
}

-- Indexed by map id.
map_data.map_to_tilesource =
{
	[1] = 1
}

-- Indexed by map id.
map_data.tiles =
{
	[1] =
	{
		{ x = 13, y = 11, data = { event_id = 1 } }
	}
}

return map_data