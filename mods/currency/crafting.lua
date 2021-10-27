if minetest.get_modpath("default") then
	minetest.register_craft({
		output = "currency:safe",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot",
				"default:steel_ingot"},
			{"default:steel_ingot", "default:mese_crystal",
				"default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot",
				"default:steel_ingot"},
		}
	})

	minetest.register_craft({
		output = "currency:shop",
		recipe = {
			{"default:sign_wall"},
			{"default:chest_locked"},
		}
	})

	minetest.register_craft({
		output = "currency:barter",
		recipe = {
			{"default:sign_wall"},
			{"default:chest"},
		}
	})
end

-- coins and bundle removed

-- ones
minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld 5",
	recipe = {"currency:minegeld_5"},
})

-- fives
minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_5",
	recipe = {
		"currency:minegeld",
		"currency:minegeld",
		"currency:minegeld",
		"currency:minegeld",
		"currency:minegeld"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_5 2",
	recipe = {"currency:minegeld_10"},
})

-- tens
minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_10",
	recipe = {
		"currency:minegeld_5",
		"currency:minegeld",
		"currency:minegeld",
		"currency:minegeld",
		"currency:minegeld",
		"currency:minegeld"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_10",
	recipe = {
		"currency:minegeld_5",
		"currency:minegeld_5"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_10 2",
	recipe = {"currency:minegeld_20"},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_10 5",
	recipe = {"currency:minegeld_50"},
})

-- twenties
minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_20",
	recipe = {
		"currency:minegeld_5",
		"currency:minegeld_5",
		"currency:minegeld_5",
		"currency:minegeld_5"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_20",
	recipe = {
		"currency:minegeld_10",
		"currency:minegeld_5",
		"currency:minegeld_5"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_20",
	recipe = {
		"currency:minegeld_10",
		"currency:minegeld_10"
	},
})

-- fifties
minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_50",
	recipe = {
		"currency:minegeld_10",
		"currency:minegeld_10",
		"currency:minegeld_10",
		"currency:minegeld_10",
		"currency:minegeld_10"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_50",
	recipe = {
		"currency:minegeld_20",
		"currency:minegeld_20",
		"currency:minegeld_10"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_50 2",
	recipe = {"currency:minegeld_100" },
})

-- hundreds
minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_100",
	recipe = {
		"currency:minegeld_20",
		"currency:minegeld_20",
		"currency:minegeld_20",
		"currency:minegeld_20",
		"currency:minegeld_20"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "currency:minegeld_100",
	recipe = {
		"currency:minegeld_50",
		"currency:minegeld_50"
	},
})

