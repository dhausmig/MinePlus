if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- Home Decor mod by VanessaE
--
-- Mostly my own code, with bits and pieces lifted from Minetest's default
-- lua files and from ironzorg's flowers mod.  Many thanks to GloopMaster
-- for helping me figure out the inventories used in the nightstands/dressers.
--
-- The code for ovens, nightstands, refrigerators are basically modified
-- copies of the code for chests and furnaces.

local S = minetest.get_translator("decor_misc")
screwdriver = screwdriver or {}
xbg = default.gui_bg .. default.gui_bg_img .. default.gui_slots

decor_misc = {}

decor.register("ceiling_paint", {
	description = S("Textured Ceiling Paint"),
	drawtype = 'signlike',
	tiles = { 'decor_ceiling_paint.png' },
	inventory_image = 'decor_ceiling_paint_roller.png',
	wield_image = 'decor_ceiling_paint_roller.png',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = { type = "wallmounted" },
})

decor.register("ceiling_tile", {
	description = S("Drop-Ceiling Tile"),
	drawtype = 'signlike',
	tiles = { 'decor_ceiling_tile.png' },
	wield_image = 'decor_ceiling_tile.png',
	inventory_image = 'decor_ceiling_tile.png',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = { type = "wallmounted" },
})

local rug_types = {
	{ "small",   "decor_small_rug.obj"    },
	{ "large",   decor.box.slab_y(0.0625) },
	{ "persian", decor.box.slab_y(0.0625) },
}

for _, rt in ipairs(rug_types) do
	local s, m = unpack(rt)

	local mesh = m
	local nodebox = nil
	local tiles = { "decor_rug_"..s..".png", "wool_grey.png" }

	if type(m) == "table" then
		mesh = nil
		nodebox = {
			type = "fixed",
			fixed = m
		}
		tiles = {
			"decor_rug_"..s..".png",
			"wool_grey.png",
			"decor_rug_"..s..".png"
		}
	end

	decor.register("rug_"..s, {
		description = S("Rug (@1)", S(s)),
		mesh = mesh,
		tiles = tiles,
		node_box = nodebox,
		paramtype2 = "wallmounted",
		walkable = false,
		groups = {snappy = 3},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = { type = "wallmounted" },
	})
end

local pot_colors = { "black", "green", "terracotta" }

for _, p in ipairs(pot_colors) do
decor.register("flower_pot_"..p, {
	description = S("Flower Pot (@1)", S(p)),
	mesh = "decor_flowerpot.obj",
	tiles = {
		"decor_flower_pot_"..p..".png",
		{ name = "default_dirt.png", color = 0xff505050 },
	},
	groups = { snappy = 3, potting_soil=1 },
	sounds = default.node_sound_stone_defaults(),
})
end

local flowers_list = {
	{ S("Rose"),				"rose",				"flowers:rose" },
	{ S("Tulip"),				"tulip",			"flowers:tulip" },
	{ S("Yellow Dandelion"),	"dandelion_yellow",	"flowers:dandelion_yellow" },
	{ S("White Dandelion"), 	"dandelion_white",	"flowers:dandelion_white" },
	{ S("Blue Geranium"),		"geranium",			"flowers:geranium" },
	{ S("Viola"),				"viola",			"flowers:viola" },
	{ S("Cactus"),				"cactus",			"default:cactus" },
	{ S("Bonsai"),				"bonsai",			"default:sapling" }
}

for _, f in ipairs(flowers_list) do
	local flowerdesc, flower, craftwith = unpack(f)

	decor.register("potted_"..flower, {
		description = S("Potted flower (@1)", flowerdesc),
		mesh = "decor_potted_plant.obj",
		tiles = {
			"decor_flower_pot_terracotta.png",
			{ name = "default_dirt.png", color = 0xff303030 },
			"flowers_"..flower..".png"
		},
		walkable = false,
		groups = {snappy = 3},
		sounds = default.node_sound_glass_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.2, -0.5, -0.2, 0.2, 0.3, 0.2 }
		}
	})

	minetest.register_craft({
		type = "shapeless",
		output = "decor:potted_"..flower,
		recipe = { craftwith, "decor:flower_pot_small" }
	})

	minetest.register_alias("flowers:flower_"..flower.."_pot", "decor:potted_"..flower)
	minetest.register_alias("flowers:potted_"..flower, "decor:potted_"..flower)
	minetest.register_alias("flowers:flower_pot", "decor:flower_pot_small")
end

decor.register("pole_brass", {
	description = S("Brass Pole"),
	mesh = "decor_round_pole.obj",
	tiles = {"decor_generic_metal_brass.png^decor_generic_metal_lines_overlay.png",},
	inventory_image = "decor_pole_brass_inv.png",
	wield_image = "decor_pole_brass_inv.png",
	selection_box = {
		type = "fixed",
		fixed = { -0.125, -0.5, -0.125, 0.125, 0.5, 0.125 },
	},
	collision_box = {
		type = "fixed",
		fixed = { -0.125, -0.5, -0.125, 0.125, 0.5, 0.125 },
	},
	groups = {snappy=3},
	sounds = default.node_sound_wood_defaults(),
	check_for_pole = true
})

decor.register("pole_wrought_iron", {
    description = S("Wrought Iron Pole"),
    tiles = { "decor_generic_metal_wrought_iron.png^decor_generic_metal_lines_overlay.png" },
    inventory_image = "decor_pole_wrought_iron_inv.png",
    wield_image = "decor_pole_wrought_iron_inv.png",
    selection_box = {
            type = "fixed",
            fixed = {-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}
    },
	node_box = {
		type = "fixed",
                fixed = {-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625}
	},
    groups = {snappy=3},
    sounds = default.node_sound_wood_defaults(),
})

local ft_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.375, 0.5, 0.3125, 0.375 }
}

decor.register("fishtank", {
	description = S("Fishtank"),
	mesh = "decor_fishtank.obj",
	tiles = {
		{ name = "decor_generic_plastic.png", color = decor.color_black },
		"decor_fishtank_filter.png",
		"decor_fishtank_fishes.png",
		"decor_fishtank_gravel.png",
		"decor_fishtank_water_top.png",
		"decor_fishtank_sides.png",
	},
	use_texture_alpha = "clip",
	selection_box = ft_cbox,
	collision_box = ft_cbox,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.set_node(pos, {name = "decor:fishtank_lighted", param2 = node.param2})
		return itemstack
	end
})

decor.register("fishtank_lighted", {
	description = S("Fishtank (lighted)"),
	mesh = "decor_fishtank.obj",
	tiles = {
		{ name = "decor_generic_plastic.png", color = decor.color_black },
		"decor_fishtank_filter.png",
		"decor_fishtank_fishes_lighted.png",
		"decor_fishtank_gravel_lighted.png",
		"decor_fishtank_water_top_lighted.png",
		"decor_fishtank_sides_lighted.png",
	},
	light_source = default.LIGHT_MAX-4,
	use_texture_alpha = "clip",
	selection_box = ft_cbox,
	collision_box = ft_cbox,
	groups = {cracky=3,oddly_breakable_by_hand=3,not_in_creative_inventory=1},
	sounds = default.node_sound_glass_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.set_node(pos, {name = "decor:fishtank", param2 = node.param2})
		return itemstack
	end,
	drop = "decor:fishtank",
})

decor.register("cardboard_box_big", {
	description = S("Cardboard box (big)"),
	tiles = {
		'decor_cardbox_big_tb.png',
		'decor_cardbox_big_tb.png',
		'decor_cardbox_big_sides.png',
	},
	groups = { snappy = 3 },
	infotext=S("Cardboard box"),
	inventory = {
		size=24,
	},
})

decor.register("cardboard_box", {
	description = S("Cardboard box"),
	tiles = {
		'decor_cardbox_tb.png',
		'decor_cardbox_tb.png',
		'decor_cardbox_sides.png',
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0, 0.3125},
		}
	},
	groups = { snappy = 3 },
	infotext=S("Cardboard box"),
	inventory = {
		size=8,
	},
})

decor.register("dvd_cd_cabinet", {
	description = S("DVD/CD cabinet"),
	mesh = "decor_dvd_cabinet.obj",
	tiles = {
		"default_wood.png",
		"decor_dvdcd_cabinet_front.png",
		"decor_dvdcd_cabinet_back.png"
	},
	selection_box = decor.nodebox.slab_z(-0.5),
	groups = {choppy=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_wood_defaults(),
})

local pooltable_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 0.5, 0.3125, 1.5 }
}

decor.register("pool_table", {
	mesh = "decor_pool_table.obj",
	tiles = {
		"decor_pool_table_cue.png",
		"decor_pool_table_baize.png",
		"decor_pool_table_pockets.png",
		"decor_pool_table_balls.png",
		decor.lux_wood,
	},
	description = S("Pool Table"),
	inventory_image = "decor_pool_table_inv.png",
	groups = {snappy=3},
	selection_box = pooltable_cbox,
	collision_box = pooltable_cbox,
	expand = { forward="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil,
})

minetest.register_alias("decor:pool_table_2", "air")

local piano_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.125, 1.5, 0.5, 0.5 }
}

decor.register("piano", {
	mesh = "decor_piano.obj",
	tiles = {
		{ name = "decor_generic_wood_luxury.png", color = decor.color_black },
		"decor_piano_keys.png",
		"decor_generic_metal_brass.png",
	},
	inventory_image = "decor_piano_inv.png",
	description = S("Piano"),
	groups = { snappy = 3 },
	selection_box = piano_cbox,
	collision_box = piano_cbox,
	expand = { right="placeholder" },
	sounds = default.node_sound_wood_defaults(),
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil,
})

minetest.register_alias("decor:piano_left", "decor:piano")
minetest.register_alias("decor:piano_right", "air")

local tr_cbox = {
	type = "fixed",
	fixed = { -0.3125, -0.5, -0.1875, 0.3125, 0.125, 0.1875 }
}

decor.register("trophy", {
	description = S("Trophy"),
	mesh = "decor_trophy.obj",
	tiles = {
		"default_wood.png",
		"decor_generic_metal_gold.png"
	},
	inventory_image = "decor_trophy_inv.png",
	groups = { snappy=3 },
	walkable = false,
	selection_box = tr_cbox,
})

local sb_cbox = {
	type = "fixed",
	fixed = { -0.4, -0.5, -0.5, 0.4, 0.375, 0.5 }
}

decor.register("sportbench", {
	description = S("Sport bench"),
	mesh = "decor_sport_bench.obj",
	tiles = {
		"decor_generic_metal_wrought_iron.png",
		"decor_generic_metal_bright.png",
		{ name = "decor_generic_metal.png", color = decor.color_black },
		"wool_black.png"
	},
	inventory_image = "decor_sport_bench_inv.png",
	groups = { snappy=3 },
	selection_box = sb_cbox,
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
})

local skate_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.15, 0.5, -0.3, 0.15 }
}

decor.register("skateboard", {
	drawtype = "mesh",
	mesh = "decor_skateboard.obj",
	tiles = { "decor_skateboard.png" },
	inventory_image = "decor_skateboard_inv.png",
	description = S("Skateboard"),
	groups = {snappy=3},
	selection_box = skate_cbox,
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

decor_misc.banister_materials = {
	{
		"wood",
		S("wood"),
		"default_wood.png",
		"default_wood.png",
		"group:wood",
		"group:stick",
		"",
		""
	},
	{
		"white_dark",
		S("dark topped"),
		decor.white_wood,
		decor.dark_wood,
		"group:wood",
		"group:stick",
		"dye:brown",
		"dye:white"
	},
	{
		"brass",
		S("brass"),
		decor.white_wood,
		"decor_generic_metal_brass.png",
		"technic:brass_ingot",
		"group:stick",
		"",
		"dye:white"
	},
	{
		"wrought_iron",
		S("wrought iron"),
		"decor_generic_metal_wrought_iron.png",
		"decor_generic_metal_wrought_iron.png",
		"decor:pole_wrought_iron",
		"decor:pole_wrought_iron",
		"",
		""
	}
}

for _, side in ipairs({"diagonal_left", "diagonal_right", "horizontal"}) do

	local sidedesc = side:match("^diagonal") and S("diagonal") or S("horizontal")

	for _, mat in ipairs(decor_misc.banister_materials) do

		local name, matdesc, tile1, tile2 = unpack(mat)
		local nodename = "banister_"..name.."_"..side

		local cbox = {
			type = "fixed",
			fixed = { -9/16, -3/16, 5/16, 9/16, 24/16, 8/16 }
		}

		if side == "horizontal" then
			cbox = {
				type = "fixed",
				fixed = { -8/16, -8/16, 5/16, 8/16, 8/16, 8/16 }
			}
		end

		local def = {
			description = S("Banister for Stairs (@1, @2)", matdesc, sidedesc),
			mesh = "decor_banister_"..side..".obj",
			tiles = {
				tile1,
				tile2,
			},
			inventory_image = "decor_banister_"..name.."_inv.png",
			selection_box = cbox,
			collision_box = cbox,
			groups = { snappy = 3},
			on_place = decor.place_banister,
			drop = "decor:banister_"..name.."_horizontal",
		}

		if side ~= "horizontal" then
			def.groups.not_in_creative_inventory = 1
		end

		if name == "wood" then
			def.palette = "unifieddyes_palette_greys.png"
			def.airbrush_replacement_node = "decor:banister_wood_"..side.."_grey"
			def.groups.ud_param2_colorable = 1
			def.paramtype2 = "colorfacedir"
			def.on_dig = unifieddyes.on_dig
		end
		decor.register(nodename, def)

		if name == "wood" then
			local nn = "decor:"..nodename
			local def2 = table.copy(minetest.registered_items[nn])
			def2.tiles = {
				decor.white_wood,
				decor.white_wood
			}
			def2.inventory_image = "decor_banister_wood_colored_inv.png"
			def2.groups.not_in_creative_inventory = 1

			unifieddyes.generate_split_palette_nodes(nn, def2, "decor:banister_"..name.."_horizontal")
		end
	end
end

decor.register("spiral_staircase", {
	description = "Spiral Staircase",
	mesh = "decor_spiral_staircase.obj",
	wield_scale = { x=0.4, y=0.4, z=0.4 },
	tiles = {
		"decor_generic_metal_wrought_iron.png",
	},
	selection_box = {
		type = "fixed",
		fixed = { -1.5, -0.5, -1.5, 0.5, 2.5, 0.5 }
	},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5625, -0.5, -0.5625, -0.4375, 2.5, -0.4375}, -- NodeBox9
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0}, -- NodeBox14
			{-0.5, -0.125, -0.5, -0.25, -0.0625, 0.5}, -- NodeBox15
			{-0.25, -0.125, -0.0625, 0, -0.0625, 0.5}, -- NodeBox16
			{-1, 0.25, -0.5, -0.5, 0.3125, 0.5}, -- NodeBox17
			{-1.5, 0.625, -0.5, -0.5, 0.6875, -0.25}, -- NodeBox18
			{-1.5, 0.625, -0.25, -0.9375, 0.6875, 0}, -- NodeBox19
			{-1.5, 1, -1, -0.5, 1.0625, -0.5}, -- NodeBox20
			{-0.75, 1.375, -1.5, -0.5, 1.4375, -0.5}, -- NodeBox21
			{-1, 1.375, -1.5, -0.75, 1.4375, -1}, -- NodeBox22
			{-0.5, 1.75, -1.5, 0.0625, 1.8125, -0.5}, -- NodeBox23
			{-0.5, 2.125, -0.8125, 0.5, 2.1875, -0.5}, -- NodeBox24
			{-0.0625, 2.125, -1.0625, 0.5, 2.1875, -0.75}, -- NodeBox25
			{-1.5, -0.125, 0.4375, 0.5, 1.625, 0.5}, -- NodeBox26
			{-1.5, 1.5625, -1.5, -1.4375, 2.875, 0.5}, -- NodeBox27
			{-1.5, 1.75, -1.5, 0.5, 3.3125, -1.4375}, -- NodeBox28
			{0.4375, -0.5, -0.5, 0.5, 0.875, 0.5}, -- NodeBox29
			{0.4375, 2.125, -1.5, 0.5, 3.3125, 0.5}, -- NodeBox30
		}
	},
	groups = {cracky = 1},
	sounds = default.node_sound_wood_defaults(),
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple or nil,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		local fdir = minetest.dir_to_facedir(placer:get_look_dir())
		local leftx =  decor.fdir_to_left[fdir+1][1]
		local leftz =  decor.fdir_to_left[fdir+1][2]
		local revx  = -decor.fdir_to_fwd[fdir+1][1]
		local revz  = -decor.fdir_to_fwd[fdir+1][2]

		local corner1 = { x = pos.x + leftx + revx, y = pos.y, z = pos.z + leftz + revz}
		local corner2 = { x = pos.x, y = pos.y + 2, z = pos.z }

		local minp = { x = math.min(corner1.x, corner2.x),
		               y = math.min(corner1.y, corner2.y),
		               z = math.min(corner1.z, corner2.z) }

		local maxp = { x = math.max(corner1.x, corner2.x),
		               y = math.max(corner1.y, corner2.y),
		               z = math.max(corner1.z, corner2.z) }

		if #minetest.find_nodes_in_area(minp, maxp, "air") < 11 then
			minetest.set_node(pos, {name = "air"})
			minetest.chat_send_player(placer:get_player_name(), S("not enough space"))
			return true
		end

		local belownode = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })

		if belownode and belownode.name == "decor:spiral_staircase" then
			local newpos = { x = pos.x, y = pos.y + 2, z = pos.z }
			minetest.set_node(pos, { name = "air" })
			minetest.set_node(newpos, { name = "decor:spiral_staircase", param2 = belownode.param2 })
		end
	end
})

minetest.register_on_placenode(function(pos, newnode, placer, oldnode, itemstack, pointed_thing)
	local belownode = minetest.get_node({ x = pos.x, y = pos.y - 1, z = pos.z })

	if newnode.name ~= "decor:spiral_staircase"
	  and belownode
	  and belownode.name == "decor:spiral_staircase" then
		minetest.set_node(pos, { name = "air" })

		local newpos = { x = pos.x, y = pos.y + 2, z = pos.z }
		local checknode = minetest.get_node(newpos)

		if checknode and checknode.name == "air" then
			local fdir = minetest.dir_to_facedir(placer:get_look_dir())
			minetest.set_node(newpos, { name = newnode.name, param2 = fdir })
		else
			return true
		end
	end
end)

minetest.register_node(":decor:tatami_mat", {
	tiles = {
		"decor_tatami.png",
		"decor_tatami.png",
		"decor_tatami.png",
		"decor_tatami.png",
		"decor_tatami.png",
		"decor_tatami.png"
	},
	description = S("Japanese tatami"),
	drawtype = "nodebox",
	paramtype = "light",
	groups = {snappy=3},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		}
	}
})

decor.register("dartboard", {
	description = S("Dartboard"),
	mesh = "decor_dartboard.obj",
	tiles = { "decor_dartboard.png" },
	inventory_image = "decor_dartboard_inv.png",
	wield_image = "decor_dartboard_inv.png",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy=2,dig_immediate=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})

-- crafting

-- Crafting for decor mod (includes folding) by Vanessa Ezekowitz
--
-- Mostly my own code; overall template borrowed from game default

minetest.register_craft( {
	output = "decor:flower_pot_terracotta",
	recipe = {
		{ "decor:roof_tile_terracotta", "default:dirt", "decor:roof_tile_terracotta" },
		{ "decor:roof_tile_terracotta", "decor:roof_tile_terracotta", "decor:roof_tile_terracotta" },
	},
})

minetest.register_craft( {
	output = "decor:flower_pot_green",
	recipe = {
		{ "", "dye:dark_green", "" },
		{ "default:plastic_sheet", "default:dirt", "default:plastic_sheet" },
		{ "default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet" },
	},
})

minetest.register_craft( {
	output = "decor:flower_pot_black",
	recipe = {
		{ "dye:black", "dye:black", "dye:black" },
		{ "default:plastic_sheet", "default:dirt", "default:plastic_sheet" },
		{ "default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet" },
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:ceiling_paint 20",
	recipe = {
		"dye:white",
		"dye:white",
		"default:sand",
		"bucket:bucket_water",
	},
	replacements = { { "bucket:bucket_water","bucket:bucket_empty" } }
})

minetest.register_craft( {
	output = "decor:ceiling_tile 10",
	recipe = {
		{ "", "dye:white", "" },
		{ "default:steel_ingot", "default:stone", "default:steel_ingot" },
	},
})

minetest.register_craft( {
	output = "decor:drawer_small",
	recipe = {
		{ "group:wood", "default:steel_ingot", "group:wood" },
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:drawer_small",
	burntime = 30,
})

-- vertical poles/lampposts

minetest.register_craft( {
	output = "decor:pole_brass 4",
	recipe = {
		{ "", "technic:brass_ingot", "" },
		{ "", "technic:brass_ingot", "" },
		{ "", "technic:brass_ingot", "" }
	},
})

minetest.register_craft( {
	output = "decor:pole_wrought_iron 4",
	recipe = {
		{ "default:iron_lump", },
		{ "default:iron_lump", },
		{ "default:iron_lump", },
	},
})

-- ===========================================================
-- Recipes that require materials from wool (cotton alternate)

minetest.register_craft( {
	type = "shapeless",
	output = "decor:rug_small 8",
	recipe = {
			"wool:red",
			"wool:yellow",
			"wool:blue",
			"wool:black"
	},
})

minetest.register_craft( {
	output = "decor:rug_persian 8",
	recipe = {
		{ "", "wool:yellow", "" },
		{ "wool:red", "wool:blue", "wool:red" },
		{ "", "wool:yellow", "" }
	},
})

-- cotton versions:

minetest.register_craft( {
	type = "shapeless",
	output = "decor:rug_small 8",
	recipe = {
		"cotton:red",
		"cotton:yellow",
		"cotton:blue",
		"cotton:black"
	},
})

minetest.register_craft( {
	output = "decor:rug_persian 8",
	recipe = {
		{ "", "cotton:yellow", "" },
		{ "cotton:red", "cotton:blue", "cotton:red" },
		{ "", "cotton:yellow", "" }
	},
})

-- fuel recipes for same

minetest.register_craft({
	type = "fuel",
	recipe = "decor:rug_small",
	burntime = 30,
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:rug_large 2",
	recipe = {
		"decor:rug_small",
		"decor:rug_small",
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:rug_large",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:rug_persian",
	burntime = 30,
})

-- more misc stuff here

minetest.register_craft({
	output = "decor:fishtank",
	recipe = {
		{ "default:plastic_sheet", "decor:glowlight_small_cube", "default:plastic_sheet" },
		{ "default:glass", "bucket:bucket_water", "default:glass" },
		{ "default:glass", "building_blocks:gravel_spread", "default:glass" },
	},
	replacements = { {"bucket:bucket_water", "bucket:bucket_empty"} }
})

minetest.register_craft({
	output = "decor:cardboard_box 2",
	recipe = {
		{ "default:paper", "", "default:paper" },
		{ "default:paper", "default:paper", "default:paper" },
	},
})

minetest.register_craft({
	output = "decor:cardboard_box_big 2",
	recipe = {
		{ "default:paper", "", "default:paper" },
		{ "default:paper", "", "default:paper" },
		{ "default:paper", "default:paper", "default:paper" },
	},
})

minetest.register_craft( {
 output = "decor:dvd_cd_cabinet 2",
	recipe = {
		{"default:plastic_sheet", "group:wood", "default:plastic_sheet"},
		{"default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet"},
		{"default:plastic_sheet", "group:wood", "default:plastic_sheet"}
 	},
})

minetest.register_craft( {
	output = "decor:openframe_bookshelf",
	recipe = {
		{"group:wood", "", "group:wood"},
		{"default:book", "default:book", "default:book"},
		{"group:wood", "", "group:wood"},
	},
})

-- japanese walls and mat

minetest.register_craft( {
	output = "decor:japanese_wall_top",
	recipe = {
		{"group:stick", "default:paper"},
		{"default:paper", "group:stick"},
		{"group:stick", "default:paper"}
	},
})

minetest.register_craft( {
	output = "decor:japanese_wall_top",
	recipe = {
		{"default:paper", "group:stick"},
		{"group:stick", "default:paper"},
		{"default:paper", "group:stick"}
	},
})

minetest.register_craft( {
	output = "decor:japanese_wall_middle",
	recipe = {
		{"decor:japanese_wall_top"}
	},
})

minetest.register_craft( {
	output = "decor:japanese_wall_bottom",
	recipe = {
		{"decor:japanese_wall_middle"}
	},
})

minetest.register_craft( {
	output = "decor:japanese_wall_top",
	recipe = {
		{"decor:japanese_wall_bottom"}
	},
})

minetest.register_craft( {
	output = "decor:tatami_mat",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"}
	},
})

minetest.register_craft( {
	output = "decor:pool_table",
	recipe = {
		{ "wool:dark_green", "wool:dark_green", "wool:dark_green" },
		{ "building_blocks:hardwood", "building_blocks:hardwood", "building_blocks:hardwood" },
		{ "building_blocks:slab_hardwood", "", "building_blocks:slab_hardwood" }
	},
})

minetest.register_craft({
	output = "decor:dartboard",
	recipe = {
		{"dye:black", "default:plastic_sheet", "dye:white"},
		{"default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet"},
		{"dye:dark_green", "default:plastic_sheet", "dye:red"}
	},
})

minetest.register_craft({
	output = "decor:piano",
	recipe = {
		{ "", "decor:steel_wire", "building_blocks:hardwood" },
		{ "default:plastic_strip", "decor:steel_wire", "building_blocks:hardwood" },
		{ "technic:brass_ingot", "default:steelblock", "building_blocks:hardwood" }
	},
})

minetest.register_craft({
	output = "decor:wall_shelf 2",
	recipe = {
		{ "decor:wood_table_small_square", "decor:curtainrod_wood", "decor:curtainrod_wood" },
	},
})

minetest.register_craft({
	output = "decor:trophy 3",
	recipe = {
		{ "default:gold_ingot","","default:gold_ingot" },
		{ "","default:gold_ingot","" },
		{ "group:wood","default:gold_ingot","group:wood" }
	},
})

minetest.register_craft({
	output = "decor:sportbench",
	recipe = {
		{ "stairs:slab_steelblock","default:steel_bar","stairs:slab_steelblock" },
		{ "default:steel_ingot","wool:black","default:steel_ingot" },
		{ "default:steel_ingot","wool:black","default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "decor:skateboard",
	recipe = {
		{ "dye:yellow","dye:green","dye:blue" },
		{ "decor:wood_table_small_square","decor:wood_table_small_square","decor:wood_table_small_square" },
		{ "default:steel_ingot","","default:steel_ingot" }
	},
})

minetest.register_craft({
	output = "decor:spiral_staircase",
	recipe = {
		{ "default:steelblock", "decor:pole_wrought_iron", "" },
		{ "", "decor:pole_wrought_iron", "default:steelblock" },
		{ "default:steelblock", "decor:pole_wrought_iron", "" }
	},
})

minetest.register_craftitem(":decor:flower_pot_small", {
	description = S("Small Flower Pot"),
	inventory_image = "decor_flowerpot_small_inv.png"
})

minetest.register_craft( {
	output = "decor:flower_pot_small",
	recipe = {
		{ "default:clay_brick", "", "default:clay_brick" },
		{ "", "default:clay_brick", "" }
	}
})

minetest.register_craft( {
	output = "decor:flower_pot_small 3",
	recipe = { { "decor:flower_pot_terracotta" } }
})

for i in ipairs(decor_misc.banister_materials) do

	local name    = decor_misc.banister_materials[i][1]
	local topmat  = decor_misc.banister_materials[i][5]
	local vertmat = decor_misc.banister_materials[i][6]
	local dye1    = decor_misc.banister_materials[i][7]
	local dye2    = decor_misc.banister_materials[i][8]

	minetest.register_craft({
		output = "decor:banister_"..name.."_horizontal 2",
		recipe = {
			{ topmat,  "",      dye1   },
			{ vertmat, topmat,  ""     },
			{ dye2,    vertmat, topmat }
		},
	})
end

unifieddyes.register_color_craft({
	output = "",
	palette = "split",
	neutral_node = "decor:banister_wood_horizontal",
	type = "shapeless",
	output_prefix = "decor:banister_wood_horizontal_",
	output_suffix = "",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE",
	}
})

-- Japanese-style wood/paper wall pieces and door

local jp_cbox = {
	type = "fixed",
	fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.0625},
}

minetest.register_node(":decor:japanese_wall_top", {
	description = S("Japanese wall (top)"),
	drawtype = "mesh",
	mesh = "decor_wall_japanese_top.obj",
	tiles = {
		decor.lux_wood,
		"decor_japanese_paper.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	selection_box = jp_cbox,
	collision_box = jp_cbox,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node(":decor:japanese_wall_middle", {
	description = S("Japanese wall"),
	drawtype = "mesh",
	mesh = "decor_wall_japanese_middle.obj",
	tiles = {
		decor.lux_wood,
		"decor_japanese_paper.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	selection_box = jp_cbox,
	collision_box = jp_cbox,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node(":decor:japanese_wall_bottom", {
	description = S("Japanese wall (bottom)"),
	drawtype = "mesh",
	mesh = "decor_wall_japanese_bottom.obj",
	tiles = {
		decor.lux_wood,
		"decor_japanese_paper.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=3},
	selection_box = jp_cbox,
	collision_box = jp_cbox,
	sounds = default.node_sound_wood_defaults(),
})

decor.register("enderchest", {
	description = S("Ender Chest"),
	tiles = {
		"decor_enderchest_top.png", "decor_enderchest_top.png",
		"decor_enderchest_side.png", "decor_enderchest_side.png",
		"decor_enderchest_side.png", "decor_enderchest_front.png"
	},
	groups = {cracky = 1, choppy = 1},
	sounds = default.node_sound_stone_defaults(),
	on_rotate = screwdriver.rotate_simple,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", [[ size[8,9]
				list[current_player;enderchest;0,0;8,4;]
				list[current_player;main;0,5;8,4;]
				listring[current_player;enderchest]
				listring[current_player;main] ]]
				 .. xbg .. default.get_hotbar_bg(0,5))

		meta:set_string("infotext", S("Ender Chest"))
	end
})

minetest.register_on_joinplayer(function(player)
	local inv = player:get_inventory()
	inv:set_size("enderchest", 8*4)
end)

minetest.register_craft({
	output = "decor:enderchest",
	recipe = {
		{"", "default:obsidian", ""},
		{"default:obsidian", "default:chest", "default:obsidian"},
		{"", "default:obsidian", ""}
	}
})
