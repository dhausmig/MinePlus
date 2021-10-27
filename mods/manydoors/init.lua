if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

-- we have our own definition so we remove the original definitions
-- to prevent having two identical recipes for the same item

minetest.unregister_item("doors:door_wood")
minetest.unregister_item("doors:door_steel")


doors.register("door_acacia", {
		tiles = {{ name = "doors_door_acacia.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Acacia Wood Door",
		inventory_image = "doors_item_acacia.png",
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:acacia_wood", "default:acacia_wood"},
			{"default:acacia_wood", "default:acacia_wood"},
			{"default:acacia_wood", "default:acacia_wood"},
		}
})

doors.register("door_acacia_win", {
		tiles = {{ name = "doors_door_acacia_win.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Acacia Windowed Door",
		use_texture_alpha = "clip",
		inventory_image = "doors_item_acacia_w.png",
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:acacia_wood", "default:glass"},
			{"default:acacia_wood", "default:acacia_wood"},
			{"default:acacia_wood", "default:acacia_wood"},
		}
})

doors.register("door_aspen", {
		tiles = {{ name = "doors_door_aspen.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Aspen Wood Door",
		inventory_image = "doors_item_aspen.png",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:aspen_wood", "default:aspen_wood"},
			{"default:aspen_wood", "default:aspen_wood"},
			{"default:aspen_wood", "default:aspen_wood"},
		}
})

doors.register("door_aspen_win", {
		tiles = {{ name = "doors_door_aspen_win.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Aspen Windowed Door",
		use_texture_alpha = "clip",
		inventory_image = "doors_item_aspen_w.png",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:aspen_wood", "default:glass"},
			{"default:aspen_wood", "default:aspen_wood"},
			{"default:aspen_wood", "default:aspen_wood"},
		}
})

doors.register("door_jungle", {
		tiles = {{ name = "doors_door_jungle.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Junglewoood Door",
		inventory_image = "doors_item_jungle.png",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:junglewood", "default:junglewood"},
			{"default:junglewood", "default:junglewood"},
			{"default:junglewood", "default:junglewood"},
		}
})

doors.register("door_jungle_win", {
		tiles = {{ name = "doors_door_jungle_win.png",
		use_texture_alpha = "clip",
		backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Junglewood Windowed Door",
		inventory_image = "doors_item_jungle_w.png",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:junglewood", "default:glass"},
			{"default:junglewood", "default:junglewood"},
			{"default:junglewood", "default:junglewood"},
		}
})

doors.register("door_pine", {
		tiles = {{ name = "doors_door_pine.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Pine Wood Door",
		inventory_image = "doors_item_pine.png",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:pine_wood", "default:pine_wood"},
			{"default:pine_wood", "default:pine_wood"},
			{"default:pine_wood", "default:pine_wood"},
		}
})

doors.register("door_pine_win", {
		tiles = {{ name = "doors_door_pine_win.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Pine Windowed Door",
		inventory_image = "doors_item_pine_w.png",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"default:pine_wood", "default:glass"},
			{"default:pine_wood", "default:pine_wood"},
			{"default:pine_wood", "default:pine_wood"},
		}
})

doors.register("door_wood", {
		tiles = {{ name = "doors_door_wood.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Wooden Door",
		inventory_image = "doors_item_wood.png",
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"group:wood", "group:wood"},
			{"group:wood", "group:wood"},
			{"group:wood", "group:wood"},
		}
})

doors.register("door_wood_win", {
		tiles = {{ name = "doors_door_wood_win.png", backface_culling = true }},
		use_texture_alpha = "clip",
		description = "Wooden Windowed Door",
		inventory_image = "doors_item_wood_w.png",
		groups = {node = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		recipe = {
			{"group:wood", "default:glass"},
			{"group:wood", "group:wood"},
			{"group:wood", "group:wood"},
		}
})

doors.register("door_steel", {
		tiles = {{name = "doors_door_steel.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Steel Door",
		inventory_image = "doors_item_steel.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot"},
		}
})

doors.register("door_steel_win", {
		tiles = {{name = "doors_door_steel_win.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Steel Windowed Door",
		inventory_image = "doors_item_steel_w.png",
		protected = true,
		groups = {node = 1, cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:steel_ingot", "default:glass"},
			{"default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot"},
		}
})

doors.register("door_copper", {
		tiles = {{name = "doors_door_copper.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Copper Door",
		inventory_image = "doors_item_copper.png",
		protected = true,
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:copper_ingot", "default:copper_ingot"},
			{"default:copper_ingot", "default:copper_ingot"},
			{"default:copper_ingot", "default:copper_ingot"},
		}
})

doors.register("door_copper_win", {
		tiles = {{name = "doors_door_copper_win.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Copper Windowed Door",
		inventory_image = "doors_item_copper_w.png",
		protected = true,
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:copper_ingot", "default:glass"},
			{"default:copper_ingot", "default:copper_ingot"},
			{"default:copper_ingot", "default:copper_ingot"},
		}
})

doors.register("door_tin", {
		tiles = {{name = "doors_door_tin.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Tin Door",
		inventory_image = "doors_item_tin.png",
		protected = true,
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:tin_ingot", "default:tin_ingot"},
			{"default:tin_ingot", "default:tin_ingot"},
			{"default:tin_ingot", "default:tin_ingot"},
		}
})

doors.register("door_tin_win", {
		tiles = {{name = "doors_door_tin_win.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Tin Windowed Door",
		inventory_image = "doors_item_tin_w.png",
		protected = true,
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:tin_ingot", "default:glass"},
			{"default:tin_ingot", "default:tin_ingot"},
			{"default:tin_ingot", "default:tin_ingot"},
		}
})

doors.register("door_bronze", {
		tiles = {{name = "doors_door_bronze.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Bronze Door",
		inventory_image = "doors_item_bronze.png",
		protected = true,
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:bronze_ingot", "default:bronze_ingot"},
			{"default:bronze_ingot", "default:bronze_ingot"},
			{"default:bronze_ingot", "default:bronze_ingot"},
		}
})

doors.register("door_bronze_win", {
		tiles = {{name = "doors_door_bronze_win.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Bronze Windowed Door",
		inventory_image = "doors_item_bronze_w.png",
		protected = true,
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:bronze_ingot", "default:glass"},
			{"default:bronze_ingot", "default:bronze_ingot"},
			{"default:bronze_ingot", "default:bronze_ingot"},
		}
})

doors.register("door_gold", {
		tiles = {{name = "doors_door_gold.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Golden Door",
		inventory_image = "doors_item_gold.png",
		protected = true,
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:gold_ingot", "default:gold_ingot"},
			{"default:gold_ingot", "default:gold_ingot"},
			{"default:gold_ingot", "default:gold_ingot"},
		}
})

doors.register("door_gold_win", {
		tiles = {{name = "doors_door_gold_win.png", backface_culling = true}},
		use_texture_alpha = "clip",
		description = "Golden Windowed Door",
		inventory_image = "doors_item_gold_w.png",
		protected = true,
		groups = {cracky = 1, level = 2},
		sounds = default.node_sound_metal_defaults(),
		sound_open = "doors_steel_door_open",
		sound_close = "doors_steel_door_close",
		recipe = {
			{"default:gold_ingot", "default:glass"},
			{"default:gold_ingot", "default:gold_ingot"},
			{"default:gold_ingot", "default:gold_ingot"},
		}
})


-- Adding or removing the window

minetest.register_craft({
	output = "doors:door_acacia",
	recipe = {
		{"doors:door_acacia_win", "default:acacia_wood"}
	},
	replacements = {{"default:acacia_wood", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_acacia_win",
	recipe = {
		{"doors:door_acacia", "default:glass"}
	},
	replacements = {{"default:glass","default:acacia_wood"  }}
})

minetest.register_craft({
	output = "doors:door_aspen",
	recipe = {
		{"doors:door_aspen_win", "default:aspen_wood"}
	},
	replacements = {{"default:aspen_wood", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_aspen_win",
	recipe = {
		{"doors:door_aspen", "default:glass"}
	},
	replacements = {{"default:glass","default:aspen_wood"  }}
})

minetest.register_craft({
	output = "doors:door_jungle",
	recipe = {
		{"doors:door_jungle_win", "default:junglewood"}
	},
	replacements = {{"default:junglewood", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_jungle_win",
	recipe = {
		{"doors:door_jungle", "default:glass"}
	},
	replacements = {{"default:glass","default:junglewood"  }}
})

minetest.register_craft({
	output = "doors:door_pine",
	recipe = {
		{"doors:door_pine_win", "default:pine_wood"}
	},
	replacements = {{"default:pine_wood", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_pine_win",
	recipe = {
		{"doors:door_pine", "default:glass"}
	},
	replacements = {{"default:glass","default:pine_wood"  }}
})

minetest.register_craft({
	output = "doors:door_wood",
	recipe = {
		{"doors:door_wood_win", "group:wood"}
	},
	replacements = {{"group:wood", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_wood_win",
	recipe = {
		{"doors:door_wood", "default:glass"}
	},
	replacements = {{"default:glass","default:wood"  }}
})

minetest.register_craft({
	output = "doors:door_steel",
	recipe = {
		{"doors:door_steel_win", "default:steel_ingot"}
	},
	replacements = {{"default:steel_ingot", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_steel_win",
	recipe = {
		{"doors:door_steel", "default:glass"}
	},
	replacements = {{"default:glass","default:steel_ingot"  }}
})

minetest.register_craft({
	output = "doors:door_copper",
	recipe = {
		{"doors:door_copper_win", "default:copper_ingot"}
	},
	replacements = {{"default:copper_ingot", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_copper_win",
	recipe = {
		{"doors:door_copper", "default:glass"}
	},
	replacements = {{"default:glass","default:copper_ingot"  }}
})

minetest.register_craft({
	output = "doors:door_tin",
	recipe = {
		{"doors:door_tin_win", "default:tin_ingot"}
	},
	replacements = {{"default:tin_ingot", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_tin_win",
	recipe = {
		{"doors:door_tin", "default:glass"}
	},
	replacements = {{"default:glass","default:tin_ingot"  }}
})

minetest.register_craft({
	output = "doors:door_bronze",
	recipe = {
		{"doors:door_bronze_win", "default:bronze_ingot"}
	},
	replacements = {{"default:bronze_ingot", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_bronze_win",
	recipe = {
		{"doors:door_bronze", "default:glass"}
	},
	replacements = {{"default:glass","default:bronze_ingot"  }}
})

minetest.register_craft({
	output = "doors:door_gold",
	recipe = {
		{"doors:door_gold_win", "default:gold_ingot"}
	},
	replacements = {{"default:gold_ingot", "default:glass" }}
})

minetest.register_craft({
	output = "doors:door_gold_win",
	recipe = {
		{"doors:door_gold", "default:glass"}
	},
	replacements = {{"default:glass","default:gold_ingot"  }}
})

-- I have included all of this mod with the doors I have made
--------------------------------------------------------
-- Minetest :: Extra Doors v2.0 (extra_doors)
--
-- See README.txt for licensing and release notes.
-- Copyright (c) 2018, Leslie E. Krause
--------------------------------------------------------

-- One of the most essential but often overlooked elements of building design is door selection.
-- Doors set the tone and character, and having the wrong style of door can make or break a build.

--[[
I have commented out the following craftitem and craft
in favor of the default:steel_bar

minetest.register_craftitem( ":default:steel_rod", {
        description = "Steel Rod",
        inventory_image = "default_steel_rod.png",
} )

minetest.register_craft( {
        output = "default:steel_rod 4",
        recipe = {
                { "default:steel_ingot" },
        }
} )
--]]

doors.register( "door_woodpanel1", {
	-- Colonial Style (6 panel)
	tiles = { { name = "doors_door_woodpanel1.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Wooden Colonial Door",
	inventory_image = "doors_item_woodpanel1.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "group:wood", "group:wood", "default:stick" },
		{ "group:wood", "group:wood", "default:stick" },
		{ "group:wood", "group:wood", "default:stick" },
	}
} )

doors.register( "door_woodglass1", {
	-- Cambridge Style (2 panel)
	tiles = { { name = "doors_door_woodglass1.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Wooden Single-Lite Door",
	inventory_image = "doors_item_woodglass1.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "default:glass", "default:glass", "default:stick" },
		{ "group:wood", "group:wood", "" },
		{ "group:wood", "group:wood", "" },
	}
} )

doors.register( "door_woodglass2", {
	-- Atherton Style (4 panel)
	tiles = { { name = "doors_door_woodglass2.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Wooden Double-Lite Door",
	inventory_image = "doors_item_woodglass2.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "default:glass", "default:glass", "default:stick" },
		{ "group:wood", "group:wood", "default:stick" },
		{ "group:wood", "group:wood", "" },
	}
} )

doors.register( "door_japanese", {
	tiles = { { name = "doors_door_japanese.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Japanese Door",
	inventory_image = "doors_item_japanese.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "default:paper", "group:wood", "default:stick" },
		{ "default:paper", "group:wood", "default:stick" },
		{ "default:paper", "group:wood", "default:stick" },
	}
} )

doors.register( "door_french", {
	tiles = { { name = "doors_door_french.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "French Door",
	inventory_image = "doors_item_french.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "default:glass", "group:wood", "default:stick" },
		{ "default:glass", "group:wood", "default:stick" },
		{ "default:glass", "group:wood", "default:stick" },
	}
} )

doors.register( "door_cottage1", {
	tiles = { { name = "doors_door_cottage1.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Cottage Interior Door",
	inventory_image = "doors_item_cottage1.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "group:wood", "group:wood" },
		{ "default:stick", "default:stick" },
		{ "group:wood", "group:wood" },
	}
} )

doors.register( "door_cottage2", {
	tiles = { { name = "doors_door_cottage2.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Cottage Exterior Door",
	inventory_image = "doors_item_cottage2.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "default:glass", "default:glass" },
		{ "default:stick", "default:stick" },
		{ "group:wood", "group:wood" },
	}
} )

doors.register( "door_barn1", {
	tiles = { { name = "doors_door_barn1.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Barn Interior Door",
	inventory_image = "doors_item_barn1.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "group:wood", "group:wood", "group:wood" },
		{ "default:stick", "default:stick", "default:stick" },
		{ "group:wood", "group:wood", "group:wood" },
	}
} )

doors.register( "door_barn2", {
	tiles = { { name = "doors_door_barn2.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Barn Exterior Door",
	inventory_image = "doors_item_barn2.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "group:wood", "group:wood", "group:wood" },
		{ "default:steel_bar", "default:steel_bar", "default:steel_bar" },
		{ "group:wood", "group:wood", "group:wood" },
	}
} )

doors.register( "door_castle1", {
	tiles = { { name = "doors_door_castle1.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Castle Interior Door",
	inventory_image = "doors_item_castle1.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "default:stick", "group:wood", "group:wood" },
		{ "", "group:wood", "group:wood" },
		{ "default:stick", "group:wood", "group:wood" },
	}
} )

doors.register( "door_castle2", {
	tiles = { { name = "doors_door_castle2.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Castle Exterior Door",
	inventory_image = "doors_item_castle2.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "default:steel_bar", "group:wood", "group:wood" },
		{ "", "group:wood", "group:wood" },
		{ "default:steel_bar", "group:wood", "group:wood" },
	}
} )

doors.register( "door_mansion1", {
	tiles = { { name = "doors_door_mansion1.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Mansion Interior Door",
	inventory_image = "doors_item_mansion1.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "group:wood", "group:wood", "dye:white" },
		{ "group:wood", "group:wood", "dye:yellow" },
		{ "group:wood", "group:wood", "dye:white" },
	}
} )

doors.register( "door_mansion2", {
	tiles = { { name = "doors_door_mansion2.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Mansion Exterior Door ",
	inventory_image = "doors_item_mansion2.png",
	groups = { choppy = 2, oddly_breakable_by_hand = 2, flammable = 2 },
	recipe = {
		{ "group:wood", "group:wood", "dye:black" },
		{ "group:wood", "group:wood", "dye:yellow" },
		{ "group:wood", "group:wood", "dye:black" },
	}
} )

doors.register("door_dungeon1", {
	tiles = { { name = "doors_door_dungeon1.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Dungeon Interior Door",
	inventory_image = "doors_item_dungeon1.png",
	protected = true,
	groups = { cracky = 1, level = 2 },
	sounds = default.node_sound_metal_defaults( ),
	sound_open = "doors_steel_door_open",
	sound_close = "doors_steel_door_close",
	recipe = {
		{ "default:steel_ingot", "default:steel_bar", "default:steel_ingot" },
		{ "default:steel_bar", "default:steel_bar", "default:steel_bar" },
		{ "default:steel_ingot", "default:steel_bar", "default:steel_ingot" },
	}
} )

doors.register( "door_dungeon2", {
	tiles = { { name = "doors_door_dungeon2.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Dungeon Exterior Door",
	inventory_image = "doors_item_dungeon2.png",
	protected = true,
	groups = { cracky = 1, level = 2 },
	sounds = default.node_sound_metal_defaults( ),
	sound_open = "doors_steel_door_open",
	sound_close = "doors_steel_door_close",
	recipe = {
		{ "default:steel_bar", "default:steel_bar", "default:steel_bar" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
	}
} )

doors.register( "door_steelpanel1", {
	tiles = { { name = "doors_door_steelpanel1.png", backface_culling = true } },
	-- dhausmig changed the above line to agree with the texture name
	use_texture_alpha = "clip",
	description = "Steel Colonial Door",
	inventory_image = "doors_item_steelpanel1.png",
	protected = true,
	groups = { cracky = 1, level = 2 },
	sounds = default.node_sound_metal_defaults( ),
	sound_open = "doors_steel_door_open",
	sound_close = "doors_steel_door_close",
	recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_bar" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_bar" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_bar" },
	}
} )

doors.register( "door_steelglass1", {
	tiles = { { name = "doors_door_steelglass1.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Steel Single-Lite Door",
	inventory_image = "doors_item_steelglass1.png",
	protected = true,
	groups = { cracky = 1, level = 2 },
	sounds = default.node_sound_metal_defaults( ),
	sound_open = "doors_steel_door_open",
	sound_close = "doors_steel_door_close",
	recipe = {
		{ "default:glass", "default:glass", "default:steel_bar" },
		{ "default:steel_ingot", "default:steel_ingot", "" },
		{ "default:steel_ingot", "default:steel_ingot", "" },
	}
} )

doors.register( "door_steelglass2", {
	tiles = { { name = "doors_door_steelglass2.png", backface_culling = true } },
	use_texture_alpha = "clip",
	description = "Steel Double-Lite Door",
	inventory_image = "doors_item_steelglass2.png",
	protected = true,
	groups = { cracky = 1, level = 2 },
	sounds = default.node_sound_metal_defaults( ),
	sound_open = "doors_steel_door_open",
	sound_close = "doors_steel_door_close",
	recipe = {
		{ "default:glass", "default:glass", "default:steel_bar" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_bar" },
		{ "default:steel_ingot", "default:steel_ingot", "" },
	}
} )

----fuels----
-- these are from manydoors

minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_acacia",
	burntime = 14,
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_aspen",
	burntime = 14,
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_jungle",
	burntime = 14,
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_pine",
	burntime = 14,
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:door_wood",
	burntime = 14,
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:gate_acacia_wood_closed",
	burntime = 8,
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:gate_junglewood_closed",
	burntime = 9,
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:gate_pine_wood_closed",
	burntime = 6,
})

minetest.register_craft({
	type = "fuel",
	recipe = "doors:gate_aspen_wood_closed",
	burntime = 5,
})

 -- these are from extra_doors
 
minetest.register_craft( {
	type = "fuel",
	recipe = "doors:door_barn1",
	burntime = 14,
} )

minetest.register_craft( {
	type = "fuel",
	recipe = "doors:door_barn2",
	burntime = 16,
} )

minetest.register_craft( {
	type = "fuel",
	recipe = "doors:door_castle1",
	burntime = 8,
} )

minetest.register_craft( {
	type = "fuel",
	recipe = "doors:door_castle2",
	burntime = 12,
} )
