minetest.register_node("furn:endtable", {
	description = "End Table",
	drawtype = "nodebox",
	tiles = {"furn_coffeetable_back.png", "furn_coffeetable_back.png",  "furn_coffeetable_back.png",  "furn_coffeetable_back.png",  "furn_coffeetable_back.png",  "furn_coffeetable_back.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	stack_max = 1,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					--legs
					{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.3125},
					{0.3125, -0.5, -0.375, 0.375, -0.0625, -0.3125},
					{-0.375, -0.5, 0.3125, -0.3125, -0.0625, 0.375},
					{0.3125, -0.5, 0.3125, 0.375, -0.0625, 0.375},
					
					--tabletop
					{-0.4375, -0.0625, -0.4375, 0.4375, 0, 0.4375},	
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.4375, -0.5, -0.4375, 0.4375, 0.0, 0.4375},
				}
	},
})

minetest.register_craft({
	output = "furn:endtable",
	recipe = {
		{"", "", "", },
		{"stairs:slab_wood", "stairs:slab_wood", "", },
		{"default:stick", "default:stick", "", }
	}
})

minetest.register_craft({
	output = "furn:endtable",
	recipe = {
		{"", "", "", },
		{"moreblocks:slab_wood", "moreblocks:slab_wood", "", },
		{"default:stick", "default:stick", "", }
	}
})

minetest.register_craft({
	output = "furn:endtable",
	recipe = {
		{"", "", "", },
		{"group:wood_slab", "group:wood_slab", "", },
		{"default:stick", "default:stick", "", }
	}
})
