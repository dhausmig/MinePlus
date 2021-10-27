--Heights for skyboxes
local space_low = otherworlds.settings.space_asteroids.YMIN
local space_high = otherworlds.settings.space_asteroids.YMAX -1
local redsky_low = otherworlds.settings.redsky_asteroids.YMIN
local redsky_high = otherworlds.settings.redsky_asteroids.YMAX -1
local sky_start = tonumber(minetest.settings:get("sky_start") or -100)
local first_dimension = tonumber(minetest.settings:get("first_dimension") or 13000)

local player_list = {} -- Holds name of skybox showing for each player

--Outerspace skybox
local spaceskybox = {
	"sky_pos_z.png",
	"sky_neg_z.png^[transformR180",
	"sky_neg_y.png^[transformR270",
	"sky_pos_y.png^[transformR270",
	"sky_pos_x.png^[transformR270",
	"sky_neg_x.png^[transformR90",
}

--Redsky skybox
local redskybox = {
	"sky_pos_z.png^[colorize:#99000050",
	"sky_neg_z.png^[transformR180^[colorize:#99000050",
	"sky_neg_y.png^[transformR270^[colorize:#99000050",
	"sky_pos_y.png^[transformR270^[colorize:#99000050",
	"sky_pos_x.png^[transformR270^[colorize:#99000050",
	"sky_neg_x.png^[transformR90^[colorize:#99000050",
}


local timer = 0

minetest.register_globalstep(function(dtime)

	timer = timer + dtime

	if timer < 2 then
		return
	end

	timer = 0

	for _, player in pairs(minetest.get_connected_players()) do

		local name = player:get_player_name()
		local pos = player:get_pos()
		local current = player_list[name] or ""

		-- Earth
		if pos.y < space_low and pos.y > sky_start and current ~= "earth" then
			player:set_sky( {type = "regular"})
			player:set_clouds({density = 0.4})
			player_list[name] = "earth"
			if otherworlds.settings.gravity.enable then
--				player:set_physics_override({gravity = 1})
				playerphysics.remove_physics_factor(player, "gravity", "ow_grav")
			end

		-- Outerspace
		elseif pos.y > space_low and pos.y < space_high and current ~= "space" then
			player:set_sky({type = "skybox", textures = spaceskybox})
			player:set_clouds({density = 0})
			player_list[name] = "space"
			if otherworlds.settings.gravity.enable then
--				player:set_physics_override({gravity = 0.4})
				playerphysics.add_physics_factor(player, "gravity", "ow_grav", 0.4)
			end

		-- Redsky
		elseif pos.y > redsky_low and pos.y < redsky_high and current ~= "redsky" then
			player:set_sky({type = "skybox", textures = redskybox})
			player:set_clouds({density = 0})
			player_list[name] = "redsky"
			if otherworlds.settings.gravity.enable then
--				player:set_physics_override({gravity = 0.2})
				playerphysics.add_physics_factor(player, "gravity", "ow_grav", 0.2)
			end

		-- Everything else (blackness above)
		elseif pos.y > redsky_high and pos.y < first_dimension and current ~= "blackness" then
			player:set_sky( {base_color = 000000, type = "plain",})
			player:set_clouds({density = 0})
			player_list[name] = "blackness"
			if otherworlds.settings.gravity.enable then
--				player:set_physics_override({gravity = 0.1})
				playerphysics.add_physics_factor(player, "gravity", "ow_grav", 0.1)
			end

		-- Everything else (blackness underground)
		elseif pos.y < sky_start and current ~= "blackness" then
			player:set_sky( {base_color = 000000, type = "plain"})
			player:set_clouds({density = 0})
			player_list[name] = "blackness"
			if otherworlds.settings.gravity.enable then
--				player:set_physics_override({gravity = 0.1})
				playerphysics.remove_physics_factor(player, "gravity", "ow_grav")
			end
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_list[name] = nil
	if otherworlds.settings.gravity.enable then
		--player:set_physics_override({gravity = 1})
		playerphysics.remove_physics_factor(player, "gravity", "ow_grav")
	end
end)
