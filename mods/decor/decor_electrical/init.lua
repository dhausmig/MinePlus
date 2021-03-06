if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local S = minetest.get_translator("decor_electrical")

decor_electrical = {}

function decor_electrical.toggle_switch(pos, node, clicker, itemstack, pointed_thing)
	if not clicker then return false end
	local playername = clicker:get_player_name()
	if minetest.is_protected(pos, playername) then
		minetest.record_protection_violation(pos, playername)
		return false
	end
	local sep = string.find(node.name, "_o", -5)
	local onoff = string.sub(node.name, sep + 1)
	local newname = string.sub(node.name, 1, sep - 1)..((onoff == "off") and "_on" or "_off")
	minetest.swap_node(pos, {name = newname, param2 = node.param2})
	return true
end

local on_rc
if minetest.get_modpath("mesecons") then
	on_rc = function(pos, node, clicker, itemstack, pointed_thing)
		local t = decor_electrical.toggle_switch(pos, node, clicker, itemstack, pointed_thing)
		if not t then return end
		if string.find(node.name, "_on", -5) then
			mesecon.receptor_off(pos, mesecon.rules.buttonlike_get(node))
		else
			mesecon.receptor_on(pos, mesecon.rules.buttonlike_get(node))
		end
	end
end

decor.register("power_outlet", {
	description = S("Power Outlet"),
	tiles = {
		"decor_outlet_edges.png",
		"decor_outlet_edges.png",
		"decor_outlet_edges.png",
		"decor_outlet_edges.png",
		"decor_outlet_back.png",
		"decor_outlet_edges.png"
	},
	inventory_image = "decor_outlet_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.125, -0.3125, 0.4375, 0.125, 0, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{ -0.1875, -0.375, 0.375, 0.1875, 0.0625, 0.5},
		}
	},
	groups = {cracky=3,dig_immediate=2},
	walkable = false
})

for _, onoff in ipairs ({"on", "off"}) do

	local switch_receptor
	if minetest.get_modpath("mesecons") then
		switch_receptor = {
			receptor = {
				state = mesecon.state[onoff],
				rules = mesecon.rules.buttonlike_get
			}
		}
	end

	local model = {
		{ -0.125,   -0.1875, 0.4375,  0.125,   0.125,  0.5 },
		{ -0.03125,  0,      0.40625, 0.03125, 0.0625, 0.5 },
	}

	if onoff == "on" then
		model = {
			{ -0.125,   -0.1875, 0.4375,  0.125,    0.125,  0.5 },
			{ -0.03125, -0.125,  0.40625, 0.03125, -0.0625, 0.5 },
		}
	end

	decor.register("light_switch_"..onoff, {
		description = S("Light switch"),
		tiles = {
			"decor_light_switch_edges.png",
			"decor_light_switch_edges.png",
			"decor_light_switch_edges.png",
			"decor_light_switch_edges.png",
			"decor_light_switch_back.png",
			"decor_light_switch_front_"..onoff..".png"
		},
		inventory_image = "decor_light_switch_inv.png",
		node_box = {
			type = "fixed",
			fixed = model
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.1875,   -0.25,    0.375,  0.1875,   0.1875, 0.5 },
			}
		},
		groups = {
			cracky=3, dig_immediate=2, mesecon_needs_receiver=1,
			not_in_creative_inventory = (onoff == "on") and 1 or nil
		},
		walkable = false,
		drop = {
			items = {
				{items = {"decor:light_switch_off"}, inherit_color = true },
			}
		},
		mesecons = switch_receptor,
		on_rightclick = on_rc
	})
end

decor.register("doorbell", {
	tiles = { "decor_doorbell.png" },
	inventory_image = "decor_doorbell_inv.png",
	description = S("Doorbell"),
    groups = {snappy=3},
    walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.0625, 0, 0.46875, 0.0625, 0.1875, 0.5}, -- NodeBox1
			{-0.03125, 0.0625, 0.45, 0.03125, 0.125, 0.4675}, -- NodeBox2
		}
	},
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.sound_play("decor_doorbell", {
			pos = pos,
			gain = 1.0,
			max_hear_distance = 15
		})
	end
})

-- crafting

minetest.register_craft( {
        output = "decor:power_outlet",
        recipe = {
			{"default:plastic_sheet", "decor:copper_strip"},
			{"default:plastic_sheet", ""},
			{"default:plastic_sheet", "decor:copper_strip"}
        },
})

minetest.register_craft( {
        output = "decor:light_switch_off",
        recipe = {
			{"", "default:plastic_sheet", "decor:copper_strip"},
			{"default:plastic_sheet", "default:plastic_sheet", "decor:copper_strip"},
			{"", "default:plastic_sheet", "decor:copper_strip"}
        },
})

minetest.register_craft( {
        output = "decor:doorbell",
        recipe = {
			{ "decor:light_switch_off", "default:mese_crystal", "decor:speaker_driver" }
        },
})

-- aliases

minetest.register_alias("decor:light_switch", "decor:light_switch_on")
