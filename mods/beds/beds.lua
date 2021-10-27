-- Fancy shaped bed

beds.register_bed("beds:fancy_bed", {
	description = "Fancy Bed",
	inventory_image = "beds_bed_fancy.png",
	wield_image = "beds_bed_fancy.png",
	tiles = {
		bottom = {
			"beds_bed_top1.png",
			"default_wood.png",
			"beds_bed_side1.png",
			"beds_bed_side1.png^[transformFX",
			"default_wood.png",
			"beds_bed_foot.png",
		},
		top = {
			"beds_bed_top2.png",
			"default_wood.png",
			"beds_bed_side2.png",
			"beds_bed_side2.png^[transformFX",
			"beds_bed_head.png",
			"default_wood.png",
		}
	},
	nodebox = {
		bottom = {
			{-0.5, -0.5, -0.5, -0.375, -0.065, -0.4375},
			{0.375, -0.5, -0.5, 0.5, -0.065, -0.4375},
			{-0.5, -0.375, -0.5, 0.5, -0.125, -0.4375},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.4375, 0.4375, -0.0625, 0.5},
		},
		top = {
			{-0.5, -0.5, 0.4375, -0.375, 0.1875, 0.5},
			{0.375, -0.5, 0.4375, 0.5, 0.1875, 0.5},
			{-0.5, 0, 0.4375, 0.5, 0.125, 0.5},
			{-0.5, -0.375, 0.4375, 0.5, -0.125, 0.5},
			{-0.5, -0.375, -0.5, -0.4375, -0.125, 0.5},
			{0.4375, -0.375, -0.5, 0.5, -0.125, 0.5},
			{-0.4375, -0.3125, -0.5, 0.4375, -0.0625, 0.4375},
		}
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"", "", "group:stick"},
		{"wool:red", "wool:red", "wool:white"},
		{"group:wood", "group:wood", "group:wood"},
	},
})

-- Simple shaped bed

beds.register_bed("beds:bed", {
	description = "Simple Bed",
	inventory_image = "beds_bed.png",
	wield_image = "beds_bed.png",
	tiles = {
		bottom = {
			"beds_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_bed_side_bottom_r.png",
			"beds_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_bed_side_bottom.png"
		},
		top = {
			"beds_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_bed_side_top_r.png",
			"beds_bed_side_top_r.png^[transformfx",
			"beds_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:red", "wool:red", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Red Jungle bed

beds.register_bed("beds:jungle_bed", {
	description = "Red Junglewood Bed",
	inventory_image = "beds_jungle_bed.png",
	wield_image = "beds_jungle_bed.png",
	tiles = {
		bottom = {
			"beds_jungle_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_jungle_bed_side_bottom_r.png",
			"beds_jungle_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_jungle_bed_side_bottom.png"
		},
		top = {
			"beds_jungle_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_jungle_bed_side_top_r.png",
			"beds_jungle_bed_side_top_r.png^[transformfx",
			"beds_jungle_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:red", "wool:red", "wool:white"},
		{"default:junglewood", "default:junglewood", "default:junglewood"}
	},
})

-- Upgrade Bed

minetest.register_craft({
	type = "shapeless",
	output = "beds:fancy_bed",
	recipe = {"beds:bed","group:stick"},
})


-- Aspen White Bed

beds.register_bed("beds:aspen_bed", {
	description = "Aspen White Bed",
	inventory_image = "beds_aspen_bed.png",
	wield_image = "beds_aspen_bed.png",
	tiles = {
		bottom = {
			"beds_aspen_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_aspen_bed_side_bottom_r.png",
			"beds_aspen_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_aspen_bed_side_bottom.png"
		},
		top = {
			"beds_aspen_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_aspen_bed_side_top_r.png",
			"beds_aspen_bed_side_top_r.png^[transformfx",
			"beds_aspen_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:white", "wool:white", "wool:white"},
		{"default:aspen_wood", "default:aspen_wood", "default:aspen_wood"}
	},
})


-- Black Bed

beds.register_bed("beds:black_bed", {
	description = "Black Bed",
	inventory_image = "beds_black_bed.png",
	wield_image = "beds_black_bed.png",
	tiles = {
		bottom = {
			"beds_black_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_black_bed_side_bottom_r.png",
			"beds_black_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_black_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_black_bed_side_top_r.png",
			"beds_black_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:black", "wool:black", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Blue Bed

beds.register_bed("beds:blue_bed", {
	description = "Blue Bed",
	inventory_image = "beds_blue_bed.png",
	wield_image = "beds_blue_bed.png",
	tiles = {
		bottom = {
			"beds_blue_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_blue_bed_side_bottom_r.png",
			"beds_blue_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_blue_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_blue_bed_side_top_r.png",
			"beds_blue_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:blue", "wool:blue", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Brown Bed

beds.register_bed("beds:brown_bed", {
	description = "Brown Bed",
	inventory_image = "beds_brown_bed.png",
	wield_image = "beds_brown_bed.png",
	tiles = {
		bottom = {
			"beds_brown_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_brown_bed_side_bottom_r.png",
			"beds_brown_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_brown_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_brown_bed_side_top_r.png",
			"beds_brown_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:brown", "wool:brown", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Cyan Bed

beds.register_bed("beds:cyan_bed", {
	description = "Cyan Bed",
	inventory_image = "beds_cyan_bed.png",
	wield_image = "beds_cyan_bed.png",
	tiles = {
		bottom = {
			"beds_cyan_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_cyan_bed_side_bottom_r.png",
			"beds_cyan_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_cyan_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_cyan_bed_side_top_r.png",
			"beds_cyan_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:cyan", "wool:cyan", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Dark Green Bed

beds.register_bed("beds:dark_green_bed", {
	description = "Dark Green Bed",
	inventory_image = "beds_dark_green_bed.png",
	wield_image = "beds_dark_green_bed.png",
	tiles = {
		bottom = {
			"beds_dark_green_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_dark_green_bed_side_bottom_r.png",
			"beds_dark_green_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_dark_green_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_dark_green_bed_side_top_r.png",
			"beds_dark_green_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:dark_green", "wool:dark_green", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Dark Grey Bed

beds.register_bed("beds:dark_grey_bed", {
	description = "Dark Grey Bed",
	inventory_image = "beds_dark_grey_bed.png",
	wield_image = "beds_dark_grey_bed.png",
	tiles = {
		bottom = {
			"beds_dark_grey_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_dark_grey_bed_side_bottom_r.png",
			"beds_dark_grey_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_dark_grey_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_dark_grey_bed_side_top_r.png",
			"beds_dark_grey_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:dark_grey", "wool:dark_grey", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Green Bed

beds.register_bed("beds:green_bed", {
	description = "Green Bed",
	inventory_image = "beds_green_bed.png",
	wield_image = "beds_green_bed.png",
	tiles = {
		bottom = {
			"beds_green_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_green_bed_side_bottom_r.png",
			"beds_green_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_green_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_green_bed_side_top_r.png",
			"beds_green_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:green", "wool:green", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Grey Bed

beds.register_bed("beds:grey_bed", {
	description = "Grey Bed",
	inventory_image = "beds_grey_bed.png",
	wield_image = "beds_grey_bed.png",
	tiles = {
		bottom = {
			"beds_grey_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_grey_bed_side_bottom_r.png",
			"beds_grey_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_grey_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_grey_bed_side_top_r.png",
			"beds_grey_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:grey", "wool:grey", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Magenta Bed

beds.register_bed("beds:magenta_bed", {
	description = "Magenta Bed",
	inventory_image = "beds_magenta_bed.png",
	wield_image = "beds_magenta_bed.png",
	tiles = {
		bottom = {
			"beds_magenta_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_magenta_bed_side_bottom_r.png",
			"beds_magenta_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_magenta_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_magenta_bed_side_top_r.png",
			"beds_magenta_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:magenta", "wool:magenta", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Orange Bed

beds.register_bed("beds:orange_bed", {
	description = "Orange Bed",
	inventory_image = "beds_orange_bed.png",
	wield_image = "beds_orange_bed.png",
	tiles = {
		bottom = {
			"beds_orange_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_orange_bed_side_bottom_r.png",
			"beds_orange_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_orange_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_orange_bed_side_top_r.png",
			"beds_orange_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:orange", "wool:orange", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Pink Bed

beds.register_bed("beds:pink_bed", {
	description = "Pink Bed",
	inventory_image = "beds_pink_bed.png",
	wield_image = "beds_pink_bed.png",
	tiles = {
		bottom = {
			"beds_pink_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_pink_bed_side_bottom_r.png",
			"beds_pink_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_pink_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_pink_bed_side_top_r.png",
			"beds_pink_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:pink", "wool:pink", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Violet Bed

beds.register_bed("beds:violet_bed", {
	description = "Violet Bed",
	inventory_image = "beds_violet_bed.png",
	wield_image = "beds_violet_bed.png",
	tiles = {
		bottom = {
			"beds_violet_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_violet_bed_side_bottom_r.png",
			"beds_violet_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_violet_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_violet_bed_side_top_r.png",
			"beds_violet_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:violet", "wool:violet", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Yellow Bed

beds.register_bed("beds:yellow_bed", {
	description = "Yellow Bed",
	inventory_image = "beds_yellow_bed.png",
	wield_image = "beds_yellow_bed.png",
	tiles = {
		bottom = {
			"beds_yellow_bed_top_bottom.png^[transformR90",
			"default_wood.png",
			"beds_yellow_bed_side_bottom_r.png",
			"beds_yellow_bed_side_bottom_r.png^[transformfx",
			"beds_transparent.png",
			"beds_new_bed_side_bottom.png"
		},
		top = {
			"beds_yellow_bed_top_top.png^[transformR90",
			"default_wood.png",
			"beds_yellow_bed_side_top_r.png",
			"beds_yellow_bed_side_top_r.png^[transformfx",
			"beds_new_bed_side_top.png",
			"beds_transparent.png",
		}
	},
	nodebox = {
		bottom = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
		top = {-0.5, -0.5, -0.5, 0.5, 0.06, 0.5},
	},
	selectionbox = {-0.5, -0.5, -0.5, 0.5, 0.06, 1.5},
	recipe = {
		{"wool:yellow", "wool:yellow", "wool:white"},
		{"group:wood", "group:wood", "group:wood"}
	},
})

-- Aliases for PilzAdam's beds mod

minetest.register_alias("beds:bed_bottom_red", "beds:bed_bottom")
minetest.register_alias("beds:bed_top_red", "beds:bed_top")

-- Fuel

minetest.register_craft({
	type = "fuel",
	recipe = "beds:fancy_bed_bottom",
	burntime = 13,
})

minetest.register_craft({
	type = "fuel",
	recipe = "beds:bed_bottom",
	burntime = 12,
})
