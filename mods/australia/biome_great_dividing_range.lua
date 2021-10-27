-- mods/australia/biome_great_dividing_range.lua
if minetest.settings:get_bool("log_files") then minetest.log("australia/biome_great_dividing_range" ) end

minetest.register_biome({
	name = "great_dividing_range",
	--node_dust = "",
	node_top = "default:dirt_with_grass",
	depth_top = 1,
	node_filler = "default:dirt",
	depth_filler = 3,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = aus.yoff +36,
	y_max = aus.yoff +500,
	heat_point = 25,
	humidity_point = 65,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs

	-- Bluestone (Basalt)
minetest.register_ore({
	ore_type        = "blob",
	ore             = "australia:bluestone",
	wherein         = {"default:stone"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 8,
	biomes          = {"great_dividing_range"},
	y_min           = aus.yoff +36,
	y_max           = aus.yoff +500,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 677,
		octaves = 1,
		persist = 0.0
	},
})
--[[
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:coal_ore",
	wherein        = "default:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 24,
	clust_size     = 5,
	biomes         = {"great_dividing_range"},
	y_min          = aus.yoff -64,
	y_max          = aus.yoff +64,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:coalblock",
	wherein        = "default:stone",
	clust_scarcity = 48 * 48 * 48,
	clust_num_ores = 8,
	clust_size     = 3,
	biomes         = {"great_dividing_range"},
	y_min          = aus.yoff -64,
	y_max          = aus.yoff +64,
})
--]]


--
-- Ferns
--

	-- Big Tree Fern
local n1 = { name = "air", prob = 0 }
local n2 = { name = "australia:tree_fern_leaf_big_end" }
local n3 = { name = "australia:tree_fern_leaf_big" }
local n4 = { name = "australia:fern_trunk_big" }
local n5 = { name = "australia:tree_fern_leaf_big_end", param2 = 1 }
local n6 = { name = "australia:fern_trunk_big_top" }
local n7 = { name = "australia:tree_fern_leaf_big_end", param2 = 3 }
local n8 = { name = "australia:tree_fern_leaves_giant" }
local n9 = { name = "australia:tree_fern_leaf_big_end", param2 = 2 }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {"default:dirt_with_grass"},
	y_min = aus.yoff +36,
	y_max = aus.yoff +70,
	fill_ratio = 0.002,
	biomes = {"great_dividing_range"},
	schematic = {
		size = {y = 7, x = 9, z = 9},
	data = {
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n2, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n1, n1, 
			n1, n1, n4, n1, n1, n1, n1, n1, n1, n1, n1, n4, n1, n1, n1, n1, n5, 
			n1, n1, n1, n6, n1, n1, n1, n7, n1, n3, n1, n3, n8, n3, n1, n3, n1, 
			n1, n1, n3, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n3, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n9, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, n1, 
			n1, n1, n1, n1, n1, n1, 
			},
		yslice_prob = {},
	},
	flags = "place_center_x, place_center_z",
})

	-- Small Tree Fern
local f1 = { name = "australia:fern_trunk" }
local f2 = { name = "australia:tree_fern_leaves_02" }
minetest.register_decoration({
	deco_type = "schematic",
	sidelen = 80,
	place_on = {"default:dirt_with_grass"},
	y_min = aus.yoff +36,
	y_max = aus.yoff +80,
	fill_ratio = 0.004,
	biomes = {"great_dividing_range"},
	schematic = {
		size = {y = 4, x = 1, z = 1},
	data = {
			f1, f1, f1, f2, 
			},
		yslice_prob = {},
	},
})

	-- Ruddy Ground Fern
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.005,
		spread = {x = 200, y = 200, z = 200},
		seed = 80,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"great_dividing_range"},
	y_min = aus.yoff +36,
	y_max = aus.yoff +160,
	decoration = "australia:fern",
})

	-- Sickle Fern
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0,
		scale = 0.007,
		spread = {x = 200, y = 200, z = 200},
		seed = 81,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"great_dividing_range"},
	y_min = aus.yoff +36,
	y_max = aus.yoff +140,
	decoration = "australia:small_fern",
})



--
-- Decorations
--

local function register_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"great_dividing_range"},
		y_min = aus.yoff +36,
		y_max =aus.yoff + 500,
		decoration = "default:grass_"..length,
	})
end

	-- Grasses
register_grass_decoration(-0.03,  0.09,  5)
register_grass_decoration(-0.015, 0.075, 4)
register_grass_decoration(0,      0.06,  3)
register_grass_decoration(0.015,  0.045, 2)
register_grass_decoration(0.03,   0.03,  1)



--
-- Logs
--

	-- River Red Gum
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0018,
		scale = 0.0011,
		spread = {x = 250, y = 250, z = 250},
		seed = 33,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"great_dividing_range"},
	y_min = aus.yoff +36,
	y_max = aus.yoff +170,
	schematic = {
		size = {x = 3, y = 3, z = 1},
		data = {
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "air", prob = 0},
			{name = "australia:river_red_gum_trunk", param2 = 12, prob = 191},
			{name = "australia:river_red_gum_trunk", param2 = 12},
			{name = "australia:river_red_gum_trunk", param2 = 12, prob = 127},
			{name = "air", prob = 0},
			{name = "flowers:mushroom_brown", prob = 63},
			{name = "air", prob = 0},
		},
	},
	flags = "place_center_x",
	rotation = "random",
})



--
-- Moss
--

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.06,
	biomes = {"great_dividing_range"},
	y_min = aus.yoff +36,
	y_max = aus.yoff +500,
	decoration = "australia:moss",
})



--
-- Trees
--

	-- Black Wattle
aus.schematics.black_wattle_tree = {}
local max_r = 6
local ht = 8
local fruit = nil
local limbs = false
local trunk = "australia:black_wattle_trunk"
local leaves = "australia:black_wattle_leaves"
for r = 5,max_r do
	local schem = aus.generate_tree_schematic(4, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.black_wattle_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +150,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Blue Gum
aus.schematics.blue_gum_tree = {}
local max_r = 7
local ht = 12
local fruit = nil
local limbs = nil
local trunk = "australia:blue_gum_trunk"
local leaves = "australia:blue_gum_leaves"
for r = 6,max_r do
	local schem = aus.generate_tree_schematic(10, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.blue_gum_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +180,
		fill_ratio = (max_r-r+1)/8000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Australian Cherry
aus.schematics.cherry_tree = {}
local max_r = 3
local fruit = "australia:cherry"
local trunk = "australia:cherry_trunk"
local leaves = "australia:cherry_leaves"
for r = 2,max_r do
	local schem = aus.generate_conifer_schematic(3, 2, trunk, leaves, fruit)
	push(aus.schematics.cherry_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +150,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Golden Wattle
aus.schematics.golden_wattle_tree = {}
local max_r = 3
local ht = 3
local fruit = nil
local limbs = false
local trunk = "australia:golden_wattle_trunk"
local leaves = "australia:golden_wattle_leaves"
for r = 2,max_r do
	local schem = aus.generate_tree_schematic(2, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.golden_wattle_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +150,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Lilly Pilly
aus.schematics.lilly_pilly_tree = {}
local max_r = 5
local ht = 8
local fruit = "australia:lilly_pilly_berries"
local limbs = false
local trunk = "australia:lilly_pilly_trunk"
local leaves = "australia:lilly_pilly_leaves"
for r = 4,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.lilly_pilly_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +150,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Red Bottlebrush
aus.schematics.red_bottlebrush_tree = {}
local max_r = 3
local ht = 4
local fruit = nil
local limbs = false
local trunk = "australia:red_bottlebrush_trunk"
local leaves = "australia:red_bottlebrush_leaves"
for r = 2,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.red_bottlebrush_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +150,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- River Red Gum
aus.schematics.river_red_gum_tree = {}
local max_r = 13
local ht = 13
local fruit = nil
local limbs = nil
local trunk = "australia:river_red_gum_trunk"
local leaves = "australia:river_red_gum_leaves"
for r = 10,max_r do
	local schem = aus.generate_giant_tree_schematic(7, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.river_red_gum_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +140,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Southern Sassafras
aus.schematics.southern_sassafras_tree = {}
local max_r = 5
local fruit = nil
local trunk = "australia:southern_sassafras_trunk"
local leaves = "australia:southern_sassafras_leaves"
for r = 4,max_r do
	local schem = aus.generate_conifer_schematic(6, 4, trunk, leaves, fruit)
	push(aus.schematics.southern_sassafras_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +180,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Tea Tree
aus.schematics.tea_tree_tree = {}
local max_r = 3
local ht = 4
local fruit = nil
local limbs = false
local trunk = "australia:tea_tree_trunk"
local leaves = "australia:tea_tree_leaves"
for r = 2,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.tea_tree_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"default:dirt_with_grass"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +170,
		fill_ratio = (max_r-r+1)/12000,
		biomes = {"great_dividing_range"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

