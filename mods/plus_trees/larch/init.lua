if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
--
-- Larch
--
local modname = "larch"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

-- Larch

local function grow_new_larch_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-5, y = pos.y, z = pos.z-5}, modpath.."/schematics/larch.mts", "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_coniferous_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0.0005,
			scale = 0.0005,
			spread = {x = 250, y = 250, z = 250},
			seed = 542,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"coniferous_forest"},
		y_min = 1,
		y_max = 32,
		place_offset_y = 1,
		schematic = modpath.."/schematics/larch.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
	})
end

--
-- Nodes
--

minetest.register_node("larch:sapling", {
	description = S("Larch Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"larch_sapling.png"},
	inventory_image = "larch_sapling.png",
	wield_image = "larch_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_larch_tree,
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
			"larch:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("larch:trunk", {
	description = S("Larch Trunk"),
	tiles = {
		"larch_trunk_top.png",
		"larch_trunk_top.png",
		"larch_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	is_ground_content = false,
	on_place = minetest.rotate_node,
})

-- larch wood
minetest.register_node("larch:wood", {
	description = S("Larch Wood"),
	tiles = {"larch_wood.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- larch tree leaves
minetest.register_node("larch:leaves", {
	description = S("Larch Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"larch_leaves.png"},
	inventory_image = "larch_leaves.png",
	wield_image = "larch_leaves.png",
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"larch:sapling"}, rarity = 20},
			{items = {"larch:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

minetest.register_node("larch:moss", {
	description = S("Larch Moss"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"larch_moss.png"},
	use_texture_alpha = "blend",
	inventory_image = "larch_moss.png",
	wield_image = "larch_moss.png",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1,
		falling_node = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

--
-- Craftitems
--

--
-- Recipes
--

minetest.register_craft({
	output = "larch:wood 4",
	recipe = {{"larch:trunk"}}
})


minetest.register_craft({
	type = "fuel",
	recipe = "larch:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "larch:wood",
	burntime = 7,
})


minetest.register_lbm({
	name = "larch:convert_larch_saplings_to_node_timer",
	nodenames = {"larch:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

default.register_leafdecay({
	trunks = {"larch:trunk"},
	leaves = {"larch:leaves"},
	radius = 3,
})

--Support for Bonemeal

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"larch:sapling", grow_new_larch_tree, "soil"},
	})
end

--Door and Gate

if minetest.get_modpath("doors") ~= nil then
	doors.register("door_larch_wood", {
			tiles = {{ name = "larch_door_wood.png", backface_culling = true }},
			description = S("Larch Wood Door"),
			inventory_image = "larch_item_wood.png",
			groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			recipe = {
				{"larch:wood", "larch:wood"},
				{"larch:wood", "larch:wood"},
				{"larch:wood", "larch:wood"},
			}
	})
end

doors.register_fencegate(":doors:gate_larch", {
	description = S("Larch Wood Fence Gate"),
	texture = "larch_wood.png",
	material = "larch:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- Fence

default.register_fence("larch:fence", {
    description = "Larch Wood Fence",
    texture = "larch_wood.png",
    inventory_image = "default_fence_overlay.png^larch_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^larch_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    material = "larch:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("larch:fence_rail", {
    description = "Larch Wood Fence Rail",
    texture = "larch_wood.png",
    inventory_image = "default_fence_rail_overlay.png^larch_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^larch_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "larch:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

--Support for lumberjack

if minetest.get_modpath("lumberjack") and minetest.global_exists("lumberjack") then
	lumberjack.register_tree("larch:trunk", "larch:sapling", 1, 3)
end

-- Shelves

vessels.register_shelf("larch:larch_shelf", {
	description = "Larch Vessels Shelf",
	tiles = {"larch_wood.png^[transformR90", "larch_wood.png^[transformR90", "larch_wood.png",
		"larch_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"larch:wood", "larch:wood", "larch:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"larch:wood", "larch:wood", "larch:wood"},
	},
})

default.register_bookshelf("larch:larch", {
	description = "Larch Bookshelf",
	tiles = {"larch_wood.png^[transformR90", "larch_wood.png^[transformR90", "larch_wood.png",
		"larch_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'larch:larch_bookshelf',
	recipe = {
		{'larch:wood', 'larch:wood', 'larch:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'larch:wood', 'larch:wood', 'larch:wood'},
	}
})

-- Stairs

if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"larch_trunk",
		"larch:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"larch_trunk_top.png",
		"larch_trunk_top.png",
		"larch_trunk.png"},
		S("Larch Trunk Stair"),
		S("Larch Trunk Slab"),
		default.node_sound_wood_defaults()
	)
	stairs.register_stair_and_slab(
		"larch",
		"larch:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"larch_wood.png"},
		S("Larch Wood Stair"),
		S("Larch Wood Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"larch",
		"trunk",
		"larch:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"larch_trunk_top.png",
				"larch_trunk_top.png",
				"larch_trunk.png"
			},
			description = S("Larch Trunk"),
			drop = "larch_trunk",
		}
	)

	stairsplus:register_all(
		"larch",
		"wood",
		"larch:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "larch_wood.png" },
			description = S("Larch Wood"),
			drop = "larch_wood",
		}
	)
end