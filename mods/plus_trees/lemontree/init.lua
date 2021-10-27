if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
--
-- Lemontree
--

local modname = "lemontree"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")
local fruit_grow_time = 1200

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

-- Lemon Fruit

minetest.register_node("lemontree:lemon", {
	description = S("Lemon"),
	drawtype = "plantlike",
	tiles = {"lemontree_lemon.png"},
	inventory_image = "lemontree_lemon.png",
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
		minetest.set_node(pos, {name = "lemontree:lemon", param2 = 1})
	end,

	on_dig = function(pos, node, digger)
		if digger:is_player() then
			local inv = digger:get_inventory()
			if inv:room_for_item("main", "lemontree:lemon") then
				inv:add_item("main", "lemontree:lemon")
			end
		end
		minetest.remove_node(pos)
		pos.y = pos.y + 1
		local node_above = minetest.get_node_or_nil(pos)
		if node_above and node_above.param2 == 0 and node_above.name == "lemontree:leaves" then
			local timer = minetest.get_node_timer(pos)
			timer:start(fruit_grow_time)
		end
	end,
})

-- lemontree

local function grow_new_lemontree_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-2, y = pos.y, z = pos.z-2}, modpath.."/schematics/lemontree.mts", "0", nil, false)
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
			scale = 0.00005,
			spread = {x = 250, y = 250, z = 250},
			seed = 5690,
			octaves = 3,
			persist = 0.66
		},
		biomes = {"deciduous_forest"},
		y_min = 1,
		y_max = 80,
		schematic = modpath.."/schematics/lemontree.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
	})
end

--
-- Nodes
--

minetest.register_node("lemontree:sapling", {
	description = S("Lemon Tree Sapling"),
	drawtype = "plantlike",
	tiles = {"lemontree_sapling.png"},
	inventory_image = "lemontree_sapling.png",
	wield_image = "lemontree_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_lemontree_tree,
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
			"lemontree:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)
		return itemstack
	end,
})

minetest.register_node("lemontree:trunk", {
	description = S("Lemon Tree Trunk"),
	tiles = {
		"lemontree_trunk_top.png",
		"lemontree_trunk_top.png",
		"lemontree_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	is_ground_content = false,
	on_place = minetest.rotate_node,
})

-- lemontree wood
minetest.register_node("lemontree:wood", {
	description = S("Lemon Tree Wood"),
	tiles = {"lemontree_wood.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- lemontree tree leaves
minetest.register_node("lemontree:leaves", {
	description = S("Lemon Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"lemontree_leaves.png"},
	inventory_image = "lemontree_leaves.png",
	wield_image = "lemontree_leaves.png",
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"lemontree:sapling"}, rarity = 20},
			{items = {"lemontree:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,

	on_timer = function(pos)
		pos.y = pos.y - 1
		local node = minetest.get_node_or_nil(pos)
		if node and node.name == "air" then
			minetest.set_node(pos, {name = "lemontree:lemon"})
			return false
		else
			return true
		end
    end
})

--
-- Craftitems
--

--
-- Recipes
--

minetest.register_craft({
	output = "lemontree:wood 4",
	recipe = {{"lemontree:trunk"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "lemontree:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "lemontree:wood",
	burntime = 7,
})

minetest.register_lbm({
	name = "lemontree:convert_lemontree_saplings_to_node_timer",
	nodenames = {"lemontree:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

default.register_leafdecay({
	trunks = {"lemontree:trunk"},
	leaves = {"lemontree:leaves"},
	radius = 3,
})

--Support for bonemeal

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"lemontree:sapling", grow_new_lemontree_tree, "soil"},
	})
end

-- Door and Gate

doors.register_fencegate(":doors:gate_lemontree", {
	description = S("Lemon Wood Fence Gate"),
	texture = "lemontree_wood.png",
	material = "lemontree:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- Fence

default.register_fence("lemontree:fence", {
    description = "lemontree Wood Fence",
    texture = "lemontree_wood.png",
    inventory_image = "default_fence_overlay.png^lemontree_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^lemontree_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    material = "lemontree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("lemontree:fence_rail", {
    description = "lemontree Wood Fence Rail",
    texture = "lemontree_wood.png",
    inventory_image = "default_fence_rail_overlay.png^lemontree_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^lemontree_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "lemontree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

--Support for lumberjack

if minetest.get_modpath("lumberjack") and minetest.global_exists("lumberjack") then
	lumberjack.register_tree("lemon_tree:trunk", "lemon_tree:sapling", 1, 3)
end

-- Shelves

vessels.register_shelf("lemontree:lemon_shelf", {
	description = "Lemonwood Vessels Shelf",
	tiles = {"lemontree_wood.png^[transformR90", "lemontree_wood.png^[transformR90", "lemontree_wood.png",
		"lemontree_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"lemontree:wood", "lemontree:wood", "lemontree:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"lemontree:wood", "lemontree:wood", "lemontree:wood"},
	},
})

default.register_bookshelf("lemontree:lemon", {
	description = "Lemonwood Bookshelf",
	tiles = {"lemontree_wood.png^[transformR90", "lemontree_wood.png^[transformR90", "lemontree_wood.png",
		"lemontree_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'lemontree:lemon_bookshelf',
	recipe = {
		{'lemontree:wood', 'lemontree:wood', 'lemontree:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'lemontree:wood', 'lemontree:wood', 'lemontree:wood'},
	}
})

-- Stairs

if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"lemontree_trunk",
		"lemontree:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"lemontree_trunk_top.png",
		"lemontree_trunk_top.png",
		"lemontree_trunk.png"},
		S("Lemon Tree Trunk Stair"),
		S("Lemon Tree Trunk Slab"),
		default.node_sound_wood_defaults()
	)
	stairs.register_stair_and_slab(
		"lemontree",
		"lemontree:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"lemontree_wood.png"},
		S("Lemon Wood Stair"),
		S("Lemon Wood Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"lemontree",
		"trunk",
		"lemontree:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"lemontree_trunk_top.png",
				"lemontree_trunk_top.png",
				"lemontree_trunk.png"
			},
			description = S("Lemontree Trunk"),
			drop = "lemontree_trunk",
		}
	)

	stairsplus:register_all(
		"lemontree",
		"wood",
		"lemontree:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "lemontree_wood.png" },
			description = S("Lemontree Wood"),
			drop = "lemontree_wood",
		}
	)
end


-- Cork

if minetest.get_modpath("cork") ~= nil then
	minetest.register_node("lemontree:trunk_nobark", {
		description = S("Lemon Tree Trunk"),
		tiles = {
			"lemontree_trunk_top.png",
			"lemontree_trunk_top.png",
			"lemontree_trunk_nobark.png"
		},
		groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
		paramtype2 = "facedir",
		is_ground_content = false,
		on_place = minetest.rotate_node,
	})

	minetest.register_craft({
		output = "lemontree:wood 4",
		recipe = {{"lemontree:trunk_nobark"}}
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "lemontree:trunk_nobark",
		burntime = 25,
	})
end