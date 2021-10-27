if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

-----------------
-- Metasequoia --
-----------------

-- Pulled from the paleotest mod
-- copied the license
-- didn't see any credits to copy

metasequoia = {}

minetest.register_node("metasequoia:trunk", {
    description = "Metasequoia Tree",
    tiles = {
        "metasequoia_tree_top.png",
        "metasequoia_tree_top.png",
		  "metasequoia_tree.png"
    },
    paramtype2 = "facedir",
    is_ground_content = false,
    groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
    sounds = default.node_sound_wood_defaults(),
    on_place = minetest.rotate_node
})

minetest.register_node("metasequoia:leaves", {
    description = "Metasequoia Leaves",
    drawtype = "allfaces_optional",
    waving = 1,
    tiles = {"metasequoia_leaves.png"},
    paramtype = "light",
    is_ground_content = false,
    groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
    drop = {
        max_items = 1,
        items = {
            {
                -- player will get sapling with 1/20 chance
                items = {"metasequoia:sapling"},
                rarity = 20
            }, {
                -- player will get leaves only if he get no saplings,
                -- this is because max_items is 1
                items = {"metasequoia:leaves"}
            }
        }
    },
    sounds = default.node_sound_leaves_defaults(),

--    after_place_node = after_place_leaves
})

local function grow_new_metasequoia_tree(pos)
    if not default.can_grow(pos) then
        minetest.get_node_timer(pos):start(300)
        return
    end
    local node = minetest.get_node(pos)
    if node.name == "metasequoia:sapling" then
        minetest.set_node(pos, {name = "air"})
        minetest.log("action", "A sapling grows into a tree at " ..
                         minetest.pos_to_string(pos))
        pos.x = pos.x - 7
        pos.y = pos.y - math.random(2, 4)
        pos.z = pos.z - 7
        minetest.place_schematic(pos, minetest.get_modpath("metasequoia") ..
                                     "/schems/metasequoia.mts",
                                 "random", nil, false)
    end
end

minetest.register_node("metasequoia:sapling", {
    description = "Metasequoia Sapling",
    drawtype = "plantlike",
    tiles = {"metasequoia_sapling.png"},
    inventory_image = "metasequoia_sapling.png",
    wield_image = "metasequoia_sapling.png",
    paramtype = "light",
    sunlight_propagates = true,
    walkable = false,
    on_timer = grow_new_metasequoia_tree,
    selection_box = {
        type = "fixed",
        fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
    },
    groups = {
        snappy = 2,
        dig_immediate = 3,
        flammable = 2,
        attached_node = 1,
        sapling = 1
    },
    sounds = default.node_sound_leaves_defaults(),

    on_construct = function(pos)
        minetest.get_node_timer(pos):start(math.random(1200, 1600))
    end,

    on_place = function(itemstack, placer, pointed_thing)
        itemstack = default.sapling_on_place(itemstack, placer, pointed_thing,
                                             "metasequoia:sapling",
                                             {x = -3, y = 1, z = -3},
                                             {x = 3, y = 6, z = 3}, 4)
        return itemstack
    end
})

minetest.register_node("metasequoia:wood", {
    description = "Metasequoia Wood Planks",
    paramtype2 = "facedir",
    place_param2 = 0,
    tiles = {"metasequoia_wood.png"},
    is_ground_content = false,
    groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
    sounds = default.node_sound_wood_defaults()
})

minetest.register_craft({
    output = "metasequoia:wood 4",
    recipe = {{"metasequoia:trunk"}}
})

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"default:dry_dirt_with_dry_grass", "default:dirt_with_rainforest_litter"},
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
	biomes = {"savanna", "rainforest"},
	y_min = 1,
	y_max = 31000,
	schematic = minetest.get_modpath("metasequoia").."/schems/metasequoia.mts",
	flags = "place_center_x, place_center_z",
})

--Support for bonemeal

if minetest.get_modpath("bonemeal") ~= nil then
	bonemeal:add_sapling({
		{"metasequoia:sapling", grow_new_metasequoia_tree, "soil"},
	})
end

-- Door and Gate

doors.register_fencegate(":doors:gate_metasequoia", {
	description = S("Metasequoia Wood Fence Gate"),
	texture = "metasequoia_wood.png",
	material = "metasequoia:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- Fence

default.register_fence("metasequoia:fence", {
    description = "Metasequoia Wood Fence",
    texture = "metasequoia_wood.png",
    inventory_image = "default_fence_overlay.png^metasequoia_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^metasequoia_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    material = "metasequoia:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("metasequoia:fence_rail", {
    description = "Metasequoia Wood Fence Rail",
    texture = "metasequoia_wood.png",
    inventory_image = "default_fence_rail_overlay.png^metasequoia_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^metasequoia_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "metasequoia:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

--Support for lumberjack mod

if minetest.get_modpath("lumberjack") and minetest.global_exists("lumberjack") then
	lumberjack.register_tree("metasequoia:trunk", "metasequoia:sapling", 1, 3)
end

--Shelves

vessels.register_shelf("metasequoia:metasequoia_shelf", {
	description = "Metasequoia Vessels Shelf",
	tiles = {"metasequoia_wood.png^[transformR90", "metasequoia_wood.png^[transformR90", "metasequoia_wood.png",
		"metasequoia_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"metasequoia:wood", "metasequoia:wood", "metasequoia:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"metasequoia:wood", "metasequoia:wood", "metasequoia:wood"},
	},
})

default.register_bookshelf("metasequoia:metasequoia", {
	description = "Metasequoia Bookshelf",
	tiles = {"metasequoia_wood.png^[transformR90", "metasequoia_wood.png^[transformR90", "metasequoia_wood.png",
		"metasequoia_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'metasequoia:metasequoia_bookshelf',
	recipe = {
		{'metasequoia:wood', 'metasequoia:wood', 'metasequoia:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'metasequoia:wood', 'metasequoia:wood', 'metasequoia:wood'},
	}
})

-- Stairs

if minetest.get_modpath("stairs") ~= nil then
	stairs.register_stair_and_slab(
		"metasequoia_trunk",
		"metasequoia:trunk",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"metasequoia_tree_top.png",
        "metasequoia_tree_top.png",
		  "metasequoia_tree.png"},
		"Metasequoia Trunk Stair",
		"Metasequoia Trunk Slab",
		default.node_sound_wood_defaults()
	)
	stairs.register_stair_and_slab(
		"metasequoia",
		"metasequoia:wood",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		{"metasequoia_wood.png"},
		"Metasequoia Stair",
		"Metasequoia Slab",
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"metasequoia",
		"trunk",
		"metasequoia:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"metasequoia_tree_top.png",
				"metasequoia_tree_top.png",
				"metasequoia_tree.png"
			},
			description = S("Metasequoia Trunk"),
			drop = "trunk",
		}
	)

	stairsplus:register_all(
		"metasequoia",
		"wood",
		"metasequoia:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "metasequoia_wood.png" },
			description = S("Metasequoia wood"),
			drop = "wood",
		}
	)
end
