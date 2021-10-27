if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- This file supplies the majority of decor's lighting

local S = minetest.get_translator("decor_lighting")

decor_lighting = {}

local function is_protected(pos, clicker)
	if minetest.is_protected(pos, clicker:get_player_name()) then
		minetest.record_protection_violation(pos,
		clicker:get_player_name())
		return true
	end
	return false
end

local hd_mesecons = minetest.get_modpath("mesecons")

-- control and brightness for dimmable lamps

local word_to_bright = {
	["off"] = 0,
	["low"] = 3,
	["med"] = 7,
	["hi"]  = 11,
	["on"]  = 14,
	["max"] = 14,
}

local rules_alldir = {
	{x =  0, y =  0, z =  1},
	{x = -1, y =  0, z =  0},
	{x =  1, y =  0, z =  0},
	{x =  0, y =  0, z = -1},  -- borrowed from lightstones
	{x =  0, y =  1, z =  1},
	{x = -1, y =  1, z =  0},
	{x =  0, y =  1, z =  0},
	{x =  1, y =  1, z =  0},
	{x =  0, y =  1, z = -1},
	{x =  0, y = -1, z =  1},
	{x = -1, y = -1, z =  0},
	{x =  0, y = -1, z =  0},
	{x =  1, y = -1, z =  0},
	{x =  0, y = -1, z = -1},
}

-- mesecons compatibility

local actions

if hd_mesecons then

	actions = {
		action_off = function(pos, node)
			local sep = string.find(node.name, "_", -5)
			if minetest.get_meta(pos):get_int("toggled") > 0 then
				minetest.swap_node(pos, {
					name = string.sub(node.name, 1, sep - 1).."_off",
					param2 = node.param2
				})
			end
		end,
		action_on = function(pos, node)
			minetest.get_meta(pos):set_int("toggled", 1)
			local sep = string.find(node.name, "_", -5)
			minetest.swap_node(pos, {
				name = string.sub(node.name, 1, sep - 1).."_on",
				param2 = node.param2
			})
		end
	}

	decor_lighting.mesecon_wall_light = {
		effector = table.copy(actions)
	}
	decor_lighting.mesecon_wall_light.effector.rules = mesecon.rules.wallmounted_get

	decor_lighting.mesecon_alldir_light = {
		effector = table.copy(actions),
	}
	decor_lighting.mesecon_alldir_light.effector.rules = rules_alldir
end

-- digilines compatibility
-- this one is based on the so-named one in Jeija's digilines mod

local player_last_clicked = {}

local digiline_on_punch

if minetest.get_modpath("digilines") then

	local on_digiline_receive_string = function(pos, node, channel, msg)
		if not msg or not channel then return end
		local meta = minetest.get_meta(pos)
		local setchan = meta:get_string("channel")
		if setchan ~= channel then return end

		if msg ~= "" and (type(msg) == "string" or type(msg) == "number" ) then
			local n = tonumber(msg)
			local suff = word_to_bright[msg] or "invalid"

			local basename = string.sub(node.name, 1, string.find(node.name, "_", -5) - 1)

			if minetest.registered_nodes[basename.."_"..msg] then
				minetest.swap_node(pos, {name = basename.."_"..msg, param2 = node.param2})
			elseif minetest.registered_nodes[basename.."_"..suff] then
				minetest.swap_node(pos, {name = basename.."_"..suff, param2 = node.param2})
			elseif minetest.registered_nodes[basename.."_on"]
			  and (msg == "med" or msg == "hi" or msg == "max" or (n and n > 3)) then
				minetest.swap_node(pos, {name = basename.."_on", param2 = node.param2})
			elseif minetest.registered_nodes[basename.."_off"]
			  and (msg == "low" or (n and n < 4)) then
				minetest.swap_node(pos, {name = basename.."_off", param2 = node.param2})
			end
		end
	end

	minetest.register_on_player_receive_fields(function(player, formname, fields)
		local name = player:get_player_name()
		local pos = player_last_clicked[name]
		if pos and formname == "decor:lamp_set_channel" then
			if is_protected(pos, player) then return end
			if (fields.channel) then
				local meta = minetest.get_meta(pos)
				meta:set_string("channel", fields.channel)
			end
		end
	end)

	if hd_mesecons then
		decor_lighting.digiline_wall_light = {
			effector = {
				action = on_digiline_receive_string,
			},
			wire = {
				rules = mesecon.rules.wallmounted_get
			}
		}
	else
		decor_lighting.digiline_wall_light = {
			effector = {
				action = on_digiline_receive_string,
			},
			wire = {
				rules = rules_alldir
			}
		}
	end

	decor_lighting.digiline_alldir_light = {
		effector = {
			action = on_digiline_receive_string,
		},
		wire = {
			rules = rules_alldir
		}
	}

	function digiline_on_punch(pos, node, puncher, pointed_thing)
		if is_protected(pos, puncher) then return end

		if puncher:get_player_control().sneak then
			local name = puncher:get_player_name()
			player_last_clicked[name] = pos
			local form = "formspec_version[4]"..
					"size[8,4]"..
					"button_exit[3,2.5;2,0.5;proceed;Proceed]"..
					"field[1.75,1.5;4.5,0.5;channel;Channel;]"
			minetest.show_formspec(name, "decor:lamp_set_channel", form)
		end
	end
end

-- turn on/off, cycle brightness

function decor_lighting.toggle_light(pos, node, clicker, itemstack, pointed_thing)
	if is_protected(pos, clicker) then return end
	local sep = string.find(node.name, "_", -5)
	local level = string.sub(node.name, sep + 1)
	local n = tonumber(level) or 0

	local newsuff
	if level == "on" then
		newsuff = "_off"
	elseif level == "off" then
		newsuff = "_on"
	elseif n > 3 then
		newsuff = "_0"
	else
		newsuff = "_14"
	end

	minetest.swap_node(pos, {name = string.sub(node.name, 1, sep - 1)..newsuff, param2 = node.param2})
end

------------------
-- Dimmable lights

--for light_brightn_name in pairs(word_to_bright) do

for brightness_level = 0, 14 do

	local tiles
	local overlay

	local onflag = (brightness_level > 0)
	local nici = (brightness_level ~= 14) and 1 or nil

	local gen_ls_tex_white =           "decor_generic_light_source_off.png"
	if onflag then gen_ls_tex_white =  "decor_generic_light_source_white.png" end

	local gen_ls_tex_yellow =          "decor_generic_light_source_off.png"
	if onflag then gen_ls_tex_yellow = "decor_generic_light_source_yellow.png" end

	local h = (brightness_level == 0) and "0" or string.format("%x", brightness_level+1)
	local brightness_hex = tonumber("0xff"..string.rep(h, 6))

	local glowlight_nodebox = {
		half = decor.nodebox.slab_y(1/2),
		quarter = decor.nodebox.slab_y(1/4),
		small_cube = {
				type = "fixed",
				fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
		},
	}

	local base =        "decor_glowlight_base.png"

	local tb_edges =    "decor_glowlight_tb_edges.png"
	local sides_edges = "decor_glowlight_thick_sides_edges.png"
	local sides_glare = "decor_glowlight_thick_sides_glare.png"

	if onflag then
		tiles = {
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
		}
		overlay = {
			{ name = "decor_glowlight_top_glare.png", color = "white"},
			"",
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
		}
	else
		tiles = {
			base.."^"..tb_edges,
			base.."^"..tb_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
		}
		overlay = nil
	end

	minetest.register_node(":decor:glowlight_half_"..brightness_level, {
		description = S("Thick Glowlight"),
		tiles = tiles,
		overlay_tiles = overlay,
		use_texture_alpha = "clip",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		selection_box = {
			type = "wallmounted",
			wall_top =    { -0.5,    0, -0.5, 0.5, 0.5, 0.5 },
			wall_bottom = { -0.5, -0.5, -0.5, 0.5,   0, 0.5 },
			wall_side =   { -0.5, -0.5, -0.5,   0, 0.5, 0.5 }
		},
		node_box = glowlight_nodebox.half,
		groups = { snappy = 3, ud_param2_colorable = 1, not_in_creative_inventory = 1 },
		light_source = brightness_level,
		sounds = default.node_sound_glass_defaults(),
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		end,
		on_dig = unifieddyes.on_dig,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:glowlight_half_on"}, inherit_color = true },
			}
		},
		mesecons = decor_lighting.mesecon_wall_light,
		digiline = decor_lighting.digiline_wall_light,
		on_punch = digiline_on_punch
	})

	sides_edges = "decor_glowlight_thin_sides_edges.png"
	sides_glare = "decor_glowlight_thin_sides_glare.png"

	if onflag then
		tiles = {
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
		}
		overlay = {
			{ name = "decor_glowlight_top_glare.png", color = "white"},
			"",
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
		}
	else
		tiles = {
			base.."^"..tb_edges,
			base.."^"..tb_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
		}
		overlay = nil
	end

	minetest.register_node(":decor:glowlight_quarter_"..brightness_level, {
		description = S("Thin Glowlight"),
		tiles = tiles,
		overlay_tiles = overlay,
		use_texture_alpha = "clip",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		selection_box = {
			type = "wallmounted",
			wall_top =    { -0.5, 0.25, -0.5,   0.5,   0.5, 0.5 },
			wall_bottom = { -0.5, -0.5, -0.5,   0.5, -0.25, 0.5 },
			wall_side =   { -0.5, -0.5, -0.5, -0.25,   0.5, 0.5 }
		},
		node_box = glowlight_nodebox.quarter,
		groups = { snappy = 3, ud_param2_colorable = 1, not_in_creative_inventory = 1 },
		light_source = brightness_level,
		sounds = default.node_sound_glass_defaults(),
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		end,
		on_dig = unifieddyes.on_dig,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:glowlight_quarter_on"}, inherit_color = true },
			}
		},
		mesecons = decor_lighting.mesecon_wall_light,
		digiline = decor_lighting.digiline_wall_light,
		on_punch = digiline_on_punch
	})

	tb_edges =    "decor_glowlight_cube_tb_edges.png"
	sides_edges = "decor_glowlight_cube_sides_edges.png"
	sides_glare = "decor_glowlight_cube_sides_glare.png"

	if onflag then
		tiles = {
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
		}
		overlay = {
			{ name = "decor_glowlight_cube_top_glare.png", color = "white"},
			"",
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
		}
	else
		tiles = {
			base.."^"..tb_edges,
			base.."^"..tb_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
		}
		overlay = nil
	end
	minetest.register_node(":decor:glowlight_small_cube_"..brightness_level, {
		description = S("Small Glowlight Cube"),
		tiles = tiles,
		overlay_tiles = overlay,
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		drawtype = "nodebox",
		palette = "unifieddyes_palette_colorwallmounted.png",
		selection_box = {
			type = "wallmounted",
			wall_top =    { -0.25,    0,  -0.25, 0.25,  0.5, 0.25 },
			wall_bottom = { -0.25, -0.5,  -0.25, 0.25,    0, 0.25 },
			wall_side =   {  -0.5, -0.25, -0.25,    0, 0.25, 0.25 }
		},
		node_box = glowlight_nodebox.small_cube,
		groups = { snappy = 3, ud_param2_colorable = 1, not_in_creative_inventory = 1 },
		light_source = brightness_level,
		sounds = default.node_sound_glass_defaults(),
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		end,
		on_dig = unifieddyes.on_dig,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:glowlight_small_cube_on"}, inherit_color = true },
			}
		},
		mesecons = decor_lighting.mesecon_wall_light,
		digiline = decor_lighting.digiline_wall_light,
		on_punch = digiline_on_punch
	})

	local lighttex

	if onflag then
		local b = (brightness_level > 6) and brightness_level or 6
		local brightened = "^[multiply:#"..string.rep(string.format("%x", b), 6)

		lighttex = {
			name="decor_plasma_storm.png"..brightened,
			animation={type="vertical_frames", aspect_w=48, aspect_h=48, length=2.0},
		}
	else
		lighttex = "decor_plasma_lamp_off.png"
	end

	decor.register("plasma_lamp_"..brightness_level, {
		description = S("Plasma Lamp/Light"),
		drawtype = "mesh",
		mesh = "plasma_lamp.obj",
		tiles = {
			"default_gold_block.png",
			lighttex
		},
		use_texture_alpha = "clip",
		light_source = brightness_level,
		sunlight_propagates = true,
		groups = {cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory = 1},
		sounds = default.node_sound_glass_defaults(),
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:plasma_lamp_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	local gl_cbox = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.45, 0.25 },
	}

	decor.register("ground_lantern_"..brightness_level, {
		description = S("Ground Lantern/Light"),
		mesh = "decor_ground_lantern.obj",
		tiles = { gen_ls_tex_yellow, "decor_generic_metal_wrought_iron.png" },
		use_texture_alpha = "clip",
		inventory_image = "decor_ground_lantern_inv.png",
		wield_image = "decor_ground_lantern_inv.png",
		groups = {snappy=3, not_in_creative_inventory = 1},
		light_source = brightness_level,
		selection_box = gl_cbox,
		walkable = false,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:ground_lantern_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	local hl_cbox = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.2, 0.25, 0.5, 0.5 },
	}

	decor.register("hanging_lantern_"..brightness_level, {
		description = S("Hanging Lantern/Light"),
		mesh = "decor_hanging_lantern.obj",
		tiles = { "decor_generic_metal_wrought_iron.png", gen_ls_tex_yellow },
		use_texture_alpha = "clip",
		inventory_image = "decor_hanging_lantern_inv.png",
		wield_image = "decor_hanging_lantern_inv.png",
		groups = {snappy=3, not_in_creative_inventory = 1},
		light_source = brightness_level,
		selection_box = hl_cbox,
		walkable = false,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:hanging_lantern_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	local cl_cbox = {
		type = "fixed",
		fixed = { -0.35, -0.45, -0.35, 0.35, 0.5, 0.35 }
	}

	decor.register("ceiling_lantern_"..brightness_level, {
		drawtype = "mesh",
		mesh = "decor_ceiling_lantern.obj",
		tiles = { gen_ls_tex_yellow, "decor_generic_metal_wrought_iron.png" },
		use_texture_alpha = "clip",
		inventory_image = "decor_ceiling_lantern_inv.png",
		description = S("Ceiling Lantern/Light"),
		groups = {snappy=3, not_in_creative_inventory = 1},
		light_source = brightness_level,
		selection_box = cl_cbox,
		walkable = false,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:ceiling_lantern_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

--	if not minetest.get_modpath("darkage") then
		decor.register("lattice_lantern_large_"..brightness_level, {
			description = S("Lattice lantern/Light (large)"),
			tiles = { gen_ls_tex_yellow.."^decor_lattice_lantern_large_overlay.png" },
			use_texture_alpha = "clip",
			groups = { snappy = 3, not_in_creative_inventory = 1 },
			light_source = brightness_level,
			sounds = default.node_sound_glass_defaults(),
			on_rightclick = decor_lighting.toggle_light,
			drop = {
				items = {
					{items = {"decor:lattice_lantern_large_on"}},
				}
			},
			mesecons = decor_lighting.mesecon_alldir_light,
			digiline = decor_lighting.digiline_alldir_light,
			on_punch = digiline_on_punch
		})
--	end

	local lighttex_tb
	local lighttex_sides

	if onflag then
		lighttex_tb =    "decor_lattice_lantern_small_tb_light.png"
		lighttex_sides = "decor_lattice_lantern_small_sides_light.png"
	else
		lighttex_tb =    "decor_generic_light_source_off.png"
		lighttex_sides = "decor_generic_light_source_off.png"
	end

	decor.register("lattice_lantern_small_"..brightness_level, {
		description = S("Lattice lantern/light (small)"),
		tiles = {
			lighttex_tb.."^decor_lattice_lantern_small_tb_overlay.png",
			lighttex_tb.."^decor_lattice_lantern_small_tb_overlay.png",
			lighttex_sides.."^decor_lattice_lantern_small_sides_overlay.png"
		},
		use_texture_alpha = "clip",
		selection_box = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
		},
		node_box = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
		},
		groups = { snappy = 3, not_in_creative_inventory = 1 },
		light_source = brightness_level,
		sounds = default.node_sound_glass_defaults(),
		on_place = minetest.rotate_node,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:lattice_lantern_small_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	-- "gooseneck" style desk lamps

	local dlamp_cbox = {
		type = "wallmounted",
		wall_side = { -0.2, -0.5, -0.15, 0.32, 0.12, 0.15 },
	}

	decor.register("desk_lamp_"..brightness_level, {
		description = S("Desk Lamp/Light"),
		mesh = "decor_desk_lamp.obj",
		tiles = {
			"decor_generic_metal.png",
			"decor_generic_metal.png",
			{ name = "decor_generic_metal.png", color = decor.color_med_grey },
			{ name = gen_ls_tex_white, color = brightness_hex },
		},
		use_texture_alpha = "clip",
		inventory_image = "decor_desk_lamp_inv.png",
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		selection_box = dlamp_cbox,
		node_box = dlamp_cbox,
		walkable = false,
		groups = {snappy=3, ud_param2_colorable = 1, not_in_creative_inventory = 1},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		end,
		on_dig = unifieddyes.on_dig,
		on_rotate = unifieddyes.fix_after_screwdriver_nsew,
		light_source = brightness_level,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:desk_lamp_on"}, inherit_color = true },
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	-- "kitchen"/"dining room" ceiling lamp

	decor.register("ceiling_lamp_"..brightness_level, {
		description = S("Ceiling Lamp/Light"),
		mesh = "decor_ceiling_lamp.obj",
		tiles = {
			"decor_generic_metal_brass.png",
			"decor_ceiling_lamp_glass.png",
			gen_ls_tex_white,
			{ name = "decor_generic_plastic.png", color = 0xff442d04 },
		},
		use_texture_alpha = "clip",
		inventory_image = "decor_ceiling_lamp_inv.png",
		light_source = brightness_level,
		groups = {snappy=3, not_in_creative_inventory = 1},
		walkable = false,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:ceiling_lamp_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	local tlamp_cbox = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 }
	}

	local slamp_cbox = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 1.5, 0.25 }
	}

	local wool_brightened = "wool_grey.png^[colorize:#ffffff:"..(brightness_level * 15)

	decor.register("table_lamp_"..brightness_level, {
		description = S("Table Lamp/Light"),
		mesh = "decor_table_lamp.obj",
		tiles = {
			wool_brightened,
			{ name = gen_ls_tex_white, color = brightness_hex },
			{ name = "decor_generic_wood_red.png", color = 0xffffffff },
			{ name = "decor_generic_metal.png", color = decor.color_black },
		},
		use_texture_alpha = "clip",
		inventory_image = "decor_table_lamp_foot_inv.png^decor_table_lamp_top_inv.png",
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette_extended.png",
		walkable = false,
		light_source = brightness_level,
		selection_box = tlamp_cbox,
		sounds = default.node_sound_wood_defaults(),
		groups = {cracky=2,oddly_breakable_by_hand=1, ud_param2_colorable = 1, not_in_creative_inventory=1 },
		drop = {
			items = {
				{items = {"decor:table_lamp_hi"}, inherit_color = true },
			}
		},
		digiline =      decor_lighting.digiline_alldir_light,
		mesecons =      decor_lighting.mesecon_wall_light,
		on_rightclick = decor_lighting.toggle_light,
		on_punch =      digiline_on_punch,
		on_dig = unifieddyes.on_dig,
	})

	decor.register("standing_lamp_"..brightness_level, {
		description = S("Standing Lamp/Light"),
		mesh = "decor_standing_lamp.obj",
		tiles = {
			wool_brightened,
			{ name = gen_ls_tex_white, color = brightness_hex },
			{ name = "decor_generic_wood_red.png", color = 0xffffffff },
			{ name = "decor_generic_metal.png", color = decor.color_black },
		},
		use_texture_alpha = "clip",
		inventory_image = "decor_standing_lamp_foot_inv.png^decor_standing_lamp_top_inv.png",
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette_extended.png",
		walkable = false,
		light_source = brightness_level,
		groups = {cracky=2,oddly_breakable_by_hand=1, ud_param2_colorable = 1, not_in_creative_inventory=1 },
		selection_box = slamp_cbox,
		sounds = default.node_sound_wood_defaults(),
		on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple or nil,
		--expand = { top="air" },
		drop = {
			items = {
				{items = {"decor:standing_lamp_hi"}, inherit_color = true },
			}
		},
		digiline =      decor_lighting.digiline_alldir_light,
		mesecons =      decor_lighting.mesecon_wall_light,
		on_rightclick = decor_lighting.toggle_light,
		on_punch =      digiline_on_punch,
		on_dig = unifieddyes.on_dig
	})
--------------------------------
if brightness_level == 14 then

	minetest.register_node(":decor:glowlight_half", {
		description = S("Thick Glowlight"),
		tiles = tiles,
		overlay_tiles = overlay,
		use_texture_alpha = "clip",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		selection_box = {
			type = "wallmounted",
			wall_top =    { -0.5,    0, -0.5, 0.5, 0.5, 0.5 },
			wall_bottom = { -0.5, -0.5, -0.5, 0.5,   0, 0.5 },
			wall_side =   { -0.5, -0.5, -0.5,   0, 0.5, 0.5 }
		},
		node_box = glowlight_nodebox.half,
		groups = { snappy = 3, ud_param2_colorable = 1, not_in_creative_inventory = nici },
		light_source = brightness_level,
		sounds = default.node_sound_glass_defaults(),
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		end,
		on_dig = unifieddyes.on_dig,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:glowlight_half_on"}, inherit_color = true },
			}
		},
		mesecons = decor_lighting.mesecon_wall_light,
		digiline = decor_lighting.digiline_wall_light,
		on_punch = digiline_on_punch
	})

	sides_edges = "decor_glowlight_thin_sides_edges.png"
	sides_glare = "decor_glowlight_thin_sides_glare.png"

	if onflag then
		tiles = {
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
		}
		overlay = {
			{ name = "decor_glowlight_top_glare.png", color = "white"},
			"",
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
		}
	else
		tiles = {
			base.."^"..tb_edges,
			base.."^"..tb_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
		}
		overlay = nil
	end

	minetest.register_node(":decor:glowlight_quarter", {
		description = S("Thin Glowlight"),
		tiles = tiles,
		overlay_tiles = overlay,
		use_texture_alpha = "clip",
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		selection_box = {
			type = "wallmounted",
			wall_top =    { -0.5, 0.25, -0.5,   0.5,   0.5, 0.5 },
			wall_bottom = { -0.5, -0.5, -0.5,   0.5, -0.25, 0.5 },
			wall_side =   { -0.5, -0.5, -0.5, -0.25,   0.5, 0.5 }
		},
		node_box = glowlight_nodebox.quarter,
		groups = { snappy = 3, ud_param2_colorable = 1, not_in_creative_inventory = nici },
		light_source = brightness_level,
		sounds = default.node_sound_glass_defaults(),
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		end,
		on_dig = unifieddyes.on_dig,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:glowlight_quarter_on"}, inherit_color = true },
			}
		},
		mesecons = decor_lighting.mesecon_wall_light,
		digiline = decor_lighting.digiline_wall_light,
		on_punch = digiline_on_punch
	})

	tb_edges =    "decor_glowlight_cube_tb_edges.png"
	sides_edges = "decor_glowlight_cube_sides_edges.png"
	sides_glare = "decor_glowlight_cube_sides_glare.png"

	if onflag then
		tiles = {
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..tb_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
			"("..base.."^"..sides_edges..")^[brighten",
		}
		overlay = {
			{ name = "decor_glowlight_cube_top_glare.png", color = "white"},
			"",
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
			{ name = sides_glare, color = "white"},
		}
	else
		tiles = {
			base.."^"..tb_edges,
			base.."^"..tb_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
			base.."^"..sides_edges,
		}
		overlay = nil
	end

	minetest.register_node(":decor:glowlight_small_cube", {
		description = S("Small Glowlight Cube"),
		tiles = tiles,
		overlay_tiles = overlay,
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		drawtype = "nodebox",
		palette = "unifieddyes_palette_colorwallmounted.png",
		selection_box = {
			type = "wallmounted",
			wall_top =    { -0.25,    0,  -0.25, 0.25,  0.5, 0.25 },
			wall_bottom = { -0.25, -0.5,  -0.25, 0.25,    0, 0.25 },
			wall_side =   {  -0.5, -0.25, -0.25,    0, 0.25, 0.25 }
		},
		node_box = glowlight_nodebox.small_cube,
		groups = { snappy = 3, ud_param2_colorable = 1, not_in_creative_inventory = nici },
		light_source = brightness_level,
		sounds = default.node_sound_glass_defaults(),
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		end,
		on_dig = unifieddyes.on_dig,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:glowlight_small_cube_on"}, inherit_color = true },
			}
		},
		mesecons = decor_lighting.mesecon_wall_light,
		digiline = decor_lighting.digiline_wall_light,
		on_punch = digiline_on_punch
	})

	local lighttex

	if onflag then
		local b = (brightness_level > 6) and brightness_level or 6
		local brightened = "^[multiply:#"..string.rep(string.format("%x", b), 6)

		lighttex = {
			name="decor_plasma_storm.png"..brightened,
			animation={type="vertical_frames", aspect_w=48, aspect_h=48, length=2.0},
		}
	else
		lighttex = "decor_plasma_lamp_off.png"
	end

	decor.register("plasma_lamp", {
		description = S("Plasma Lamp/Light"),
		drawtype = "mesh",
		mesh = "plasma_lamp.obj",
		tiles = {
			"default_gold_block.png",
			lighttex
		},
		use_texture_alpha = "clip",
		light_source = brightness_level,
		sunlight_propagates = true,
		groups = {cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory = nici},
		sounds = default.node_sound_glass_defaults(),
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:plasma_lamp_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	local gl_cbox = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.45, 0.25 },
	}

	decor.register("ground_lantern", {
		description = S("Ground Lantern/Light"),
		mesh = "decor_ground_lantern.obj",
		tiles = { gen_ls_tex_yellow, "decor_generic_metal_wrought_iron.png" },
		use_texture_alpha = "clip",
		inventory_image = "decor_ground_lantern_inv.png",
		wield_image = "decor_ground_lantern_inv.png",
		groups = {snappy=3, not_in_creative_inventory = nici},
		light_source = brightness_level,
		selection_box = gl_cbox,
		walkable = false,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:ground_lantern_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	local hl_cbox = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.2, 0.25, 0.5, 0.5 },
	}

	decor.register("hanging_lantern", {
		description = S("Hanging Lantern/Light"),
		mesh = "decor_hanging_lantern.obj",
		tiles = { "decor_generic_metal_wrought_iron.png", gen_ls_tex_yellow },
		use_texture_alpha = "clip",
		inventory_image = "decor_hanging_lantern_inv.png",
		wield_image = "decor_hanging_lantern_inv.png",
		groups = {snappy=3, not_in_creative_inventory = nici},
		light_source = brightness_level,
		selection_box = hl_cbox,
		walkable = false,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:hanging_lantern_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	local cl_cbox = {
		type = "fixed",
		fixed = { -0.35, -0.45, -0.35, 0.35, 0.5, 0.35 }
	}

	decor.register("ceiling_lantern", {
		drawtype = "mesh",
		mesh = "decor_ceiling_lantern.obj",
		tiles = { gen_ls_tex_yellow, "decor_generic_metal_wrought_iron.png" },
		use_texture_alpha = "clip",
		inventory_image = "decor_ceiling_lantern_inv.png",
		description = S("Ceiling Lantern/Light"),
		groups = {snappy=3, not_in_creative_inventory = nici},
		light_source = brightness_level,
		selection_box = cl_cbox,
		walkable = false,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:ceiling_lantern_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

--	if not minetest.get_modpath("darkage") then
		decor.register("lattice_lantern_large", {
			description = S("Lattice lantern/Light (large)"),
			tiles = { gen_ls_tex_yellow.."^decor_lattice_lantern_large_overlay.png" },
			groups = { snappy = 3, not_in_creative_inventory = nici },
			light_source = brightness_level,
			sounds = default.node_sound_glass_defaults(),
			on_rightclick = decor_lighting.toggle_light,
			drop = {
				items = {
					{items = {"decor:lattice_lantern_large_on"}},
				}
			},
			mesecons = decor_lighting.mesecon_alldir_light,
			digiline = decor_lighting.digiline_alldir_light,
			on_punch = digiline_on_punch
		})
--	end

	local lighttex_tb
	local lighttex_sides

	if onflag then
		lighttex_tb =    "decor_lattice_lantern_small_tb_light.png"
		lighttex_sides = "decor_lattice_lantern_small_sides_light.png"
	else
		lighttex_tb =    "decor_generic_light_source_off.png"
		lighttex_sides = "decor_generic_light_source_off.png"
	end

	decor.register("lattice_lantern_small", {
		description = S("Lattice lantern/light (small)"),
		tiles = {
			lighttex_tb.."^decor_lattice_lantern_small_tb_overlay.png",
			lighttex_tb.."^decor_lattice_lantern_small_tb_overlay.png",
			lighttex_sides.."^decor_lattice_lantern_small_sides_overlay.png"
		},
		selection_box = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
		},
		node_box = {
			type = "fixed",
			fixed = { -0.25, -0.5, -0.25, 0.25, 0, 0.25 }
		},
		groups = { snappy = 3, not_in_creative_inventory = nici },
		light_source = brightness_level,
		sounds = default.node_sound_glass_defaults(),
		on_place = minetest.rotate_node,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:lattice_lantern_small_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	-- "gooseneck" style desk lamps

	local dlamp_cbox = {
		type = "wallmounted",
		wall_side = { -0.2, -0.5, -0.15, 0.32, 0.12, 0.15 },
	}

	decor.register("desk_lamp", {
		description = S("Desk Lamp/Light"),
		mesh = "decor_desk_lamp.obj",
		tiles = {
			"decor_generic_metal.png",
			"decor_generic_metal.png",
			{ name = "decor_generic_metal.png", color = decor.color_med_grey },
			{ name = gen_ls_tex_white, color = brightness_hex },
		},
		inventory_image = "decor_desk_lamp_inv.png",
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		selection_box = dlamp_cbox,
		node_box = dlamp_cbox,
		walkable = false,
		groups = {snappy=3, ud_param2_colorable = 1, not_in_creative_inventory = nici},
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
		end,
		on_dig = unifieddyes.on_dig,
		on_rotate = unifieddyes.fix_after_screwdriver_nsew,
		light_source = brightness_level,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:desk_lamp_on"}, inherit_color = true },
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	-- "kitchen"/"dining room" ceiling lamp

	decor.register("ceiling_lamp", {
		description = S("Ceiling Lamp/Light"),
		mesh = "decor_ceiling_lamp.obj",
		tiles = {
			"decor_generic_metal_brass.png",
			"decor_ceiling_lamp_glass.png",
			gen_ls_tex_white,
			{ name = "decor_generic_plastic.png", color = 0xff442d04 },
		},
		inventory_image = "decor_ceiling_lamp_inv.png",
		light_source = brightness_level,
		groups = {snappy=3, not_in_creative_inventory = nici},
		walkable = false,
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:ceiling_lamp_on"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	local tlamp_cbox = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 0.5, 0.25 }
	}

	local slamp_cbox = {
		type = "fixed",
		fixed = { -0.25, -0.5, -0.25, 0.25, 1.5, 0.25 }
	}

	local wool_brightened = "wool_grey.png^[colorize:#ffffff:"..(brightness_level * 15)

	decor.register("table_lamp", {
		description = S("Table Lamp/Light"),
		mesh = "decor_table_lamp.obj",
		tiles = {
			wool_brightened,
			{ name = gen_ls_tex_white, color = brightness_hex },
			{ name = "decor_generic_wood_red.png", color = 0xffffffff },
			{ name = "decor_generic_metal.png", color = decor.color_black },
		},
		inventory_image = "decor_table_lamp_foot_inv.png^decor_table_lamp_top_inv.png",
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette_extended.png",
		walkable = false,
		light_source = brightness_level,
		selection_box = tlamp_cbox,
		sounds = default.node_sound_wood_defaults(),
		groups = {cracky=2,oddly_breakable_by_hand=1, ud_param2_colorable = 1, not_in_creative_inventory=nici },
		drop = {
			items = {
				{items = {"decor:table_lamp_hi"}, inherit_color = true },
			}
		},
		digiline =      decor_lighting.digiline_alldir_light,
		mesecons =      decor_lighting.mesecon_wall_light,
		on_rightclick = decor_lighting.toggle_light,
		on_punch =      digiline_on_punch,
		on_dig = unifieddyes.on_dig,
	})

	decor.register("standing_lamp", {
		description = S("Standing Lamp/Light"),
		mesh = "decor_standing_lamp.obj",
		tiles = {
			wool_brightened,
			{ name = gen_ls_tex_white, color = brightness_hex },
			{ name = "decor_generic_wood_red.png", color = 0xffffffff },
			{ name = "decor_generic_metal.png", color = decor.color_black },
		},
		inventory_image = "decor_standing_lamp_foot_inv.png^decor_standing_lamp_top_inv.png",
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette_extended.png",
		walkable = false,
		light_source = brightness_level,
		groups = {cracky=2,oddly_breakable_by_hand=1, ud_param2_colorable = 1, not_in_creative_inventory=nici },
		selection_box = slamp_cbox,
		sounds = default.node_sound_wood_defaults(),
		on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple or nil,
		--expand = { top="air" },
		drop = {
			items = {
				{items = {"decor:standing_lamp_hi"}, inherit_color = true },
			}
		},
		digiline =      decor_lighting.digiline_alldir_light,
		mesecons =      decor_lighting.mesecon_wall_light,
		on_rightclick = decor_lighting.toggle_light,
		on_punch =      digiline_on_punch,
		on_dig = unifieddyes.on_dig,
	})

end

--------------------------------

end

------------------------------------------
-- Simple non-dimmable, on/off-only lights

for _, light_brightn_name in ipairs({"off", "on"}) do

	local onflag = (light_brightn_name == "on")
	local nici = (light_brightn_name == "off") and 1 or nil
	local nici_m = (light_brightn_name == "off") and 1 or nil
	local on_rc = decor_lighting.toggle_light
	local di = "on"

	if hd_mesecons then
		nici_m = (light_brightn_name ~= "off") and 1 or nil
		on_rc = nil
		di = "off"
	end

	local gen_ls_tex_white =           "decor_generic_light_source_off.png"
	if onflag then gen_ls_tex_white =  "decor_generic_light_source_white.png" end

	local gen_ls_tex_yellow =          "decor_generic_light_source_off.png"
	if onflag then gen_ls_tex_yellow = "decor_generic_light_source_yellow.png" end

	local lighttex = "decor_blanktile.png"
	if onflag then
		lighttex = {
			name = "decor_plasma_ball_streamers.png",
			animation={type="vertical_frames", aspect_w=48, aspect_h=48, length=2.0},
		}
	end

	decor.register("plasma_ball_"..light_brightn_name, {
		description = S("Plasma Ball/light"),
		mesh = "decor_plasma_ball.obj",
		tiles = {
			{ name = "decor_generic_plastic.png", color = decor.color_black },
			lighttex,
			"decor_plasma_ball_glass.png"
		},
		inventory_image = "decor_plasma_ball_inv.png",
		selection_box = {
			type = "fixed",
			fixed = { -0.1875, -0.5, -0.1875, 0.1875, 0, 0.1875 }
		},
		walkable = false,
		use_texture_alpha = "clip",
		light_source = onflag and (default.LIGHT_MAX - 5) or nil,
		sunlight_propagates = true,
		groups = {cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory = nici},
		sounds = default.node_sound_glass_defaults(),
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:plasma_ball"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch,
		not_in_creative_inventory = true
	})

	local wl_cbox = {
		type = "fixed",
		fixed = { -0.2, -0.5, 0, 0.2, 0.5, 0.5 },
	}

	-- rope lighting has no craft recipe
--[[
	minetest.register_node(":decor:rope_light_on_floor_"..light_brightn_name, {
		description = S("Rope lighting (on floor)"),
		inventory_image =  "decor_rope_light_on_floor.png",
		paramtype = "light",
		light_source = word_to_bright[light_brightn_name],
		walkable = false,
		sunlight_propagates = true,
		tiles = { gen_ls_tex_white },
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {},
			connect_front = { -1/16, -8/16, -8/16, 1/16, -6/16, 1/16 },
			connect_left =  { -8/16, -8/16, -1/16, 1/16, -6/16, 1/16 },
			connect_back =  { -1/16, -8/16, -1/16, 1/16, -6/16, 8/16 },
			connect_right = { -1/16, -8/16, -1/16, 8/16, -6/16, 1/16 },
			disconnected_sides = {
				{ -6/16, -8/16, -6/16, -4/16, -6/16,  6/16 },
				{  4/16, -8/16, -6/16,  6/16, -6/16,  6/16 },
				{ -6/16, -8/16, -6/16,  6/16, -6/16, -4/16 },
				{ -6/16, -8/16,  4/16,  6/16, -6/16,  6/16 }
			},
		},
		connects_to = {
			"decor:rope_light_on_floor_on",
			"decor:rope_light_on_floor_off",
			"group:mesecon_conductor_craftable"
		},
		groups = {cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory = nici_m},
		sounds =  default.node_sound_stone_defaults(),
		drop = {
			items = {
				{items = {"decor:rope_light_on_floor_"..di} },
			}
		},
		on_rightclick = on_rc,
		mesecons = hd_mesecons and {
			conductor = {
				state = mesecon and (onflag and mesecon.state.on or mesecon.state.off),
				onstate =  "decor:rope_light_on_floor_on",
				offstate = "decor:rope_light_on_floor_off",
				rules = rules_alldir
			},
		} or nil,
		not_in_creative_inventory = true
	})

	minetest.register_node(":decor:rope_light_on_ceiling_"..light_brightn_name, {
		description = S("Rope lighting (on ceiling)"),
		inventory_image =  "decor_rope_light_on_ceiling.png",
		paramtype = "light",
		light_source = word_to_bright[light_brightn_name],
		walkable = false,
		sunlight_propagates = true,
		tiles = { gen_ls_tex_white },
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {},
			connect_front = { -1/16, 8/16, -8/16, 1/16, 6/16, 1/16 },
			connect_left =  { -8/16, 8/16, -1/16, 1/16, 6/16, 1/16 },
			connect_back =  { -1/16, 8/16, -1/16, 1/16, 6/16, 8/16 },
			connect_right = { -1/16, 8/16, -1/16, 8/16, 6/16, 1/16 },
			disconnected_sides = {
				{ -6/16, 8/16, -6/16, -4/16, 6/16,  6/16 },
				{  4/16, 8/16, -6/16,  6/16, 6/16,  6/16 },
				{ -6/16, 8/16, -6/16,  6/16, 6/16, -4/16 },
				{ -6/16, 8/16,  4/16,  6/16, 6/16,  6/16 }
			},
		},
		connects_to = {
			"decor:rope_light_on_ceiling_on",
			"decor:rope_light_on_ceiling_off",
			"group:mesecon_conductor_craftable"
		},
		groups = {cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory = nici_m},
		sounds =  default.node_sound_stone_defaults(),
		drop = {
			items = {
				{items = {"decor:rope_light_on_ceiling_"..di}},
			}
		},
		on_rightclick = on_rc,
		mesecons = hd_mesecons and {
			conductor = {
				state = mesecon and (onflag and mesecon.state.on or mesecon.state.off),
				onstate =  "decor:rope_light_on_ceiling_on",
				offstate = "decor:rope_light_on_ceiling_off",
				rules = rules_alldir
			},
		} or nil,
		not_in_creative_inventory = true
	})
--]]
	decor.register("wall_lamp_"..light_brightn_name, {
		description = S("Wall Lamp/light"),
		mesh = "decor_wall_lamp.obj",
		tiles = {
			{ name = "decor_generic_metal.png", color = decor.color_med_grey },
			decor.lux_wood,
			gen_ls_tex_yellow,
			"decor_generic_metal_wrought_iron.png"
		},
		use_texture_alpha = "clip",
		inventory_image = "decor_wall_lamp_inv.png",
		groups = {snappy=3, not_in_creative_inventory = nici},
		light_source = onflag and (default.LIGHT_MAX - 3) or nil,
		selection_box = wl_cbox,
		walkable = false,
		drop = {
			items = {
				{items = {"decor:wall_lamp"}},
			}
		},
		on_rightclick = decor_lighting.toggle_light,
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch,
		not_in_creative_inventory = true
	})
------------------------------------
	if light_brightn_name == "on" then
	
	local onflag = (light_brightn_name == "on")
	local nici = (light_brightn_name == "off") and 1 or nil
	local nici_m = (light_brightn_name == "off") and 1 or nil
	local on_rc = decor_lighting.toggle_light
	local di = "on"

	if hd_mesecons then
		nici_m = (light_brightn_name ~= "off") and 1 or nil
		on_rc = nil
		di = "off"
	end

	local gen_ls_tex_white =           "decor_generic_light_source_off.png"
	if onflag then gen_ls_tex_white =  "decor_generic_light_source_white.png" end

	local gen_ls_tex_yellow =          "decor_generic_light_source_off.png"
	if onflag then gen_ls_tex_yellow = "decor_generic_light_source_yellow.png" end

	local lighttex = "decor_blanktile.png"
	if onflag then
		lighttex = {
			name = "decor_plasma_ball_streamers.png",
			animation={type="vertical_frames", aspect_w=48, aspect_h=48, length=2.0},
		}
	end

	decor.register("plasma_ball", {
		description = S("Plasma Ball/light"),
		mesh = "decor_plasma_ball.obj",
		tiles = {
			{ name = "decor_generic_plastic.png", color = decor.color_black },
			lighttex,
			"decor_plasma_ball_glass.png"
		},
		inventory_image = "decor_plasma_ball_inv.png",
		selection_box = {
			type = "fixed",
			fixed = { -0.1875, -0.5, -0.1875, 0.1875, 0, 0.1875 }
		},
		walkable = false,
		use_texture_alpha = "clip",
		light_source = onflag and (default.LIGHT_MAX - 5) or nil,
		sunlight_propagates = true,
		groups = {cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory = nici},
		sounds = default.node_sound_glass_defaults(),
		on_rightclick = decor_lighting.toggle_light,
		drop = {
			items = {
				{items = {"decor:plasma_ball"}},
			}
		},
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})

	local wl_cbox = {
		type = "fixed",
		fixed = { -0.2, -0.5, 0, 0.2, 0.5, 0.5 },
	}

	-- rope lighting has no craft recipe
--[[
	minetest.register_node(":decor:rope_light_on_floor", {
		description = S("Rope lighting (on floor)"),
		inventory_image =  "decor_rope_light_on_floor.png",
		paramtype = "light",
		light_source = word_to_bright[light_brightn_name],
		walkable = false,
		sunlight_propagates = true,
		tiles = { gen_ls_tex_white },
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {},
			connect_front = { -1/16, -8/16, -8/16, 1/16, -6/16, 1/16 },
			connect_left =  { -8/16, -8/16, -1/16, 1/16, -6/16, 1/16 },
			connect_back =  { -1/16, -8/16, -1/16, 1/16, -6/16, 8/16 },
			connect_right = { -1/16, -8/16, -1/16, 8/16, -6/16, 1/16 },
			disconnected_sides = {
				{ -6/16, -8/16, -6/16, -4/16, -6/16,  6/16 },
				{  4/16, -8/16, -6/16,  6/16, -6/16,  6/16 },
				{ -6/16, -8/16, -6/16,  6/16, -6/16, -4/16 },
				{ -6/16, -8/16,  4/16,  6/16, -6/16,  6/16 }
			},
		},
		connects_to = {
			"decor:rope_light_on_floor_on",
			"decor:rope_light_on_floor_off",
			"group:mesecon_conductor_craftable"
		},
		groups = {cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory = nici_m},
		sounds =  default.node_sound_stone_defaults(),
		drop = {
			items = {
				{items = {"decor:rope_light_on_floor_"..di} },
			}
		},
		on_rightclick = on_rc,
		mesecons = hd_mesecons and {
			conductor = {
				state = mesecon and (onflag and mesecon.state.on or mesecon.state.off),
				onstate =  "decor:rope_light_on_floor_on",
				offstate = "decor:rope_light_on_floor_off",
				rules = rules_alldir
			},
		} or nil,
	})

	minetest.register_node(":decor:rope_light_on_ceiling", {
		description = S("Rope lighting (on ceiling)"),
		inventory_image =  "decor_rope_light_on_ceiling.png",
		paramtype = "light",
		light_source = word_to_bright[light_brightn_name],
		walkable = false,
		sunlight_propagates = true,
		tiles = { gen_ls_tex_white },
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {},
			connect_front = { -1/16, 8/16, -8/16, 1/16, 6/16, 1/16 },
			connect_left =  { -8/16, 8/16, -1/16, 1/16, 6/16, 1/16 },
			connect_back =  { -1/16, 8/16, -1/16, 1/16, 6/16, 8/16 },
			connect_right = { -1/16, 8/16, -1/16, 8/16, 6/16, 1/16 },
			disconnected_sides = {
				{ -6/16, 8/16, -6/16, -4/16, 6/16,  6/16 },
				{  4/16, 8/16, -6/16,  6/16, 6/16,  6/16 },
				{ -6/16, 8/16, -6/16,  6/16, 6/16, -4/16 },
				{ -6/16, 8/16,  4/16,  6/16, 6/16,  6/16 }
			},
		},
		connects_to = {
			"decor:rope_light_on_ceiling_on",
			"decor:rope_light_on_ceiling_off",
			"group:mesecon_conductor_craftable"
		},
		groups = {cracky=3, oddly_breakable_by_hand=3, not_in_creative_inventory = nici_m},
		sounds =  default.node_sound_stone_defaults(),
		drop = {
			items = {
				{items = {"decor:rope_light_on_ceiling_"..di}},
			}
		},
		on_rightclick = on_rc,
		mesecons = hd_mesecons and {
			conductor = {
				state = mesecon and (onflag and mesecon.state.on or mesecon.state.off),
				onstate =  "decor:rope_light_on_ceiling_on",
				offstate = "decor:rope_light_on_ceiling_off",
				rules = rules_alldir
			},
		} or nil,
	})
--]]
	decor.register("wall_lamp", {
		description = S("Wall Lamp/light"),
		mesh = "decor_wall_lamp.obj",
		tiles = {
			{ name = "decor_generic_metal.png", color = decor.color_med_grey },
			decor.lux_wood,
			gen_ls_tex_yellow,
			"decor_generic_metal_wrought_iron.png"
		},
		use_texture_alpha = "clip",
		inventory_image = "decor_wall_lamp_inv.png",
		groups = {snappy=3, not_in_creative_inventory = nici},
		light_source = onflag and (default.LIGHT_MAX - 3) or nil,
		selection_box = wl_cbox,
		walkable = false,
		drop = {
			items = {
				{items = {"decor:wall_lamp"}},
			}
		},
		on_rightclick = decor_lighting.toggle_light,
		mesecons = decor_lighting.mesecon_alldir_light,
		digiline = decor_lighting.digiline_alldir_light,
		on_punch = digiline_on_punch
	})
end
--------------------------------------
end

-------------------------------------------------------
-- Light sources and other items that don't turn on/off

local tc_cbox = {
	type = "fixed",
	fixed = {
		{ -0.1875, -0.5, -0.1875, 0.1875, 0.375, 0.1875 },
	}
}

decor.register("candle", {
	description = S("Thick Candle"),
	mesh = "decor_candle_thick.obj",
	tiles = {
		'decor_candle_sides.png',
		{name="decor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
	},
	use_texture_alpha = "clip",
	inventory_image = "decor_candle_inv.png",
	selection_box = tc_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

local c_cbox = {
	type = "fixed",
	fixed = {
		{ -0.125, -0.5, -0.125, 0.125, 0.05, 0.125 },
	}
}

decor.register("candle_thin", {
	description = S("Thin Candle"),
	mesh = "decor_candle_thin.obj",
	tiles = {
		'decor_candle_sides.png',
		{name="decor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
	},
	use_texture_alpha = "clip",
	inventory_image = "decor_candle_thin_inv.png",
	selection_box = c_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

local cs_cbox = {
	type = "fixed",
	fixed = {
		{ -0.15625, -0.5, -0.15625, 0.15625, 0.3125, 0.15625 },
	}
}

decor.register("candlestick_wrought_iron", {
	description = S("Candlestick (wrought iron)"),
	mesh = "decor_candlestick.obj",
	tiles = {
		"decor_candle_sides.png",
		{name="decor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		"decor_generic_metal_wrought_iron.png",
	},
	use_texture_alpha = "clip",
	inventory_image = "decor_candlestick_wrought_iron_inv.png",
	selection_box = cs_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

decor.register("candlestick_brass", {
	description = S("Candlestick (brass)"),
	mesh = "decor_candlestick.obj",
	tiles = {
		"decor_candle_sides.png",
		{name="decor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		"decor_generic_metal_brass.png",
	},
	use_texture_alpha = "clip",
	inventory_image = "decor_candlestick_brass_inv.png",
	selection_box = cs_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

decor.register("wall_sconce", {
	description = S("Wall sconce"),
	mesh = "decor_wall_sconce.obj",
	tiles = {
		'decor_candle_sides.png',
		{name="decor_candle_flame.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		'decor_wall_sconce_back.png',
		'decor_generic_metal_wrought_iron.png',
	},
	use_texture_alpha = "clip",
	inventory_image = "decor_wall_sconce_inv.png",
	selection_box = {
		type = "fixed",
		fixed = { -0.1875, -0.25, 0.3125, 0.1875, 0.25, 0.5 }
	},
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-4,
})

local ol_cbox = {
	type = "fixed",
	fixed = {
		{ -5/16, -8/16, -3/16, 5/16, 4/16, 3/16 },
	}
}

decor.register("oil_lamp", {
	description = S("Oil lamp/Light (hurricane)"),
	mesh = "decor_oil_lamp.obj",
	tiles = {
		"decor_generic_metal_brass.png",
		{ name = "decor_generic_metal.png", color = decor.color_black },
		{ name = "decor_generic_metal.png", color = 0xffa00000 },
		"decor_oil_lamp_wick.png",
		{ name = "decor_generic_metal.png", color = 0xffa00000 },
		"decor_oil_lamp_glass.png",
	},
	use_texture_alpha = "clip",
	inventory_image = "decor_oil_lamp_inv.png",
	selection_box = ol_cbox,
	walkable = false,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-3,
	sounds = default.node_sound_glass_defaults(),
})

decor.register("oil_lamp_tabletop", {
	description = S("Oil Lamp/Light (tabletop)"),
	mesh = "decor_oil_lamp_tabletop.obj",
	tiles = {"decor_oil_lamp_tabletop.png"},
	use_texture_alpha = "clip",
	inventory_image = "decor_oil_lamp_tabletop_inv.png",
	selection_box = ol_cbox,
	collision_box = ol_cbox,
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-3,
	sounds = default.node_sound_glass_defaults(),
})

local topchains_sbox = {
	type = "fixed",
	fixed = {
		{ -0.25, 0.35, -0.25, 0.25, 0.5, 0.25 },
		{ -0.1, -0.5, -0.1, 0.1, 0.4, 0.1 }
	}
}

minetest.register_node(":decor:chain_steel_top", {
	description = S("Hanging chain (ceiling mount, steel)"),
	drawtype = "mesh",
	mesh = "decor_chains_top.obj",
	tiles = {"decor_chain_steel.png"},
	use_texture_alpha = "clip",
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "decor_chain_steel_inv.png",
	groups = {cracky=3},
	selection_box = topchains_sbox,
})

minetest.register_node(":decor:chain_brass_top", {
	description = S("Hanging chain (ceiling mount, brass)"),
	drawtype = "mesh",
	mesh = "decor_chains_top.obj",
	tiles = {"decor_chain_brass.png"},
	use_texture_alpha = "clip",
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "decor_chain_brass_inv.png",
	groups = {cracky=3},
	selection_box = topchains_sbox,
})

minetest.register_node(":decor:chandelier_steel", {
	description = S("Chandelier (steel)"),
	paramtype = "light",
	light_source = 12,
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	tiles = {
		"decor_chain_steel.png",
		"decor_candle_flat.png",
		{
			name="decor_candle_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0
			}
		}
	},
	use_texture_alpha = "clip",
	drawtype = "mesh",
	mesh = "decor_chandelier.obj",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

minetest.register_node(":decor:chandelier_brass", {
	description = S("Chandelier (brass)"),
	paramtype = "light",
	light_source = 12,
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	tiles = {
		"decor_chain_brass.png",
		"decor_candle_flat.png",
		{
			name="decor_candle_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=16,
				aspect_h=16,
				length=3.0
			}
		}
	},
	use_texture_alpha = "clip",
	drawtype = "mesh",
	mesh = "decor_chandelier.obj",
	groups = {cracky=3},
	sounds =  default.node_sound_stone_defaults(),
})

decor.register("torch_wall", {
	description = S("Wall Torch"),
	mesh = "forniture_torch.obj",
	tiles = {
		{
			name="forniture_torch_flame.png",
			animation={
				type="vertical_frames",
				aspect_w=40,
				aspect_h=40,
				length=1.0,
			},
		},
		{ name = "decor_generic_metal.png", color = decor.color_black },
		{ name = "decor_generic_metal.png", color = decor.color_med_grey },
		"forniture_coal.png",
	},
	use_texture_alpha = "clip",
	inventory_image="forniture_torch_inv.png",
	walkable = false,
	light_source = 14,
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.45, 0.15, 0.15,0.35, 0.5 },
	},
	groups = {cracky=3},
})

-- table lamps and standing lamps

local lamp_colors = {
	"white",
	"blue",
	"green",
	"pink",
	"red",
	"violet",
}

-- conversion LBM for param2 coloring

decor_lighting.old_static_nodes = {
	"decor:glowlight_quarter_white",
	"decor:glowlight_quarter_yellow",
	"decor:glowlight_half_white",
	"decor:glowlight_half_yellow",
	"decor:glowlight_small_cube_white",
	"decor:glowlight_small_cube_yellow"
}

local lamp_power = {"off", "low", "med", "hi", "max"}

for _, power in ipairs(lamp_power) do
	for _, color in ipairs(lamp_colors) do
		table.insert(decor_lighting.old_static_nodes, "decor:table_lamp_"..color.."_"..power)
		table.insert(decor_lighting.old_static_nodes, "decor:standing_lamp_"..color.."_"..power)
	end
end

minetest.register_lbm({
	name = ":decor:convert_lighting",
	label = "Convert decor glowlights, table lamps, and standing lamps to use param2 color",
	run_at_every_load = false,
	nodenames = decor_lighting.old_static_nodes,
	action = function(pos, node)
		local name = node.name
		local newname
		local color

		if string.find(name, "small_cube") then
			newname = "decor:glowlight_small_cube"
		elseif string.find(name, "glowlight_half") then
			newname = "decor:glowlight_half"
		elseif string.find(name, "glowlight_quarter") then
			newname = "decor:glowlight_quarter"
		end

		local lampname
		if string.find(name, "standing_lamp") then
			lampname = "decor:standing_lamp"
		elseif string.find(name, "table_lamp") then
			lampname = "decor:table_lamp"
		end
		if lampname then
			newname = lampname
			if string.find(name, "_off") then
				newname = newname.."_off"
			elseif string.find(name, "_low") then
				newname = newname.."_low"
			elseif string.find(name, "_med") then
				newname = newname.."_med"
			elseif string.find(name, "_hi") then
				newname = newname.."_hi"
			elseif string.find(name, "_max") then
				newname = newname.."_max"
			end
		end

		if string.find(name, "red") then
			color = "red"
		elseif string.find(name, "pink") then
			color = "pink"
		elseif string.find(name, "green") then
			color = "green"
		elseif string.find(name, "blue") then
			color = "blue"
		elseif string.find(name, "yellow") then
			color = "yellow"
		elseif string.find(name, "violet") then
			color = "violet"
		else
			color = "white"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "extended")

		local old_fdir
		local new_node = newname
		local new_fdir = 1
		local param2

		if string.find(name, "glowlight") then
			paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")

			old_fdir = math.floor(node.param2 / 4)

			if old_fdir == 5 then
				new_fdir = 0
			elseif old_fdir == 1 then
				new_fdir = 5
			elseif old_fdir == 2 then
				new_fdir = 4
			elseif old_fdir == 3 then
				new_fdir = 3
			elseif old_fdir == 4 then
				new_fdir = 2
			elseif old_fdir == 0 then
				new_fdir = 1
			end
			param2 = paletteidx + new_fdir
		else
			param2 = paletteidx
		end

		local meta = minetest.get_meta(pos)

		if string.find(name, "table_lamp") or string.find(name, "standing_lamp") then
			meta:set_string("palette", "ext")
		end

		minetest.set_node(pos, { name = new_node, param2 = param2 })
		meta:set_string("dye", "unifieddyes:"..color)
	end
})

-- this one's for the small "gooseneck" desk lamps

decor_lighting.old_static_desk_lamps = {
	"decor:desk_lamp_red",
	"decor:desk_lamp_blue",
	"decor:desk_lamp_green",
	"decor:desk_lamp_violet",
}

minetest.register_lbm({
	name = ":decor:convert_desk_lamps",
	label = "Convert decor desk lamps to use param2 color",
	run_at_every_load = false,
	nodenames = decor_lighting.old_static_desk_lamps,
	action = function(pos, node)
		local name = node.name
		local color = string.sub(name, string.find(name, "_", -8) + 1)

		if color == "green" then
			color = "medium_green"
		elseif color == "violet" then
			color = "magenta"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")
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

		local param2 = paletteidx + new_fdir

		minetest.set_node(pos, { name = "decor:desk_lamp", param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
	end
})



-- crafting

minetest.register_craft({
	output = 'decor:chain_steel_top',
	recipe = {
		{'default:steel_ingot'},
		{'decor:chainlink_steel'},
	},
})

minetest.register_craft({
	output = 'decor:chandelier_steel',
	recipe = {
		{'', 'decor:chainlink_steel', ''},
		{'default:torch', 'decor:chainlink_steel', 'default:torch'},
		{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
	}
})

-- brass versions

minetest.register_craft({
	output = 'decor:chain_brass_top',
	recipe = {
		{'technic:brass_ingot'},
		{'decor:chainlink_brass'},
	},
})

minetest.register_craft({
	output = 'decor:chandelier_brass',
	recipe = {
		{'', 'decor:chainlink_brass', ''},
		{'default:torch', 'decor:chainlink_brass', 'default:torch'},
		{'technic:brass_ingot', 'technic:brass_ingot', 'technic:brass_ingot'},
	}
})

-- candles

minetest.register_craft({
	output = "decor:candle_thin 4",
	recipe = {
		{"farming:string" },
		{"default:paraffin" }
	}
})

minetest.register_craft({
	output = "decor:candle 2",
	recipe = {
		{"farming:string" },
		{"default:paraffin" },
		{"default:paraffin" }
	}
})

minetest.register_craft({
	output = "decor:wall_sconce 2",
	recipe = {
		{"default:iron_lump", "", ""},
		{"default:iron_lump", "decor:candle", ""},
		{"default:iron_lump", "", ""},
	}
})

minetest.register_craft({
	output = "decor:candlestick_wrought_iron",
	recipe = {
		{""},
		{"decor:candle_thin"},
		{"default:iron_lump"},
	}
})

minetest.register_craft({
	output = "decor:candlestick_brass",
	recipe = {
		{""},
		{"decor:candle_thin"},
		{"technic:brass_ingot"},
	}
})

minetest.register_craft({
	output = "decor:oil_lamp",
	recipe = {
		{ "", "vessels:glass_bottle", "" },
		{ "", "farming:string", "" },
		{ "default:steel_ingot", "default:oil_extract", "default:steel_ingot" }
	}
})

minetest.register_craft({
	output = "decor:oil_lamp_tabletop",
	recipe = {
		{ "", "vessels:glass_bottle", "" },
		{ "", "farming:string", "" },
		{ "default:iron_lump", "default:oil_extract", "default:iron_lump" }
	}
})

-- Wrought-iron wall latern

minetest.register_craft({
	output = "decor:ground_lantern",
	recipe = {
		{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
		{ "default:iron_lump", "default:torch", "default:iron_lump" },
		{ "", "default:iron_lump", "" }
	}
})

-- wood-lattice lamps
--[[
if minetest.get_modpath("darkage") then
	minetest.register_craft( {
		output = "decor:lattice_lantern_small 8",
		recipe = {
			{ "darkage:lamp" },
		},
	})

	minetest.register_craft( {
		output = "darkage:lamp",
		type = "shapeless",
		recipe = {
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
		},
	})
else
--]]
	minetest.register_craft( {
			output = "decor:lattice_lantern_large 2",
			recipe = {
				{ "dye:black", "dye:yellow", "dye:black" },
				{ "group:stick", "building_blocks:woodglass", "group:stick" },
				{ "group:stick", "default:mese_crystal", "group:stick" }
			},
	})

	minetest.register_craft( {
		output = "decor:lattice_lantern_small 8",
		recipe = {
			{ "decor:lattice_lantern_large" },
		},
	})

	minetest.register_craft( {
		output = "decor:lattice_lantern_large",
		type = "shapeless",
		recipe = {
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
			"decor:lattice_lantern_small",
		},
	})
--end

-- glowlights

minetest.register_craft({
	output = "decor:glowlight_half 6",
	recipe = {
		{ "default:glass", "default:mese_crystal", "default:glass", },
	}
})

minetest.register_craft({
        output = "decor:glowlight_half 6",
        recipe = {
		{"moreblocks:super_glow_glass", "moreblocks:glow_glass", "moreblocks:super_glow_glass", },
	}
})

minetest.register_craft({
        output = "decor:glowlight_half",
        recipe = {
		{"decor:glowlight_small_cube","decor:glowlight_small_cube"},
		{"decor:glowlight_small_cube","decor:glowlight_small_cube"}
	}
})

minetest.register_craft({
		output = "decor:glowlight_half",
		type = "shapeless",
		recipe = {
		"decor:glowlight_quarter",
		"decor:glowlight_quarter"
	}
})

unifieddyes.register_color_craft({
	output = "decor:glowlight_half",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "decor:glowlight_half",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
        output = "decor:glowlight_quarter 6",
        recipe = {
		{"decor:glowlight_half", "decor:glowlight_half", "decor:glowlight_half", },
	}
})

unifieddyes.register_color_craft({
	output = "decor:glowlight_quarter",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "decor:glowlight_quarter",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
	output = "decor:glowlight_small_cube 8",
	recipe = {
		{ "dye:white" },
		{ "default:glass" },
		{ "default:mese_crystal" },
	}
})

minetest.register_craft({
        output = "decor:glowlight_small_cube 8",
        recipe = {
		{"dye:white" },
		{"moreblocks:super_glow_glass" },
	}
})

minetest.register_craft({
        output = "decor:glowlight_small_cube 4",
        recipe = {
		{"decor:glowlight_half" },
	}
})

unifieddyes.register_color_craft({
	output = "decor:glowlight_small_cube",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "decor:glowlight_small_cube",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

----

minetest.register_craft({
    output = "decor:plasma_lamp",
    recipe = {
		{"", "default:glass", ""},
		{"default:glass", "default:mese_crystal", "default:glass"},
		{"", "default:glass", ""}
	}
})

minetest.register_craft({
    output = "decor:plasma_ball 2",
    recipe = {
		{"", "default:glass", ""},
		{"default:glass", "default:copper_ingot", "default:glass"},
		{"default:plastic_sheet", "default:mese_crystal", "default:plastic_sheet"}
	}
})


minetest.register_craft({
	output = "decor:desk_lamp 2",
	recipe = {
		{ "", "default:steel_ingot", "decor:glowlight_small_cube" },
		{ "", "decor:steel_strip", "" },
		{ "default:plastic_sheet", "technic:fine_copper_wire", "default:plastic_sheet" },
	},
})

unifieddyes.register_color_craft({
	output = "decor:desk_lamp",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "decor:desk_lamp",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
	output = "decor:hanging_lantern 2",
	recipe = {
		{ "default:iron_lump", "default:iron_lump", "" },
		{ "default:iron_lump", "decor:lattice_lantern_large", "" },
		{ "default:iron_lump", "", "" },
	},
})

minetest.register_craft({
	output = "decor:ceiling_lantern 2",
	recipe = {
		{ "default:iron_lump", "default:iron_lump", "default:iron_lump" },
		{ "default:iron_lump", "decor:lattice_lantern_large", "default:iron_lump" },
		{ "", "default:iron_lump", "" },
	},
})

minetest.register_craft({
	output = "decor:wall_lamp 2",
	recipe = {
		{ "", "decor:lattice_lantern_large", "" },
		{ "default:iron_lump", "group:stick", "" },
		{ "default:iron_lump", "group:stick", "" },
	},
})

minetest.register_craft({
	output = "decor:ceiling_lamp",
	recipe = {
		{ "", "technic:brass_ingot", ""},
		{ "", "decor:chainlink_brass", ""},
		{ "default:glass", "decor:glowlight_small_cube", "default:glass"}
	},
})

minetest.register_craft({
	output = "decor:ceiling_lamp",
	recipe = {
		{ "", "decor:chain_steel_top_brass", ""},
		{ "default:glass", "decor:glowlight_small_cube", "default:glass"}
	},
})

minetest.register_craft({
	output = "decor:standing_lamp",
	recipe = {
		{"decor:table_lamp"},
		{"group:stick"},
		{"group:stick"},
	},
})

unifieddyes.register_color_craft({
	output = "decor:standing_lamp",
	palette = "extended",
	type = "shapeless",
	neutral_node = "decor:standing_lamp_hi",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:table_lamp",
	burntime = 10,
})

minetest.register_craft({
	output = "decor:table_lamp",
	recipe = {
		{ "wool:white", "default:torch", "wool:white"},
		{ "", "group:stick", ""},
		{ "", "stairs:slab_wood", "" },
	},
})

unifieddyes.register_color_craft({
	output = "decor:table_lamp_hi",
	palette = "extended",
	type = "shapeless",
	neutral_node = "decor:table_lamp_hi",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

minetest.register_craft({
	output = "decor:torch_wall 10",
	recipe = {
		{ "default:coal_lump" },
		{ "default:steel_ingot" },
	},
})
-- aliases
--[[
minetest.register_alias("chains:chain_top",                    "decor:chain_steel_top")
minetest.register_alias("chains:chain_top_brass",              "decor:chain_brass_top")

minetest.register_alias("chains:chandelier",                   "decor:chandelier_steel")
minetest.register_alias("chains:chandelier_steel",             "decor:chandelier_steel")
minetest.register_alias("chains:chandelier_brass",             "decor:chandelier_brass")

minetest.register_alias("decor:glowlight_half",            "decor:glowlight_half_14")
--minetest.register_alias("decor:glowlight_half_max",        "decor:glowlight_half_14")

minetest.register_alias("decor:glowlight_quarter",         "decor:glowlight_quarter_14")
--minetest.register_alias("decor:glowlight_quarter_max",     "decor:glowlight_quarter_14")

minetest.register_alias("decor:glowlight_small_cube",      "decor:glowlight_small_cube_14")
--minetest.register_alias("decor:glowlight_small_cube_max",  "decor:glowlight_small_cube_14")

minetest.register_alias("decor:plasma_lamp",               "decor:plasma_lamp_14")
--minetest.register_alias("decor:plasma_lamp_max",           "decor:plasma_lamp_14")

minetest.register_alias("decor:ground_lantern",            "decor:ground_lantern_14")
--minetest.register_alias("decor:ground_lantern_max",        "decor:ground_lantern_14")

minetest.register_alias("decor:hanging_lantern",           "decor:hanging_lantern_14")
--minetest.register_alias("decor:hanging_lantern_max",       "decor:hanging_lantern_14")

minetest.register_alias("decor:ceiling_lantern",           "decor:ceiling_lantern_14")
--minetest.register_alias("decor:ceiling_lantern_max",       "decor:ceiling_lantern_14")

minetest.register_alias("decor:lattice_lantern_large",     "decor:lattice_lantern_large_14")
minetest.register_alias("decor:lattice_lantern_large_max", "decor:lattice_lantern_large_14")

minetest.register_alias("decor:lattice_lantern_small",     "decor:lattice_lantern_small_14")
--minetest.register_alias("decor:lattice_lantern_small_max", "decor:lattice_lantern_small_14")

minetest.register_alias("decor:desk_lamp",                 "decor:desk_lamp_14")
--minetest.register_alias("decor:desk_lamp_max",             "decor:desk_lamp_14")

minetest.register_alias("decor:ceiling_lamp",              "decor:ceiling_lamp_14")
--minetest.register_alias("decor:ceiling_lamp_max",          "decor:ceiling_lamp_14")

minetest.register_alias("decor:table_lamp",                "decor:table_lamp_14")
--minetest.register_alias("decor:table_lamp_max",            "decor:table_lamp_14")

minetest.register_alias("decor:standing_lamp",             "decor:standing_lamp_14")
--minetest.register_alias("decor:standing_lamp_max",         "decor:standing_lamp_14")

minetest.register_alias("3dforniture:table_lamp",              "decor:table_lamp_14")
--minetest.register_alias("3dforniture:table_lamp_max",          "decor:table_lamp_14")

minetest.register_alias("3dforniture:torch_wall",              "decor:torch_wall")
minetest.register_alias("torch_wall",                          "decor:torch_wall")

minetest.register_alias("decor:plasma_ball",               "decor:plasma_ball_on")
minetest.register_alias("decor:wall_lamp",                 "decor:wall_lamp_on")

--minetest.register_alias("decor:rope_light_on_floor_0",     "decor:rope_light_on_floor_off")
--minetest.register_alias("decor:rope_light_on_floor_14",    "decor:rope_light_on_floor_on")

--minetest.register_alias("decor:rope_light_on_ceiling_0",   "decor:rope_light_on_ceiling_off")
--minetest.register_alias("decor:rope_light_on_ceiling_14",  "decor:rope_light_on_ceiling_on")

for name, level in pairs(word_to_bright) do
	minetest.register_alias("decor:glowlight_half_"..name,        "decor:glowlight_half_"..level)
	minetest.register_alias("decor:glowlight_quarter_"..name,     "decor:glowlight_quarter_"..level)
	minetest.register_alias("decor:glowlight_small_cube_"..name,  "decor:glowlight_small_cube_"..level)
--	minetest.register_alias("decor:rope_light_on_floor_"..name,   "decor:rope_light_on_floor_"..level)
--	minetest.register_alias("decor:rope_light_on_ceiling_"..name, "decor:rope_light_on_ceiling_"..level)
	minetest.register_alias("decor:plasma_lamp_"..name,           "decor:plasma_lamp_"..level)
	minetest.register_alias("decor:plasma_ball_"..name,           "decor:plasma_ball_"..level)
	minetest.register_alias("decor:ground_lantern_"..name,        "decor:ground_lantern_"..level)
	minetest.register_alias("decor:hanging_lantern_"..name,       "decor:hanging_lantern_"..level)
	minetest.register_alias("decor:ceiling_lantern_"..name,       "decor:ceiling_lantern_"..level)
	minetest.register_alias("decor:lattice_lantern_large_"..name, "decor:lattice_lantern_large_"..level)
	minetest.register_alias("decor:lattice_lantern_small_"..name, "decor:lattice_lantern_small_"..level)
	minetest.register_alias("decor:desk_lamp_"..name,             "decor:desk_lamp_"..level)
	minetest.register_alias("decor:ceiling_lamp_"..name,          "decor:ceiling_lamp_"..level)
	minetest.register_alias("decor:table_lamp_"..name,            "decor:table_lamp_"..level)
	minetest.register_alias("decor:standing_lamp_"..name,         "decor:standing_lamp_"..level)
	minetest.register_alias("3dforniture:table_lamp_"..name,          "decor:table_lamp_"..level)
end

if minetest.get_modpath("darkage") then
	minetest.register_alias("decor:lattice_lantern_large",        "darkage:lamp")
	for n = 0, 14 do
		minetest.register_alias("decor:lattice_lantern_large_"..n, "darkage:lamp")
	end
	for name, level in pairs(word_to_bright) do
		minetest.register_alias("decor:lattice_lantern_large_"..name, "darkage:lamp")
	end
end
--]]
