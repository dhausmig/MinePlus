
local S = food.intllib

-- saucepan

minetest.register_craftitem("food:saucepan", {
	description = S("Saucepan"),
	inventory_image = "food_saucepan.png",
	groups = {food_saucepan = 1, flammable = 2}
})

minetest.register_craft({
	output = "food:saucepan",
	recipe = {
		{"default:steel_ingot", "", ""},
		{"", "group:stick", ""}
	}
})

-- cooking pot

minetest.register_craftitem("food:pot", {
	description = S("Cooking Pot"),
	inventory_image = "food_pot.png",
	groups = {food_pot = 1, flammable = 2}
})

minetest.register_craft({
	output = "food:pot",
	recipe = {
		{"group:stick", "default:steel_ingot", "default:steel_ingot"},
		{"", "default:steel_ingot", "default:steel_ingot"}
	}
})

-- baking tray

minetest.register_craftitem("food:baking_tray", {
	description = S("Baking Tray"),
	inventory_image = "food_baking_tray.png",
	groups = {food_baking_tray = 1, flammable = 2}
})

minetest.register_craft({
	output = "food:baking_tray",
	recipe = {
		{"default:clay_brick", "default:clay_brick", "default:clay_brick"},
		{"default:clay_brick", "", "default:clay_brick"},
		{"default:clay_brick", "default:clay_brick", "default:clay_brick"}
	}
})

-- skillet

minetest.register_craftitem("food:skillet", {
	description = S("Skillet"),
	inventory_image = "food_skillet.png",
	groups = {food_skillet = 1, flammable = 2}
})

minetest.register_craft({
	output = "food:skillet",
	recipe = {
		{"default:steel_ingot", "", ""},
		{"", "default:steel_ingot", ""},
		{"", "", "group:stick"}
	}
})

-- mortar and pestle

minetest.register_craftitem("food:mortar_pestle", {
	description = S("Mortar and Pestle"),
	inventory_image = "food_mortar_pestle.png",
	groups = {food_mortar_pestle = 1, flammable = 2}
})

minetest.register_craft({
	output = "food:mortar_pestle",
	recipe = {
		{"default:stone", "group:stick", "default:stone"},
		{"", "default:stone", ""}
	}
})

-- cutting board

minetest.register_craftitem("food:cutting_board", {
	description = S("Cutting Board"),
	inventory_image = "food_cutting_board.png",
	groups = {food_cutting_board = 1, flammable = 2}
})

minetest.register_craft({
	output = "food:cutting_board",
	recipe = {
		{"default:steel_ingot", "", ""},
		{"", "group:stick", ""},
		{"", "", "group:wood"}
	}
})

-- juicer

minetest.register_craftitem("food:juicer", {
	description = S("Juicer"),
	inventory_image = "food_juicer.png",
	groups = {food_juicer = 1, flammable = 2}
})

minetest.register_craft({
	output = "food:juicer",
	recipe = {
		{"", "default:stone", ""},
		{"default:stone", "", "default:stone"}
	}
})

-- glass mixing bowl

minetest.register_craftitem("food:mixing_bowl", {
	description = S("Glass Mixing Bowl"),
	inventory_image = "food_mixing_bowl.png",
	groups = {food_mixing_bowl = 1, flammable = 2}
})

minetest.register_craft({
	output = "food:mixing_bowl",
	recipe = {
		{"default:glass", "group:stick", "default:glass"},
		{"", "default:glass", ""}
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "vessels:glass_fragments",
	recipe = {
		"food:mixing_bowl"
	}
})
