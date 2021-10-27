if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- This file adds fences of various types

local S = minetest.get_translator("decor_fences")

local materials = {
	{ S("brass"), "brass" },
	{ S("wrought iron"), "wrought_iron" },
}

for _, m in ipairs(materials) do

	local desc, name = unpack(m)

	decor.register("fence_"..name, {
		description = S("Fence/railing (@1)", desc),
		drawtype = "fencelike",
		tiles = {"decor_generic_metal_"..name..".png"},
		inventory_image = "decor_fence_"..name..".png",
		selection_box = decor.nodebox.bar_y(1/7),
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
	})

end

-- other types of fences

decor.register("fence_picket", {
	description = S("Unpainted Picket Fence"),
	tiles = {
		"decor_blanktile.png",
		"decor_blanktile.png",
		"decor_fence_picket.png",
		"decor_fence_picket.png",
		"decor_fence_picket_backside.png",
		"decor_fence_picket.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.slab_z(-0.1),
	node_box = decor.nodebox.slab_z(-0.002),
})

decor.register("fence_picket_corner", {
	description = S("Unpainted Picket Fence Corner"),
	tiles = {
		"decor_blanktile.png",
		"decor_blanktile.png",
		"decor_fence_picket.png",
		"decor_fence_picket_backside.png",
		"decor_fence_picket_backside.png",
		"decor_fence_picket.png",
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.corner_xz(0.1, -0.1),
	node_box = decor.nodebox.corner_xz(0.002, -0.002),
})

decor.register("fence_picket_white", {
	description = S("White Picket Fence"),
	tiles = {
		"decor_blanktile.png",
		"decor_blanktile.png",
		"decor_fence_picket_white.png",
		"decor_fence_picket_white.png",
		"decor_fence_picket_white_backside.png",
		"decor_fence_picket_white.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.slab_z(-0.1),
	node_box = decor.nodebox.slab_z(-0.002),
})

decor.register("fence_picket_corner_white", {
	description = S("White Picket Fence Corner"),
	tiles = {
		"decor_blanktile.png",
		"decor_blanktile.png",
		"decor_fence_picket_white.png",
		"decor_fence_picket_white_backside.png",
		"decor_fence_picket_white_backside.png",
		"decor_fence_picket_white.png",
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.corner_xz(0.1, -0.1),
	node_box = decor.nodebox.corner_xz(0.002, -0.002),
})

decor.register("fence_privacy", {
	description = S("Wooden Privacy Fence"),
	tiles = {
		"decor_fence_privacy_tb.png",
		"decor_fence_privacy_tb.png",
		"decor_fence_privacy_sides.png",
		"decor_fence_privacy_sides.png",
		"decor_fence_privacy_backside.png",
		"decor_fence_privacy_front.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.slab_z(-3/16),
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, 5/16, -5/16,  8/16, 7/16 },	-- left part
			{ -4/16, -8/16, 5/16,  3/16,  8/16, 7/16 },	-- middle part
			{  4/16, -8/16, 5/16,  8/16,  8/16, 7/16 },	-- right part
			{ -8/16, -2/16, 7/16,  8/16,  2/16, 8/16 },	-- connecting rung
		}
	},
})

decor.register("fence_privacy_corner", {
	description = S("Wooden Privacy Fence Corner"),
	tiles = {
		"decor_fence_privacy_corner_tb.png",
		"decor_fence_privacy_corner_tb.png^[transformFY",
		"decor_fence_privacy_corner_right.png",
		"decor_fence_privacy_backside2.png",
		"decor_fence_privacy_backside.png",
		"decor_fence_privacy_corner_front.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {
			decor.box.slab_z(-3/16),
			{ -0.5, -0.5, -0.5, -5/16, 0.5, 5/16 },
		}
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -7/16, -8/16, 5/16, -5/16, 8/16, 7/16 },	-- left part
			{ -4/16, -8/16, 5/16,  3/16, 8/16, 7/16 },	-- middle part
			{  4/16, -8/16, 5/16,  8/16, 8/16, 7/16 },	-- right part
			{ -8/16, -2/16, 7/16,  8/16, 2/16, 8/16 },	-- back-side connecting rung

			{ -7/16, -8/16,  4/16, -5/16, 8/16,  7/16 },	-- back-most part
			{ -7/16, -8/16, -4/16, -5/16, 8/16,  3/16 },	-- middle part
			{ -7/16, -8/16, -8/16, -5/16, 8/16, -5/16 },	-- front-most part
			{ -8/16, -2/16, -8/16, -7/16, 2/16,  7/16 },	-- left-side connecting rung
		}
	},
})

decor.register("fence_barbed_wire", {
	description = S("Barbed Wire Fence"),
	mesh = "decor_fence_barbed_wire.obj",
	tiles = {"decor_fence_barbed_wire.png"},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.slab_z(-0.125),
	collision_box = decor.nodebox.slab_z(-0.125),
})

decor.register("fence_barbed_wire_corner", {
	description = S("Barbed Wire Fence Corner"),
	mesh = "decor_fence_barbed_wire_corner.obj",
	tiles = { "decor_fence_barbed_wire.png" },
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.corner_xz(0.125, -0.125),
	collision_box = decor.nodebox.corner_xz(0.125, -0.125),
})

decor.register("fence_chainlink", {
	description = S("Chainlink Fence"),
	mesh="decor_fence_chainlink.obj",
	tiles = {
		"decor_fence_chainlink_tb.png",
		"decor_fence_chainlink_tb.png",
		"decor_fence_chainlink_sides.png",
		"decor_fence_chainlink_sides.png",
		"decor_fence_chainlink_fb.png",
		"decor_fence_chainlink_fb.png",
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.slab_z(-0.125),
	collision_box = decor.nodebox.slab_z(-0.125),
})


decor.register("fence_chainlink_corner", {
	description = S("Chainlink Fence Corner"),
	mesh = "decor_fence_chainlink_corner.obj",
	tiles = {
		"decor_fence_chainlink_corner_top.png",
		"decor_fence_chainlink_corner_top.png",
		"decor_fence_chainlink_corner_front.png",
		"decor_fence_chainlink_corner_front.png",
		"decor_fence_chainlink_corner_front.png",
		"decor_fence_chainlink_corner_front.png",
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.corner_xz(0.125, -0.125),
	collision_box = decor.nodebox.corner_xz(0.125, -0.125),
})

decor.register("fence_wrought_iron_2", {
	description = S("Wrought Iron fence (type 2)"),
	tiles = {
		"decor_fence_wrought_iron_2_tb.png",
		"decor_fence_wrought_iron_2_tb.png",
		"decor_fence_wrought_iron_2_sides.png",
		"decor_fence_wrought_iron_2_sides.png",
		"decor_fence_wrought_iron_2_fb.png",
		"decor_fence_wrought_iron_2_fb.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.slab_z(-0.08),
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16,  14/32, -7.75/16,  8/16,  16/32 }, -- left post
			{  7.75/16, -8/16,  14/32,  8/16,  8/16,  16/32 }, -- right post
			{ -8/16,  7.75/16, 14/32,  8/16,  8/16, 16/32 }, -- top piece
			{ -8/16,  -0.015625, 14.75/32,  8/16,  0.015625, 15.25/32 }, -- cross piece
			{ -0.015625, -8/16,  14.75/32,  0.015625,  8/16,  15.25/32 }, -- cross piece
			{ -8/16, -8/16, 14/32,  8/16, -7.75/16, 16/32 }, -- bottom piece
			{ -8/16, -8/16,  15/32,  8/16,  8/16,  15/32 }	-- the grid itself
		}
	},
})

decor.register("fence_wrought_iron_2_corner", {
	description = S("Wrought Iron fence (type 2) Corner"),
	tiles = {
		"decor_fence_corner_wrought_iron_2_tb.png",
		"decor_fence_corner_wrought_iron_2_tb.png",
		"decor_fence_corner_wrought_iron_2_sides.png^[transformFX",
		"decor_fence_corner_wrought_iron_2_sides.png",
		"decor_fence_corner_wrought_iron_2_sides.png^[transformFX",
		"decor_fence_corner_wrought_iron_2_sides.png"
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	selection_box = decor.nodebox.corner_xz(0.08, -0.08),
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.453125, -0.453125, 0.5, 0.5 }, -- corner edge
			{ -7.5/16,  7.75/16, 14/32,  8/16,  8/16, 16/32 },	-- top piece
			{ -7.5/16, -8/16, 14/32,  8/16, -7.75/16, 16/32 },	-- bottom piece
			{ -16/32,  7.75/16, -8/16, -14/32,  8/16,  8/16 },	-- top piece, side
			{ -16/32, -8/16, -8/16, -14/32, -7.75/16,  8/16 },	-- bottom piece, side
			{ -7.5/16, -8/16,  7.5/16,  8/16,  8/16,  7.5/16 },	-- the grid itself
			{ -7.5/16, -8/16, -8/16,  -7.5/16,  8/16,  7.5/16 },	-- the grid itself, side
			{ -15.5/32, -0.5, -0.5, -14.5/32, 0.5, -0.484375 }, -- left post side
			{  7.75/16, -8/16,  14.5/32,  8/16,  8/16,  15.5/32 }, -- right post
			{ -8/16,  -0.015625, 14.75/32,  8/16,  0.015625, 15.25/32 }, -- cross piece
			{ -0.015625, -8/16,  14.75/32,  0.015625,  8/16,  15.25/32 }, -- cross piece
			{ -15.25/32, -0.5, -0.015625, -14.75/32, 0.5, 0.015625 }, -- cross piece side
			{ -15.25/32, -0.015625, -0.5, -14.75/32, 0.015625, 0.5 } -- cross piece side
		}
	},
})

-- insert the old wood signs-on-metal-fences into signs_lib's conversion LBM
if minetest.get_modpath("signs_lib") then
	-- FIXME: export a function in signs_lib API to allow signs_lib to be read only in .luacheckrc
	table.insert(signs_lib.old_fenceposts_with_signs, "decor:fence_brass_with_sign")
	signs_lib.old_fenceposts["decor:fence_brass_with_sign"] = "decor:fence_brass"
	signs_lib.old_fenceposts_replacement_signs["decor:fence_brass_with_sign"] = "default:sign_wall_wood_onpole"

	table.insert(signs_lib.old_fenceposts_with_signs, "decor:fence_wrought_iron_with_sign")
	signs_lib.old_fenceposts["decor:fence_wrought_iron_with_sign"] = "decor:fence_wrought_iron"
	signs_lib.old_fenceposts_replacement_signs["decor:fence_wrought_iron_with_sign"] = "default:sign_wall_wood_onpole"
end

-- crafting

-- Brass/wrought iron fences

minetest.register_craft( {
        output = "decor:fence_brass 6",
	recipe = {
		{ "technic:brass_ingot", "technic:brass_ingot", "technic:brass_ingot" },
		{ "technic:brass_ingot", "technic:brass_ingot", "technic:brass_ingot" },
	},
})

minetest.register_craft( {
	output = "decor:fence_wrought_iron 6",
	recipe = {
		{ "default:iron_lump","default:iron_lump","default:iron_lump" },
		{ "default:iron_lump","default:iron_lump","default:iron_lump" },
	},
})

-- other types of fences

minetest.register_craft( {
	output = "decor:fence_wrought_iron_2 4",
	recipe = {
		{ "decor:pole_wrought_iron", "default:iron_lump" },
		{ "decor:pole_wrought_iron", "default:iron_lump" },
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_wrought_iron_2_corner",
	recipe = {
		"decor:fence_wrought_iron_2",
		"decor:fence_wrought_iron_2"
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_wrought_iron_2 2",
	recipe = {
		"decor:fence_wrought_iron_2_corner",
	},
})

--

minetest.register_craft( {
	output = "decor:fence_picket 6",
	recipe = {
		{ "group:stick", "group:stick", "group:stick" },
		{ "group:stick", "", "group:stick" },
		{ "group:stick", "group:stick", "group:stick" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_picket_corner",
	recipe = {
		"decor:fence_picket",
		"decor:fence_picket"
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_picket 2",
	recipe = {
		"decor:fence_picket_corner"
	},
})

--


minetest.register_craft( {
	output = "decor:fence_picket_white 6",
	recipe = {
		{ "group:stick", "group:stick", "group:stick" },
		{ "group:stick", "dye:white", "group:stick" },
		{ "group:stick", "group:stick", "group:stick" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_picket_corner_white",
	recipe = {
		"decor:fence_picket_white",
		"decor:fence_picket_white"
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_picket_white 2",
	recipe = {
		"decor:fence_picket_corner_white"
	},
})

--


minetest.register_craft( {
	output = "decor:fence_privacy 6",
	recipe = {
		{ "group:wood", "group:stick", "group:wood" },
		{ "group:wood", "", "group:wood" },
		{ "group:wood", "group:stick", "group:wood" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_privacy_corner",
	recipe = {
		"decor:fence_privacy",
		"decor:fence_privacy"
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_privacy 2",
	recipe = {
		"decor:fence_privacy_corner"
	},
})

--


minetest.register_craft( {
	output = "decor:fence_barbed_wire 6",
	recipe = {
		{ "group:stick", "decor:steel_wire", "group:stick" },
		{ "group:stick", "", "group:stick" },
		{ "group:stick", "decor:steel_wire", "group:stick" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_barbed_wire_corner",
	recipe = { "decor:fence_barbed_wire", "decor:fence_barbed_wire" },
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_barbed_wire 2",
	recipe = { "decor:fence_barbed_wire_corner" },
})

--

minetest.register_craft( {
	output = "decor:fence_chainlink 9",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "decor:steel_wire", "decor:steel_wire", "default:steel_ingot" },
		{ "decor:steel_wire", "decor:steel_wire", "default:steel_ingot" }
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_chainlink_corner",
	recipe = { "decor:fence_chainlink", "decor:fence_chainlink" },
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:fence_chainlink 2",
	recipe = { "decor:fence_chainlink_corner" },
})
