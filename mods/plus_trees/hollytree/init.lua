if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
--
-- Hollytree
--
local modname = "hollytree"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

-- Hollytree

local function grow_new_hollytree_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-4, y = pos.y, z = pos.z-4}, modpath.."/schematics/hollytree.mts", "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "v6" and mg_name ~= "singlenode" then

	local place_on
	local biomes
	local offset
	local scale

	if minetest.get_modpath("rainf") then
		place_on = "rainf:meadow"
		biomes = "rainf"
		offset = 0.0008
		scale = 0.00005
	else
		place_on = "default:dirt_with_grass"
		biomes = "grassland"
		offset = 0.00008
		scale = 0.00005
	end

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {place_on},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 250, y = 250, z = 250},
			seed = 789,
			octaves = 3,
			persist = 0.66
		},
		biomes = {biomes},
		y_min = 1,
		y_max = 32,
		schematic = modpath.."/schematics/hollytree.mts",
		flags = "place_center_x, place_center_z, force_placement",
		rotation = "random",
	})
end

--
-- Nodes
--

minetest.register_node("hollytree:sapling", {
	description = S("Holly Tree Sapling"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"hollytree_sapling.png"},
	inventory_image = "hollytree_sapling.png",
	wield_image = "hollytree_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_hollytree_tree,
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
			"hollytree:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("hollytree:trunk", {
	description = S("Holly Tree Trunk"),
	tiles = {
		"hollytree_trunk_top.png",
		"hollytree_trunk_top.png",
		"hollytree_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	is_ground_content = false,
	on_place = minetest.rotate_node,
})

-- hollytree wood
minetest.register_node("hollytree:wood", {
	description = S("Holly Tree Wood"),
	tiles = {"hollytree_wood.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- hollytree tree leaves
minetest.register_node("hollytree:leaves", {
	description = S("Holly Tree Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"hollytree_leaves.png"},
	inventory_image = "hollytree_leaves.png",
	wield_image = "hollytree_leaves.png",
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"hollytree:sapling"}, rarity = 20},
			{items = {"hollytree:leaves"}}
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
	output = "hollytree:wood 4",
	recipe = {{"hollytree:trunk"}}
})


minetest.register_craft({
	type = "fuel",
	recipe = "hollytree:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "hollytree:wood",
	burntime = 7,
})


minetest.register_lbm({
	name = "hollytree:convert_hollytree_saplings_to_node_timer",
	nodenames = {"hollytree:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

default.register_leafdecay({
	trunks = {"hollytree:trunk"},
	leaves = {"hollytree:leaves"},
	radius = 3,
})

--Support for bonemeal

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"hollytree:sapling", grow_new_hollytree_tree, "soil"},
	})
end

-- Door and Gate

doors.register_fencegate(":doors:gate_hollytree", {
	description = S("HollyWood Fence Gate"),
	texture = "hollytree_wood.png",
	material = "hollytree:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- Fence

default.register_fence("hollytree:fence", {
    description = "hollytree Wood Fence",
    texture = "hollytree_wood.png",
    inventory_image = "default_fence_overlay.png^hollytree_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^hollytree_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    material = "hollytree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("hollytree:fence_rail", {
    description = "hollytree Wood Fence Rail",
    texture = "hollytree_wood.png",
    inventory_image = "default_fence_rail_overlay.png^hollytree_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^hollytree_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "hollytree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

-- Shelves

vessels.register_shelf("hollytree:holly_shelf", {
	description = "Hollywood Vessels Shelf",
	tiles = {"hollytree_wood.png^[transformR90", "hollytree_wood.png^[transformR90", "hollytree_wood.png",
		"hollytree_wood.png", "vessels_orange_shelf.png", "vessels_orange_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"hollytree:wood", "hollytree:wood", "hollytree:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"hollytree:wood", "hollytree:wood", "hollytree:wood"},
	},
})

default.register_bookshelf("hollytree:hollywood", {
	description = "Hollywood Bookshelf",
	tiles = {"hollytree_wood.png^[transformR90", "hollytree_wood.png^[transformR90", "hollytree_wood.png",
		"hollytree_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'hollytree:hollywood_bookshelf',
	recipe = {
		{'hollytree:wood', 'hollytree:wood', 'hollytree:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'hollytree:wood', 'hollytree:wood', 'hollytree:wood'},
	}
})

-- Stairs

if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"hollytree_trunk",
		"hollytree:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"hollytree_trunk_top.png",
		"hollytree_trunk_top.png",
		"hollytree_trunk.png"},
		S("Hollytree Trunk Stair"),
		S("Hollytree Trunk Slab"),
		default.node_sound_wood_defaults()
	)
	stairs.register_stair_and_slab(
		"hollytree",
		"hollytree:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"hollytree_wood.png"},
		S("Hollytree Stair"),
		S("Hollytree Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"hollytree",
		"trunk",
		"hollytree:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"hollytree_trunk_top.png",
				"hollytree_trunk_top.png",
				"hollytree_trunk.png"
			},
			description = S("Hollytree Trunk"),
			drop = "hollytree_trunk",
		}
	)

	stairsplus:register_all(
		"hollytree",
		"hollytree_wood",
		"hollytree:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "hollytree_wood.png" },
			description = S("Hollytree wood"),
			drop = "hollytree_wood",
		}
	)
end
