if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local S = minetest.get_translator("decor_laundry")
-- laundry devices

decor.register("washing_machine", {
	description = S("Washing Machine"),
	tiles = {
		"decor_washing_machine_top.png",
		"decor_washing_machine_bottom.png",
		"decor_washing_machine_sides.png",
		"decor_washing_machine_sides.png^[transformFX",
		"decor_washing_machine_back.png",
		"decor_washing_machine_front.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.375, 0.375},
			{-0.5, -0.5, 0.3125, 0.5, 0.5, 0.5},
		}
	},
	selection_box = { type = "regular" },
	groups = { snappy = 3 },
})

decor.register("dryer", {
	description = S("Tumble dryer"),
	tiles = {
		"decor_dryer_top.png",
		"decor_dryer_bottom.png",
		"decor_dryer_sides.png",
		"decor_dryer_sides.png^[transformFX",
		"decor_dryer_back.png",
		"decor_dryer_front.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.375, 0.375},
			{-0.5, -0.5, 0.3125, 0.5, 0.5, 0.5},
		}
	},
	selection_box = { type = "regular" },
	groups = { snappy = 3 },
})

local ib_cbox = {
	type = "fixed",
	fixed = { -6/16, -8/16, -4/16, 17/16, 4/16, 4/16 }
}

decor.register("ironing_board", {
	description = S("Ironing board"),
	mesh = "decor_ironing_board.obj",
	tiles = {
		"wool_grey.png",
		{ name = "decor_generic_metal.png", color = decor.color_med_grey },
	},
	expand = {right = "placeholder"},
	groups = { snappy = 3 },
	selection_box = ib_cbox,
	collision_box = ib_cbox
})

-- crafting


-- laundry stuff

minetest.register_craft( {
    output = "decor:washing_machine",
    recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "decor:ic" },
		{ "default:steel_ingot", "bucket:bucket_water", "default:steel_ingot" },
		{ "default:steel_ingot", "technic:motor", "default:steel_ingot" }
    },
})

minetest.register_craft( {
    output = "decor:dryer",
    recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "decor:ic" },
		{ "default:steel_ingot", "bucket:bucket_empty", "technic:motor" },
		{ "default:steel_ingot", "decor:heating_element", "default:steel_ingot" }
    },
})

minetest.register_craft( {
    output = "decor:ironing_board",
    recipe = {
		{ "wool:grey", "wool:grey", "wool:grey"},
		{ "", "default:steel_ingot", "" },
		{ "default:steel_ingot", "", "default:steel_ingot" }
    },
})

