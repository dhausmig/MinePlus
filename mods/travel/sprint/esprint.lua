--[[
Sprint mod for Minetest by GunshipPenguin

To the extent possible under law, the author(s)
have dedicated all copyright and related and neighboring rights
to this software to the public domain worldwide. This software is
distributed without any warranty.
]]

local players = {}
local staminaHud = {}

minetest.register_on_joinplayer(function(player)
	local playerName = player:get_player_name()
	players[playerName] = {
		timeOut = false,
		sprinting = false,
		stamina = SPRINT_STAMINA,
	}
	if SPRINT_HUDBARS_USED then
		hb.init_hudbar(player, "sprint")
	else
		players[playerName].hud = player:hud_add({
			hud_elem_type = "statbar",
			position = {x=0.503,y=1},
			size = {x=23, y=13.9},
			text = "sprint_stamina_icon.png",
			number = 20,
			alignment = {x=0,y=0},
            offset = {x=15, y=-142},
            }
		)
	end
end)
minetest.register_on_leaveplayer(function(player)
	local playerName = player:get_player_name()
	players[playerName] = nil
end)

local gameTime = 0
minetest.register_globalstep(function(dtime)
	--Get the gametime
	gameTime = gameTime + dtime
	--Loop through all connected players
	for playerName,playerInfo in pairs(players) do
		local player = minetest.get_player_by_name(playerName)
		if player ~= nil then
			local playerPos = player:get_pos()
			--Check whether the player wants and can sprint
			if player:get_player_control()["aux1"] and player:get_player_control()["up"] and playerInfo["timeOut"] == false then
				if not playerInfo["sprinting"] then
--					player:set_physics_override({speed=SPRINT_SPEED,jump=SPRINT_JUMP})
					playerphysics.add_physics_factor(player, "speed", "sprint_speed", SPRINT_SPEED)
					playerphysics.add_physics_factor(player, "jump", "sprint_jump", SPRINT_JUMP)
					playerInfo["sprinting"] = true
				end
				if gameTime > 0.4 then
					local numParticles = math.random(1, 2)
					local playerNode = minetest.get_node({x=playerPos["x"], y=playerPos["y"]-1, z=playerPos["z"]})
					if playerNode["name"] ~= "air" then
						for i=1, numParticles, 1 do
							minetest.add_particle({
								pos = {x=playerPos["x"]+math.random(-1,1)*math.random()/2,y=playerPos["y"]+0.1,z=playerPos["z"]+math.random(-1,1)*math.random()/2},
								velocity = {x=0, y=5, z=0},
								acceleration = {x=0, y=-13, z=0},
								expirationtime = math.random(),
								size = math.random()+0.5,
								collisiondetection = true,
								vertical = false,
								texture = "sprint_particle.png",
							})
						end
					end
				end
				playerInfo["stamina"] = playerInfo["stamina"] - dtime
				--if empty stamina
				if playerInfo["stamina"] < 0 then
					playerInfo["stamina"] = 0
					playerInfo["timeOut"] = true
					playerInfo["sprinting"] = false
--					player:set_physics_override(physics)     --{speed=1.0,jump=1.0})
					playerphysics.remove_physics_factor(player, "speed", "sprint_speed")
					playerphysics.remove_physics_factor(player, "jump", "sprint_jump")
					minetest.sound_play("default_breathless",{object=player})
				end
			else
				if playerInfo["sprinting"] then
--					player:set_physics_override(physics)     --({speed=1.0,jump=1.0})
					playerphysics.remove_physics_factor(player, "speed", "sprint_speed")
					playerphysics.remove_physics_factor(player, "jump", "sprint_jump")
					playerInfo["sprinting"] = false
				end
				if playerInfo["stamina"] < SPRINT_STAMINA then
					--if player walk, stamina regen /2
					if player:get_player_control()["up"] then
						playerInfo["stamina"] = playerInfo["stamina"] + dtime/2
					else
						playerInfo["stamina"] = playerInfo["stamina"] + dtime
					end
					-- if stamina regenered
					if playerInfo["stamina"] > SPRINT_STAMINA then
						playerInfo["stamina"] = SPRINT_STAMINA
						playerInfo["timeOut"] = false
					end
				end
			end
--[[	 no cactus damage
			if gameTime > 0.4 then
				-- From playerplus :
				-- am I near a cactus?
				playerPos.y = playerPos.y + 0.1
				if minetest.find_node_near(playerPos, 1, "default:cactus") and player:get_hp() > 0 then
					player:set_hp(player:get_hp()-1)
				end
			end
--]]
			--Update the players's hud sprint stamina bar
			if SPRINT_HUDBARS_USED then
				hb.change_hudbar(player, "sprint", playerInfo["stamina"])
			else
				local numBars = (playerInfo["stamina"]/SPRINT_STAMINA)*20
				player:hud_change(playerInfo["hud"], "number", numBars)
			end
		end
	end

	if gameTime > 0.4 then
		gameTime = 0
	end
end)
