if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

local S = minetest.get_translator("decor_clocks")

local clock_sbox = {
	type = "fixed",
	fixed = { -8/32, -8/32, 14/32, 8/32, 8/32, 16/32 }
}

local clock_materials = {
	{ "plastic", S("Plastic analog clock"), "decor_generic_plastic.png" },
	{ "wood", S("Wooden analog clock"), "default_wood.png" }
}

for _, mat in ipairs(clock_materials) do
	local name, desc, tex = unpack(mat)
	decor.register("analog_clock_"..name, {
		description = desc,
		mesh = "decor_analog_clock.obj",
		tiles = {
			"decor_analog_clock_face.png",
			tex,
			"decor_analog_clock_back.png"
		},
		inventory_image = "decor_analog_clock_"..name.."_inv.png",
		walkable = false,
		selection_box = clock_sbox,
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
	})
end

decor.register("digital_clock", {
	description = S("Digital clock"),
	tiles = {
		"decor_digital_clock_edges.png",
		"decor_digital_clock_edges.png",
		"decor_digital_clock_edges.png",
		"decor_digital_clock_edges.png",
		"decor_digital_clock_back.png",
		"decor_digital_clock_front.png"
	},
	inventory_image = "decor_digital_clock_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.28125, -0.25, 0.4375, 0.3125, 0.25, 0.5},
		}
	},
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
	groups = {snappy=3},
})

decor.register("alarm_clock", {
	description = S("Alarm clock"),
	tiles = {
		"decor_alarm_clock_top.png",
		"decor_alarm_clock_bottom.png",
		"decor_alarm_clock_sides.png",
		"decor_alarm_clock_sides.png^[transformFX",
		"decor_alarm_clock_back.png",
		"decor_alarm_clock_front.png"
	},
	inventory_image = "decor_alarm_clock_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{ -9/32, -16/32, 7/32, 10/32, -5/32, 16/32 },
		}
	},
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
	groups = {snappy=3},
})

local gf_cbox = {
	type = "fixed",
	fixed = { -7/16, -8/16, -7/16, 7/16, 24/16, 7/16 }
}

decor.register("grandfather_clock", {
	description = S("Grandfather Clock"),
	mesh = "decor_grandfather_clock.obj",
	tiles = {
		"default_glass.png",
		"decor_grandfather_clock_face.png",
		decor.lux_wood,
		"decor_grandfather_clock_face_edge.png",
		"decor_generic_metal_brass.png"
	},
	inventory_image = "decor_grandfather_clock_inv.png",
	groups = { snappy = 3 },
	selection_box = gf_cbox,
	collision_box = gf_cbox,
	sounds = default.node_sound_wood_defaults(),
	expand = { top="placeholder" },
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple or nil,
})

-- crafting


minetest.register_craft({
    output = "decor:analog_clock_plastic 2",
    recipe = {
		{ "default:plastic_sheet", "dye:black", "default:plastic_sheet" },
		{ "default:plastic_sheet", "decor:ic", "default:plastic_sheet" },
		{ "default:plastic_sheet", "dye:black", "default:plastic_sheet" },
    },
})

minetest.register_craft({
    output = "decor:analog_clock_wood 2",
    recipe = {
		{ "group:stick", "dye:black", "group:stick" },
		{ "group:stick", "decor:ic", "group:stick" },
		{ "group:stick", "dye:black", "group:stick" },
    },
})

minetest.register_craft({
    output = "decor:digital_clock 2",
    recipe = {
		{ "default:plastic_sheet", "default:paper", "default:plastic_sheet" },
		{ "default:plastic_sheet", "decor:ic", "default:plastic_sheet" },
		{ "default:plastic_sheet", "default:mese_crystal", "default:plastic_sheet" },
    },
})

minetest.register_craft({
    output = "decor:alarm_clock",
    recipe = {
		{ "default:plastic_sheet", "decor:speaker_driver", "default:plastic_sheet" },
		{ "default:plastic_sheet", "decor:digital_clock", "default:plastic_sheet" },
		{ "default:plastic_sheet", "default:mese_crystal", "default:plastic_sheet" },
    },
})

minetest.register_craft({
	output = "decor:grandfather_clock",
	recipe = {
		{ "building_blocks:slab_hardwood","decor:analog_clock_wood","building_blocks:slab_hardwood" },
		{ "building_blocks:slab_hardwood","technic:brass_ingot","building_blocks:slab_hardwood" },
		{ "building_blocks:slab_hardwood","technic:brass_ingot","building_blocks:slab_hardwood" }
	},
})

-- aliases

minetest.register_alias("decor:grandfather_clock_bottom", "decor:grandfather_clock")
minetest.register_alias("decor:grandfather_clock_top", "air")
