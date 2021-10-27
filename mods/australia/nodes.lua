-- mods/australia/nodes.lua
if minetest.settings:get_bool("log_files") then minetest.log("australia/nodes" ) end


--
-- Stone
--

minetest.register_node("australia:red_stone", {
	description = "Red Stone",
	tiles = {"aus_red_stone.png"},
	groups = {cracky=3, stone=1},
	drop = 'australia:red_cobble',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:red_cobble", {
	description = "Red cobblestone",
	tiles = {"aus_red_cobble.png"},
	is_ground_content = false,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:red_stonebrick", {
	description = "Red Stone Brick",
	tiles = {"aus_red_stonebrick.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:bluestone", {
	description = "Bluestone (Basalt)",
	tiles = {"aus_bluestone.png"},
	groups = {cracky=2, stone=1},
	drop = 'australia:bluestone_cobble',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:bluestone_cobble", {
	description = "Bluestone cobble",
	tiles = {"aus_bluestone_cobble.png"},
	is_ground_content = false,
	groups = {cracky=2, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:bluestone_brick", {
	description = "Bluestone Brick",
	tiles = {"aus_bluestone_brick.png"},
	is_ground_content = false,
	groups = {cracky=1, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_brain", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cluster_green", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cluster_orange", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cluster_purple", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_hammer", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_seafan", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_tube_sponge", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cauliflower_brown", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cauliflower_green", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_cauliflower_pink", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_staghorn_blue", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_staghorn_pink", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_staghorn_purple", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:coral_stone_staghorn_yellow", {
	description = "Sea coral stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:stone_kelp_brown", {
	description = "Sea stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("australia:stone_kelp_giant_brown", {
	description = "Sea stone",
	tiles = {"aus_coral_stone.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	drop = 'default:stone',
	sounds = default.node_sound_stone_defaults(),
})



--
-- Soft / Non-Stone
--

minetest.register_node("australia:red_dirt", {
	description = "Red Dirt",
	tiles = {"aus_red_dirt.png"},
	groups = {crumbly=3,soil=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("australia:red_sand", {
	description = "Red Sand",
	tiles = {"aus_red_sand.png"},
	groups = {crumbly=3, falling_node=1, sand=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("australia:red_gravel", {
	description = "Red Gravel",
	tiles = {"aus_red_gravel.png"},
	groups = {crumbly=2, falling_node=1, gravel = 1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_gravel_footstep", gain=0.5},
		dug = {name="default_gravel_footstep", gain=1.0},
	}),
})

minetest.register_node("australia:mangrove_mud", {
	description = "Mangrove Mud",
	tiles = {"aus_mangrove_mud.png"},
	groups = {crumbly=2, soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="aus_mangrove_mud", gain=0.4},
		dug = {name="aus_mangrove_mud", gain=0.4},
	}),
})

minetest.register_node("australia:woodship", {
	description = "Sand for the wooden ship",
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {crumbly=3, falling_node=1, sand=1, soil=1, not_in_creative_inventory=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("australia:submarine", {
	description = "Dirt for the submarine",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3,soil=1, not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults(),
})

--
-- Trees
--

aus.treelist = {
	--treename, treedesc, treetrunk_dia, treespaling, treefruit, treefruit_desc, treefruit_scale, treefruit_health
	{"black_box", "Black Box", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"black_wattle", "Black Wattle", 0.75, "acacia", nil, nil, nil, nil },
	{"blue_gum", "Blue Gum", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"boab", "Boab", 1.0, "boab", nil, nil, nil, nil },
	{"bull_banksia", "Bull Banksia", 0.33, "banksia", nil, nil, nil, nil },
	{"celery_top_pine", "Celery-top Pine", 1, "pine", nil, nil, nil, nil },
	{"cherry", "Australian Cherry", 0.5, "berry", "cherry", "Australian Cherries", 0.67, 1 },
	{"cloncurry_box", "Cloncurry Box", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"coast_banksia", "Coast Banksia", 1.0, "banksia", nil, nil, nil, nil },
	{"coolabah", "Coolabah", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"daintree_stringybark", "Daintree Stringybark", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"darwin_woollybutt", "Darwin Woollybutt", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"desert_oak", "Desert Oak", 1.0, "acacia", nil, nil, nil, nil },
	{"fan_palm", "Australian Fan Palm", 1.0, "palm", nil, nil, nil, nil },
	{"golden_wattle", "Golden Wattle", 0.33, "acacia", nil, nil, nil, nil },
	{"grey_mangrove", "Grey Mangrove", 0.25, "mangrove", nil, nil, nil, nil },
	{"huon_pine", "Huon Pine", 1.0, "pine", nil, nil, nil, nil },
	{"illawarra_flame", "Illawarra Flame", 1.0, "illawarra_flame", nil, nil, nil, nil },
	{"jarrah", "Jarrah", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"karri", "Karri", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"lemon_eucalyptus", "Lemon Eucalyptus", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"lemon_myrtle", "Lemon Myrtle", 0.5, "myrtle", nil, nil, nil, nil },
	{"lilly_pilly", "Lilly Pilly", 0.33, "berry", "lilly_pilly_berries", "Lilly Pilly Berries", 0.67, 1 },
	{"macadamia", "Prickly Macadamia", 0.75, "macadamia", "macadamia", "Macadamia Nuts", 0.67, 1 },
	{"mangrove_apple", "Mangrove Apple", 0.75, "mangrove_apple", "mangrove_apple", "Mangrove Apple", 0.67, 1 },
	{"merbau", "Merbau", 1.0, "merbau", nil, nil, nil, nil },
	{"marri", "Marri", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"moreton_bay_fig", "Moreton Bay Fig", 1.0, "fig", "moreton_bay_fig", "Moreton Bay Fig", 0.67, 1 },
	{"mulga", "Mulga", 0.5, "acacia", nil, nil, nil, nil },
	{"paperbark", "Paper Bark", 1.0, "melaleuca", nil, nil, nil, nil },
	{"quandong", "Desert Quandong", 0.25, "quandong", "quandong", "Desert Quandong", 0.5, 1 },
	{"red_bottlebrush", "Red Bottlebrush", 0.33, "melaleuca", nil, nil, nil, nil },
	{"river_oak", "River Oak", 1.0, "acacia", nil, nil, nil, nil },
	{"river_red_gum", "River Red Gum", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"rottnest_island_pine", " Rottnest Island Pine", 0.75, "pine", nil, nil, nil, nil },
	{"scribbly_gum", "Scribbly Gum", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"shoestring_acacia", "Shoestring Acacia", 1.0, "acacia", nil, nil, nil, nil },
	{"snow_gum", "Snow Gum", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"southern_sassafras", "Southern Sassafras", 1, "pine", nil, nil, nil, nil },
	{"stilted_mangrove", "Stilted Mangrove", 0.25, "mangrove", nil, nil, nil, nil },
	{"sugar_gum", "Sugar Gum", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"swamp_bloodwood", "Swamp Bloodwood", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"swamp_gum", "Swamp Gum", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"swamp_paperbark", "Swamp Paperbark", 0.5, "melaleuca", nil, nil, nil, nil },
	{"tasmanian_myrtle", "Tasmanian Myrtle", 1.0, "myrtle", nil, nil, nil, nil },
	{"tea_tree", "Tea", 0.5, "melaleuca", nil, nil, nil, nil },
	{"white_box", "White Box", 1.0, "eucalyptus", nil, nil, nil, nil },
	{"wirewood", "Wirewood", 0.33, "acacia", nil, nil, nil, nil },
}

for i in ipairs(aus.treelist) do
	local treename			= aus.treelist[i][1]
	local treedesc			= aus.treelist[i][2]
	local treetrunk_dia		= aus.treelist[i][3]
	local treespaling		= aus.treelist[i][4]
	local treefruit			= aus.treelist[i][5]
	local treefruit_desc	= aus.treelist[i][6]
	local treefruit_scale	= aus.treelist[i][7]
	local treefruit_health	= aus.treelist[i][8]

	-- tree
	local node_d = {
		description = treedesc.. " Trunk",
		tiles = {
			"aus_"..treename.."_trunk_top.png",
			"aus_"..treename.."_trunk_top.png",
			"aus_"..treename.."_trunk.png"
		},
		use_texture_alpha = "clip",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {tree=1,choppy=2,oddly_breakable_by_hand=1,flammable=2},
		sounds = default.node_sound_wood_defaults(),
		on_place = minetest.rotate_node,
	}
	-- Some trunks aren't a meter wide.
	if treetrunk_dia and treetrunk_dia ~= 1 then
		local radius = treetrunk_dia / 2
		node_d.paramtype = "light"
		node_d.drawtype = "nodebox"
		node_d.node_box = { type = "fixed",
			fixed = { {-radius, -0.5, -radius, radius, 0.5, radius}, }
		}
		node_d.selection_box = { type = "fixed",
			fixed = { {-radius, -0.5, -radius, radius, 0.5, radius}, }
		}
	end
	minetest.register_node("australia:"..treename.."_trunk", node_d)

	-- wood
	minetest.register_node("australia:"..treename.."_wood", {
		description = treedesc.." Wood Planks",
		tiles = {"aus_"..treename.."_wood.png"},
		use_texture_alpha = "clip",
		groups = {choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
		sounds = default.node_sound_wood_defaults(),
	})

	-- leaves
	minetest.register_node("australia:"..treename.."_leaves", {
		description = treedesc.." Leaves",
		drawtype = "allfaces_optional",
		visual_scale = 1.3,
		tiles = { "aus_"..treename.."_leaves.png"},
		use_texture_alpha = "clip",
		paramtype = "light",
		is_ground_content = false,
		groups = {snappy=3,flammable=2,leaves=1},
		drop = {
			max_items = 1,
			items = {
				{items = {"australia:"..treename.."_sapling"}, rarity = 50 },
				{items = {"australia:"..treename.."_leaves"} }
			}
		},
		sounds = default.node_sound_leaves_defaults(),
	})

	-- sapling
	minetest.register_node("australia:"..treename.."_sapling", {
		description = treedesc.." Sapling",
		drawtype = "plantlike",
		visual_scale = 1.0,
		tiles = {"aus_"..treespaling.."_sapling.png"},
		use_texture_alpha = "clip",
		inventory_image = "aus_"..treespaling.."_sapling.png",
		wield_image = "aus_"..treespaling.."_sapling.png",
		paramtype = "light",
		sunlight_propagates = true,
		walkable = false,
		is_ground_content = false,
		selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0.35, 0.3}
		},
		groups = {snappy=2,dig_immediate=3,flammable=2,attached_node=1},
		sounds = default.node_sound_leaves_defaults(),
	})

	-- fruit, if applicable
	if treefruit then
		if treefruit == "cherry" then
			minetest.register_node("australia:"..treefruit.."", {
				description = treefruit_desc,
				drawtype = "plantlike",
				visual_scale = treefruit_scale,
				tiles = { "aus_"..treefruit..".png" },
				use_texture_alpha = "clip",
				inventory_image = "aus_"..treefruit..".png",
				wield_image = "aus_"..treefruit..".png",
				paramtype = "light",
				sunlight_propagates = true,
				walkable = false,
				is_ground_content = false,
				selection_box = {
					type = "fixed",
					fixed = {-0.1, -0.5, -0.1, 0.1, -0.25, 0.1},
				},
				groups = {fleshy=3,dig_immediate=3,flammable=2,leafdecay=3,leafdecay_drop=1, cherries = 1},
				-- Fruit makes you healthy.
				on_use = minetest.item_eat(treefruit_health),
				sounds = default.node_sound_leaves_defaults(),
				after_place_node = function(pos, placer, itemstack)
					if placer:is_player() then
						minetest.set_node(pos, {name="australia:"..treefruit.."", param2=1})
					end
				end,
			})
		else
			minetest.register_node("australia:"..treefruit.."", {
				description = treefruit_desc,
				drawtype = "plantlike",
				visual_scale = treefruit_scale,
				tiles = { "aus_"..treefruit..".png" },
				use_texture_alpha = "clip",
				inventory_image = "aus_"..treefruit..".png",
				wield_image = "aus_"..treefruit..".png",
				paramtype = "light",
				sunlight_propagates = true,
				walkable = false,
				is_ground_content = false,
				selection_box = {
					type = "fixed",
					fixed = {-0.1, -0.5, -0.1, 0.1, -0.25, 0.1},
				},
				groups = {fleshy=3,dig_immediate=3,flammable=2,leafdecay=3,leafdecay_drop=1},
				-- Fruit makes you healthy.
				on_use = minetest.item_eat(treefruit_health),
				sounds = default.node_sound_leaves_defaults(),
				after_place_node = function(pos, placer, itemstack)
					if placer:is_player() then
						minetest.set_node(pos, {name="australia:"..treefruit.."", param2=1})
					end
				end,
			})
		end
	end
	--[[
	-- fence
	default.register_fence("australia:fence_"..treename.."_wood", {
		description = treedesc.." Fence",
		texture = "aus_"..treename.."_wood.png",
		material = "australia:"..treename.."_wood",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults(),
	})
	--]]
end



--
-- Ferns
--

	-- Fern
minetest.register_node("australia:fern", {
	description = "Ruddy Ground Fern",
	inventory_image = "aus_fern.png",
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	tiles = {"aus_fern_mid.png"},
	use_texture_alpha = "clip",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
	drop = "australia:fern",
})

	-- Small Fern
minetest.register_node("australia:small_fern", {
	description = "Sickle Fern",
	inventory_image = "aus_fern.png",
	drawtype = "plantlike",
	visual_scale = 1,
	paramtype = "light",
	tiles = {"aus_fern.png"},
	use_texture_alpha = "clip",
	walkable = false,
	buildable_to = true,
	groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
	drop = "australia:small_fern",
})

	-- Tree fern leaves
minetest.register_node("australia:tree_fern_leaves", {
	description = "Tree Fern Crown",
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"aus_fern_tree.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_fern_tree_inv.png",
	walkable = false,
	groups = {snappy=3,flammable=2,attached_node=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"autralia:sapling_tree_fern"},
				rarity = 20,
			},
			{
				items = {"australia:tree_fern_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})
minetest.register_node("australia:tree_fern_leaves_02", {
	drawtype = "plantlike",
	visual_scale = 2,
	paramtype = "light",
	tiles = {"aus_fern_big.png"},
	use_texture_alpha = "clip",
	walkable = false,
	groups = {snappy=3,flammable=2,attached_node=1,not_in_creative_inventory=1},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"australia:sapling_tree_fern"},
				rarity = 20,
			},
			{
				items = {"australia:tree_fern_leaves"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})

	-- Fern trunk
minetest.register_node("australia:fern_trunk", {
	description = "Tree Fern Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {
		"aus_fern_trunk_top.png",
		"aus_fern_trunk_top.png",
		"aus_fern_trunk.png"
	},
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {-1/8, -1/2, -1/8, 1/8, 1/2, 1/8},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
        if node.name == "australia:fern_trunk" then
            minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z})
            minetest.add_item(pos,"australia:fern_trunk")
        end
    end,
})

	-- Giant tree fern leaves
minetest.register_node("australia:tree_fern_leaves_giant", {
	description = "Tree Fern Crown",
	drawtype = "plantlike",
	visual_scale = math.sqrt(8),
	wield_scale = {x=0.175, y=0.175, z=0.175},
	paramtype = "light",
	tiles = {"aus_fern_tree_giant.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_fern_tree.png",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		not_in_creative_inventory=1
	},
	drop = {
		max_items = 2,
		items = {
			{
				-- occasionally, drop a second sapling instead of leaves
				-- (extra saplings can also be obtained by replanting and
				--  reharvesting leaves)
				items = {"australia:sapling_giant_tree_fern"},
				rarity = 10,
			},
			{
				items = {"australia:sapling_giant_tree_fern"},
			},
			{
				items = {"australia:tree_fern_leaves_giant"},
			}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})

	-- Giant tree fern leaf part
minetest.register_node("australia:tree_fern_leaf_big", {
	description = "Giant Tree Fern Leaves",
	drawtype = "raillike",
	paramtype = "light",
	tiles = {
		"aus_tree_fern_leaf_big.png",
	},
	use_texture_alpha = "clip",
	walkable = false,
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		not_in_creative_inventory=1
	},
	drop = "",
	sounds = default.node_sound_leaves_defaults(),
})

	-- Giant tree fern leaf end
minetest.register_node("australia:tree_fern_leaf_big_end", {
	description = "Giant Tree Fern Leaf End",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = { "aus_tree_fern_leaf_big_end.png" },
	use_texture_alpha = "clip",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2,   1/2, 1/2,   33/64, 1/2},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2,   1/2, 1/2,   33/64, 1/2},
	},
	groups = {
		snappy=3,
		flammable=2,
		attached_node=1,
		not_in_creative_inventory=1
	},
	drop = "",
	sounds = default.node_sound_leaves_defaults(),
})

	-- Giant tree fern trunk top
minetest.register_node("australia:fern_trunk_big_top", {
	description = "Giant Tree Fern Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {
		"aus_fern_trunk_big_top.png^aus_tree_fern_leaf_big_cross.png",
		"aus_fern_trunk_big_top.png^aus_tree_fern_leaf_big_cross.png",
		"aus_fern_trunk_big.png"
	},
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {
			{-1/2,  33/64, -1/2, 1/2, 33/64, 1/2},
			{-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
	},
	groups = {
		tree=1,
		choppy=2,
		oddly_breakable_by_hand=2,
		flammable=3,
		wood=1,
		not_in_creative_inventory=1,
		leafdecay=3 -- to support vines
	},
	drop = "australia:fern_trunk_big",
	sounds = default.node_sound_wood_defaults(),
})

	-- Giant tree fern trunk
minetest.register_node("australia:fern_trunk_big", {
	description = "Giant Tree Fern Trunk",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {
		"aus_fern_trunk_big_top.png",
		"aus_fern_trunk_big_top.png",
		"aus_fern_trunk_big.png"
	},
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/4, -1/2, -1/4, 1/4, 1/2, 1/4},
	},
	groups = {tree=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_wood_defaults(),
	after_destruct = function(pos,oldnode)
        local node = minetest.get_node({x=pos.x,y=pos.y+1,z=pos.z})
        if node.name == "australia:fern_trunk_big" or node.name == "australia:fern_trunk_big_top" then
            minetest.dig_node({x=pos.x,y=pos.y+1,z=pos.z})
            minetest.add_item(pos,"australia:fern_trunk_big")
        end
    end,
})

	-- Tree fern sapling
minetest.register_node("australia:sapling_tree_fern", {
	description = "Tree Fern Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"aus_sapling_tree_fern.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_sapling_tree_fern.png",
	walkable = false,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})

	-- Giant tree fern sapling
minetest.register_node("australia:sapling_giant_tree_fern", {
	description = "Giant Tree Fern Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"aus_sapling_tree_fern_giant.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_sapling_tree_fern_giant.png",
	walkable = false,
	groups = {snappy=3,flammable=2,flora=1,attached_node=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-7/16, -1/2, -7/16, 7/16, 0, 7/16},
	},
})



--
-- Ores
--


--
-- Plantlife (non-cubic)
--

	-- Acrostichum speciosum: Mangrove Fern
minetest.register_node("australia:mangrove_fern", {
	description = "Mangrove Fern",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.0,
	tiles = {"aus_mangrove_fern.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_mangrove_fern.png",
	wield_image = "aus_mangrove_fern.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Crinum pedunculatum: Mangrove Lily
minetest.register_node("australia:mangrove_lily", {
	description = "Mangrove Lily",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.0,
	tiles = {"aus_mangrove_lily.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_mangrove_lily.png",
	wield_image = "aus_mangrove_lily.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Nypa fruticans: Mangrove Palm
minetest.register_node("australia:mangrove_palm_trunk", {
	description = "Mangrove Fern",
	tiles = {"aus_mangrove_palm_trunk.png", "aus_mangrove_mud.png",
		"aus_mangrove_palm_trunk.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_mangrove_palm_trunk.png",
	wield_image = "aus_mangrove_palm_trunk.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, flammable = 2, flora = 1, attached_node = 1, oddly_breakable_by_hand = 1},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
--	drawtype = "nodebox",
--	node_box = {
--		type = "fixed",
--		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
--	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
})

minetest.register_node("australia:mangrove_palm_leaf_bot", {
	description = "Mangrove Fern",
	tiles = {"aus_mangrove_palm_leaf_bot.png", "aus_mangrove_palm_leaf_bot.png",
		"aus_mangrove_palm_leaf_bot.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_mangrove_palm_leaf_bot.png",
	wield_image = "aus_mangrove_palm_leaf_bot.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	drawtype = "nodebox",
	nodebox = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
})

minetest.register_node("australia:mangrove_palm_leaf_top", {
	description = "Mangrove Fern",
	tiles = {"aus_mangrove_palm_leaf_top.png", "aus_mangrove_palm_leaf_top.png",
		"aus_mangrove_palm_leaf_top.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_mangrove_palm_leaf_top.png",
	wield_image = "aus_mangrove_palm_leaf_top.png",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	drawtype = "nodebox",
	nodebox = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
	},
})

	-- Banksia dallanneyi: Couch Honeypot
minetest.register_node("australia:couch_honeypot", {
	description = "Couch Honeypot",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_couch_honeypot.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_couch_honeypot.png",
	wield_image = "aus_couch_honeypot.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Crinum flaccidum: Darling Lily
minetest.register_node("australia:darling_lily", {
	description = "Darling Lily",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.0,
	tiles = {"aus_darling_lily.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_darling_lily.png",
	wield_image = "aus_darling_lily.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Astrebla pectinata: Mitchell Grass
minetest.register_node("australia:mitchell_grass", {
	description = "Mitchell Grass",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_mitchell_grass.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_mitchell_grass.png",
	wield_image = "aus_mitchell_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Atriplex nummularia: Saltbush
minetest.register_node("australia:saltbush", {
	description = "Saltbush",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.4,
	tiles = {"aus_saltbush.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_saltbush.png",
	wield_image = "aus_saltbush.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Olearia pannosa: Silver Daisy
minetest.register_node("australia:silver_daisy", {
	description = "Silver Daisy",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.0,
	tiles = {"aus_silver_daisy.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_silver_daisy.png",
	wield_image = "aus_silver_daisy.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Triodia longiceps: Spinifex
minetest.register_node("australia:spinifex", {
	description = "Spinifex",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.2,
	tiles = {"aus_spinifex.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_spinifex.png",
	wield_image = "aus_spinifex.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Telopea speciosissima: Waratah
minetest.register_node("australia:waratah", {
	description = "Waratah",
	drawtype = "allfaces_optional",
	visual_scale = 1.0,
	tiles = { "aus_waratah.png"},
	use_texture_alpha = "clip",
	inventory_image =  "aus_waratah.png",
	wield_image =  "aus_waratah.png",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy = 3, flammable = 2, flora = 1, attached_node = 1},
	sounds = default.node_sound_leaves_defaults(),
})

	-- Ecklonia radiata: Common Kelp
minetest.register_node("australia:kelp_brown", {
	description = "Common Kelp",
	drawtype = "plantlike",
	waving = 1,
	tiles = {"aus_kelp_brown.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_kelp_brown.png",
	wield_image = "aus_kelp_brown.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Macrocystis pyrifera: Giant Kelp
minetest.register_node("australia:kelp_giant_brown", {
	description = "Giant Kelp ",
	drawtype = "plantlike",
	tiles = {"aus_kelp_giant_brown.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_kelp_giant_brown.png",
	wield_image = "aus_kelp_giant_brown.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.3, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	sounds = default.node_sound_leaves_defaults(),
	on_use = minetest.item_eat(1)
})

minetest.register_node("australia:kelp_giant_brown_middle", {
	description = "Giant Kelp middle",
	drawtype = "plantlike",
	tiles = {"aus_kelp_giant_brown_middle.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_kelp_giant_brown_middle.png",
	wield_image = "aus_kelp_giant_brown_middle.png",
	paramtype = "light",
	walkable = false,
	climbable = true,
	drowning = 1,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {snappy=3, seaplants=1, sea=1},
	drop = "australia:kelp_giant_brown",
	sounds = default.node_sound_leaves_defaults(),
})

	-- Dipsastraea speciosa: Brain Coral
minetest.register_node("australia:brain_coral", {
	description = "Brain Coral",
	drawtype = "nodebox",
	paramtype = "light",
	tiles = {
		"aus_brain_coral.png",
		"aus_brain_coral.png",
		"aus_brain_coral.png",
		"aus_brain_coral.png",
		"aus_brain_coral.png",
		"aus_brain_coral.png"
	},
	use_texture_alpha = "clip",
	inventory_image =  "aus_brain_coral.png",
	wield_image =  "aus_brain_coral.png",
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
			{-0.1875, -0.5, -0.1875, 0.1875, 0.4375, 0.1875},
			{-0.25, -0.5, -0.25, 0.25, 0.375, 0.25},
			{-0.3125, -0.5, -0.3125, 0.3125, 0.3125, 0.3125},
			{-0.375, -0.5, -0.375, 0.375, 0.25, 0.375},
			{-0.4375, -0.4375, -0.4375, 0.4375, 0.1875, 0.4375},
			{-0.5, -0.375, -0.5, 0.5, 0.125, 0.5},
		}
	},
})

	-- Pocillopora damicornis: Cauliflower Coral (brown)
minetest.register_node("australia:cauliflower_coral_brown", {
	description = "Cauliflower Coral",
	drawtype = "plantlike",
	visual_scale = 0.75,
	tiles = { "aus_cauliflower_coral_brown.png"},
	use_texture_alpha = "clip",
	inventory_image =  "aus_cauliflower_coral_brown.png",
	wield_image =  "aus_cauliflower_coral_brown.png",
	paramtype = "light",
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Pocillopora damicornis: Cauliflower Coral (green)
minetest.register_node("australia:cauliflower_coral_green", {
	description = "Cauliflower Coral",
	drawtype = "plantlike",
	visual_scale = 0.75,
	tiles = { "aus_cauliflower_coral_green.png"},
	use_texture_alpha = "clip",
	inventory_image =  "aus_cauliflower_coral_green.png",
	wield_image =  "aus_cauliflower_coral_green.png",
	paramtype = "light",
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Pocillopora damicornis: Cauliflower Coral (pink)
minetest.register_node("australia:cauliflower_coral_pink", {
	description = "Cauliflower Coral",
	drawtype = "plantlike",
	visual_scale = 0.75,
	tiles = { "aus_cauliflower_coral_pink.png"},
	use_texture_alpha = "clip",
	inventory_image =  "aus_cauliflower_coral_pink.png",
	wield_image =  "aus_cauliflower_coral_pink.png",
	paramtype = "light",
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Acropora millepora: Cluster Coral (green)
minetest.register_node("australia:cluster_coral_green", {
	description = "Cluster Coral",
	drawtype = "plantlike",
	tiles = {"aus_cluster_coral_green.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_cluster_coral_green.png",
	wield_image = "aus_cluster_coral_green.png",
	paramtype = "light",
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Acropora millepora: Cluster Coral (orange)
minetest.register_node("australia:cluster_coral_orange", {
	description = "Cluster Coral",
	drawtype = "plantlike",
	tiles = {"aus_cluster_coral_orange.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_cluster_coral_orange.png",
	wield_image = "aus_cluster_coral_orange.png",
	paramtype = "light",
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Acropora millepora: Cluster Coral (purple)
minetest.register_node("australia:cluster_coral_purple", {
	description = " Cluster Coral",
	drawtype = "plantlike",
	tiles = {"aus_cluster_coral_purple.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_cluster_coral_purple.png",
	wield_image = "aus_cluster_coral_purple.png",
	paramtype = "light",
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Acropora cervicornis: Staghorn Coral (blue)
minetest.register_node("australia:staghorn_coral_blue", {
	description = "Staghorn Coral",
	drawtype = "plantlike",
	tiles = {"aus_staghorn_coral_blue.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_staghorn_coral_blue.png",
	wield_image = "aus_staghorn_coral_blue.png",
	paramtype = "light",
	walkable = false,
	climable = true,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Acropora cervicornis: Staghorn Coral (pink)
minetest.register_node("australia:staghorn_coral_pink", {
	description = "Staghorn Coral",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_staghorn_coral_pink.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_staghorn_coral_pink.png",
	wield_image = "aus_staghorn_coral_pink.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Acropora cervicornis: Staghorn Coral (purple)
minetest.register_node("australia:staghorn_coral_purple", {
	description = "Staghorn Coral",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_staghorn_coral_purple.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_staghorn_coral_purple.png",
	wield_image = "aus_staghorn_coral_purple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Acropora cervicornis: Staghorn Coral (yellow)
minetest.register_node("australia:staghorn_coral_yellow", {
	description = "Staghorn Coral",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_staghorn_coral_yellow.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_staghorn_coral_yellow.png",
	wield_image = "aus_staghorn_coral_yellow.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {cracky = 3, coral = 1, stone = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_stone_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Acabaria sp.: Sea Fan
minetest.register_node("australia:seafan_coral", {
	description = "Sea Fan",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_seafan_coral.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_seafan_coral.png",
	wield_image = "aus_seafan_coral.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy = 3, coral = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Euphyllia ancora: Hammer coral
minetest.register_node("australia:hammer_coral", {
	description = "Hammer coral",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_hammer_coral.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_hammer_coral.png",
	wield_image = "aus_hammer_coral.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy = 3, coral = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Pipestela candelabra: Bob Marley Sponge
minetest.register_node("australia:tube_sponge", {
	description = "Bob Marley Sponge",
	drawtype = "plantlike",
	waving = 0,
	visual_scale = 1.0,
	tiles = {"aus_tube_sponge.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_tube_sponge.png",
	wield_image = "aus_tube_sponge.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy = 3, coral = 1, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})

	-- Halodule uninervis: Narrowleaf Seagrass
minetest.register_node("australia:sea_grass", {
	description = "Narrowleaf Seagrass",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.0,
	tiles = {"aus_sea_grass.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_sea_grass.png",
	wield_image = "aus_sea_grass.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	climable = true,
	buildable_to = false,
	drowning = 1,
	is_ground_content = true,
	groups = {snappy = 3, attached_node = 1, sea = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.3125, 0.5},
	},
})



--
-- Liquids
--

minetest.register_node("australia:muddy_river_water_source", {
	description = "Muddy river water source",
	drawtype = "liquid",
	tiles = {
		{
			name="aus_muddy_river_water_flowing.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	special_tiles = {
		{
			name="aus_muddy_river_water_flowing.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
			backface_culling = false,
		},
	},
--	alpha = 224,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "australia:muddy_river_water_flowing",
	liquid_alternative_source = "australia:muddy_river_water_source",
	liquid_viscosity = 1,
	liquid_renewable = true,
	liquid_range = 3,
	post_effect_color = {a = 232, r = 92, g = 80, b = 48},
	groups = {water = 3, liquid = 3, puts_out_fire = 1},
})

minetest.register_node("australia:muddy_river_water_flowing", {
	description = "Flowing muddy river water",
	drawtype = "flowingliquid",
	tiles = {"aus_muddy_river_water_source.png"},
	special_tiles = {
		{
			image="aus_muddy_river_water_flowing.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			image="aus_muddy_river_water_flowing.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
	},
--	alpha = 224,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "australia:muddy_river_water_flowing",
	liquid_alternative_source = "australia:muddy_river_water_source",
	liquid_viscosity = 1,
	liquid_renewable = true,
	liquid_range = 3,
	post_effect_color = {a = 232, r = 92, g = 80, b = 48},
	groups = {water = 3, liquid = 3, puts_out_fire = 1,
		not_in_creative_inventory = 1},
})


--
-- Tools / "Advanced" crafting / Non-"natural"
--

minetest.register_node("australia:woodshipchest", {
	description = "Wooden ship chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	drop = 'default:chest',
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"size[8,9]"..
			"list[current_name;main;0,0;8,4;]"..
			"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Woodship chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	local contents = {}
	if math.random(1,100) <= 25 then
		contents = {main = {[1] = "default:coal_lump 36"}}
	elseif math.random(1,100) >= 26 or math.random(1,100) <= 40 then
		contents = {main = {[1] = "default:iron_lump 24"}}
	elseif math.random(1,100) >= 41 or math.random(1,100) <= 45 then
		contents = {main = {[1] = "default:gold_lump 24"}}
	elseif math.random(1,100) >= 46 or math.random(1,100) <= 50 then
		contents = {main = {[1] = "default:diamond 24"}}
	elseif math.random(1,100) >= 51 or math.random(1,100) <= 60 then
		contents = {main = {[1] = "australia:huon_pine_tree 18"}}
	elseif math.random(1,100) >= 61 or math.random(1,100) <= 70 then
		contents = {main = {[1] = "australia:jarrah_tree 18"}}
	elseif math.random(1,100) >= 71 or math.random(1,100) <= 80 then
		contents = {main = {[1] = "australia:marri_tree 18"}}
	elseif math.random(1,100) >= 81 or math.random(1,100) <= 90 then
		contents = {main = {[1] = "australia:merbau_tree 18"}}
	else
		contents = {main = {[1] = "australia:river_red_gum_tree 18"}}
	end
meta:from_table({
	inventory = contents,
	fields = {
	formspec = "size[8,9;]list[context;main;0,0;8,4;]list[current_player;main;0,5;8,4;]",
	infotext = "Normal chest"
	}
})
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,
})

minetest.register_node("australia:submarinechest", {
	description = "U-boot chest",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {choppy=2,oddly_breakable_by_hand=2, not_in_creative_inventory=1},
	drop = 'default:chest',
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
			"size[8,9]"..
			"list[current_name;main;0,0;8,4;]"..
			"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "U-boot chest")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	local contents = {}
	if math.random(1,2) == 1 and minetest.get_modpath("technic_worldgen") then
		contents = {main = {[1] = "technic:mineral_uranium 18", [2] = "default:sword_steel 2"}}
	else
		contents = {main = {[1] = "tnt:tnt 3", [2] = "default:sword_steel 2"}}
	end
meta:from_table({
	inventory = contents,
	fields = {
	formspec = "size[8,9;]list[context;main;0,0;8,4;]list[current_player;main;0,5;8,4;]",
	infotext = "Normal chest"
	}
})
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,
})



--
-- Misc
--

minetest.register_node("australia:moss", {
	description = "Moss",
	drawtype = "nodebox",
	tiles = {"aus_moss.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_moss.png",
	wield_image = "aus_moss.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.46875, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
	},
	groups = {snappy = 3,flammable = 3},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("australia:moss_with_fungus", {
	description = "Moss with Fungus",
	drawtype = "nodebox",
	tiles = {"aus_moss_fungus.png"},
	use_texture_alpha = "clip",
	inventory_image = "aus_moss_fungus.png",
	wield_image = "aus_moss_fungus.png",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.46875, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}
	},
	groups = {snappy = 3,flammable = 3},
	sounds = default.node_sound_leaves_defaults(),
})
