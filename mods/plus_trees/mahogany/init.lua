if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
--
-- Mahogany
--

local modname = "mahogany"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")


-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

-- Mahogany

local function grow_new_mahogany_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-3, y = pos.y, z = pos.z-3}, modpath.."/schematics/mahogany.mts", "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "v6" and mg_name ~= "singlenode" then
	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {"default:dirt_with_rainforest_litter"},
		sidelen = 16,
		noise_params = {
			offset = 0.005,
			scale = 0.005,
			spread = {x = 250, y = 250, z = 250},
			seed = 345,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"rainforest"},
		height = 2,
		y_min = 1,
		y_max = 62,
		schematic = modpath.."/schematics/mahogany.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
	})
end

--
-- Nodes
--

minetest.register_node("mahogany:sapling", {
	description = S("Mahogany Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"mahogany_sapling.png"},
	inventory_image = "mahogany_sapling.png",
	wield_image = "mahogany_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_mahogany_tree,
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
			"mahogany:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("mahogany:trunk", {
	description = S("Mahogany Trunk"),
	tiles = {
		"mahogany_trunk_top.png",
		"mahogany_trunk_top.png",
		"mahogany_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	is_ground_content = false,
	on_place = minetest.rotate_node,
})

-- mahogany wood
minetest.register_node("mahogany:wood", {
	description = S("Mahogany Wood"),
	tiles = {"mahogany_wood.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- mahogany tree leaves
minetest.register_node("mahogany:leaves", {
	description = S("Mahogany Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"mahogany_leaves.png"},
	inventory_image = "mahogany_leaves.png",
	wield_image = "mahogany_leaves.png",
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"mahogany:sapling"}, rarity = 20},
			{items = {"mahogany:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

--
-- Creeper/Vines...
--

minetest.register_node("mahogany:creeper", {
	description = S("Mahogany Creeper"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"mahogany_creeper.png"},
	use_texture_alpha = "blend",
	inventory_image = "mahogany_creeper.png",
	wield_image = "mahogany_creeper.png",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("mahogany:flower_creeper", {
	description = S("Mahogany Flower Creeper"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"mahogany_flower_creeper.png"},
	use_texture_alpha = "blend",
	inventory_image = "mahogany_flower_creeper.png",
	wield_image = "mahogany_flower_creeper.png",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.49, 0.5, 0.5, 0.5}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1, falling_node = 1
	},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("mahogany:hanging_creeper", {
	description = S("Mahogany Hanging Creeper"),
	drawtype = "nodebox",
	walkable = true,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"mahogany_hanging_creeper.png"},
	use_texture_alpha = "blend",
	inventory_image = "mahogany_hanging_creeper.png",
	wield_image = "mahogany_hanging_creeper.png",
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, 0.0, 0.5, 0.5, 0.0}
	},
	groups = {
		snappy = 2, flammable = 3, oddly_breakable_by_hand = 3, choppy = 2, carpet = 1, leafdecay = 3, leaves = 1, falling_node = 1
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
	output = "mahogany:wood 4",
	recipe = {{"mahogany:trunk"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "mahogany:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "mahogany:wood",
	burntime = 7,
})


minetest.register_lbm({
	name = "mahogany:convert_mahogany_saplings_to_node_timer",
	nodenames = {"mahogany:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

default.register_leafdecay({
	trunks = {"mahogany:trunk"},
	leaves = {"mahogany:leaves"},
	radius = 3,
})

--Support for bonemeal

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"mahogany:sapling", grow_new_mahogany_tree, "soil"},
	})
end

-- Door and Gate

doors.register_fencegate(":doors:gate_mahogany", {
	description = S("Mahogany Wood Fence Gate"),
	texture = "mahogany_wood.png",
	material = "mahogany:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- Fence

default.register_fence("mahogany:fence", {
    description = "Mahogany Wood Fence",
    texture = "mahogany_wood.png",
    inventory_image = "default_fence_overlay.png^mahogany_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^mahogany_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    material = "mahogany:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("mahogany:fence_rail", {
    description = "Mahogany Wood Fence Rail",
    texture = "mahogany_wood.png",
    inventory_image = "default_fence_rail_overlay.png^mahogany_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^mahogany_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "mahogany:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

--Support for lumberjack mod

if minetest.get_modpath("lumberjack") and minetest.global_exists("lumberjack") then
	lumberjack.register_tree("mahogany:trunk", "mahogany:sapling", 1, 3)
end

-- Shelves

vessels.register_shelf("mahogany:mahogany_shelf", {
	description = "Mahogany Vessels Shelf",
	tiles = {"mahogany_wood.png^[transformR90", "mahogany_wood.png^[transformR90", "mahogany_wood.png",
		"mahogany_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"mahogany:wood", "mahogany:wood", "mahogany:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"mahogany:wood", "mahogany:wood", "mahogany:wood"},
	},
})

default.register_bookshelf("mahogany:mahogany", {
	description = "Mahogany Bookshelf",
	tiles = {"mahogany_wood.png^[transformR90", "mahogany_wood.png^[transformR90", "mahogany_wood.png",
		"mahogany_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'mahogany:mahogany_bookshelf',
	recipe = {
		{'mahogany:wood', 'mahogany:wood', 'mahogany:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'mahogany:wood', 'mahogany:wood', 'mahogany:wood'},
	}
})

-- Stairs

if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"mahogany_trunk",
		"mahogany:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"mahogany_trunk_top.png",
		"mahogany_trunk_top.png",
		"mahogany_trunk.png"},
		S("Mahogany Trunk Stair"),
		S("Mahogany Trunk Slab"),
		default.node_sound_wood_defaults()
	)
	stairs.register_stair_and_slab(
		"mahogany",
		"mahogany:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"mahogany_wood.png"},
		S("Mahogany Stair"),
		S("Mahogany Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"mahogany",
		"trunk",
		"mahogany:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"mahogany_trunk_top.png",
				"mahogany_trunk_top.png",
				"mahogany_trunk.png"
			},
			description = S("Mahogany Trunk"),
			drop = "mahogany_trunk",
		}
	)

	stairsplus:register_all(
		"mahogany",
		"wood",
		"mahogany:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "mahogany_wood.png" },
			description = S("Mahogany Wood"),
			drop = "mahogany_wood",
		}
	)
end
