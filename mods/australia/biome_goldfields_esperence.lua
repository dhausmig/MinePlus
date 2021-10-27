-- mods/australia/biome_goldfields_esperence.lua
if minetest.settings:get_bool("log_files") then minetest.log("australia/biome_goldfields_esperence" ) end

minetest.register_biome({
	name = "goldfields_esperence",
	--node_dust = "",
	node_top = "default:desert_sand",
	depth_top = 2,
	node_filler = "default:sandstone",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "default:dirt_with_dry_grass",
	y_min = aus.yoff +4,
	y_max = aus.yoff +35,
	heat_point = 60,
	humidity_point = 20,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs
--[[
	-- Gold
minetest.register_ore({
	ore_type        = "blob",
	ore             = "default:gold_ore",
	wherein         = {"default:stone"},
	clust_scarcity  = 36 * 36 * 36,
	clust_size      = 8,
	biomes          = {"goldfields_esperence"},
	y_min           = aus.yoff -64,
	y_max           = aus.yoff,
	noise_threshold = 0.8,
	noise_params    = {
		offset = 0,
		scale = 3,
		spread = {x = 16, y = 16, z = 16},
		seed = 891,
		octaves = 3,
		persist = 0.6
	},
})
--]]


--
-- Decorations
--

local function register_dry_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"goldfields_esperence"},
		y_min = aus.yoff +5,
		y_max = aus.yoff +35,
		decoration = "default:dry_grass_"..length,
	})
end

	-- Dry grasses
register_dry_grass_decoration(0.01, 0.05,  5)
register_dry_grass_decoration(0.03, 0.03,  4)
register_dry_grass_decoration(0.05, 0.01,  3)
register_dry_grass_decoration(0.07, -0.01, 2)
register_dry_grass_decoration(0.09, -0.03, 1)


	-- Spinifex
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:desert_sand"},
	sidelen = 80,
	fill_ratio = 0.05,
	biomes = {"goldfields_esperence"},
	y_min = aus.yoff +6,
	y_max = aus.yoff +35,
	decoration = "australia:spinifex",
})



--
-- Trees
--

	-- Desert Quandong
aus.schematics.quandong_tree = {}
local max_r = 4
local ht = 4
local fruit = "australia:quandong"
local limbs = false
local trunk = "australia:quandong_trunk"
local leaves = "australia:quandong_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(2, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.quandong_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:desert_sand"},
		y_min = aus.yoff +6,
		y_max = aus.yoff +35,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"goldfields_esperence"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end
