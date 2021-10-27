-- from ethereal
local S = farming.intllib

-- Strawberry (can also be planted as seed)
minetest.register_craftitem("farming:strawberry", {
	description = S("Strawberry"),
	inventory_image = "farming_strawberry.png",
	wield_image = "farming_strawberry.png",
	groups = {food_strawberry = 1, food_berry = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:strawberry_1")
	end,
	on_use = minetest.item_eat(1),
})

-- Define Strawberry Bush growth stages
local crop_def = {
	drawtype = "plantlike",
	tiles = {"farming_strawberry_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5}
	},
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults(),
}

--stage 1
minetest.register_node("farming:strawberry_1", table.copy(crop_def))

-- stage 2
crop_def.tiles = {"farming_strawberry_2.png"}
minetest.register_node("farming:strawberry_2", table.copy(crop_def))

-- stage 3
crop_def.tiles = {"farming_strawberry_3.png"}
minetest.register_node("farming:strawberry_3", table.copy(crop_def))

-- stage 4
crop_def.tiles = {"farming_strawberry_4.png"}
minetest.register_node("farming:strawberry_4", table.copy(crop_def))

-- stage 5
crop_def.tiles = {"farming_strawberry_5.png"}
minetest.register_node("farming:strawberry_5", table.copy(crop_def))

-- stage 6
crop_def.tiles = {"farming_strawberry_6.png"}
crop_def.drop = {
	items = {
		{items = {"farming:strawberry 1"},rarity = 2},
		{items = {"farming:strawberry 2"},rarity = 3},
	}
}
minetest.register_node("farming:strawberry_6", table.copy(crop_def))

-- stage 7
crop_def.tiles = {"farming_strawberry_7.png"}
crop_def.drop = {
	items = {
		{items = {"farming:strawberry 1"},rarity = 1},
		{items = {"farming:strawberry 2"},rarity = 3},
	}
}
minetest.register_node("farming:strawberry_7", table.copy(crop_def))

-- stage 8
crop_def.tiles = {"farming_strawberry_8.png"}
crop_def.groups.growing = 0
crop_def.drop = {
	items = {
		{items = {"farming:strawberry 2"},rarity = 1},
		{items = {"farming:strawberry 3"},rarity = 3},
	}
}
minetest.register_node("farming:strawberry_8", table.copy(crop_def))

-- add to registered_plants
farming.registered_plants["farming:strawberry"] = {
	crop = "farming:strawberry",
	seed = "farming:strawberry",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}

