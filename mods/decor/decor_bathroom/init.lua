if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local S = minetest.get_translator("decor_bathroom")

local sc_disallow = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil

minetest.register_node(":decor:bathroom_tiles_dark", {
	description = S("Bathroom/kitchen tiles (dark)"),
	tiles = {
		"decor_bathroom_tiles_bg.png"
	},
	overlay_tiles = {
		{ name = "decor_bathroom_tiles_fg.png", color = 0xff606060 },
	},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	groups = {cracky=3, ud_param2_colorable = 1},
	sounds = default.node_sound_stone_defaults(),
	on_construct = unifieddyes.on_construct,
	on_dig = unifieddyes.on_dig,
})

minetest.register_node(":decor:bathroom_tiles_medium", {
	description = S("Bathroom/kitchen tiles (medium)"),
	tiles = {
		"decor_bathroom_tiles_bg.png"
	},
	overlay_tiles = {
		{ name = "decor_bathroom_tiles_fg.png", color = 0xffc0c0c0 },
	},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	groups = {cracky=3, ud_param2_colorable = 1},
	sounds = default.node_sound_stone_defaults(),
	on_construct = unifieddyes.on_construct,
	on_dig = unifieddyes.on_dig,
})

minetest.register_node(":decor:bathroom_tiles_light", {
	description = S("Bathroom/kitchen tiles (light)"),
	tiles = {
		"decor_bathroom_tiles_bg.png"
	},
	overlay_tiles = {
			{ name = "decor_bathroom_tiles_fg.png", color = 0xffffffff },
	},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	groups = {cracky=3, ud_param2_colorable = 1},
	sounds = default.node_sound_stone_defaults(),
	on_construct = unifieddyes.on_construct,
	on_dig = unifieddyes.on_dig,
})

local tr_cbox = {
	type = "fixed",
	fixed = { -0.375, -0.3125, 0.25, 0.375, 0.375, 0.5 }
}

decor.register("towel_rod", {
	description = S("Towel rod with towel"),
	mesh = "decor_towel_rod.obj",
	tiles = {
		"decor_generic_terrycloth.png",
		"default_wood.png",
	},
	inventory_image = "decor_towel_rod_inv.png",
	selection_box = tr_cbox,
	walkable = false,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3},
	sounds = default.node_sound_defaults(),
})

decor.register("medicine_cabinet", {
	description = S("Medicine cabinet"),
	mesh = "decor_medicine_cabinet.obj",
	tiles = {
		'default_wood.png',
		'decor_medicine_cabinet_mirror.png'
	},
	inventory_image = "decor_medicine_cabinet_inv.png",
	selection_box = {
		type = "fixed",
		fixed = {-0.3125, -0.1875, 0.3125, 0.3125, 0.5, 0.5}
	},
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher, pointed_thing)
		node.name = "decor:medicine_cabinet_open"
		minetest.swap_node(pos, node)
	end,
	infotext=S("Medicine cabinet"),
	inventory = {
		size=6,
	},
})

decor.register("medicine_cabinet_open", {
	mesh = "decor_medicine_cabinet_open.obj",
	tiles = {
		'default_wood.png',
		'decor_medicine_cabinet_mirror.png',
		'decor_medicine_cabinet_inside.png'
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3125, -0.1875, -0.25, 0.3125, 0.5, 0.5}
	},
	walkable = false,
	groups = { snappy = 3, not_in_creative_inventory=1 },
	drop = "decor:medicine_cabinet",
	on_punch = function(pos, node, puncher, pointed_thing)
		node.name = "decor:medicine_cabinet"
		minetest.swap_node(pos, node)
	end,
})

-- "Sanitation" related

local toilet_sbox = {
	type = "fixed",
	fixed = { -6/16, -8/16, -8/16, 6/16, 9/16, 8/16 },
}

local toilet_cbox = {
	type = "fixed",
	fixed = {
		{-6/16, -8/16, -8/16, 6/16, 1/16, 8/16 },
		{-6/16, -8/16, 4/16, 6/16, 9/16, 8/16 }
	}
}

decor.register("toilet", {
	description = S("Toilet"),
	mesh = "decor_toilet_closed.obj",
	tiles = {
		"technic_marble.png",
		"technic_marble.png",
		"technic_marble.png",
		{ name = "decor_generic_metal.png", color = decor.color_med_grey }
	},
	selection_box = toilet_sbox,
	node_box = toilet_cbox,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		node.name = "decor:toilet_open"
		minetest.set_node(pos, node)
	end
})

decor.register("toilet_open", {
	mesh = "decor_toilet_open.obj",
	tiles = {
		"technic_marble.png",
		"technic_marble.png",
		"technic_marble.png",
		"default_water.png",
		{ name = "decor_generic_metal.png", color = decor.color_med_grey }
	},
	selection_box = toilet_sbox,
	collision_box = toilet_cbox,
	drop = "decor:toilet",
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		node.name = "decor:toilet"
		minetest.set_node(pos, node)
		minetest.sound_play("decor_toilet_flush", {
			pos=pos,
			max_hear_distance = 5,
			gain = 1,
		})
	end
})

-- toilet paper :-)

local tp_cbox = {
	type = "fixed",
	fixed = { -0.25, 0.125, 0.0625, 0.1875, 0.4375, 0.5 }
}

decor.register("toilet_paper", {
	description = S("Toilet paper"),
	mesh = "decor_toilet_paper.obj",
	tiles = {
		"decor_generic_quilted_paper.png",
		"default_wood.png"
	},
	inventory_image = "decor_toilet_paper_inv.png",
	selection_box = tp_cbox,
	walkable = false,
	groups = {snappy=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_defaults(),
})

--Sink

local sink_sbox = {
	type = "fixed",
	fixed = { -5/16, -8/16, 1/16, 5/16, 8/16, 8/16 }
}

local sink_cbox = {
	type = "fixed",
	fixed = {
		{ -5/16,  5/16, 1/16, -4/16, 8/16, 8/16 },
		{  5/16,  5/16, 1/16,  4/16, 8/16, 8/16 },
		{ -5/16,  5/16, 1/16,  5/16, 8/16, 2/16 },
		{ -5/16,  5/16, 6/16,  5/16, 8/16, 8/16 },
		{ -4/16, -8/16, 1/16,  4/16, 5/16, 6/16 }
	}
}

decor.register("sink", {
	description = S("Bathroom Sink"),
	mesh = "decor_bathroom_sink.obj",
	tiles = {
		"technic_marble.png",
		"technic_marble.png",
		"default_water.png"
	},
	inventory_image="decor_bathroom_sink_inv.png",
	selection_box = sink_sbox,
	collision_box = sink_cbox,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_destruct = function(pos)
		decor.stop_particle_spawner({x=pos.x, y=pos.y+1, z=pos.z})
	end
})

--Taps

local function taps_on_rightclick(pos, node, clicker, itemstack, pointed_thing)
	local below = minetest.get_node_or_nil({x=pos.x, y=pos.y-1, z=pos.z})
	if below and
	  below.name == "decor:shower_tray" or
	  below.name == "decor:sink" or
	  below.name == "decor:kitchen_cabinet_with_sink" or
	  below.name == "decor:kitchen_cabinet_with_sink_locked" then
		local particledef = {
			outlet      = { x = 0, y = -0.44, z = 0.28 },
			velocity_x  = { min = -0.1, max = 0.1 },
			velocity_y  = -0.3,
			velocity_z  = { min = -0.1, max = 0 },
			spread      = 0,
			die_on_collision = true,
		}
		decor.start_particle_spawner(pos, node, particledef, "decor_faucet")
	end
	return itemstack
end

decor.register("taps", {
	description = S("Bathroom taps/faucet"),
	mesh = "decor_bathroom_faucet.obj",
	tiles = {
		{ name = "decor_generic_metal.png", color = decor.color_med_grey },
		"decor_generic_metal_bright.png",
		"decor_generic_metal.png",
		"decor_generic_metal_bright.png"
	},
	inventory_image = "3dforniture_taps_inv.png",
	wield_image = "3dforniture_taps_inv.png",
	selection_box = {
		type = "fixed",
		fixed = { -4/16, -7/16, 4/16, 4/16, -4/16, 8/16 },
	},
	walkable = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = taps_on_rightclick,
	on_destruct = decor.stop_particle_spawner,
	on_rotate = sc_disallow or nil
})

decor.register("taps_brass", {
	description = S("Bathroom taps/faucet (brass)"),
	mesh = "decor_bathroom_faucet.obj",
	tiles = {
		"decor_generic_metal_brass.png",
		"decor_generic_metal_brass.png",
		"decor_generic_metal.png",
		"decor_generic_metal_brass.png"
	},
	inventory_image = "3dforniture_taps_brass_inv.png",
	wield_image = "3dforniture_taps_brass_inv.png",
	selection_box = {
		type = "fixed",
		fixed = { -4/16, -7/16, 4/16, 4/16, -4/16, 8/16 },
	},
	walkable = false,
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
	on_rightclick = taps_on_rightclick,
	on_destruct = decor.stop_particle_spawner,
	on_rotate = sc_disallow or nil,
})

--Shower Tray

decor.register("shower_tray", {
	description = S("Shower Tray"),
	tiles = {
		"forniture_marble_base_ducha_top.png",
		"technic_marble.png"
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, -0.5, 0.5, -0.45, 0.5 },
			{ -0.5, -0.45, -0.5, 0.5, -0.4, -0.45 },
			{ -0.5, -0.45, 0.45, 0.5, -0.4, 0.5 },
			{ -0.5, -0.45, -0.45, -0.45, -0.4, 0.45 },
			{  0.45, -0.45, -0.45, 0.5, -0.4, 0.45 }
		},
	},
	selection_box = decor.nodebox.slab_y(0.1),
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
	on_destruct = function(pos)
		decor.stop_particle_spawner({x=pos.x, y=pos.y+2, z=pos.z}) -- the showerhead
		decor.stop_particle_spawner({x=pos.x, y=pos.y+1, z=pos.z}) -- the taps, if any
	end
})

--Shower Head


local sh_cbox = {
	type = "fixed",
	fixed = { -0.2, -0.4, -0.05, 0.2, 0.1, 0.5 }
}

decor.register("shower_head", {
	drawtype = "mesh",
	mesh = "decor_shower_head.obj",
	tiles = {
		"decor_generic_metal.png",
		"decor_shower_head.png"
	},
	inventory_image = "decor_shower_head_inv.png",
	description = S("Shower Head"),
	groups = {snappy=3},
	selection_box = sh_cbox,
	walkable = false,
	on_rotate = sc_disallow or nil,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local below = minetest.get_node_or_nil({x=pos.x, y=pos.y-2.0, z=pos.z})
		if below and (
			below.name == "decor:shower_tray" or
			below.name == "decor:bathtub_clawfoot_brass_taps" or
			below.name == "decor:bathtub_clawfoot_chrome_taps" ) then
			local particledef = {
				outlet      = { x = 0, y = -0.42, z = 0.1 },
				velocity_x  = { min = -0.15, max = 0.15 },
				velocity_y  = -2,
				velocity_z  = { min = -0.3,  max = 0.1 },
				spread      = 0.12
			}
			decor.start_particle_spawner(pos, node, particledef, "decor_shower")
		end
		return itemstack
	end,
	on_destruct = function(pos)
		decor.stop_particle_spawner(pos)
	end
})

local tub_sbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 1.5, 0.3125, 0.5 },
}

local tub_cbox = {
	type = "fixed",
	fixed = {
		{-0.4375, -0.0625, -0.5, 1.4375, 0.5, -0.4375}, -- NodeBox1
		{-0.4375, -0.0625, 0.4375, 1.4375, 0.5, 0.5}, -- NodeBox2
		{-0.5, 0.1875, -0.4375, -0.4375, 0.5, 0.4375}, -- NodeBox3
		{1.4375, -0.0625, -0.4375, 1.5, 0.5, 0.4375}, -- NodeBox4
		{-0.3125, -0.3125, -0.4375, -0.125, -0.0625, 0.4375}, -- NodeBox5
		{1.375, -0.3125, -0.4375, 1.4375, -0.0625, 0.4375}, -- NodeBox6
		{-0.125, -0.3125, 0.375, 1.375, -0.0625, 0.4375}, -- NodeBox7
		{-0.125, -0.3125, -0.4375, 1.375, -0.0625, -0.375}, -- NodeBox8
		{-0.125, -0.5, -0.375, 1.375, -0.3125, 0.375}, -- NodeBox9
		{-0.4375, -0.0625, -0.4375, -0.3125, 0.1875, 0.4375}, -- NodeBox10
	}
}

decor.register("bathtub_clawfoot_brass_taps", {
	drawtype = "mesh",
	mesh = "decor_bathtub_clawfoot.obj",
	tiles = {
		{ name = "decor_generic_metal.png", color = decor.color_med_grey },
		"decor_generic_metal_bright.png",
		"decor_generic_metal_bright.png",
		"decor_generic_metal_brass.png",
		"technic_marble.png",
		"decor_bathtub_clawfoot_bottom_inside.png",
	},
	description = S("Bathtub, clawfoot, with brass taps"),
	groups = {cracky=3},
	selection_box = tub_sbox,
	node_box = tub_cbox,
	sounds = default.node_sound_stone_defaults(),
})

decor.register("bathtub_clawfoot_chrome_taps", {
	drawtype = "mesh",
	mesh = "decor_bathtub_clawfoot.obj",
	tiles = {
		{ name = "decor_generic_metal.png", color = decor.color_med_grey },
		"decor_generic_metal_bright.png",
		"decor_generic_metal_bright.png",
		"decor_generic_metal_bright.png",
		"technic_marble.png",
		"decor_bathtub_clawfoot_bottom_inside.png",
	},
	description = S("Bathtub, clawfoot, with chrome taps"),
	groups = {cracky=3},
	selection_box = tub_sbox,
	node_box = tub_cbox,
	sounds = default.node_sound_stone_defaults(),
})

local bs_cbox = {
	type = "fixed",
	fixed = { -8/16, -8/16, 1/16, 8/16, 8/16, 8/16 }
}

decor.register("bathroom_set", {
	drawtype = "mesh",
	mesh = "decor_bathroom_set.obj",
	tiles = {
		"decor_bathroom_set_mirror.png",
		"decor_bathroom_set_tray.png",
		"decor_bathroom_set_toothbrush.png",
		"decor_bathroom_set_cup.png",
		"decor_bathroom_set_toothpaste.png",
	},
	inventory_image = "decor_bathroom_set_inv.png",
	description = S("Bathroom sundries set"),
	groups = {snappy=3},
	selection_box = bs_cbox,
	walkable = false,
	sounds = default.node_sound_glass_defaults(),
})

-- aliases

minetest.register_alias("3dforniture:toilet", "decor:toilet")
minetest.register_alias("3dforniture:toilet_open", "decor:toilet_open")
minetest.register_alias("3dforniture:sink", "decor:sink")
minetest.register_alias("3dforniture:taps", "decor:taps")
minetest.register_alias("3dforniture:shower_tray", "decor:shower_tray")
minetest.register_alias("3dforniture:shower_head", "decor:shower_head")
minetest.register_alias("3dforniture:table_lamp", "decor:table_lamp_off")

minetest.register_alias("toilet", "decor:toilet")
minetest.register_alias("sink", "decor:sink")
minetest.register_alias("taps", "decor:taps")
minetest.register_alias("shower_tray", "decor:shower_tray")
minetest.register_alias("shower_head", "decor:shower_head")
minetest.register_alias("table_lamp", "decor:table_lamp_off")

-- convert old static nodes

local old_static_bathroom_tiles = {
	"decor:tiles_1",
	"decor:tiles_2",
	"decor:tiles_3",
	"decor:tiles_4",
	"decor:tiles_red",
	"decor:tiles_tan",
	"decor:tiles_yellow",
	"decor:tiles_green",
	"decor:tiles_blue"
}

local old_to_color = {
	"light_grey",
	"grey",
	"black",
	"black"
}

minetest.register_lbm({
	name = ":decor:convert_bathroom_tiles",
	label = "Convert bathroom tiles to use param2 color",
	run_at_every_load = false,
	nodenames = old_static_bathroom_tiles,
	action = function(pos, node)
		local name = node.name
		local newname = "decor:bathroom_tiles_light"
		local a = string.find(name, "_")
		local color = string.sub(name, a + 1)

		if color == "tan" then
			color = "yellow_s50"
		elseif color == "1" or color == "2" or color == "3" or color == "4" then
			if color == "4" then
				newname = "decor:bathroom_tiles_medium"
			end
			color = old_to_color[tonumber(color)]
		elseif color ~= "yellow" then
			color = color.."_s50"
		end

		local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color, "extended")

		minetest.set_node(pos, { name = newname, param2 = paletteidx })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
		meta:set_string("palette", "ext")
	end
})

-- crafting


minetest.register_craft({
    output = "decor:towel_rod",
    recipe = {
		{ "group:wood", "group:stick", "group:wood" },
		{ "", "building_blocks:terrycloth_towel", "" },
    },
})

minetest.register_craft({
    output = "decor:toilet_paper",
    recipe = {
		{ "", "default:paper", "default:paper" },
		{ "group:wood", "group:stick", "default:paper" },
		{ "", "default:paper", "default:paper" },
    },
})

minetest.register_craft({
    output = "decor:medicine_cabinet",
    recipe = {
		{ "group:stick", "default:glass", "group:stick" },
		{ "group:stick", "default:glass", "group:stick" },
		{ "group:stick", "default:glass", "group:stick" }
    },
})


-- bathroom/kitchen tiles

minetest.register_craft( {
		output = "decor:bathroom_tiles_light 4",
		recipe = {
			{"group:marble", "group:marble", "" },
			{"group:marble", "group:marble", "dye:white" }
		},
})

unifieddyes.register_color_craft({
	output = "decor:bathroom_tiles_light",
	palette = "extended",
	type = "shapeless",
	neutral_node = "decor:bathroom_tiles_light",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft( {
		output = "decor:bathroom_tiles_medium 4",
		recipe = {
			{ "group:marble", "group:marble", "" },
			{ "group:marble", "group:marble", "dye:grey" }
		},
})

unifieddyes.register_color_craft({
	output = "decor:bathroom_tiles_medium",
	palette = "extended",
	type = "shapeless",
	neutral_node = "decor:bathroom_tiles_medium",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft( {
		output = "decor:bathroom_tiles_dark 4",
		recipe = {
			{ "group:marble", "group:marble", "" },
			{ "group:marble", "group:marble", "dye:dark_grey" }
		},
})

unifieddyes.register_color_craft({
	output = "decor:bathroom_tiles_dark",
	palette = "extended",
	type = "shapeless",
	neutral_node = "decor:bathroom_tiles_dark",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
	output = "decor:bathroom_set",
	recipe = {
		{ "", "decor:glass_table_small_round", "" },
		{ "default:plastic_sheet", "decor:glass_table_small_round", "default:plastic_sheet" },
		{ "group:stick", "default:plastic_sheet", "group:stick" }
	},
})

minetest.register_craft({
	output = "decor:toilet",
	recipe = {
		{ "","","bucket:bucket_water"},
		{ "group:marble","group:marble", "group:marble" },
		{ "", "bucket:bucket_empty", "" },
	},
})

minetest.register_craft({
	output = "decor:sink",
	recipe = {
		{ "group:marble","bucket:bucket_empty", "group:marble" },
		{ "", "group:marble", "" }
	},
})

minetest.register_craft({
	output = "decor:taps",
	recipe = {
		{ "default:steel_ingot","bucket:bucket_water", "default:steel_ingot" },
	},
})

minetest.register_craft({
	output = "decor:taps_brass",
	recipe = {
		{ "technic:brass_ingot","bucket:bucket_water", "technic:brass_ingot" },
	},
})

minetest.register_craft({
	output = "decor:shower_tray",
	recipe = {
		{ "group:marble","bucket:bucket_empty", "group:marble" },
	},
})

minetest.register_craft({
	output = "decor:shower_head",
	recipe = {
		{"default:steel_ingot", "bucket:bucket_water"},
	},
})

minetest.register_craft({
	output = "decor:bathtub_clawfoot_brass_taps",
	recipe = {
		{ "decor:taps_brass", "", "" },
		{ "group:marble", "", "group:marble" },
		{ "default:steel_ingot", "group:marble", "default:steel_ingot"},
	},
})

minetest.register_craft({
	output = "decor:bathtub_clawfoot_chrome_taps",
	recipe = {
		{ "decor:taps", "", "" },
		{ "group:marble", "", "group:marble" },
		{"default:steel_ingot", "group:marble", "default:steel_ingot"},
	},
})

