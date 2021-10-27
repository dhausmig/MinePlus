
--[[
	Original textures from GeMinecraft
	http://www.minecraftforum.net/forums/mapping-and-modding/minecraft-mods/wip-mods/1440575-1-2-5-generation-minecraft-beta-1-2-farming-and
]]

local S = farming.intllib

-- corn
minetest.register_craftitem("farming:corn", {
	description = S("Corn"),
	inventory_image = "farming_corn.png",
	groups = {seed = 2, food_corn = 1, flammable = 2},
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:corn_1")
	end,
	on_use = minetest.item_eat(3)
})

-- corn definition
local def = {
	drawtype = "plantlike",
	tiles = {"farming_corn_1.png"},
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = default.node_sound_leaves_defaults()
}

-- stage 1
minetest.register_node("farming:corn_1", table.copy(def))

-- stage 2
def.tiles = {"farming_corn_2.png"}
minetest.register_node("farming:corn_2", table.copy(def))

-- stage 3
def.tiles = {"farming_corn_3.png"}
minetest.register_node("farming:corn_3", table.copy(def))

-- stage 4
def.tiles = {"farming_corn_4.png"}
minetest.register_node("farming:corn_4", table.copy(def))

-- stage 5
def.tiles = {"farming_corn_5.png"}
minetest.register_node("farming:corn_5", table.copy(def))

-- stage 6
def.tiles = {"farming_corn_6.png"}
def.visual_scale = 1.9
minetest.register_node("farming:corn_6", table.copy(def))

-- stage 7
def.tiles = {"farming_corn_7.png"}
def.drop = {
	items = {
		{items = {"farming:corn"}, rarity = 1},
		{items = {"farming:corn"}, rarity = 2},
		{items = {"farming:corn"}, rarity = 3}
	}
}
minetest.register_node("farming:corn_7", table.copy(def))

-- stage 8 (final)
def.tiles = {"farming_corn_8.png"}
def.groups.growing = nil
def.drop = {
	items = {
		{items = {"farming:corn 2"}, rarity = 1},
		{items = {"farming:corn 2"}, rarity = 2},
		{items = {"farming:corn 2"}, rarity = 2}
	}
}
minetest.register_node("farming:corn_8", table.copy(def))

-- add to registered_plants
farming.registered_plants["farming:corn"] = {
	crop = "farming:corn",
	seed = "farming:corn",
	minlight = farming.min_light,
	maxlight = farming.max_light,
	steps = 8
}
