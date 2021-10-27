-- mods/australia/biome_kimberley.lua
if minetest.settings:get_bool("log_files") then minetest.log("australia/biome_kimberley" ) end

minetest.register_biome({
	name = "kimberley",
	--node_dust = "",
	node_top = "australia:red_dirt",
	depth_top = 2,
	node_filler = "default:sandstone",
	depth_filler = 3,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = aus.yoff +4,
	y_max = aus.yoff +35,
	heat_point = 80,
	humidity_point = 75,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs
--[[
minetest.register_ore({
	ore_type       = "scatter",
	ore            = "default:diamond_ore",
	wherein        = "default:stone",
	clust_scarcity = 40 * 40 * 40,
	clust_num_ores = 12,
	clust_size     = 4,
	biomes         = {"kimberley"},
	y_min          = aus.yoff -64,
	y_max          = aus.yoff +35,
})
--]]


--
-- Decorations
--

local function register_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"australia:red_dirt"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"kimberley"},
		y_min = aus.yoff +4,
		y_max = aus.yoff +30,
		decoration = "default:grass_"..length,
	})
end

local function register_dry_grass_decoration(offset, scale, length)
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"australia:red_dirt"},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 200, y = 200, z = 200},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"kimberley"},
		y_min = aus.yoff +7,
		y_max = aus.yoff +35,
		decoration = "default:dry_grass_"..length,
	})
end

	-- Grasses
register_grass_decoration(0.015,  0.045, 2)
register_grass_decoration(0.03,   0.03,  1)

	-- Dry grasses
register_dry_grass_decoration(0.01, 0.05,  5)
register_dry_grass_decoration(0.03, 0.03,  4)
register_dry_grass_decoration(0.05, 0.01,  3)
register_dry_grass_decoration(0.07, -0.01, 2)
register_dry_grass_decoration(0.09, -0.03, 1)



--
-- Trees
--

	-- Boab Tree
aus.schematics.boab_tree = {}
local max_r = 4
local ht = 4
local fruit = nil
local limbs = false
local trunk = "australia:boab_trunk"
local leaves = "australia:boab_leaves"
for r = 3,max_r do
	local schem = aus.generate_giant_tree_schematic(3, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.boab_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = aus.yoff +9,
		y_max = aus.yoff +35,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"kimberley"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Darwin Woollybutt
aus.schematics.darwin_woollybutt_tree = {}
local max_r = 4
local ht = 5
local fruit = nil
local limbs = nil
local trunk = "australia:darwin_woollybutt_trunk"
local leaves = "australia:darwin_woollybutt_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(6, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.darwin_woollybutt_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = aus.yoff +12,
		y_max = aus.yoff +35,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"kimberley"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Swamp Bloodwood
aus.schematics.swamp_bloodwood_tree = {}
local max_r = 4
local ht = 6
local fruit = nil
local limbs = nil
local trunk = "australia:swamp_bloodwood_trunk"
local leaves = "australia:swamp_bloodwood_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(3, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.swamp_bloodwood_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_dirt"},
		y_min = aus.yoff +7,
		y_max = aus.yoff +35,
		fill_ratio = (max_r-r+1)/10000,
		biomes = {"kimberley"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

