if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
--
-- Clementinetree
--

local modname = "clementinetree"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

minetest.register_node("clementinetree:clementine", {
	description = S("Clementine"),
	drawtype = "plantlike",
	tiles = {"clementinetree_clementine.png"},
	inventory_image = "clementinetree_clementine.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "clementinetree:clementine", param2 = 1})
	end,
})

-- clementinetree

local function grow_new_clementinetree_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-2, y = pos.y, z = pos.z-2}, modpath.."/schematics/clementinetree.mts", "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.00004,
			spread = {x = 250, y = 250, z = 250},
			seed = 3456,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_min = 1,
		y_max = 80,
		schematic = modpath.."/schematics/clementinetree.mts",
		flags = "place_center_x, place_center_z,  force_placement",
		rotation = "random",
	})
end

--
-- Nodes
--

minetest.register_node("clementinetree:sapling", {
	description = S("Clementine Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"clementinetree_sapling.png"},
	inventory_image = "clementinetree_sapling.png",
	wield_image = "clementinetree_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_clementinetree_tree,
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
	},
	groups = {snappy = 2, dig_immediate = 3, flammable = 2,
		attached_node = 1, sapling = 1},
	sounds = default.node_sound_leaves_defaults(),

	on_construct = function(pos)
		minetest.get_node_timer(pos):start(math.random(2400,4800))
	end,

	on_place = function(itemstack, placer, pointed_thing)
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"clementinetree:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("clementinetree:trunk", {
	description = S("Clementine Tree Trunk"),
	tiles = {
		"clementinetree_trunk_top.png",
		"clementinetree_trunk_top.png",
		"clementinetree_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- clementinetree wood
minetest.register_node("clementinetree:wood", {
	description = S("Clementine Tree Wood"),
	tiles = {"clementinetree_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- clementinetree tree leaves
minetest.register_node("clementinetree:leaves", {
	description = S("Clementine Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"clementinetree_leaves.png"},
	inventory_image = "clementinetree_leaves.png",
	wield_image = "clementinetree_leaves.png",
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"clementinetree:sapling"}, rarity = 20},
			{items = {"clementinetree:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

--
-- Craftitems
--

--
-- Recipes
--

minetest.register_craft({
	output = "clementinetree:wood 4",
	recipe = {{"clementinetree:trunk"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "clementinetree:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "clementinetree:wood",
	burntime = 7,
})


minetest.register_lbm({
	name = "clementinetree:convert_clementinetree_saplings_to_node_timer",
	nodenames = {"clementinetree:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

default.register_leafdecay({
	trunks = {"clementinetree:trunk"},
	leaves = {"clementinetree:leaves"},
	radius = 3,
})

--Support for bonemeal

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"clementinetree:sapling", grow_new_clementinetree_tree, "soil"},
	})
end

--Door and Gate

if minetest.get_modpath("doors") ~= nil then
	doors.register("door_clementinetree_wood", {
			tiles = {{ name = "clementinetree_door_wood.png", backface_culling = true }},
			description = S("Clementine Wood Door"),
			inventory_image = "clementinetree_item_wood.png",
			groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			recipe = {
				{"clementinetree:wood", "clementinetree:wood"},
				{"clementinetree:wood", "clementinetree:wood"},
				{"clementinetree:wood", "clementinetree:wood"},
			}
	})
end

doors.register_fencegate(":doors:gate_clementinetree", {
	description = S("Clementine Wood Fence Gate"),
	texture = "clementinetree_wood.png",
	material = "clementinetree:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- Fence

default.register_fence("clementinetree:fence", {
    description = "Clementinetree Wood Fence",
    texture = "clementinetree_wood.png",
    inventory_image = "default_fence_overlay.png^clementinetree_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^clementinetree_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    material = "clementinetree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("clementinetree:fence_rail", {
    description = "Clementinetree Wood Fence Rail",
    texture = "clementinetree_wood.png",
    inventory_image = "default_fence_rail_overlay.png^clementinetree_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^clementinetree_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "clementinetree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

--Support for lumberjack

if minetest.get_modpath("lumberjack") and minetest.global_exists("lumberjack") then
	lumberjack.register_tree("clementinetree:trunk", "clementinetree:sapling", 1, 3)
end

-- Shelves

vessels.register_shelf("clementinetree:clementine_shelf", {
	description = "Clementine Vessels Shelf",
	tiles = {"clementinetree_wood.png^[transformR90", "clementinetree_wood.png^[transformR90", "clementinetree_wood.png",
		"clementinetree_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"clementinetree:wood", "clementinetree:wood", "clementinetree:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"clementinetree:wood", "clementinetree:wood", "clementinetree:wood"},
	},
})

default.register_bookshelf("clementinetree:clementine", {
	description = "Clementine Bookshelf",
	tiles = {"clementinetree_wood.png^[transformR90", "clementinetree_wood.png^[transformR90", "clementinetree_wood.png",
		"clementinetree_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'clementinetree:clementine_bookshelf',
	recipe = {
		{'clementinetree:wood', 'clementinetree:wood', 'clementinetree:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'clementinetree:wood', 'clementinetree:wood', 'clementinetree:wood'},
	}
})

-- Stairs

if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"clementinetree_trunk",
		"clementinetree:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"clementinetree_trunk_top.png",
		"clementinetree_trunk_top.png",
		"clementinetree_trunk.png"},
		S("Clementine Tree Stair"),
		S("Clementine Tree Slab"),
		default.node_sound_wood_defaults()
	)
	stairs.register_stair_and_slab(
		"clementinetree",
		"clementinetree:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"clementinetree_wood.png"},
		S("Clementine Wood Stair"),
		S("Clementine Wood Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"clementinetree",
		"trunk",
		"clementinetree:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"clementinetree_trunk_top.png",
				"clementinetree_trunk_top.png",
				"clementinetree_trunk.png"
			},
			description = S("clementinetree Trunk"),
			drop = "clementinetree_trunk",
		}
	)

	stairsplus:register_all(
		"clementinetree",
		"clementinetree_wood",
		"clementinetree:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "clementinetree_wood.png" },
			description = S("clementinetree wood"),
			drop = "clementinetree_wood",
		}
	)
end
