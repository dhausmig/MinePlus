if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local S = minetest.get_translator("decor_furniture_medieval")

decor.register("bars", {
	description = S("Bars"),
	tiles = { { name = "decor_generic_metal.png^[transformR270", color = decor.color_black } },
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.50, -0.10, -0.4,  0.50,  0.10 },
			{ -0.1, -0.50, -0.10,  0.1,  0.50,  0.10 },
			{  0.4, -0.50, -0.10,  0.5,  0.50,  0.10 },
			{ -0.5, -0.50, -0.05,  0.5, -0.45,  0.05 },
			{ -0.5,  0.45, -0.05,  0.5,  0.50,  0.05 },
		},
	},
	selection_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.1, 0.5, 0.5, 0.1 },
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

--L Binding Bars
decor.register("L_binding_bars", {
	description = S("Binding Bars"),
	tiles = { { name = "decor_generic_metal.png^[transformR270", color = decor.color_black } },
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.10, -0.50, -0.50,  0.10,  0.50, -0.40 },
			{ -0.15, -0.50, -0.15,  0.15,  0.50,  0.15 },
			{  0.40, -0.50, -0.10,  0.50,  0.50,  0.10 },
			{  0.00, -0.50, -0.05,  0.50, -0.45,  0.05 },
			{ -0.05, -0.50, -0.50,  0.05, -0.45,  0.00 },
			{  0.00,  0.45, -0.05,  0.50,  0.50,  0.05 },
			{ -0.05,  0.45, -0.50,  0.05,  0.50,  0.00 },
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

-- Crafts

minetest.register_craft({
	output = "decor:bars 6",
	recipe = {
		{ "default:steel_ingot","default:steel_ingot","default:steel_ingot" },
		{ "decor:pole_wrought_iron","decor:pole_wrought_iron","decor:pole_wrought_iron" },
	},
})

minetest.register_craft({
	output = "decor:L_binding_bars 3",
	recipe = {
		{ "decor:bars","" },
		{ "decor:bars","decor:bars" },
	},
})
