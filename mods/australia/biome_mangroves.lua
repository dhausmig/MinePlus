-- mods/australia/biome_mangroves.lua
if minetest.settings:get_bool("log_files") then minetest.log("australia/biome_mangroves" ) end

minetest.register_biome({
	name = "mangroves",
	--node_dust = "",
	node_top = "australia:mangrove_mud",
	depth_top = 3,
	node_filler = "default:clay",
	depth_filler = 1,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = aus.yoff -2,
	y_max = aus.yoff +3,
	heat_point = 80,
	humidity_point = 80,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs



--
-- Decorations
--

	-- Mangrove Fern
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"australia:mangrove_mud",
		"default:dirt",
		"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.2,
	biomes = {"mangroves"},
	y_min = aus.yoff +2,
	y_max = aus.yoff +3,
	decoration = "australia:mangrove_fern",
})

	-- Mangrove Lily
minetest.register_decoration({
	deco_type = "simple",
	place_on = {"australia:mangrove_mud",
		"default:dirt",
		"default:dirt_with_grass"},
	sidelen = 80,
	fill_ratio = 0.1,
	biomes = {"mangroves"},
	y_min = aus.yoff +2,
	y_max = aus.yoff +3,
	decoration = "australia:mangrove_lily",
})

	-- Mangrove Palm
minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"australia:mangrove_mud",
		"default:dirt"},
	sidelen = 80,
	fill_ratio = 0.3,
	biomes = {"mangroves"},
	y_min = aus.yoff +1,
	y_max = aus.yoff +3,
	schematic = {
		size = { x = 1, y = 4, z = 1},
		data = {
			{ name = "ignore", param1 = 0, param2 = 0 },
			{ name = "australia:mangrove_palm_trunk", param1 = 255, param2 = 0 },
			{ name = "australia:mangrove_palm_leaf_bot", param1 = 255, param2 = 0 },
			{ name = "australia:mangrove_palm_leaf_top", param1 = 255, param2 = 0 },
		},
	},
	flags = "force_placement",
})




--
-- Trees
--

	-- Grey Mangrove
aus.schematics.grey_mangrove_tree = {}
local max_ht = 6
local trunk = "australia:grey_mangrove_trunk"
local leaves = "australia:grey_mangrove_leaves"
for h = 4,max_ht do
	local schem = aus.generate_mangrove_tree_schematic(3, trunk, leaves)
	push(aus.schematics.grey_mangrove_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:mangrove_mud", "default:dirt", "default:sand"},
		fill_ratio = 0.003,
		biomes = {"mangroves"},
		y_min = aus.yoff -2,
		y_max = aus.yoff +3,
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Mangrove Apple
aus.schematics.mangrove_apple_tree = {}
local max_r = 5
local ht = 4
local fruit = "australia:mangrove_apple"
local limbs = false
local trunk = "australia:mangrove_apple_trunk"
local leaves = "australia:mangrove_apple_leaves"
for r = 3,max_r do
	local schem = aus.generate_tree_schematic(1, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.mangrove_apple_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:mangrove_mud", "default:dirt", "default:sand"},
		y_min = aus.yoff,
		y_max = aus.yoff +3,
		fill_ratio = (max_r-r+1)/5000,
		biomes = {"mangroves"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

	-- Stilted Mangrove
aus.schematics.stilted_mangrove_tree = {}
local max_ht = 6
local trunk = "australia:stilted_mangrove_trunk"
local leaves = "australia:stilted_mangrove_leaves"
for h = 4,max_ht do
	local schem = aus.generate_mangrove_tree_schematic(3, trunk, leaves)
	push(aus.schematics.stilted_mangrove_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:mangrove_mud", "default:dirt", "default:sand"},
		fill_ratio = 0.003,
		biomes = {"mangroves"},
		y_min = aus.yoff -2,
		y_max = aus.yoff +3,
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

