if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- This file supplies Kitchen stuff like refrigerators, sinks, etc.

local S = minetest.get_translator("decor_kitchen")

-- steel-textured fridge
decor.register("refrigerator_steel", {
	mesh = "decor_refrigerator.obj",
	tiles = { "decor_refrigerator_steel.png" },
	use_texture_alpha = "clip",
	inventory_image = "decor_refrigerator_steel_inv.png",
	description = S("Refrigerator (stainless steel)"),
	groups = {snappy=3},
	sounds = default.node_sound_stone_defaults(),
	selection_box = decor.nodebox.slab_y(2),
	collision_box = decor.nodebox.slab_y(2),
	expand = { top="placeholder" },
	infotext=S("Refrigerator"),
	inventory = {
		size=50,
		lockable=true,
	},
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple or nil,
})

-- white, enameled fridge
decor.register("refrigerator_white", {
	mesh = "decor_refrigerator.obj",
	tiles = { "decor_refrigerator_white.png" },
	use_texture_alpha = "clip",
	inventory_image = "decor_refrigerator_white_inv.png",
	description = S("Refrigerator"),
	groups = {snappy=3},
	selection_box = decor.nodebox.slab_y(2),
	collision_box = decor.nodebox.slab_y(2),
	sounds = default.node_sound_stone_defaults(),
	expand = { top="placeholder" },
	infotext=S("Refrigerator"),
	inventory = {
		size=50,
		lockable=true,
	},
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple or nil,
})

minetest.register_alias("decor:refrigerator_white_bottom", "decor:refrigerator_white")
minetest.register_alias("decor:refrigerator_white_top", "air")

minetest.register_alias("decor:refrigerator_steel_bottom", "decor:refrigerator_steel")
minetest.register_alias("decor:refrigerator_steel_top", "air")

minetest.register_alias("decor:refrigerator_white_bottom_locked", "decor:refrigerator_white_locked")
minetest.register_alias("decor:refrigerator_white_top_locked", "air")
minetest.register_alias("decor:refrigerator_locked", "decor:refrigerator_white_locked")

minetest.register_alias("decor:refrigerator_steel_bottom_locked", "decor:refrigerator_steel_locked")
minetest.register_alias("decor:refrigerator_steel_top_locked", "air")

-- kitchen "furnaces"
decor.register_furnace("oven", {
	description = S("Oven"),
	tile_format = "decor_oven_%s%s.png",
	output_slots = 4,
	output_width = 2,
	cook_speed = 1.25,
})

decor.register_furnace("oven_steel", {
	description = S("Oven (stainless steel)"),
	tile_format = "decor_oven_steel_%s%s.png",
	output_slots = 4,
	output_width = 2,
	cook_speed = 1.25,
})

decor.register_furnace("microwave_oven", {
	description = S("Microwave Oven"),
	tiles = {
		"decor_microwave_top.png", "decor_microwave_top.png^[transformR180",
		"decor_microwave_top.png^[transformR270", "decor_microwave_top.png^[transformR90",
		"decor_microwave_top.png^[transformR180", "decor_microwave_front.png"
	},
	use_texture_alpha = "clip",
	tiles_active = {
		"decor_microwave_top.png", "decor_microwave_top.png^[transformR180",
		"decor_microwave_top.png^[transformR270", "decor_microwave_top.png^[transformR90",
		"decor_microwave_top.png^[transformR180", "decor_microwave_front_active.png"
	},
	use_texture_alpha = "clip",
	output_slots = 2,
	output_width = 2,
	cook_speed = 1.5,
	extra_nodedef_fields = {
		node_box = {
			type = "fixed",
			fixed = { -0.5, -0.5, -0.125, 0.5, 0.125, 0.5 },
		},
	},
})

decor.register("dishwasher", {
	description = S("Dishwasher"),
	drawtype = "nodebox",
	tiles = {
		"decor_dishwasher_top.png",
		"decor_dishwasher_bottom.png",
		"decor_dishwasher_sides.png",
		"decor_dishwasher_sides.png^[transformFX",
		"decor_dishwasher_back.png",
		"decor_dishwasher_front.png"
	},
	use_texture_alpha = "clip",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
			{-0.5, -0.5, -0.5, 0.5, 0.5, -0.4375},
			{-0.5, -0.5, -0.5, 0.5, 0.1875, 0.1875},
			{-0.4375, -0.5, -0.5, 0.4375, 0.4375, 0.4375},
		}
	},
	selection_box = { type = "regular" },
	sounds = default.node_sound_stone_defaults(),
	groups = { snappy = 3 },
})

local materials = { ["granite"] = S("granite"), ["marble"] = S("marble"), ["steel"] = S("steel"), ["wood"] = S("wood") }

for m, m_loc in pairs(materials) do
decor.register("dishwasher_"..m, {
	description = S("Dishwasher (@1)", m_loc),
	tiles = {
		"decor_kitchen_cabinet_top_"..m..".png",
		"decor_dishwasher_bottom.png",
		"decor_dishwasher_sides.png",
		"decor_dishwasher_sides.png^[transformFX",
		"decor_dishwasher_back.png",
		"decor_dishwasher_front.png"
	},
	use_texture_alpha = "clip",
	groups = { snappy = 3 },
	sounds = default.node_sound_stone_defaults(),
})
end

local cabinet_sides = "(default_wood.png^[transformR90)^decor_kitchen_cabinet_bevel.png"
local cabinet_sides_colored = "(decor_generic_wood_plain.png^[transformR90)^decor_kitchen_cabinet_bevel.png"

local ic_cabinet_sides = string.gsub(cabinet_sides, "%^", "&")
local ic_cabinet_sides_colored = string.gsub(cabinet_sides_colored, "%^", "&")

local cabinet_bottom = "(default_wood.png^[colorize:#000000:100)^decor_kitchen_cabinet_bevel.png"
local cabinet_bottom_colored = "decor_generic_wood_plain.png^decor_kitchen_cabinet_bevel.png"

local function N_(x) return x end

local counter_materials = { "", N_("granite"), N_("marble"), N_("steel") }

decor.kitchen_convert_nodes = {}

for _, mat in ipairs(counter_materials) do

	local desc = S("Kitchen Cabinet")
	local material = ""

	if mat ~= "" then
		desc = S("Kitchen Cabinet (@1 top)", S(mat))
		desc2 = S("Kitchen Cabinet with drawers (@1 top)", S(mat))
		material = "_"..mat
	else
		desc = S("Kitchen Cabinet")
		desc2 = S("Kitchen Cabinet with drawers")
	end

	decor.register("kitchen_cabinet"..material, {
		description = desc,
		tiles = {
			'decor_kitchen_cabinet_top'..material..'.png',
			cabinet_bottom,
			cabinet_sides,
			cabinet_sides,
			cabinet_sides,
			'decor_kitchen_cabinet_front.png^decor_kitchen_cabinet_bevel.png'
		},
		use_texture_alpha = "clip",
		inventory_image = "[inventorycube"
			.."{decor_kitchen_cabinet_top"..material..".png"
			.."{decor_kitchen_cabinet_front.png"
			.."{"..ic_cabinet_sides,
		mesh = "decor_kitchen_cabinet.obj",
		place_param2 = 0,
		groups = { snappy = 3, ud_param2_colorable = 1},
		sounds = default.node_sound_wood_defaults(),
		infotext=S("Kitchen Cabinet"),
		inventory = {
			size=24,
			lockable=true,
		}
--		after_place_node = function(pos, placer, itemstack, pointed_thing)
--			unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
--		end
	})

	decor.register("kitchen_cabinet_with_drawers"..material, {
		description = desc2,
		tiles = {
			'decor_kitchen_cabinet_top'..material..'.png',
			cabinet_bottom,
			cabinet_sides,
			cabinet_sides,
			cabinet_sides,
			'decor_kitchen_cabinet_front_with_drawers.png^decor_kitchen_cabinet_bevel.png'
		},
		use_texture_alpha = "clip",
		inventory_image = "[inventorycube"
			.."{decor_kitchen_cabinet_top"..material..".png"
			.."{decor_kitchen_cabinet_front_with_drawers.png"
			.."{"..ic_cabinet_sides,
		mesh = "decor_kitchen_cabinet.obj",
		place_param2 = 0,
		groups = { snappy = 3, ud_param2_colorable = 1},
		sounds = default.node_sound_wood_defaults(),
		infotext=S("Kitchen Cabinet with drawers"),
		inventory = {
			size=24,
			lockable=true,
		},
--		after_place_node = function(pos, placer, itemstack, pointed_thing)
--			unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
--		end
	})

--[[
	decor.register("kitchen_cabinet_colorable"..material, {
		description = desc,
		tiles = {
			'decor_kitchen_cabinet_top'..material..'.png',
			cabinet_bottom,
			cabinet_sides,
			cabinet_sides,
			cabinet_sides,
			'decor_kitchen_cabinet_front.png^decor_kitchen_cabinet_bevel.png'
		},
		use_texture_alpha = "clip",
		inventory_image = "[inventorycube"
			.."{decor_kitchen_cabinet_top"..material..".png"
			.."{decor_kitchen_cabinet_front.png"
			.."{"..ic_cabinet_sides,
		mesh = "decor_kitchen_cabinet.obj",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		airbrush_replacement_node = "decor:kitchen_cabinet_colored"..material,
		place_param2 = 0,
		groups = { snappy = 3, ud_param2_colorable = 1},
		sounds = default.node_sound_wood_defaults(),
		infotext=S("Kitchen Cabinet"),
		inventory = {
			size=24,
			lockable=true,
		},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		end
	})

	decor.register("kitchen_cabinet_colorable_with_drawers"..material, {
		description = desc2,
		tiles = {
			'decor_kitchen_cabinet_top'..material..'.png',
			cabinet_bottom,
			cabinet_sides,
			cabinet_sides,
			cabinet_sides,
			'decor_kitchen_cabinet_front_with_drawers.png^decor_kitchen_cabinet_bevel.png'
		},
		use_texture_alpha = "clip",
		inventory_image = "[inventorycube"
			.."{decor_kitchen_cabinet_top"..material..".png"
			.."{decor_kitchen_cabinet_front_with_drawers.png"
			.."{"..ic_cabinet_sides,
		mesh = "decor_kitchen_cabinet.obj",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		airbrush_replacement_node = "decor:kitchen_cabinet_colored_with_drawers"..material,
		place_param2 = 0,
		groups = { snappy = 3, ud_param2_colorable = 1},
		sounds = default.node_sound_wood_defaults(),
		infotext=S("Kitchen Cabinet with drawers"),
		inventory = {
			size=24,
			lockable=true,
		},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		end
	})

	decor.register("kitchen_cabinet_colored"..material, {
		description = desc,
		tiles = {
			{name = 'decor_kitchen_cabinet_top'..material..'.png', color = 0xFFFFFFFF},
			{name = cabinet_bottom, color = 0xFFFFFFFF },
			cabinet_sides_colored,
			cabinet_sides_colored,
			cabinet_sides_colored,
			'decor_kitchen_cabinet_colored_front.png^decor_kitchen_cabinet_bevel.png'
		},
		use_texture_alpha = "clip",
		inventory_image = "[inventorycube"
			.."{decor_kitchen_cabinet_top"..material..".png"
			.."{decor_kitchen_cabinet_front.png"
			.."{"..ic_cabinet_sides_colored,
		mesh = "decor_kitchen_cabinet.obj",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		groups = { snappy = 3, ud_param2_colorable = 1, not_in_creative_inventory = 1 },
		sounds = default.node_sound_wood_defaults(),
		infotext=S("Kitchen Cabinet"),
		inventory = {
			size=24,
			lockable=true,
		},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		end
	})

	decor.register("kitchen_cabinet_colorable_with_drawers"..material, {
		description = desc2,
		tiles = {
			'decor_kitchen_cabinet_top'..material..'.png',
			cabinet_bottom,
			cabinet_sides,
			cabinet_sides,
			cabinet_sides,
			'decor_kitchen_cabinet_front_with_drawers.png^decor_kitchen_cabinet_bevel.png'
		},
		use_texture_alpha = "clip",
		inventory_image = "[inventorycube"
			.."{decor_kitchen_cabinet_top"..material..".png"
			.."{decor_kitchen_cabinet_front_with_drawers.png"
			.."{"..ic_cabinet_sides,
		mesh = "decor_kitchen_cabinet.obj",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		airbrush_replacement_node = "decor:kitchen_cabinet_colored_with_drawers"..material,
		place_param2 = 0,
		groups = { snappy = 3, ud_param2_colorable = 1},
		sounds = default.node_sound_wood_defaults(),
		infotext=S("Kitchen Cabinet with drawers"),
		inventory = {
			size=24,
			lockable=true,
		},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		end
	})

	decor.register("kitchen_cabinet_colored_with_drawers"..material, {
		description = desc2,
		tiles = {
			{name = 'decor_kitchen_cabinet_top'..material..'.png', color = 0xFFFFFFFF},
			{name = cabinet_bottom, color = 0xFFFFFFFF },
			cabinet_sides_colored,
			cabinet_sides_colored,
			cabinet_sides_colored,
			'decor_kitchen_cabinet_colored_front_with_drawers.png^decor_kitchen_cabinet_bevel.png'
		},
		use_texture_alpha = "clip",
		inventory_image = "[inventorycube"
			.."{decor_kitchen_cabinet_top"..material..".png"
			.."{decor_kitchen_cabinet_colored_front_with_drawers.png"
			.."{"..ic_cabinet_sides_colored,
		mesh = "decor_kitchen_cabinet.obj",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		groups = { snappy = 3, ud_param2_colorable = 1, not_in_creative_inventory = 1 },
		sounds = default.node_sound_wood_defaults(),
		infotext=S("Kitchen Cabinet with drawers"),
		inventory = {
			size=24,
			lockable=true,
		},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		end
	})

	decor.kitchen_convert_nodes[#decor.kitchen_convert_nodes + 1] = "decor:kitchen_cabinet"..material
	decor.kitchen_convert_nodes[#decor.kitchen_convert_nodes + 1] = "decor:kitchen_cabinet_locked"..material
--]]
end

local kitchen_cabinet_half_box = decor.nodebox.slab_z(0.5, 0.5)

decor.register("kitchen_cabinet_half", {
	description = S('Half-height Kitchen Cabinet (on ceiling)'),
	tiles = {
		cabinet_sides,
		cabinet_bottom,
		cabinet_sides,
		cabinet_sides,
		cabinet_sides,
		'decor_kitchen_cabinet_front_half.png^decor_kitchen_cabinet_half_bevel.png'
	},
	use_texture_alpha = "clip",
	mesh = "decor_kitchen_cabinet_half.obj",
	place_param2 = 0,
	selection_box = kitchen_cabinet_half_box,
	node_box = kitchen_cabinet_half_box,
	groups = { snappy = 3, ud_param2_colorable = 1 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Kitchen Cabinet"),
	inventory = {
		size=12,
		lockable=true,
	},
--	after_place_node = function(pos, placer, itemstack, pointed_thing)
--		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
--	end
})
--[[
decor.register("kitchen_cabinet_colorable_half", {
	description = S('Half-height Kitchen Cabinet (on ceiling)'),
	tiles = {
		cabinet_sides,
		cabinet_bottom,
		cabinet_sides,
		cabinet_sides,
		cabinet_sides,
		'decor_kitchen_cabinet_front_half.png^decor_kitchen_cabinet_half_bevel.png'
	},
	use_texture_alpha = "clip",
	mesh = "decor_kitchen_cabinet_half.obj",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	airbrush_replacement_node = "decor:kitchen_cabinet_colored_half",
	place_param2 = 0,
	selection_box = kitchen_cabinet_half_box,
	node_box = kitchen_cabinet_half_box,
	groups = { snappy = 3, ud_param2_colorable = 1 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Kitchen Cabinet"),
	inventory = {
		size=12,
		lockable=true,
	},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
	end
})

decor.kitchen_convert_nodes[#decor.kitchen_convert_nodes + 1] = "decor:kitchen_cabinet_half"
decor.kitchen_convert_nodes[#decor.kitchen_convert_nodes + 1] = "decor:kitchen_cabinet_half_locked"

decor.register("kitchen_cabinet_colored_half", {
	description = S('Half-height Kitchen Cabinet (on ceiling)'),
	tiles = {
		{ name = cabinet_sides, color = 0xFFFFFFFF },
		cabinet_bottom_colored,
		cabinet_sides_colored,
		cabinet_sides_colored,
		cabinet_sides_colored,
		'decor_kitchen_cabinet_colored_front_half.png^decor_kitchen_cabinet_half_bevel.png'
	},
	use_texture_alpha = "clip",
	mesh = "decor_kitchen_cabinet_half.obj",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = kitchen_cabinet_half_box,
	node_box = kitchen_cabinet_half_box,
	groups = { snappy = 3, ud_param2_colorable = 1, not_in_creative_inventory = 1  },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Kitchen Cabinet"),
	inventory = {
		size=12,
		lockable=true,
	},
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
	end
})
--]]

decor.register("kitchen_cabinet_with_sink", {
	description = S("Kitchen Cabinet with sink"),
	mesh = "decor_kitchen_sink.obj",
	tiles = {
		"decor_kitchen_sink_top.png",
		cabinet_bottom,
		cabinet_sides,
		cabinet_sides,
		cabinet_sides,
		"decor_kitchen_cabinet_front.png^decor_kitchen_cabinet_bevel.png"
	},
	use_texture_alpha = "clip",
	inventory_image = "[inventorycube"
		.."{decor_kitchen_sink_top.png"
		.."{decor_kitchen_cabinet_front.png"
		.."{"..ic_cabinet_sides,
	place_param2 = 0,
	groups = { snappy = 3, ud_param2_colorable = 1 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Under-sink cabinet"),
	inventory = {
		size=16,
		lockable=true,
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, -8/16,  8/16, 6/16,  8/16 },
			{ -8/16,  6/16, -8/16, -6/16, 8/16,  8/16 },
			{  6/16,  6/16, -8/16,  8/16, 8/16,  8/16 },
			{ -8/16,  6/16, -8/16,  8/16, 8/16, -6/16 },
			{ -8/16,  6/16,  6/16,  8/16, 8/16,  8/16 },
		}
	},
	on_destruct = function(pos)
		decor.stop_particle_spawner({x=pos.x, y=pos.y+1, z=pos.z})
	end,
--	after_place_node = function(pos, placer, itemstack, pointed_thing)
--		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
--	end
})
--[[
decor.register("kitchen_cabinet_colorable_with_sink", {
	description = S("Kitchen Cabinet with sink"),
	mesh = "decor_kitchen_sink.obj",
	tiles = {
		"decor_kitchen_sink_top.png",
		cabinet_bottom,
		cabinet_sides,
		cabinet_sides,
		cabinet_sides,
		"decor_kitchen_cabinet_front.png^decor_kitchen_cabinet_bevel.png"
	},
	use_texture_alpha = "clip",
	inventory_image = "[inventorycube"
			.."{decor_kitchen_sink_top.png"
			.."{decor_kitchen_cabinet_front.png"
			.."{"..ic_cabinet_sides,
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	airbrush_replacement_node = "decor:kitchen_cabinet_colored_with_sink",
	place_param2 = 0,
	groups = { snappy = 3, ud_param2_colorable = 1 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Under-sink cabinet"),
	inventory = {
		size=16,
		lockable=true,
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, -8/16,  8/16, 6/16,  8/16 },
			{ -8/16,  6/16, -8/16, -6/16, 8/16,  8/16 },
			{  6/16,  6/16, -8/16,  8/16, 8/16,  8/16 },
			{ -8/16,  6/16, -8/16,  8/16, 8/16, -6/16 },
			{ -8/16,  6/16,  6/16,  8/16, 8/16,  8/16 },
		}
	},
	on_destruct = function(pos)
		decor.stop_particle_spawner({x=pos.x, y=pos.y+1, z=pos.z})
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
	end
})

decor.kitchen_convert_nodes[#decor.kitchen_convert_nodes + 1] = "decor:kitchen_cabinet_with_sink"
decor.kitchen_convert_nodes[#decor.kitchen_convert_nodes + 1] = "decor:kitchen_cabinet_with_sink_locked"

decor.register("kitchen_cabinet_colored_with_sink", {
	description = S("Kitchen Cabinet with sink"),
	mesh = "decor_kitchen_sink.obj",
	tiles = {
		{ name = "decor_kitchen_sink_top.png", color = 0xFFFFFFFF },
		{ name = cabinet_bottom, color = 0xFFFFFFFF},
		cabinet_sides_colored,
		cabinet_sides_colored,
		cabinet_sides_colored,
		"decor_kitchen_cabinet_colored_front.png^decor_kitchen_cabinet_bevel.png",
	},
	use_texture_alpha = "clip",
	inventory_image = "[inventorycube"
			.."{decor_kitchen_sink_top.png"
			.."{decor_kitchen_cabinet_front.png"
			.."{"..ic_cabinet_sides_colored,
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	groups = { snappy = 3, ud_param2_colorable = 1,  not_in_creative_inventory = 1 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Under-sink cabinet"),
	inventory = {
		size=16,
		lockable=true,
	},
	node_box = {
		type = "fixed",
		fixed = {
			{ -8/16, -8/16, -8/16,  8/16, 6/16,  8/16 },
			{ -8/16,  6/16, -8/16, -6/16, 8/16,  8/16 },
			{  6/16,  6/16, -8/16,  8/16, 8/16,  8/16 },
			{ -8/16,  6/16, -8/16,  8/16, 8/16, -6/16 },
			{ -8/16,  6/16,  6/16,  8/16, 8/16,  8/16 },
		}
	},
	on_destruct = function(pos)
		decor.stop_particle_spawner({x=pos.x, y=pos.y+1, z=pos.z})
	end,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
	end
})
--]]
local cp_cbox = {
	type = "fixed",
	fixed = { -0.375, -0.5, -0.5, 0.375, -0.3125, 0.3125 }
}

decor.register("copper_pans", {
	description = S("Copper pans"),
	mesh = "decor_copper_pans.obj",
	tiles = { "decor_polished_copper.png" },
	use_texture_alpha = "clip",
	inventory_image = "decor_copper_pans_inv.png",
	groups = { snappy=3 },
	selection_box = cp_cbox,
	walkable = false,
	on_place = minetest.rotate_node
})

local kf_cbox = {
	type = "fixed",
	fixed = { -2/16, -8/16, 1/16, 2/16, -1/16, 8/16 }
}

decor.register("kitchen_faucet", {
	mesh = "decor_kitchen_faucet.obj",
	tiles = { "decor_generic_metal_bright.png" },
	use_texture_alpha = "clip",
	inventory_image = "decor_kitchen_faucet_inv.png",
	description = S("Kitchen Faucet"),
	groups = {snappy=3},
	selection_box = kf_cbox,
	walkable = false,
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local below = minetest.get_node_or_nil({x=pos.x, y=pos.y-1, z=pos.z})
		if below and
		  below.name == "decor:sink" or
		  below.name == "decor:kitchen_cabinet_with_sink" or
		  below.name == "decor:kitchen_cabinet_with_sink_locked" then
			local particledef = {
				outlet      = { x = 0, y = -0.19, z = 0.13 },
				velocity_x  = { min = -0.05, max = 0.05 },
				velocity_y  = -0.3,
				velocity_z  = { min = -0.1,  max = 0 },
				spread      = 0
			}
			decor.start_particle_spawner(pos, node, particledef, "decor_faucet")
		end
		return itemstack
	end,
	on_destruct = decor.stop_particle_spawner
})

decor.register("paper_towel", {
	mesh = "decor_paper_towel.obj",
	tiles = {
		"decor_generic_quilted_paper.png",
		"default_wood.png"
	},
	use_texture_alpha = "clip",
	inventory_image = "decor_paper_towel_inv.png",
	description = S("Paper towels"),
	groups = { snappy=3 },
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = { -0.4375, 0.125, 0.0625, 0.4375, 0.4375, 0.5 }
	},
})

-- crafting


minetest.register_craft({
        output = "decor:oven_steel",
        recipe = {
		{"decor:heating_element", "default:steel_ingot", "decor:heating_element", },
		{"default:steel_ingot", "moreblocks:iron_glass", "default:steel_ingot", },
		{"default:steel_ingot", "decor:heating_element", "default:steel_ingot", },
	}
})

minetest.register_craft({
        output = "decor:oven_steel",
        recipe = {
		{"decor:heating_element", "default:steel_ingot", "decor:heating_element", },
		{"default:steel_ingot", "default:glass", "default:steel_ingot", },
		{"default:steel_ingot", "decor:heating_element", "default:steel_ingot", },
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "decor:oven",
	recipe = {
		"decor:oven_steel",
		"dye:white",
		"dye:white",
	}
})

minetest.register_craft({
        output = "decor:microwave_oven 2",
        recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", },
		{"default:steel_ingot", "moreblocks:iron_glass", "decor:ic", },
		{"default:steel_ingot", "default:copper_ingot", "default:mese_crystal", },
	}
})

minetest.register_craft({
        output = "decor:microwave_oven 2",
        recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot", },
		{"default:steel_ingot", "default:glass", "decor:ic", },
		{"default:steel_ingot", "default:copper_ingot", "default:mese_crystal", },
	}
})

minetest.register_craft({
	output = "decor:refrigerator_steel",
	recipe = {
		{"default:steel_ingot", "decor:glowlight_small_cube", "default:steel_ingot", },
		{"default:steel_ingot", "default:copperblock", "default:steel_ingot", },
		{"default:steel_ingot", "default:clay", "default:steel_ingot", },
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "decor:refrigerator_white",
	recipe = {
		"decor:refrigerator_steel",
		"dye:white",
		"dye:white",
		"dye:white",
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet",
        recipe = {
		{"group:wood", "group:stick", "group:wood", },
		{"group:wood", "group:stick", "group:wood", },
		{"group:wood", "group:stick", "group:wood", },
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_with_drawers",
        recipe = {
		{"group:wood", "group:stick", "group:wood", },
		{"group:wood", "group:stick", "group:wood", },
		{"group:wood", "decor:drawer_small", "group:wood", },
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_steel",
        recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"", "decor:kitchen_cabinet", ""},
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_steel",
        recipe = {
			{"moreblocks:slab_steelblock_1"},
			{ "decor:kitchen_cabinet" },
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_marble",
        recipe = {
			{"technic:slab_marble"},
			{"decor:kitchen_cabinet"},
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_marble",
        recipe = {
			{"technic:slab_marble_1"},
			{"decor:kitchen_cabinet"},
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_granite",
        recipe = {
			{"technic:slab_granite_1"},
			{"decor:kitchen_cabinet"},
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_with_drawers_steel",
        recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"", "decor:kitchen_cabinet_with_drawers", ""},
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_with_drawers_steel",
        recipe = {
			{"moreblocks:slab_steelblock_1"},
			{ "decor:kitchen_cabinet_with_drawers" },
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_with_drawers_marble",
        recipe = {
			{"technic:slab_marble"},
			{"decor:kitchen_cabinet_with_drawers"},
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_with_drawers_marble",
        recipe = {
			{"technic:slab_marble_1"},
			{"decor:kitchen_cabinet_with_drawers"},
	}
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_with_drawers_granite",
        recipe = {
			{"technic:slab_granite_1"},
			{"decor:kitchen_cabinet_with_drawers"},
	}
})

minetest.register_craft({
	type = "shapeless",
        output = "decor:kitchen_cabinet_half 2",
        recipe = { "decor:kitchen_cabinet" }
})

minetest.register_craft({
        output = "decor:kitchen_cabinet_with_sink",
        recipe = {
		{"group:wood", "default:steel_ingot", "group:wood", },
		{"group:wood", "default:steel_ingot", "group:wood", },
		{"group:wood", "group:stick", "group:wood", },
	}
})

minetest.register_craft( {
    output = "decor:dishwasher",
    recipe = {
		{ "decor:ic",  "building_blocks:slab_grate_1",    "default:steel_ingot",  },
		{ "default:steel_ingot", "decor:shower_head",           "technic:motor" },
		{ "default:steel_ingot", "decor:heating_element", "bucket:bucket_water"   }
    },
})

minetest.register_craft( {
    output = "decor:dishwasher",
    recipe = {
		{ "decor:ic", "decor:fence_chainlink", "default:steel_ingot",  },
		{ "default:steel_ingot", "decor:shower_head", "technic:motor" },
		{ "default:steel_ingot", "decor:heating_element", "bucket:bucket_water" }
    },
})

minetest.register_craft( {
    output = "decor:dishwasher_wood",
    recipe = {
		{ "stairs:slab_wood" },
		{ "decor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "decor:dishwasher_steel",
    recipe = {
		{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" },
		{ "", "decor:dishwasher", "" },
    },
})

minetest.register_craft( {
    output = "decor:dishwasher_steel",
    recipe = {
		{ "moreblocks:slab_steelblock_1" },
		{ "decor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "decor:dishwasher_marble",
    recipe = {
		{ "technic:slab_marble" },
		{ "decor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "decor:dishwasher_marble",
    recipe = {
		{ "technic:slab_marble_1" },
		{ "decor:dishwasher" },
    },
})

minetest.register_craft( {
    output = "decor:dishwasher_granite",
    recipe = {
		{ "technic:slab_granite_1" },
		{ "decor:dishwasher" },
    },
})

minetest.register_craft( {
        output = "decor:kitchen_faucet",
        recipe = {
			{ "", "default:steel_ingot" },
			{ "default:steel_ingot", "" },
			{ "decor:taps", "" }
        },
})

minetest.register_craft( {
        output = "decor:kitchen_faucet",
        recipe = {
			{ "default:steel_ingot","" },
			{ "", "default:steel_ingot" },
			{ "", "decor:taps" }
        },
})

minetest.register_craft( {
        output = "decor:cutlery_set",
        recipe = {
			{ "", "vessels:drinking_glass", "" },
			{ "decor:steel_strip", "technic:slab_marble_1", "decor:steel_strip" },
        },
})

minetest.register_craft({
	output = "decor:copper_pans",
	recipe = {
		{ "decor:copper_strip","","decor:copper_strip" },
		{ "default:copper_ingot","","default:copper_ingot" },
		{ "default:copper_ingot","","default:copper_ingot" }
	},
})

minetest.register_craft({
    output = "decor:paper_towel",
    recipe = {
		{ "decor:toilet_paper", "decor:toilet_paper" }
    },
})

minetest.register_lbm({
	name = ":decor:convert_kitchen_cabinets",
	label = "Convert decor kitchen cabinets to use [color]wallmounted",
	run_at_every_load = false,
	nodenames = decor.kitchen_convert_nodes,
	action = function(pos, node)
		local name = node.name
		local newname = string.gsub(name, "_cabinet", "_cabinet_colorable")

		local old_fdir = math.floor(node.param2 % 32)
		local new_fdir = 3

		if old_fdir == 0 then
			new_fdir = 3
		elseif old_fdir == 1 then
			new_fdir = 4
		elseif old_fdir == 2 then
			new_fdir = 2
		elseif old_fdir == 3 then
			new_fdir = 5
		end

		minetest.swap_node(pos, { name = newname, param2 = new_fdir })
	end
})
