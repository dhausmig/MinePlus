local S = moretrees.intllib

for i in ipairs(moretrees.treelist) do
	local treename = moretrees.treelist[i][1]

	minetest.register_craft({
		type = "shapeless",
		output = "moretrees:"..treename.."_planks 4",
		recipe = {
			"moretrees:"..treename.."_trunk"
		}
	})

	minetest.register_craft({
		type = "fuel",
		recipe = "moretrees:"..treename.."_sapling",
		burntime = 10,
	})
end

minetest.register_craft({
	type = "shapeless",
	output = "moretrees:rubber_tree_planks 4",
	recipe = {
		"moretrees:rubber_tree_trunk_empty"
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:moretrees_leaves",
	burntime = 1,
})

-- Food recipes!

minetest.register_craftitem("moretrees:date", {
	description = S("Date"),
	inventory_image = "moretrees_date.png",
	on_use = minetest.item_eat(1),
})
