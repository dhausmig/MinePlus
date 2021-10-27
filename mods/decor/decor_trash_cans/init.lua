if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local S = minetest.get_translator("decor_trash_cans")

local tg_cbox = {
	type = "fixed",
	fixed = { -0.35, -0.5, -0.35, 0.35, 0.4, 0.35 }
}

local trashcan_green = 0x00006000

decor.register("trash_can_green", {
	drawtype = "mesh",
	mesh = "decor_trash_can_green.obj",
	tiles = { { name = "decor_generic_plastic.png", color = trashcan_green } },
	use_texture_alpha = "clip",
	inventory_image = "decor_trash_can_green_inv.png",
	description = S("Green Trash Can"),
	groups = {snappy=3},
	selection_box = tg_cbox,
	collision_box = tg_cbox,
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "decor:trash_can_green_open", param2 = node.param2})
	end
})

decor.register("trash_can_green_open", {
	drawtype = "mesh",
	mesh = "decor_trash_can_green_open.obj",
	tiles = { { name = "decor_generic_plastic.png", color = trashcan_green } },
	use_texture_alpha = "clip",
	groups = {snappy=3, not_in_creative_inventory=1},
	selection_box = tg_cbox,
	collision_box = tg_cbox,
	drop = "decor:trash_can_green",
	on_punch = function(pos, node, puncher, pointed_thing)
		minetest.set_node(pos, {name = "decor:trash_can_green", param2 = node.param2})
	end,
	infotext=S("Trash Can"),
	inventory= {
		size = 9,
		formspec = "size[8,9]" .. default.gui_bg .. default.gui_bg_img .. default.gui_slots ..
		"button[2.5,3.8;3,1;empty;Empty Trash]"..
		"list[context;main;2.5,0.5;3,3;]"..
		"list[current_player;main;0,5;8,4;]" ..
		"listring[]",
	},
	on_receive_fields = function(pos, formname, fields, sender)
		if fields.empty then
			local meta = minetest.get_meta(pos)
			meta:get_inventory():set_list("main", {})
			minetest.sound_play("decor_trash_all", {to_player=sender:get_player_name(), gain = 1.0})
		end
	end
})

local trash_cbox = {
	type = "fixed",
	fixed = { -0.25, -0.5, -0.25, 0.25, 0.125, 0.25 }
}

decor.register("trash_can", {
	drawtype = "mesh",
	mesh = "decor_trash_can.obj",
	tiles = { "decor_trash_can.png" },
	use_texture_alpha = "clip",
	inventory_image = "decor_trash_can_inv.png",
	description = S("Small Trash Can"),
	groups = {snappy=3},
	selection_box = trash_cbox,
	collision_box = trash_cbox,
})

-- crafting


minetest.register_craft( {
        output = "decor:trash_can 3",
        recipe = {
			{ "decor:steel_wire", "", "decor:steel_wire" },
			{ "default:steel_ingot", "default:steel_ingot", "default:steel_ingot" }
        },
})

minetest.register_craft({
	output = "decor:trash_can_green",
	recipe = {
		{ "default:plastic_sheet", "", "default:plastic_sheet" },
		{ "default:plastic_sheet", "dye:green", "default:plastic_sheet" },
		{ "default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet" }
	},
})
