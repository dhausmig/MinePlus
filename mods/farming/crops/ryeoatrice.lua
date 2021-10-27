
local S = farming.intllib

--= A nice addition from Ademant's grain mod :)

-- Rye

farming.register_plant("farming:rye", {
	description = S("Rye seed"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_rye_seed.png",
	steps = 8,
	place_param2 = 3
})

minetest.override_item("farming:rye", {
	description = S("Rye"),
	groups = {food_rye = 1, flammable = 4}
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:rye",
	burntime = 1
})

-- Oats

farming.register_plant("farming:oat", {
	description = S("Oat seed"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_oat_seed.png",
	steps = 8,
	place_param2 = 3
})

minetest.override_item("farming:oat", {
	description = S("Oats"),
	groups = {food_oats = 1, flammable = 4}
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:oat",
	burntime = 1
})

-- Rice

farming.register_plant("farming:rice", {
	description = S("Rice grains"),
	paramtype2 = "meshoptions",
	inventory_image = "farming_rice_seed.png",
	steps = 8,
	place_param2 = 3
})

minetest.override_item("farming:rice", {
	description = S("Rice"),
	groups = {food_rice = 1, flammable = 4}
})

minetest.register_craft({
	type = "fuel",
	recipe = "farming:rice",
	burntime = 1
})
