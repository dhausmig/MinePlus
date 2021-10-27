-- mods/australia/biome_simpson_desert.lua
if minetest.settings:get_bool("log_files") then minetest.log("australia/biome_simpson_desert" ) end

minetest.register_biome({
	name = "simpson_desert",
	--node_dust = "",
	node_top = "australia:red_sand",
	depth_top = 3,
	node_filler = "australia:red_stone",
	depth_filler = 2,
	--node_stone = "",
	--node_water_top = "",
	--depth_water_top = ,
	--node_water = "",
	node_river_water = "australia:muddy_river_water_source",
	y_min = aus.yoff +36,
	y_max = aus.yoff +500,
	heat_point = 85,
	humidity_point = 10,
})



--
-- Register ores
--

-- All mapgens except singlenode
-- Blob ore first to avoid other ores inside blobs



--
-- Trees
--

	-- Coolabah Tree
aus.schematics.coolabah_tree = {}
local max_r = 5
local ht = 7
local fruit = nil
local limbs = nil
local trunk = "australia:coolabah_trunk"
local leaves = "australia:coolabah_leaves"
for r = 4,max_r do
	local schem = aus.generate_tree_schematic(3, {x=r, y=ht, z=r}, trunk, leaves, fruit, limbs)
	push(aus.schematics.coolabah_tree, schem)
	minetest.register_decoration({
		deco_type = "schematic",
		sidelen = 80,
		place_on = {"australia:red_sand"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +150,
		fill_ratio = (max_r-r+1)/20000,
		biomes = {"simpson_desert"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

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
		place_on = {"australia:red_sand"},
		y_min = aus.yoff +36,
		y_max = aus.yoff +130,
		fill_ratio = (max_r-r+1)/15000,
		biomes = {"simpson_desert"},
		schematic = schem,
		flags = "place_center_x, place_center_z",
		rotation = "random",
	})
end

