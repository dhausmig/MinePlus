if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

local path = minetest.get_modpath(minetest.get_current_modname() )
furn = {}
----------------------
-- function for sitting
----------------------
--[[
--sit functions from xdecor mod written by jp
--Copyright (c) 2015-2016 kilbith <jeanpatrick.guerrero@gmail.com>   |
--Code: GPL version 3
--]]

function furn.sit(pos, node, clicker)
	local player = clicker:get_player_name()
	if default.player_attached[player] == true then
		pos.y = pos.y + 0.1
		clicker:setpos(pos)
		clicker:set_eye_offset({x=0, y=0, z=0}, {x=0, y=0, z=0})
--		clicker:set_physics_override(1, 1, 1)
		playerphysics.remove_physics_factor(clicker, "speed", "furn_speed")
		playerphysics.remove_physics_factor(clicker, "jump", "furn_jump")
		playerphysics.remove_physics_factor(clicker, "gravity", "furn_grav")
		default.player_attached[player] = false
		default.player_set_animation(clicker, "stand", 30)
	elseif default.player_attached[player] ~= true and
		clicker:get_player_velocity().x == 0 and
		clicker:get_player_velocity().y == 0 and
		clicker:get_player_velocity().z == 0 and node.param2 <= 3 then

		clicker:set_eye_offset({x=0, y=-7, z=2}, {x=0, y=0, z=0})
--		clicker:set_physics_override(0, 0, 0)
		playerphysics.add_physics_factor(clicker, "speed", "furn_speed", 0)
		playerphysics.add_physics_factor(clicker, "jump", "furn_jump", 0)
		playerphysics.add_physics_factor(clicker, "gravity", "furn_grav", 0)
		clicker:setpos(pos)
		default.player_attached[player] = true
		default.player_set_animation(clicker, "sit", 30)

		if node.param2 == 0 then
			clicker:set_look_yaw(3.15)
		elseif node.param2 == 1 then
			clicker:set_look_yaw(7.9)
		elseif node.param2 == 2 then
			clicker:set_look_yaw(6.28)
		elseif node.param2 == 3 then
			clicker:set_look_yaw(4.75)
		end
	end
end

dofile(path.."/longsofas.lua")
dofile(path.."/sofas.lua")
dofile(path.."/armchairs.lua")
dofile(path.."/tables.lua")

