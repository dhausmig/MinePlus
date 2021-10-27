if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

maple = {}
S = function ( s ) return s end

dofile(minetest.get_modpath("maple").."/trees.lua")

minetest.register_node("maple:trunk", {
	description = "Maple Trunk",
	tiles = {"maple_tree_top.png", "maple_tree_top.png", "maple_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),

	on_place = minetest.rotate_node
})

minetest.register_node("maple:wood", {
	description = "Maple Wood Planks",
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"maple_wood.png"},
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'maple:wood 4',
	recipe = {
		{'maple:trunk'},
	}
})

minetest.register_node("maple:leaves", {
	description = "Maple Leaves",
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"maple_leaves.png"},
	special_tiles = {"maple_leaves_simple.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	drop = {
		max_items = 1,
		items = {
			{
				-- player will get sapling with 1/20 chance
				items = {'maple:sapling'},
				rarity = 20,
			},
			{
				-- player will get leaves only if he get no saplings,
				-- this is because max_items is 1
				items = {'maple:leaves'},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = default.after_place_leaves,
})



minetest.register_node("maple:sapling", {
	description = "Maple Sapling",
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"maple_sapling.png"},
	inventory_image = "maple_sapling.png",
	wield_image = "maple_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = maple.grow_sapling,
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
	print("Maple sapling placed.")
		itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
			"maple:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 13, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})


minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = 0.0,
		--scale = -0.015,
		scale = 0.0007,
		spread = {x = 250, y = 250, z = 250},
		seed = 2,
		octaves = 3,
		persist = 0.66
	},
	biomes = {"deciduous_forest"},
	y_min = 1,
	y_max = 31000,
	schematic = minetest.get_modpath("maple").."/schematics/maple_tree.mts",
	flags = "place_center_x, place_center_z",
})

default.register_leafdecay({
	trunks = {"maple:trunk"},
	leaves = {"maple:leaves"},
	radius = 3,
})

--Support for bonemeal

if minetest.get_modpath("bonemeal") then
	bonemeal:add_sapling({
		{"maple:sapling", maple.grow_sapling, "soil"},
	})
end

-- Door and Gate

doors.register_fencegate(":doors:gate_maple", {
	description = S("Maple Wood Fence Gate"),
	texture = "maple_wood.png",
	material = "maple:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- Fence

default.register_fence("maple:fence", {
	description = "Maple Wood Fence",
	texture = "maple_fence.png",
	inventory_image = "default_fence_overlay.png^maple_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	wield_image = "default_fence_overlay.png^maple_wood.png^default_fence_overlay.png^[makealpha:255,126,126",
	material = "maple:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("maple:fence_rail", {
    description = "Maple Wood Fence Rail",
    texture = "maple_wood.png",
    inventory_image = "default_fence_rail_overlay.png^maple_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^maple_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "maple:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

--Support for lumberjack

if minetest.get_modpath("lumberjack") and minetest.global_exists("lumberjack") then
	lumberjack.register_tree("maple:trunk", "maple:sapling", 1, 3)
end

-- Shelves

vessels.register_shelf("maple:maple_shelf", {
	description = "Maple Vessels Shelf",
	tiles = {"maple_wood.png^[transformR90", "maple_wood.png^[transformR90", "maple_wood.png",
		"maple_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"maple:wood", "maple:wood", "maple:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"maple:wood", "maple:wood", "maple:wood"},
	},
})

default.register_bookshelf("maple:maple", {
	description = "Maple Bookshelf",
	tiles = {"maple_wood.png^[transformR90", "maple_wood.png^[transformR90", "maple_wood.png",
		"maple_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'maple:maple_bookshelf',
	recipe = {
		{'maple:wood', 'maple:wood', 'maple:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'maple:wood', 'maple:wood', 'maple:wood'},
	}
})

-- Stairs

if minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab(
		"maple_trunk",
		"maple:trunk",
		{ snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
		{	"maple_tree_top.png",
			"maple_tree_top.png",
			"maple_tree.png"
		},
		S("Maple Trunk Stair"),
		S("Maple Trunk Slab"),
		default.node_sound_wood_defaults()
	)

	stairs.register_stair_and_slab(
		"maple",
		"maple:wood",
		{ snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
		{ "maple_wood.png" },
		S("Maple Wood Stair"),
		S("Maple Wood Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"maple",
		"maple_trunk",
		"maple:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"maple_tree_top.png",
				"maple_tree_top.png",
				"maple_tree.png"
			},
			description = S("Maple Trunk"),
			drop = "maple_trunk",
		}
	)

	stairsplus:register_all(
		"maple",
		"maple_wood",
		"maple:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "maple_wood.png" },
			description = S("Maple Wood"),
			drop = "maple_wood",
		}
	)
end

minetest.register_craft({
	type = "fuel",
	recipe = "maple:sapling",
	burntime = 12,
})

minetest.register_craft({
	type = "fuel",
	recipe = "maple:fence_maple_wood",
	burntime = 8,
})
