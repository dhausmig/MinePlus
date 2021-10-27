local armchairs_list = {
	{ "Red Armchair", "red"},
	{ "Orange Armchair", "orange"},	
	{ "Yellow Armchair", "yellow"},
	{ "Green Armchair", "green"},
	{ "Blue Armchair", "blue"},
	{ "Violet Armchair", "violet"},
	{ "Black Armchair", "black"},
	{ "Grey Armchair", "grey"},
	{ "White Armchair", "white"},
   { "Cyan Armchair", "cyan"},
   { "Brown Armchair", "brown"},
   { "Magenta Armchair", "magenta"},
   { "Pink Armchair", "pink"},
   { "Dark Green Armchair", "dark_green"},
   { "Dark Grey Armchair", "dark_grey"},
}

for i in ipairs(armchairs_list) do
	local armchairdesc = armchairs_list[i][1]
	local color = armchairs_list[i][2]

	minetest.register_node("furn:armchair_"..color, {
		description = armchairdesc,
		drawtype = "nodebox",
		tiles = {"furn_armchair_top_"..color..".png", "furn_coffeetable_back.png",  "furn_sofa_left_side_"..color..".png",  "furn_sofa_right_side_"..color..".png",  "furn_sofa_back_"..color..".png",  "furn_armchair_front_"..color..".png"},
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		stack_max = 1,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						--legs
						{-0.4375, -0.5, -0.4375, -0.375, -0.375, -0.375},
						{0.375, -0.5, -0.4375, 0.4375, -0.375, -0.375},
						{-0.4375, -0.5, 0.375, -0.375, -0.375, 0.4375},
						{0.375, -0.5, 0.375, 0.4375, -0.375, 0.4375},
						
						--base/cushion
						{-0.5, -0.375, -0.5, 0.5, 0, 0.5},
						
						--back
						{-0.5, 0, 0.3125, 0.5, 0.5, 0.5},
						
						--arms
						{-0.5, 0, -0.5, -0.3125, 0.25, 0.3125},
						{0.3125, 0, -0.5, 0.5, 0.25, 0.3125},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
					}
		},

		on_rightclick = function(pos, node, clicker)
			local objs = minetest.get_objects_inside_radius(pos, 0.5)
			for _, p in pairs(objs) do
				if p:get_player_name() ~= clicker:get_player_name() then return end
			end
			pos.y = pos.y -0.25
			furn.sit(pos, node, clicker)
			clicker:set_hp(maxhp.get_maxhp(clicker))
		end,

		can_dig = function(pos, player)
			local pname = player:get_player_name()
			local objs = minetest.get_objects_inside_radius(pos, 0.5)

			for _, p in pairs(objs) do
				if p:get_player_name() ~= nil or
					default.player_attached[pname] == true or not
					player or not player:is_player() then
					return false
				end
			end
			return true
		end

	})
	minetest.register_craft({
		output = "furn:armchair_"..color,
		recipe = {
			{"wool:"..color, "", "", },
			{"stairs:slab_wood", "", "", },
			{"default:stick", "", "", }
		}
	})
		
--[[
	minetest.register_craft({
		output = "furn:armchair_"..color,
		recipe = {
			{"wool:"..color, "", "", },
			{"moreblocks:slab_wood", "", "", },
			{"default:stick", "", "", }
		}
	})

	minetest.register_craft({
		output = "furn:armchair_"..color,
		recipe = {
			{"wool:"..color, "", "", },
			{"group:wood_slab", "", "", },
			{"default:stick", "", "", }
		}
	})
--]]

end
