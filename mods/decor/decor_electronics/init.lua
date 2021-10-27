if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- Various home electronics

local S = minetest.get_translator("decor_electronics")

decor.register("speaker", {
	description = S("Large Stereo Speaker"),
	mesh="decor_speaker_large.obj",
	tiles = {
		"decor_speaker_sides.png",
		"decor_speaker_front.png"
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.set_node(pos, {name = "decor:speaker_open", param2 = node.param2})
	end
})

decor.register("speaker_open", {
	description = S("Large Stereo Speaker, open front"),
	mesh="decor_speaker_large_open.obj",
	tiles = {
		"decor_speaker_sides.png",
		"decor_speaker_driver.png",
		"decor_speaker_open_front.png",
		{ name = "decor_generic_metal.png", color = decor.color_black }
	},
	groups = { snappy = 3, not_in_creative_inventory=1 },
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.set_node(pos, {name = "decor:speaker", param2 = node.param2})
	end
})

local spk_cbox = {
	type = "fixed",
	fixed = { -3/16, -8/16, 1/16, 3/16, -2/16, 7/16 }
}

decor.register("speaker_small", {
	description = S("Small Surround Speaker"),
	mesh="decor_speaker_small.obj",
	tiles = {
		"decor_speaker_sides.png",
		"decor_speaker_front.png"
	},
	selection_box = spk_cbox,
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
})

decor.register("stereo", {
	description = S("Stereo Receiver"),
	tiles = { 'decor_stereo_top.png',
			'decor_stereo_bottom.png',
			'decor_stereo_left.png^[transformFX',
			'decor_stereo_left.png',
			'decor_stereo_back.png',
			'decor_stereo_front.png'},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
})

decor.register("projection_screen", {
	description = S("Projection Screen Material"),
	drawtype = 'signlike',
	tiles = { 'decor_projection_screen.png' },
	wield_image = 'decor_projection_screen_inv.png',
	inventory_image = 'decor_projection_screen_inv.png',
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	paramtype2 = 'wallmounted',
	selection_box = {
		type = "wallmounted",
		--wall_side = = <default>
	},
})

decor.register("television", {
	description = S("Small CRT Television"),
	tiles = { 'decor_television_top.png',
		  'decor_television_bottom.png',
		  'decor_television_left.png^[transformFX',
		  'decor_television_left.png',
		  'decor_television_back.png',
		   { name="decor_television_front_animated.png",
			  animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=80.0
			  }
		   }
	},
	light_source = default.LIGHT_MAX - 1,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
})

decor.register("dvd_vcr", {
	description = S("DVD and VCR"),
	tiles = {
		"decor_dvdvcr_top.png",
		"decor_dvdvcr_bottom.png",
		"decor_dvdvcr_sides.png",
		"decor_dvdvcr_sides.png^[transformFX",
		"decor_dvdvcr_back.png",
		"decor_dvdvcr_front.png",
	},
	inventory_image = "decor_dvdvcr_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.25, 0.3125, -0.375, 0.1875},
			{-0.25, -0.5, -0.25, 0.25, -0.1875, 0.125},
		}
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
})

local tel_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.1875, 0.25, -0.21, 0.15 }
}

decor.register("telephone", {
	mesh = "decor_telephone.obj",
	tiles = {
		"decor_telephone_dial.png",
		"decor_telephone_base.png",
		"decor_telephone_handset.png",
		"decor_telephone_cord.png",
	},
	inventory_image = "decor_telephone_inv.png",
	description = S("Telephone"),
	groups = {snappy=3},
	selection_box = tel_cbox,
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
})

-- crafting

minetest.register_craftitem(":decor:vcr", {
	description = S("VCR"),
	inventory_image = "decor_vcr.png"
})

minetest.register_craftitem(":decor:dvd_player", {
	description = S("DVD Player"),
	inventory_image = "decor_dvd_player.png"
})

minetest.register_craftitem(":decor:speaker_driver", {
	description = S("Speaker driver"),
	inventory_image = "decor_speaker_driver_inv.png"
})

minetest.register_craft( {
	output = "decor:projection_screen 3",
	recipe = {
		{ "", "default:glass", "" },
		{ "default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet" },
		{ "default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet" },
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:projection_screen",
	burntime = 30,
})

minetest.register_craft( {
	output = "decor:television",
	recipe = {
		{ "default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet" },
		{ "default:plastic_sheet", "moreblocks:glow_glass", "default:plastic_sheet" },
		{ "decor:ic", "decor:ic", "decor:ic" },
	},
})

minetest.register_craft( {
	output = "decor:television",
	recipe = {
		{ "default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet" },
		{ "default:plastic_sheet", "default:glass", "default:plastic_sheet" },
		{ "decor:ic", "default:mese_crystal", "decor:ic" },
	},
})

minetest.register_craft( {
	output = "decor:stereo",
	recipe = {
		{ "default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet" },
		{ "default:plastic_sheet", "decor:ic", "default:plastic_sheet" },
		{ "default:steel_ingot", "decor:ic", "default:steel_ingot" },
	},
})


minetest.register_craft( {
	output = "decor:speaker_driver 2",
	recipe = {
		{ "", "default:steel_ingot", "" },
		{ "default:paper", "technic:fine_copper_wire", "default:iron_lump" },
		{ "", "default:steel_ingot", "" },
	},
})

minetest.register_craft( {
	output = "decor:speaker_small",
	recipe = {
		{ "wool:black", "decor:speaker_driver", "group:wood" },
	},
})

minetest.register_craft( {
	output = "decor:speaker",
	recipe = {
		{ "wool:black", "decor:speaker_driver", "group:wood" },
		{ "wool:black", "decor:speaker_driver", "group:wood" },
		{ "wool:black", "group:wood", "group:wood" },
	},
})

-- cotton version

minetest.register_craft( {
	output = "decor:speaker_small",
	recipe = {
		{ "cotton:black", "decor:speaker_driver", "group:wood" },
	},
})

minetest.register_craft( {
	output = "decor:speaker",
	recipe = {
		{ "cotton:black", "decor:speaker_driver", "group:wood" },
		{ "cotton:black", "decor:speaker_driver", "group:wood" },
		{ "cotton:black", "group:wood", "group:wood" },
	},
})


minetest.register_craft({
	output = "decor:vcr 2",
	recipe = {
		{ "decor:ic", "default:steel_ingot", "default:plastic_sheet" },
		{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
		{ "default:plastic_sheet", "", "default:plastic_sheet" },
	},
})

minetest.register_craft({
	output = "decor:dvd_player 2",
	recipe = {
		{ "", "default:plastic_sheet", "" },
		{ "default:obsidian_glass", "technic:motor", "technic:motor" },
		{ "default:mese_crystal_fragment", "decor:ic", "default:mese_crystal" },
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "decor:dvd_vcr",
	recipe = {
		"decor:vcr",
		"decor:dvd_player"
	},
})

minetest.register_craft( {
	output = "decor:telephone",
	recipe = {
		{ "decor:speaker_driver", "technic:fine_copper_wire", "decor:speaker_driver" },
		{ "default:plastic_sheet", "default:steel_ingot", "default:plastic_sheet" },
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
	},
})
