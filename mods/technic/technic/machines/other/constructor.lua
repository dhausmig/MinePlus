--local S = technic.getter
local S = function ( s ) return s end

local function deploy_node(inv, slot_name, pos, node, machine_node)
	-- param2 can be over 3 for flowing liquids
	if node.param2 > 3 and minetest.get_node_group(node.name, "liquid") < 1 then
		return
	end

	local drops = true

	if node.name ~= "air" then

		-- placing tracks causes advtrains restart
		if string.find(node.name, "advtrains:dtrack") then
			return
		end

		if node.name == "ignore" or
		   node.name == "default:lava_source" or
		   node.name == "default:lava_flowing" or
		   node.name == "default:water_source" or
		   node.name == "default:water_flowing" or
		   node.name == "technic:corium_source" or
		   node.name == "technic:corium_flowing"
		   then
			-- return
			drops = false
		end

		if drops then
			-- regular material replacement
			local drops = minetest.get_node_drops(node.name, "")
			local remove_to = false
			for i, item in ipairs(drops) do
				if not inv:room_for_item(slot_name, item) then
					remove_to = i - 1
					break
				end
				inv:add_item(slot_name, item)
			end
			if remove_to then
				for i = 1, remove_to do
					inv:remove_item(slot_name, drops[i])
				end
			else
				minetest.remove_node(pos)
			end
			return
		end
	end

	if not inv:is_empty(slot_name) then
		local stack = inv:get_list(slot_name)[1]
		local def = stack:get_definition()

		if string.find(stack:get_name(), "advtrains:dtrack") then
			return
		end

		if def.type == "node" then
			minetest.set_node(pos, {
				name = stack:get_name(),
				param2 = machine_node.param2
			})
			stack:take_item()
			inv:set_stack(slot_name, 1, stack)
		elseif def.type == "craft" then
			if def.on_place then
				-- Use pcall to avoid nil placer errors.
				-- TODO: Do without pcall.
				local ok, stk = pcall(def.on_place, stack, nil, {
					-- Fake pointed_thing
					type = "node",
					above = pos,
					under = {x=pos.x, y=pos.y-1, z=pos.z},
				})
				if ok then
					inv:set_stack(slot_name, 1, stk or stack)
					return
				end
			end
			minetest.item_place_object(stack, nil, {
				-- Fake pointed_thing
				type = "node",
				above = pos,
				under = pos,
			})
			inv:set_stack(slot_name, 1, nil)
		end
	end
end

-- crafting recipes

minetest.register_craft({
	type = "shapeless",
	output = 'technic:constructor_mk1_off 1',
	recipe = {'technic:nodebreaker_off', 'technic:deployer_off'},

})

minetest.register_craft({
	type = "shapeless",
	output = 'technic:constructor_mk2_off 2',
	recipe = {'technic:constructor_mk1_off', 'technic:constructor_mk1_off'},

})

minetest.register_craft({
	type = "shapeless",
	output = 'technic:constructor_mk3_off 2',
	recipe = {'technic:constructor_mk1_off', 'technic:constructor_mk2_off'},

})

minetest.register_craft({
	type = "shapeless",
	output = 'technic:constructor_mk4_off 2',
	recipe = {'technic:constructor_mk2_off', 'technic:constructor_mk2_off'},

})

minetest.register_craft({
	type = "shapeless",
	output = 'technic:constructor_mk5_off 2',
	recipe = {'technic:constructor_mk2_off', 'technic:constructor_mk3_off'},

})

-- recycling recipe

minetest.register_craft({
	type = "shapeless",
	output = 'technic:constructor_mk1_off',
	recipe = {'group:technic_constructor'},

})


local function make_on(mark, length)
	return function(pos, node)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local dir = vector.new()
		if node.param2 == 3 then dir.x = 1 end
		if node.param2 == 2 then dir.z = 1 end
		if node.param2 == 1 then dir.x = -1 end
		if node.param2 == 0 then dir.z = -1 end

		local place_pos = vector.new(pos)

		if node.name == "technic:constructor_mk"..mark.."_off" then
			technic.swap_node(pos, "technic:constructor_mk"..mark.."_on")
			--nodeupdate(pos)
			core.check_for_falling(pos)
			for i = 1, length do
				place_pos = vector.add(place_pos, dir)
				local place_node = minetest.get_node(place_pos)
				deploy_node(inv, "slot"..i, place_pos, place_node, node)
			end
		end
	end
end

local function make_off(mark)
	return function(pos, node)
		if node.name == "technic:constructor_mk"..mark.."_on" then
			technic.swap_node(pos,"technic:constructor_mk"..mark.."_off")
			--nodeupdate(pos)
			core.check_for_falling(pos)
		end
	end
end

local function allow_inventory_put(pos, listname, index, stack, player)
	if stack and minetest.get_item_group(stack:get_name(), "technic_constructor") == 1 then
		return 0
	end
	return technic.machine_inventory_put(pos, listname, index, stack, player)
end

local function make_constructor(mark, length)
	minetest.register_node("technic:constructor_mk"..mark.."_off", {
		description = S("Constructor Mk%d"):format(mark),
		tiles = {"technic_constructor_mk"..mark.."_side_off.png^[transformR180",
			"technic_constructor_mk"..mark.."_side_off.png",
			"technic_constructor_mk"..mark.."_side_off.png^[transformR90",
			"technic_constructor_mk"..mark.."_side_off.png^[transformR270",
			"technic_constructor_back.png",
			"technic_constructor_front_off.png"},
		paramtype2 = "facedir",
		groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
				mesecon = 2, technic_constructor = 1},
		mesecons = {effector = {action_on = make_on(mark, length)}},
		sounds = default.node_sound_stone_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			local formspec = "size[8,9;]"..
				"label[0,0;"..S("Constructor Mk%d"):format(mark).."]"..
				"list[current_player;main;0,5;8,4;]"
			for i = 1, length do
				formspec = formspec
					.."label["..(i - 1)..",1;"..S("Slot %d"):format(i).."]"
					.."list[current_name;slot"..i
						..";"..(i - 1)..",2;1,1;]"
			end
			meta:set_string("formspec", formspec)
			meta:set_string("infotext", S("Constructor Mk%d"):format(mark))
			local inv = meta:get_inventory()
			for i = 1, length do
				inv:set_size("slot"..i, 1)
			end
		end,
		can_dig = function(pos, player)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			for i = 1, length do
				if not inv:is_empty("slot"..i) then
					return false
				end
			end
			return true
		end,
		allow_metadata_inventory_put = allow_inventory_put,
		allow_metadata_inventory_take = technic.machine_inventory_take,
		allow_metadata_inventory_move = technic.machine_inventory_move,
		on_rotate = screwdriver.rotate_simple
	})

	minetest.register_node("technic:constructor_mk"..mark.."_on", {
		tiles = {"technic_constructor_mk"..mark.."_side_on.png^[transformR180",
			"technic_constructor_mk"..mark.."_side_on.png",
			"technic_constructor_mk"..mark.."_side_on.png^[transformR90",
			"technic_constructor_mk"..mark.."_side_on.png^[transformR270",
			"technic_constructor_back.png",
			"technic_constructor_front_on.png"},
		paramtype2 = "facedir",
		drop = "technic:constructor_mk"..mark.."_off",
		groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
				mesecon=2, not_in_creative_inventory=1, technic_constructor=1},
		mesecons= {effector = {action_off = make_off(mark)}},
		sounds = default.node_sound_stone_defaults(),
		allow_metadata_inventory_put = allow_inventory_put,
		allow_metadata_inventory_take = technic.machine_inventory_take,
		allow_metadata_inventory_move = technic.machine_inventory_move,
		on_rotate = false
	})
end

make_constructor(1, 1)
make_constructor(2, 2)
make_constructor(3, 3)
make_constructor(4, 4)
make_constructor(5, 5)
