if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- Minetest mod: vessels
-- See README.txt for licensing and other information.

vessels = {}
vessels.has_shelf_api = true

local vessels_shelf_formspec =
	"size[8,7;]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"list[context;vessels;0,0.3;8,2;]" ..
	"list[current_player;main;0,2.85;8,1;]" ..
	"list[current_player;main;0,4.08;8,3;8]" ..
	"listring[context;vessels]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0, 2.85)

local function get_vessels_shelf_formspec(inv)
	local formspec = vessels_shelf_formspec
	local invlist = inv and inv:get_list("vessels")
	-- Inventory slots overlay
	local vx, vy = 0, 0.3
	for i = 1, 16 do
		if i == 9 then
			vx = 0
			vy = vy + 1
		end
		if not invlist or invlist[i]:is_empty() then
			formspec = formspec ..
				"image[" .. vx .. "," .. vy .. ";1,1;vessels_shelf_slot.png]"
		end
		vx = vx + 1
	end
	return formspec
end

function vessels.register_shelf(name, d)
	if not name:find(":") then
		name = "vessels:" .. name
	end
	local def = table.copy(d)
	def.paramtype2 = "facedir"
	def.is_ground_content = false

	if def.protected then
		def.on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", "Locked Shelf")
			meta:set_string("owner", "")
			local inv = meta:get_inventory()
			inv:set_size("vessels", 8 * 2)
		end
		def.after_place_node = function(pos, placer)
			local meta = minetest.get_meta(pos)
			meta:set_string("owner", placer:get_player_name() or "")
			meta:set_string("infotext", "Locked Chest (owned by @1)", meta:get_string("owner"))
		end
		def.can_dig = function(pos,player)
			local meta = minetest.get_meta(pos);
			local inv = meta:get_inventory()
			return inv:is_empty("main") and
					default.can_interact_with_node(player, pos)
		end
		def.allow_metadata_inventory_move = function(pos, from_list, from_index,
				to_list, to_index, count, player)
			if not default.can_interact_with_node(player, pos) then
				return 0
			end
			return count
		end
		def.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			if not default.can_interact_with_node(player, pos) then
				return 0
			end
			return stack:get_count()
		end
		def.allow_metadata_inventory_take = function(pos, listname, index, stack, player)
			if not default.can_interact_with_node(player, pos) then
				return 0
			end
			return stack:get_count()
		end
		def.on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			if not default.can_interact_with_node(clicker, pos) then
				return itemstack
			end
			minetest.show_formspec(	clicker:get_player_name(),
				name, get_vessels_shelf_formspec(pos))
		end
		def.on_blast = function() end
		def.on_key_use = function(pos, player)
			local secret = minetest.get_meta(pos):get_string("key_lock_secret")
			local itemstack = player:get_wielded_item()
			local key_meta = itemstack:get_meta()

			if itemstack:get_metadata() == "" then
				return
			end

			if key_meta:get_string("secret") == "" then
				key_meta:set_string("secret", minetest.parse_json(itemstack:get_metadata()).secret)
				itemstack:set_metadata("")
			end

			if secret ~= key_meta:get_string("secret") then
				return
			end

			minetest.show_formspec(
				player:get_player_name(),
				name,
				get_vessels_shelf_formspec(pos)
			)
		end
		def.on_skeleton_key_use = function(pos, player, newsecret)
			local meta = minetest.get_meta(pos)
			local owner = meta:get_string("owner")
			local pn = player:get_player_name()

			-- verify placer is owner of lockable chest
			if owner ~= pn then
				minetest.record_protection_violation(pos, pn)
				minetest.chat_send_player(pn, "You do not own this shelf.")
				return nil
			end

			local secret = meta:get_string("key_lock_secret")
			if secret == "" then
				secret = newsecret
				meta:set_string("key_lock_secret", secret)
			end

			return secret, "a locked shelf", owner
		end
	else
		def.on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", get_vessels_shelf_formspec(nil))
			local inv = meta:get_inventory()
			inv:set_size("vessels", 8 * 2)
		end
		def.can_dig = function(pos,player)
			local inv = minetest.get_meta(pos):get_inventory()
			return inv:is_empty("vessels")
		end
		def.allow_metadata_inventory_put = function(pos, listname, index, stack, player)
			if minetest.get_item_group(stack:get_name(), "vessel") ~= 0 then
				return stack:get_count()
			end
			return 0
		end
		def.on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
			minetest.log("action", player:get_player_name() ..
					" moves stuff in vessels shelf at ".. minetest.pos_to_string(pos))
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", get_vessels_shelf_formspec(meta:get_inventory()))
		end
		def.on_metadata_inventory_put = function(pos, listname, index, stack, player)
			minetest.log("action", player:get_player_name() ..
				" moves stuff to vessels shelf at ".. minetest.pos_to_string(pos))
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", get_vessels_shelf_formspec(meta:get_inventory()))
		end
		def.on_metadata_inventory_take = function(pos, listname, index, stack, player)
			minetest.log("action", player:get_player_name() ..
					" takes stuff from vessels shelf at ".. minetest.pos_to_string(pos))
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", get_vessels_shelf_formspec(meta:get_inventory()))
		end
		def.on_blast = function(pos)
			local drops = {}
			default.get_inventory_drops(pos, "vessels", drops)
			drops[#drops + 1] = name
			minetest.remove_node(pos)
			return drops
		end
	end
	if def.recipe then
		minetest.register_craft({
			output = name,
			recipe = def.recipe,
		})
	end
	def.recipe = nil
	minetest.register_node(name, def)
end
			
		
vessels.register_shelf("vessels:shelf", {
	description = "Vessels Shelf",
	tiles = {"default_wood.png^[transformR90", "default_wood.png^[transformR90", "default_wood.png",
		"default_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"group:wood", "group:wood", "group:wood"},
	}
})

vessels.register_shelf("vessels:acacia_shelf", {
	description = "Acacia Vessels Shelf",
	tiles = {"default_acacia_wood.png^[transformR90", "default_acacia_wood.png^[transformR90", "default_acacia_wood.png",
		"default_acacia_wood.png", "vessels_acacia_shelf.png", "vessels_acacia_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"default:acacia_wood", "default:acacia_wood", "default:acacia_wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"default:acacia_wood", "default:acacia_wood", "default:acacia_wood"},
	}
})

vessels.register_shelf("vessels:aspen_shelf", {
	description = "Aspen Vessels Shelf",
	tiles = {"default_aspen_wood.png^[transformR90", "default_aspen_wood.png^[transformR90", "default_aspen_wood.png",
		"default_aspen_wood.png", "vessels_aspen_shelf.png", "vessels_aspen_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"default:aspen_wood", "default:aspen_wood", "default:aspen_wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"default:aspen_wood", "default:aspen_wood", "default:aspen_wood"},
	}
})

vessels.register_shelf("vessels:junglewood_shelf", {
	description = "Junglewood Vessels Shelf",
	tiles = {"default_junglewood.png^[transformR90", "default_junglewood.png^[transformR90", "default_junglewood.png",
		"default_junglewood.png", "vessels_junglewood_shelf.png", "vessels_junglewood_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"default:junglewood", "default:junglewood", "default:junglewood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"default:junglewood", "default:junglewood", "default:junglewood"},
	}
})

vessels.register_shelf("vessels:pine_shelf", {
	description = "Pine Vessels Shelf",
	tiles = {"default_pine_wood.png^[transformR90", "default_pine_wood.png^[transformR90", "default_pine_wood.png",
		"default_pine_wood.png", "vessels_pine_shelf.png", "vessels_pine_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"default:pine_wood", "default:pine_wood", "default:pine_wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"default:pine_wood", "default:pine_wood", "default:pine_wood"},
	}
})
		
vessels.register_shelf("vessels:steel_shelf", {
	description = "Steel Vessels Shelf",
	protected = 1,
	tiles = {"default_steel_block.png", "default_steel_block.png", "default_steel_block.png",
		"default_steel_block.png", "vessels_steel_shelf.png", "vessels_steel_shelf.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_metal_defaults(),
	recipe = {
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

vessels.register_shelf("vessels:copper_shelf", {
	description = "Copper Vessels Shelf",
	protected = 1,
	tiles = {"default_copper_block.png", "default_copper_block.png", "default_copper_block.png",
		"default_copper_block.png", "vessels_copper_shelf.png", "vessels_copper_shelf.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_metal_defaults(),
	recipe = {
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"default:copper_ingot", "default:copper_ingot", "default:copper_ingot"},
	}
})

vessels.register_shelf("vessels:tin_shelf", {
	description = "Tin Vessels Shelf",
	protected = 1,
	tiles = {"default_tin_block.png", "default_tin_block.png", "default_tin_block.png",
		"default_tin_block.png", "vessels_tin_shelf.png", "vessels_tin_shelf.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_metal_defaults(),
	recipe = {
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"default:tin_ingot", "default:tin_ingot", "default:tin_ingot"},
	}
})

vessels.register_shelf("vessels:bronze_shelf", {
	description = "Bronze Vessels Shelf",
	protected = 1,
	tiles = {"default_bronze_block.png", "default_bronze_block.png", "default_bronze_block.png",
		"default_bronze_block.png", "vessels_bronze_shelf.png", "vessels_bronze_shelf.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_metal_defaults(),
	recipe = {
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"default:bronze_ingot", "default:bronze_ingot", "default:bronze_ingot"},
	}
})

vessels.register_shelf("vessels:gold_shelf", {
	description = "Gold Vessels Shelf",
	protected = 1,
	tiles = {"default_gold_block.png", "default_gold_block.png", "default_gold_block.png",
		"default_gold_block.png", "vessels_gold_shelf.png", "vessels_gold_shelf.png"},
	groups = {cracky = 3, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_metal_defaults(),
	recipe = {
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"},
	}
})


minetest.register_node("vessels:glass_bottle", {
	description = "Glass Bottle (empty)",
	drawtype = "plantlike",
	tiles = {"vessels_glass_bottle.png"},
	inventory_image = "vessels_glass_bottle.png",
	wield_image = "vessels_glass_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft( {
	output = "vessels:glass_bottle 10",
	recipe = {
		{"default:glass", "", "default:glass"},
		{"default:glass", "", "default:glass"},
		{"", "default:glass", ""}
	}
})

minetest.register_node("vessels:drinking_glass", {
	description = "Drinking Glass (empty)",
	drawtype = "plantlike",
	tiles = {"vessels_drinking_glass.png"},
	inventory_image = "vessels_drinking_glass_inv.png",
	wield_image = "vessels_drinking_glass.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft( {
	output = "vessels:drinking_glass 14",
	recipe = {
		{"default:glass", "", "default:glass"},
		{"default:glass", "", "default:glass"},
		{"default:glass", "default:glass", "default:glass"}
	}
})

minetest.register_node("vessels:steel_bottle", {
	description = "Heavy Steel Bottle (empty)",
	drawtype = "plantlike",
	tiles = {"vessels_steel_bottle.png"},
	inventory_image = "vessels_steel_bottle.png",
	wield_image = "vessels_steel_bottle.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_defaults(),
})

minetest.register_craft( {
	output = "vessels:steel_bottle 5",
	recipe = {
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})

-- Glass and steel recycling

minetest.register_craftitem("vessels:glass_fragments", {
	description = "Pile of Glass Fragments",
	inventory_image = "vessels_glass_fragments.png",
})

minetest.register_craft( {
	type = "shapeless",
	output = "vessels:glass_fragments",
	recipe = {
		"vessels:glass_bottle",
		"vessels:glass_bottle",
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "vessels:glass_fragments",
	recipe = {
		"vessels:drinking_glass",
		"vessels:drinking_glass",
	},
})

minetest.register_craft({
	type = "cooking",
	output = "default:glass",
	recipe = "vessels:glass_fragments",
})

minetest.register_craft( {
	type = "cooking",
	output = "default:steel_ingot",
	recipe = "vessels:steel_bottle",
})

minetest.register_craft({
	type = "fuel",
	recipe = "vessels:shelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "vessels:acacia_shelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "vessels:aspen_shelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "vessels:junglewood_shelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "vessels:pine_shelf",
	burntime = 30,
})
