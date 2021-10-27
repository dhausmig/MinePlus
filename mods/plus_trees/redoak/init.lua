if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
--
-- redoak
--

local modname = "redoak"
local modpath = minetest.get_modpath(modname)
local mg_name = minetest.get_mapgen_setting("mg_name")

-- internationalization boilerplate
local S = minetest.get_translator(minetest.get_current_modname())

--Acorn

minetest.register_node("redoak:acorn", {
	description = S("Acorn"),
	drawtype = "plantlike",
	tiles = {"redoak_acorn.png"},
	inventory_image = "redoak_acorn.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = false,
	selection_box = {
		type = "fixed",
		fixed = {-3 / 16, -7 / 16, -3 / 16, 3 / 16, 4 / 16, 3 / 16}
	},
	groups = {fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1, acorn = 1},
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),

	after_place_node = function(pos, placer, itemstack)
		minetest.set_node(pos, {name = "redoak:acorn", param2 = 1})
	end,
})

-- redoak

local function grow_new_redoak_tree(pos)
	if not default.can_grow(pos) then
		-- try a bit later again
		minetest.get_node_timer(pos):start(math.random(240, 600))
		return
	end
	minetest.remove_node(pos)
	minetest.place_schematic({x = pos.x-5, y = pos.y, z = pos.z-5}, modpath.."/schematics/redoak.mts", "0", nil, false)
end

--
-- Decoration
--

if mg_name ~= "v6" and mg_name ~= "singlenode" then

	if minetest.get_modpath("rainf") then
		place_on = "rainf:meadow"
		biomes = "rainf"
		offset = 0.0008
		scale = 0.00004
	else
		place_on = "default:dirt_with_grass"
		biomes = "grassland"
		offset = 0.0008
		scale = 0.00004
	end

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = {place_on},
		sidelen = 16,
		noise_params = {
			offset = offset,
			scale = scale,
			spread = {x = 250, y = 250, z = 250},
			seed = 6431,
			octaves = 3,
			persist = 0.66
		},
		biomes = {biomes},
		y_min = 1,
		y_max = 80,
		schematic = modpath.."/schematics/redoak.mts",
		flags = "place_center_x, place_center_z,  force_placement",
		rotation = "random",
		place_offset_y = 0,
	})
end

--
-- Nodes
--

minetest.register_node("redoak:sapling", {
	description = S("Redoak Sapling"),
	drawtype = "plantlike",
	tiles = {"redoak_sapling.png"},
	inventory_image = "redoak_sapling.png",
	wield_image = "redoak_sapling.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	on_timer = grow_new_redoak_tree,
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
			"redoak:sapling",
			-- minp, maxp to be checked, relative to sapling pos
			-- minp_relative.y = 1 because sapling pos has been checked
			{x = -2, y = 1, z = -2},
			{x = 2, y = 6, z = 2},
			-- maximum interval of interior volume check
			4)

		return itemstack
	end,
})

minetest.register_node("redoak:trunk", {
	description = S("Redoak Trunk"),
	tiles = {
		"redoak_trunk_top.png",
		"redoak_trunk_top.png",
		"redoak_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- redoak wood
minetest.register_node("redoak:wood", {
	description = S("Redoak Wood"),
	tiles = {"redoak_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

-- redoak tree leaves
minetest.register_node("redoak:leaves", {
	description = S("Redoak Leaves"),
	drawtype = "allfaces_optional",
	tiles = {"redoak_leaves.png"},
	inventory_image = "redoak_leaves.png",
	wield_image = "redoak_leaves.png",
	paramtype = "light",
	walkable = true,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"redoak:sapling"}, rarity = 20},
			{items = {"redoak:leaves"}}
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
	output = "redoak:wood 4",
	recipe = {{"redoak:trunk"}}
})

minetest.register_craft({
	type = "fuel",
	recipe = "redoak:trunk",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "redoak:wood",
	burntime = 7,
})


minetest.register_lbm({
	name = "redoak:convert_redoak_saplings_to_node_timer",
	nodenames = {"redoak:sapling"},
	action = function(pos)
		minetest.get_node_timer(pos):start(math.random(1200, 2400))
	end
})

default.register_leafdecay({
	trunks = {"redoak:trunk"},
	leaves = {"redoak:leaves"},
	radius = 3,
})

--Support for bonemeal

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"redoak:sapling", grow_new_redoak_tree, "soil"},
	})
end

-- Door and Gate

if minetest.get_modpath("doors") ~= nil then
	doors.register("door_redoak_wood", {
			tiles = {{ name = "redoak_door_wood.png", backface_culling = true }},
			use_texture_alpha = "clip",
			description = S("redoak Wood Door"),
			inventory_image = "redoak_item_wood.png",
			groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
			recipe = {
				{"redoak:wood", "redoak:wood"},
				{"redoak:wood", "redoak:wood"},
				{"redoak:wood", "redoak:wood"},
			}
	})

doors.register_fencegate(":doors:gate_redoak", {
	description = S("Red Oak Fence Gate"),
	texture = "redoak_wood.png",
	material = "redoak:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})
end

-- Fence

default.register_fence("redoak:fence", {
    description = "redoak Wood Fence",
    texture = "redoak_wood.png",
    inventory_image = "default_fence_overlay.png^redoak_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^redoak_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    material = "redoak:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("redoak:fence_rail", {
    description = "redoak Wood Fence Rail",
    texture = "redoak_wood.png",
    inventory_image = "default_fence_rail_overlay.png^redoak_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^redoak_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "redoak:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

--Support for lumberjack mod

if minetest.get_modpath("lumberjack") and minetest.global_exists("lumberjack") then
	lumberjack.register_tree("redoak:trunk", "redoak:sapling", 1, 3)
end

-- Shelves

vessels.register_shelf("redoak:redoak_shelf", {
	description = "redoak Vessels Shelf",
	tiles = {"redoak_wood.png^[transformR90", "redoak_wood.png^[transformR90", "redoak_wood.png",
		"redoak_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"redoak:wood", "redoak:wood", "redoak:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"redoak:wood", "redoak:wood", "redoak:wood"},
	},
})

default.register_bookshelf("redoak:redoak", {
	description = "redoak Bookshelf",
	tiles = {"redoak_wood.png^[transformR90", "redoak_wood.png^[transformR90", "redoak_wood.png",
		"redoak_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'redoak:redoak_bookshelf',
	recipe = {
		{'redoak:wood', 'redoak:wood', 'redoak:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'redoak:wood', 'redoak:wood', 'redoak:wood'},
	}
})

-- Stairs

if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"redoak_trunk",
		"redoak:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"redoak_trunk_top.png",
		"redoak_trunk_top.png",
		"redoak_trunk.png"},
		S("Redoak Trunk Stair"),
		S("Redoak Trunk Slab"),
		default.node_sound_wood_defaults()
	)
	stairs.register_stair_and_slab(
		"redoak",
		"redoak:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"redoak_wood.png"},
		S("Redoak Stair"),
		S("Redoak Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"redoak",
		"trunk",
		"redoak:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"redoak_trunk_top.png",
				"redoak_trunk_top.png",
				"redoak_trunk.png"
			},
			description = S("redoak Trunk"),
			drop = "redoak_trunk",
		}
	)

	stairsplus:register_all(
		"redoak",
		"wood",
		"redoak:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "redoak_wood.png" },
			description = S("redoak Wood"),
			drop = "redoak_wood",
		}
	)
end
