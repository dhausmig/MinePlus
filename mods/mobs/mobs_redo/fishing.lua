
local S = mobs.intllib

-- Raw Fish (Thanks to Altairas for her Fish image on DeviantArt)
minetest.register_craftitem("mobs:fish_raw", {
	description = S("Raw Fish"),
	inventory_image = "fish_raw.png",
	wield_image = "fish_raw.png",
	groups = {food_fish_raw = 1, flammable = 3},
	on_use = minetest.item_eat(2),
})

-- Worm
minetest.register_craftitem("mobs:worm", {
	description = S("Worm"),
	inventory_image = "worm.png",
	wield_image = "worm.png",
})

-- Sift through 2 Dirt Blocks to find Worm
minetest.register_craft({
	output = "mobs:worm 3",
	recipe = {
		{"default:dirt","default:dirt"},
	}
})

-- Fishing Rod
minetest.register_craftitem("mobs:fishing_rod", {
	description = S("Fishing Rod"),
	inventory_image = "fishing_rod.png",
	wield_image = "fishing_rod.png",
})

minetest.register_craft({
	output = "mobs:fishing_rod",
	recipe = {
			{"","","default:stick"},
			{"", "default:stick", "farming:string"},
			{"default:stick", "", "farming:string"},
		}
})

-- default mobs fish
mobs.fish = {
	{"mobs:fish_raw"},
}


-- Fishing Rod (Baited)
minetest.register_craftitem("mobs:fishing_rod_baited", {
	description = S("Baited Fishing Rod"),
	inventory_image = "fishing_rod_baited.png",
	wield_image = "fishing_rod_wield.png",
	stack_max = 1,
	liquids_pointable = true,

	on_use = function (itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end
		
		local node = minetest.get_node(pointed_thing.under).name

		if (node == "default:water_source"
		or node == "default:river_water_source")
		and math.random(1, 100) < 5 then

			local type = mobs.fish[math.random(1, #mobs.fish)][1]
			local inv = user:get_inventory()

			if inv:room_for_item("main", {name = type}) then

				inv:add_item("main", {name = type})

				return ItemStack("mobs:fishing_rod")
			else
				minetest.chat_send_player(user:get_player_name(),
					S("Inventory full, Fish Got Away!"))
			end
		end
	end,
})

minetest.register_craft({
	type = "shapeless",
	output = "mobs:fishing_rod_baited",
	recipe = {"mobs:fishing_rod", "mobs:worm"},
})
