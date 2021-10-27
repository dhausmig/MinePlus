--local S = rawget(_G, "intllib") and intllib.Getter() or function(s) return s end
--local S = function ( s ) return s end
local S = minetest.get_translator("technic_extranodes")

-- Artificial diamonds

minetest.register_craftitem(":technic:diamond_seed", {
	description = S("Diamond Seed"),
	inventory_image = "technic_diamond_seed.png",
})

minetest.register_craft({
	type = "cooking",
	output = "technic:diamond_seed",
	recipe = "technic:graphite"
})
