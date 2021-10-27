-- mods/australia/biome_timor_sea.lua
if minetest.settings:get_bool("log_files") then minetest.log("australia/biome_timor_sea" ) end

minetest.register_biome({
	name = "timor_sea",
	--node_dust = "",
	node_top = "default:sand",
	depth_top = 1,
	node_filler = "default:sand",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	--node_river_water = "",
	y_min = aus.yoff -64,
	y_max = aus.yoff +3,
	heat_point = 80,
	humidity_point = 90,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "australia:submarine",
	wherein        = "default:sand",
	clust_scarcity = 80*80*80,
	clust_num_ores = 1,
	clust_size     = 12,
	biomes         = {"timor_sea"},
	y_min     = aus.yoff -64,
	y_max     = aus.yoff -8,
})



--
-- Decorations
--

local function register_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:sand"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"timor_sea"},
		y_min = aus.yoff +3,
		y_max = aus.yoff +3,
		decoration = "default:grass_"..length,
	})
end

	-- Grasses
register_grass_decoration(-0.03,  0.09,  5)
register_grass_decoration(-0.015, 0.075, 4)
register_grass_decoration(0,      0.06,  3)
register_grass_decoration(0.015,  0.045, 2)
register_grass_decoration(0.03,   0.03,  1)

	-- Narrowleaf Seagrass
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:sand"},
	sidelen = 80,
	fill_ratio = 0.02,
	biomes = {"timor_sea"},
	y_min     = aus.yoff -10,
	y_max     = aus.yoff -2,
	decoration = "australia:sea_grass",
	flags = "force_placement",
})



--
-- ABM'S
--

local function place_submarine(pos)
	minetest.add_node(pos, {name = "default:dirt"})

	pos.y = pos.y + 1
	pos.x = pos.x - 15

	for a = 1, 31 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x + 1

	for a = 1, 31 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x +1

	for a = 1, 27 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 3
	pos.x = pos.x + 1

	for a = 1, 27 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 1
	pos.x = pos.x + 2

	for a = 1, 21 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 5
	pos.x = pos.x + 1

	for a = 1, 21 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.y = pos.y + 1
	pos.z = pos.z + 1
	pos.x = pos.x - 1

	for a = 1, 21 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 7
	pos.x = pos.x + 1

	for a = 1, 21 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 24
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 5
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 22
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 29
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 3
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 28
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 32
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 32
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.y = pos.y + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x + 32
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z - 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x - 32
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z - 1
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x + 28
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z + 3
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x - 28
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z + 1
	pos.x = pos.x + 2
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x + 22
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z + 1
	pos.x = pos.x - 2
	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 9 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.z = pos.z - 6
	pos.x = pos.x - 3
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.x = pos.x + 22
	minetest.add_node(pos, {name = "default:steelblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:steelblock"})

	pos.z = pos.z - 1
	pos.x = pos.x - 2

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:obsidian_glass"})

	for a = 1, 9 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y + 1
	pos.z = pos.z + 7
	pos.x = pos.x - 1
	for a = 1, 21 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 7
	pos.x = pos.x + 1

	for a = 1, 21 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 24
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 5
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 22
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 29
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 3
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 28
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 32
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 32
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.y = pos.y + 1
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 28
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 28
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z - 1
	pos.x = pos.x + 2
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x + 22
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x + 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 3
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.x = pos.x - 22
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})
	pos.x = pos.x - 1
	minetest.add_node(pos, {name = "default:copperblock"})

	pos.z = pos.z + 1
	pos.x = pos.x + 2
	for a = 1, 21 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 5
	pos.x = pos.x + 1
	for a = 1, 21 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.y = pos.y + 1
	pos.z = pos.z + 2
	pos.x = pos.x - 4
	for a = 1, 3 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.x = pos.x + 21
	for a = 1, 3 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x + 1
	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.x = pos.x - 21
	for a = 1, 3 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 2
	pos.x = pos.x + 3
	for a = 1, 4 do
		pos.z = pos.z - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 1
	pos.x = pos.x + 1
	for a = 1, 4 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.x = pos.x + 6
	for a = 1, 13 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z - 3
	pos.x = pos.x + 1
	for a = 1, 13 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:copperblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x - 1
	for a = 1, 13 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:bronzeblock"})
	end

	pos.z = pos.z + 1
	pos.x = pos.x + 1
	for a = 1, 13 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:bronzeblock"})
	end

	pos.z = pos.z - 3
	for a = 1, 6 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.z = pos.z + 5
	pos.x = pos.x - 1
	for a = 1, 6 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y + 1
	for a = 1, 4 do
		pos.z = pos.z - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 5
	pos.z = pos.z - 1
	for a = 1, 4 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	for a = 1, 4 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x + 1
	pos.z = pos.z - 3
	for a = 1, 4 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y + 1
	pos.x = pos.x - 1
	pos.z = pos.z - 1
	for a = 1, 4 do
		pos.z = pos.z + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x + 5
	pos.z = pos.z + 1
	for a = 1, 4 do
		pos.z = pos.z - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	for a = 1, 4 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	pos.z = pos.z + 3
	for a = 1, 4 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y + 1
	pos.x = pos.x - 1
	pos.z = pos.z - 1
	for a = 1, 2 do
		pos.x = pos.x - 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.x = pos.x - 1
	pos.z = pos.z - 1
	for a = 1, 2 do
		pos.x = pos.x + 1
		minetest.add_node(pos, {name = "default:steelblock"})
	end

	pos.y = pos.y - 7
	pos.x = pos.x +16
	pos.z = pos.z +3
	minetest.add_node(pos, {name = "australia:submarinechest"})
end

minetest.register_abm({
	nodenames = {"australia:submarine"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local yp = {x = pos.x, y = pos.y + 8, z = pos.z}
		if node.name == "australia:submarine"
		and (
			minetest.get_node(yp).name == "default:water_source"
			or minetest.get_node(yp).name == "australia:water_source"
		) then
			place_submarine(pos)
		end
	end
})
