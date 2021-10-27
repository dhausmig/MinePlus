-- this component contains all of the random types of seating previously
-- scattered among decor's other mods

local dc_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 0, 1 }
}

decor.register("deckchair", {
	mesh = "decor_deckchair.obj",
	tiles = {"decor_deckchair.png"},
	description = "Deck Chair",
	groups = { snappy = 3 },
	expand = { forward="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	selection_box = dc_cbox,
	collision_box = dc_cbox,
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil,
})

minetest.register_alias("decor:deckchair_foot", "decor:deckchair")
minetest.register_alias("decor:deckchair_head", "air")

decor.register("deckchair_striped_blue", {
	mesh = "decor_deckchair.obj",
	tiles = {"decor_deckchair_striped_blue.png"},
	description = "Deck Chair (blue striped)",
	groups = { snappy = 3 },
	expand = { forward="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	selection_box = dc_cbox,
	collision_box = dc_cbox,
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil,
})

decor.register("simple_bench", {
	tiles = { "decor_generic_wood_old.png" },
	description = "Simple Bench",
	groups = {snappy=3},
	node_box = {
	type = "fixed",
	fixed = {
			{-0.5, -0.15, 0,  0.5,  -0.05, 0.4},
			{-0.4, -0.5,  0.1, -0.3, -0.15, 0.3},
			{ 0.3, -0.5,  0.1,  0.4, -0.15, 0.3},
			}
	},
	sounds = default.node_sound_wood_defaults(),
})

local bl1_sbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.25, 1.5, 0.5, 0.5 }
}

local bl1_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.25, 1.5, 0, 0.5 },
		{-0.5, -0.5, 0.45, 1.5, 0.5, 0.5 },
	}
}

decor.register("bench_large_1", {
	mesh = "decor_bench_large_1.obj",
	tiles = {
		"decor_generic_wood_old.png",
		"decor_generic_metal_wrought_iron.png"
	},
	description = "Garden Bench (style 1)",
	inventory_image = "decor_bench_large_1_inv.png",
	groups = { snappy = 3 },
	expand = { right="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	selection_box = bl1_sbox,
	node_box = bl1_cbox,
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil,
})

minetest.register_alias("decor:bench_large_1_left", "decor:bench_large_1")
minetest.register_alias("decor:bench_large_1_right", "air")

local bl2_sbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.25, 1.5, 0.5, 0.5 }
}

local bl2_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.25, 1.5, 0, 0.5 },
		{-0.5, -0.5, 0.45, 1.5, 0.5, 0.5 },
	}
}

decor.register("bench_large_2", {
	description = "Garden Bench (style 2)",
	mesh = "decor_bench_large_2.obj",
	tiles = { "decor_generic_wood_old.png" },
	inventory_image = "decor_bench_large_2_inv.png",
	groups = {snappy=3},
	selection_box = bl2_sbox,
	node_box = bl2_cbox,
	expand = { right="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil,
})

minetest.register_alias("decor:bench_large_2_left", "decor:bench_large_2")
minetest.register_alias("decor:bench_large_2_right", "air")

local kc_cbox = {
	type = "fixed",
	fixed = { -0.3125, -0.3125, -0.5, 0.3125, 0.3125, 0.5 },
}

decor.register("kitchen_chair_wood", {
	description = "Kitchen chair",
	mesh = "decor_kitchen_chair.obj",
	tiles = {
		decor.plain_wood,
		decor.plain_wood
	},
	inventory_image = "decor_chair_wood_inv.png",
	paramtype2 = "wallmounted",
	selection_box = kc_cbox,
	collision_box = kc_cbox,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = unifieddyes.fix_rotation_nsew,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y+0 -- where do I put my ass ?
		decor.sit(pos, node, clicker)
		return itemstack
	end
})

decor.register("kitchen_chair_padded", {
	description = "Kitchen chair",
	mesh = "decor_kitchen_chair.obj",
	tiles = {
		decor.plain_wood,
		"wool_white.png",
	},
	inventory_image = "decor_chair_padded_inv.png",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = kc_cbox,
	collision_box = kc_cbox,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
	end,
	on_dig = unifieddyes.on_dig,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		pos.y = pos.y+0 -- where do I put my ass ?
		decor.sit(pos, node, clicker)
		return itemstack
	end
})

local ofchairs_sbox = {
	type = "fixed",
	fixed = { -8/16, -8/16, -8/16, 8/16, 29/32, 8/16 }
}
local ofchairs_cbox = {
	type = "fixed",
	fixed = {
		{ -5/16,   1/16, -7/16,  5/16,   4/16,  7/16 }, -- seat
		{ -5/16,   4/16,  4/16,  5/16,  29/32, 15/32 }, -- seatback
		{ -1/16, -11/32, -1/16,  1/16,   1/16,  1/16 }, -- cylinder
		{ -8/16,  -8/16, -8/16,  8/16, -11/32,  8/16 }  -- legs/wheels
	}
}

local chairs = {
	{ "basic",   "Basic office chair" },
	{ "upscale", "Upscale office chair" },
}

for _, c in pairs(chairs) do
	local name, desc = unpack(c)
	decor.register("office_chair_"..name, {
		description = desc,
		drawtype = "mesh",
		tiles = { "decor_office_chair_"..name..".png" },
		mesh = "decor_office_chair_"..name..".obj",
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		selection_box = ofchairs_sbox,
		collision_box = ofchairs_cbox,
		expand = { top = "placeholder" },
		on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple or nil,
	})
end

-- crafts!

minetest.register_craft( {
        output = "decor:bench_large_1",
        recipe = {
			{ "group:wood", "group:wood", "group:wood" },
			{ "group:wood", "group:wood", "group:wood" },
			{ "default:steel_bar", "", "default:steel_bar" }
        },
})

minetest.register_craft( {
        output = "decor:bench_large_2_left",
        recipe = {
			{ "decor:shutter_oak", "decor:shutter_oak", "decor:shutter_oak" },
			{ "group:wood", "group:wood", "group:wood" },
			{ "stairs:slab_wood", "", "stairs:slab_wood" }
        },
})

minetest.register_craft( {
        output = "decor:simple_bench",
        recipe = {
			{ "stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood" },
			{ "stairs:slab_wood", "", "stairs:slab_wood" }
        },
})

minetest.register_craft({
	output = "decor:deckchair",
	recipe = {
		{ "group:stick", "building_blocks:terrycloth_towel", "group:stick" },
		{ "group:stick", "building_blocks:terrycloth_towel", "group:stick" },
		{ "group:stick", "building_blocks:terrycloth_towel", "group:stick" }
	},
})

minetest.register_craft({
	output = "decor:deckchair_striped_blue",
	type = "shapeless",
	recipe = {
		"decor:deckchair",
		"dye:blue"
	}
})

minetest.register_craft({
	output = "decor:kitchen_chair_wood 2",
	recipe = {
		{ "group:stick",""},
		{ "group:wood","group:wood" },
		{ "group:stick","group:stick" },
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "decor:kitchen_chair_padded",
	recipe = {
		"decor:kitchen_chair_wood",
		"wool:white",
	},
})

unifieddyes.register_color_craft({
	output = "decor:kitchen_chair_padded",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "decor:kitchen_chair_padded",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:kitchen_chair_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:kitchen_chair_padded",
	burntime = 15,
})


minetest.register_craft({
	output = "decor:office_chair_basic",
	recipe = {
		{ "", "", "wool:black" },
		{ "", "wool:black", "default:steel_ingot" },
		{ "group:stick", "default:steel_bar", "group:stick" }
	},
})

minetest.register_craft({
	output = "decor:office_chair_upscale",
	recipe = {
		{ "dye:black", "building_blocks:sticks", "group:wool" },
		{ "default:plastic_sheet", "group:wool", "default:steel_ingot" },
		{ "building_blocks:sticks", "default:steel_bar", "building_blocks:sticks" }
	},
})

-- aliases

minetest.register_alias("3dforniture:chair", "decor:chair")
minetest.register_alias('chair', 'decor:chair')
