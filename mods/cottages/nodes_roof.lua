-- Boilerplate to support localized strings if intllib mod is installed.
local S = cottages.S

---------------------------------------------------------------------------------------
-- roof parts
---------------------------------------------------------------------------------------
-- a better roof than the normal stairs; can be replaced by stairs:stair_wood



-- create the three basic roof parts plus receipes for them;
cottages.register_roof = function( name, description, tiles, basic_material, decor_alternative )

   minetest.register_node("cottages:roof_"..name, {
		description = S(description) .. " " .. S("roof"),
		drawtype = "nodebox",
		--tiles = {"default_tree.png","default_wood.png","default_wood.png","default_wood.png","default_wood.png","default_tree.png"},
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, roof = 1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		is_ground_content = false,
	})


   minetest.register_node("cottages:roof_" .. name .. "_corner_inner", {
		description = S(description) .. " " .. S("roof (inner corner)"),
		drawtype = "nodebox",
		tiles = {	tiles[1],
				tiles[2],
				tiles[3],
				tiles[2] .. "^(" .. tiles[6] .. "^cottages_corner_inner_mask.png^[transformFX^[makealpha:255,255,255)",
				tiles[5],
				tiles[2] .. "^(" .. tiles[6] .. "^cottages_corner_inner_mask.png^[makealpha:255,255,255)" },
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, roof = 1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.0, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{0, 0, 0, 0.5, 0.5, -0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.0, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
				{0, 0, 0, 0.5, 0.5, -0.5},
			},
		},
		is_ground_content = false,
	})

	 minetest.register_node("cottages:roof_" .. name .. "_corner_outer", {
		description = S(description) .. " " .. S("roof (outer corner)"),
		drawtype = "nodebox",
		tiles = {	tiles[1],
				tiles[2],
				tiles[1],
				tiles[2],
				tiles[2],
				tiles[1] },
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, roof = 1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0, 0.5, 0.5},
				{0, -0.5, 0, 0.5, 0, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0, 0.5, 0.5},
				{0, -0.5, 0, 0.5, 0, 0.5},
			},
		},
		is_ground_content = false,
	})

   -- a better roof than the normal stairs; this one is for usage directly on top of walls (it has the form of a stair)
   minetest.register_node("cottages:roof_connector_"..name, {
		description = S(description) .. " " .. S("roof (connector)"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, roof = 1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		is_ground_content = false,
	})

   -- this one is the slab version of the above roof
   minetest.register_node("cottages:roof_flat_"..name, {
		description = S(description) .. " " .. S("roof (flat)"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
                -- this one is from all sides - except from the underside - of the given material
		tiles = { tiles[1], tiles[2], tiles[1], tiles[1], tiles[1], tiles[1] };
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2, roof = 1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
		},
		is_ground_content = false,
	})


	if( not( decor_alternative )
		or ( minetest.get_modpath("decor") ~= nil )) then

	minetest.register_craft({
	output = "cottages:roof_"..name.." 6",
	recipe = {
		{'', '', basic_material },
		{'', basic_material, '' },
		{basic_material, '', '' }
	}
      })
	end

	-- make those roof parts that use decor craftable without that mod
	if( decor_alternative ) then
	basic_material = 'cottages:roof_wood';

	minetest.register_craft({
	output = "cottages:roof_"..name.." 3",
	recipe = {
		{decor_alternative, '', basic_material },
		{'', basic_material, '' },
		{basic_material, '', '' }
	}
	})
	end

	minetest.register_craft({
		output = "cottages:roof_connector_"..name,
		recipe = {
			{'cottages:roof_'..name },
			{"group:wood" },
		}
	})

	minetest.register_craft({
		output = "cottages:roof_"..name.."_corner_inner 3",
		recipe = {
			{'cottages:roof_'..name, 'cottages:roof_'..name},
			{'cottages:roof_'..name, '' },
		}
	})

	minetest.register_craft({
		output = "cottages:roof_"..name.." 3",
		recipe = {
			{"cottages:roof_"..name.."_corner_inner", "cottages:roof_"..name.."_corner_inner", "cottages:roof_"..name.."_corner_inner"}
		}
	})

	minetest.register_craft({
		output = "cottages:roof_"..name.."_corner_outer 3",
		recipe = {
			{'', 'cottages:roof_'..name},
			{'cottages:roof_'..name, 'cottages:roof_'..name },
		}
	})

	minetest.register_craft({
		output = "cottages:roof_"..name.." 3",
		recipe = {
			{"cottages:roof_"..name.."_corner_outer", "cottages:roof_"..name.."_corner_outer", "cottages:roof_"..name.."_corner_outer"}
		}
	})

	minetest.register_craft({
		output = "cottages:roof_flat_"..name..' 2',
		recipe = {
			{'cottages:roof_'..name, 'cottages:roof_'..name },
		}
	})

	-- convert flat roofs back to normal roofs
	minetest.register_craft({
		output = "cottages:roof_"..name,
		recipe = {
			{"cottages:roof_flat_"..name, "cottages:roof_flat_"..name }
		}
	})

end -- of cottages.register_roof( name, tiles, basic_material )




---------------------------------------------------------------------------------------
-- add the diffrent roof types
---------------------------------------------------------------------------------------
cottages.register_roof( 'straw', "Straw",
		{"cottages_darkage_straw.png","cottages_darkage_straw.png",
		"cottages_darkage_straw.png","cottages_darkage_straw.png",
		"cottages_darkage_straw.png","cottages_darkage_straw.png"},
		'cottages:straw_mat', nil );
cottages.register_roof( 'straw_dark', "Dark straw",
		{"cottages_dark_straw.png","cottages_dark_straw.png",
		"cottages_dark_straw.png","cottages_dark_straw.png",
		"cottages_dark_straw.png","cottages_dark_straw.png"},
		'cottages:straw_bale', nil );
cottages.register_roof( 'reet', "Reed",
		{"cottages_reet.png","cottages_reet.png",
		"cottages_reet.png","cottages_reet.png",
		"cottages_reet.png","cottages_reet.png"},
		"default:papyrus", nil );
cottages.register_roof( 'hay', "Hay",
		{cottages.straw_texture.."^[multiply:#88BB88",cottages.straw_texture.."^[multiply:#88BB88",
		cottages.straw_texture.."^[multiply:#88BB88",cottages.straw_texture.."^[multiply:#88BB88",
		cottages.straw_texture.."^[multiply:#88BB88",cottages.straw_texture.."^[multiply:#88BB88"},
		'cottages:hay_mat', nil );
cottages.register_roof( 'wood', "Wooden",
		{"default_tree.png", "default_wood.png",
		"default_wood.png",  "default_wood.png",
		"default_wood.png",  "default_tree.png"},
		"group:wood", nil);
cottages.register_roof( 'black', "Asphalt",
		{"cottages_decor_shingles_asphalt.png", "default_wood.png",
		"default_wood.png", "default_wood.png",
		"default_wood.png", "cottages_decor_shingles_asphalt.png"},
		'decor:shingles_asphalt', "cottages:roof_asphalt");
cottages.register_roof( 'red', "Terracotta",
		{"cottages_decor_shingles_terracotta.png", "default_wood.png",
		"default_wood.png", "default_wood.png",
		"default_wood.png", "cottages_decor_shingles_terracotta.png"},
		'decor:shingles_terracotta', "default:clay_brick");
cottages.register_roof( 'brown', "Brown shingle",
		{"cottages_decor_shingles_wood.png", "default_wood.png",
		"default_wood.png", "default_wood.png",
		"default_wood.png", "cottages_decor_shingles_wood.png"},
		'decor:shingles_wood', "default:dirt");
cottages.register_roof( 'slate', "Slate",
		{"cottages_slate.png", "default_wood.png",
		"cottages_slate.png", "cottages_slate.png",
		"default_wood.png","cottages_slate.png"},
		"default:stone", nil);
cottages.register_roof( 'shingle', "Shingle",
		{"cottages_decor_shingles_misc_wood.png", "default_wood.png",
		"default_wood.png", "default_wood.png",
		"default_wood.png", "cottages_decor_shingles_misc_wood.png"},
		'cottages:wood_flat', nil);

---------------------------------------------------------------------------------------
-- slate roofs are sometimes on vertical fronts of houses
---------------------------------------------------------------------------------------

-- minetest.register_alias("cottages:roof_vertical_slate", "cottages:slate_vertical")

minetest.register_node("cottages:slate_vertical", {
	description = S("Vertical slate"),
	tiles = {"cottages_slate.png", "default_wood.png",
               "cottages_slate.png", "cottages_slate.png",
               "default_wood.png", "cottages_slate.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2, roof = 1},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})

minetest.register_craft({
	output = "cottages:slate_vertical 2",
	recipe = {{ "default:stone", "group:wood", '' }}
});

cottages.derive_blocks( "cottages", "slate_vertical", "Slate", "cottages_slate.png", {cracky = 2, roof = 1} )


---------------------------------------------------------------------------------------
-- asphalt roof: sawable block
---------------------------------------------------------------------------------------
minetest.register_node("cottages:roof_asphalt", {
	description = S("Asphalt roof"),
	tiles = {"cottages_decor_shingles_asphalt.png", "default_wood.png",
               "cottages_decor_shingles_asphalt.png", "cottages_decor_shingles_asphalt.png",
               "default_wood.png", "cottages_decor_shingles_asphalt.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2, roof = 1},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})

minetest.register_craft({
	output = "cottages:roof_asphalt 3",
	recipe = {{ "moreblocks:tar", "group:gravel", "group:sand" }}
});

cottages.derive_blocks( "cottages", "roof_asphalt", "Asphalt", "cottages_decor_shingles_asphalt.png", {cracky = 2, roof = 1} )



---------------------------------------------------------------------------------------
-- terracota roof: sawable block
---------------------------------------------------------------------------------------
minetest.register_node("cottages:roof_vertical_terracotta", {
	description = S("Vertical terracotta roof"),
	tiles = {"cottages_decor_shingles_terracotta.png", "default_wood.png",
               "cottages_decor_shingles_terracotta.png", "cottages_decor_shingles_terracotta.png",
               "default_wood.png", "cottages_decor_shingles_terracotta.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2, roof = 1},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})

minetest.register_craft({
	output = "cottages:roof_vertical_terracotta 3",
	recipe = {{ "default:stone", "group:wood", "default:clay_brick" }}
});

cottages.derive_blocks( "cottages", "roof_vertical_terracotta", "Terracotta", "cottages_decor_shingles_terracotta.png", {cracky = 2, roof = 1} )



---------------------------------------------------------------------------------------
-- wooden roof: sawable block
---------------------------------------------------------------------------------------
minetest.register_node("cottages:roof_vertical_wood", {
	description = S("Vertical wooden roof"),
	tiles = {"default_tree.png", "default_wood.png",
               "default_tree.png", "default_tree.png",
               "default_wood.png", "default_tree.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2, roof = 1},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})

minetest.register_craft({
	output = "cottages:roof_vertical_wood 3",
	recipe = {{ "default:stone", "group:wood", "group:tree" }}
});

cottages.derive_blocks( "cottages", "roof_vertical_wood", "Wooden", "default_tree.png", {cracky = 2, roof = 1} )



---------------------------------------------------------------------------------------
-- brown shingles roof: sawable block
---------------------------------------------------------------------------------------
minetest.register_node("cottages:roof_vertical_brown", {
	description = S("Vertical brown shingle roof"),
	tiles = {"cottages_decor_shingles_wood.png", "default_wood.png",
               "cottages_decor_shingles_wood.png", "cottages_decor_shingles_wood.png",
               "default_wood.png", "cottages_decor_shingles_wood.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2, roof = 1},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})

minetest.register_craft({
	output = "cottages:roof_vertical_brown 3",
	recipe = {{ "default:stone", "group:wood", "default:dirt" }}
});

cottages.derive_blocks( "cottages", "roof_vertical_brown", "Brown shingle", "cottages_decor_shingles_wood.png", {cracky = 2, roof = 1} )



---------------------------------------------------------------------------------------
-- assorted shingles roof: sawable block
---------------------------------------------------------------------------------------
minetest.register_node("cottages:roof_vertical_shingle", {
	description = S("Vertical shingle roof"),
	tiles = {"cottages_decor_shingles_misc_wood.png", "default_wood.png",
               "cottages_decor_shingles_misc_wood.png", "cottages_decor_shingles_misc_wood.png",
               "default_wood.png", "cottages_decor_shingles_misc_wood.png"},
	paramtype2 = "facedir",
	groups = {cracky = 2, roof = 1},
	sounds = default.node_sound_stone_defaults(),
	is_ground_content = false,
})

-- minetest.register_craft({
-- 	output = "cottages:roof_vertical_shingle",
-- 	recipe = { {"cottages:wood_flat", "cottages:wood_flat"},
-- 	           {"cottages:wood_flat", "cottages:wood_flat"},
-- 	},
-- })

minetest.register_craft({
	output = "cottages:roof_vertical_shingle 2",
	recipe = {{ "group:wood", "cottages:wood_flat" }}
});

cottages.derive_blocks( "cottages", "roof_vertical_shingle", "Shingle", "cottages_decor_shingles_misc_wood.png", {cracky = 2, roof = 1} )


---------------------------------------------------------------------------------------
-- Reed might also be needed as a full block
---------------------------------------------------------------------------------------
minetest.register_node("cottages:reet", {
	description = S("Reed for thatching"),
	tiles = {"cottages_reet.png"},
	groups = {snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3, roof = 1},
	sounds = default.node_sound_wood_defaults(),
	is_ground_content = false,
})

minetest.register_craft({
	output = "cottages:reet",
	recipe = {
			{ "default:papyrus", "default:papyrus" },
			{ "default:papyrus", "default:papyrus" },
	},
})

cottages.derive_blocks( "cottages", "reet", "Reed", "cottages_reet.png", {snappy = 3, choppy = 3, oddly_breakable_by_hand = 3, flammable = 3, roof = 1} )

-----------------------------------------------------------------------------------------------
-- Cut Grass
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("cottages:cut_grass", {
	description = "Cut Grass",
	inventory_image = "cottages_cut_grass.png",
})

-----------------------------------------------------------------------------------------------
-- Hay
-----------------------------------------------------------------------------------------------
minetest.register_craftitem("cottages:hay", {
	description = "Hay",
	inventory_image = "cottages_hay.png",
})

-----------------------------------------------------------------------------------------------
-- Reed
-----------------------------------------------------------------------------------------------
minetest.register_node("cottages:reed", {
	description = "Reed",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"cottages_reed.png"},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-- Reed Roof
minetest.register_node("cottages:reed_roof", {
	description = "Reed Roof",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"cottages_reed.png"},
	node_box = {
		type = "fixed",
--				{ left	, bottom , front  ,  right ,  top   ,  back  }
		fixed = {
			{-1/2, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 0, 0},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, -1/2, -1/2, 1/2, 0, 0},
		}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-- Reed Roof Corner
minetest.register_node("cottages:reed_roof_corner", {
	description = "Reed Roof Corner",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"cottages_reed.png"},
	node_box = {
		type = "fixed",
--				{ left	, bottom , front  ,  right ,  top   ,  back  }
		fixed = {
			{-1/2, 0, 0, 0, 1/2, 1/2},
			{0, -1/2, 0, 1/2, 0, 1/2},
			{-1/2, -1/2, -1/2, 0, 0, 0},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, 0, 0, 0, 1/2, 1/2},
			{0, -1/2, 0, 1/2, 0, 1/2},
			{-1/2, -1/2, -1/2, 0, 0, 0},
		}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})

-- Reed Roof Corner 2
minetest.register_node("cottages:reed_roof_corner_2", {
	description = "Reed Roof Corner 2",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"cottages_reed.png"},
	node_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/2, 0, 0, 0, 1/2},
			{0, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, 0, -1/2, 0, 1/2, 0},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/2, 0, 0, 0, 1/2},
			{0, 0, 0, 1/2, 1/2, 1/2},
			{-1/2, 0, -1/2, 0, 1/2, 0},
		}
	},
	groups = {snappy=3, flammable=2},
	sounds = default.node_sound_leaves_defaults(),
})


-----------------------------------------------------------------------------------------------
-- Cut Grass
-----------------------------------------------------------------------------------------------
-- grass recipes (remove roots)
minetest.register_craft({
	output = "cottages:cut_grass",
	recipe = {
		{"default:grass_1"},
	}
})
minetest.register_craft({
	output = "cottages:cut_grass 2",
	recipe = {
		{"default:junglegrass"},
	}
})

minetest.register_craft({
	output = "cottages:cut_grass",
	recipe = {
		{"default:marram_grass_1"},
	}
})

minetest.register_craft({
	type = "cooking",
	output = "cottages:hay",
	recipe = "cottages:cut_grass",
})

minetest.register_craft({ -- hay -> reed
	output = "cottages:reed 2",
	recipe = {
		{"cottages:hay","cottages:hay"},
		{"cottages:hay","cottages:hay"},
	}
})

minetest.register_craft({ -- roof -> block
	output = "cottages:reed",
	recipe = {
		{"cottages:reed_roof"},
		{"cottages:reed_roof"},
	}
})

minetest.register_craft({ -- corner -> block
	type = "shapeless",
	output = "cottages:reed 3",
	recipe = {"cottages:reed_roof_corner", "cottages:reed_roof_corner", "cottages:reed_roof_corner",
		"cottages:reed_roof_corner", "cottages:reed_roof_corner", "cottages:reed_roof_corner",
		"cottages:reed_roof_corner", "cottages:reed_roof_corner"}, -- 8x
})

minetest.register_craft({ -- corner_2 -> block
	type = "shapeless",
	output = "cottages:reed 3",
	recipe = {"cottages:reed_roof_corner_2", "cottages:reed_roof_corner_2", "cottages:reed_roof_corner_2",
		"cottages:reed_roof_corner_2", "cottages:reed_roof_corner_2", "cottages:reed_roof_corner_2",
		"cottages:reed_roof_corner_2", "cottages:reed_roof_corner_2"}, -- 8x
})

minetest.register_craft({ -- block -> roof
	output = "cottages:reed_roof 4",
	recipe = {
		{"","cottages:reed"},
		{"cottages:reed",""},
	}
})

minetest.register_craft({ -- block -> corner
	output = "cottages:reed_roof_corner 8",
	recipe = {
		{"","cottages:reed",""},
		{"cottages:reed","","cottages:reed"},
	}
})
minetest.register_craft({ -- corner_2 -> corner
	output = "cottages:reed_roof_corner",
	recipe = {
		{"cottages:reed_roof_corner_2"},
	}
})

minetest.register_craft({ -- block -> corner_2
	output = "cottages:reed_roof_corner_2 8",
	recipe = {
		{"cottages:reed","","cottages:reed"},
		{"","cottages:reed",""},
	}
})
minetest.register_craft({ -- corner -> corner_2
	output = "cottages:reed_roof_corner_2",
	recipe = {
		{"cottages:reed_roof_corner"},
	}
})

stairs.register_stair_and_slab(
	"reed",
	"cottages:reed",
	{snappy = 3, flammable = 2},
	{"cottages_reed.png"},
	"Reed Stair",
	"Reed Slab",
	default.node_sound_leaves_defaults(),
	true
)
