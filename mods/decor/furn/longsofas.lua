
--[[
S("Red Wool")
S("Orange Wool")
S("Yellow Wool")
S("Green Wool")
S("Blue Wool")
S("Violet Wool")
S("Black Wool")
S("Grey Wool")
S("White Wool")
S("Cyan Wool")
S("Brown Wool")
S("Magenta Wool")
S("Pink Wool")
S("Dark Green Wool")
S("Dark Grey Wool")
--]]
local longsofas_list = {
	{ "Red Long Sofa", "red"},
	{ "Orange Long Sofa", "orange"},	
	{ "Yellow Long Sofa", "yellow"},
	{ "Green Long Sofa", "green"},
	{ "Blue Long Sofa", "blue"},
	{ "Violet Long Sofa", "violet"},
	{ "Black Long Sofa", "black"},
	{ "Grey Long Sofa", "grey"},
	{ "White Long Sofa", "white"},
   { "Cyan Long Sofa", "cyan"},
   { "Brown Long Sofa", "brown"},
   { "Magenta Long Sofa", "magenta"},
   { "Pink Long Sofa", "pink"},
   { "Dark Green Long Sofa", "dark_green"},
   { "Dark Grey Long Sofa", "dark_grey"},
}

for i in ipairs(longsofas_list) do
	local longsofadesc = longsofas_list[i][1]
	local color = longsofas_list[i][2]

	minetest.register_node("furn:longsofa_right_"..color, {
		description = longsofadesc,
		drawtype = "nodebox",
		tiles = {"furn_sofa_right_top_"..color..".png", 
		   "furn_coffeetable_back.png",  
		   "furn_sofa_right_front_"..color..".png",  
		   "furn_sofa_back_"..color..".png",  
		   "furn_sofa_left_side_"..color..".png",  
		   "furn_sofa_right_side_"..color..".png"
	   },
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
--		stack_max = 1,
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						--legs
						{-0.4375, -0.5, -0.4375, -0.375, -0.375, -0.375},
						{0.375, -0.5, -0.4375, 0.4375, -0.375, -0.375},
						
						--base/cushion
						{-0.5, -0.375, -0.5, 0.5, 0, 0.5},
						
						--back
						{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},
						
						--arm
						{-0.3125, 0, -0.5, 0.5, 0.25, -0.3125},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{-0.5, -0.5, -0.5, 0.5, 0.5, 2.5},
					}
		},

		on_construct = function(pos)
			local node = minetest.env:get_node(pos)
			local param2 = node.param2
			node.name = "furn:longsofa_middle_"..color
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).name == "air" ) then
				minetest.env:set_node(pos, node)
				node.name = "furn:longsofa_left_"..color
				if param2 == 0 then
					pos.z = pos.z+1
				elseif param2 == 1 then
					pos.x = pos.x+1
				elseif param2 == 2 then
					pos.z = pos.z-1
				elseif param2 == 3 then
					pos.x = pos.x-1
				end
				if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).name == "air" ) then
					minetest.env:set_node(pos, node)
				end
			end
		end,
			
		on_destruct = function(pos)
			local node = minetest.env:get_node(pos)
			local param2 = node.param2
			if param2 == 0 then
				pos.z = pos.z+1
			elseif param2 == 1 then
				pos.x = pos.x+1
			elseif param2 == 2 then
				pos.z = pos.z-1
			elseif param2 == 3 then
				pos.x = pos.x-1
			end
			if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).name == "furn:longsofa_middle_"..color ) then
				if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
					minetest.env:remove_node(pos)
					if param2 == 0 then
						pos.z = pos.z+1
					elseif param2 == 1 then
						pos.x = pos.x+1
					elseif param2 == 2 then
						pos.z = pos.z-1
					elseif param2 == 3 then
						pos.x = pos.x-1
					end
					if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).name == "furn:longsofa_left_"..color ) then
						if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
							minetest.env:remove_node(pos)
						end	
					end
				end	
			end
		end,
		
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

	minetest.register_node("furn:longsofa_middle_"..color, {
		drawtype = "nodebox",
		tiles = {"furn_longsofa_middle_top_"..color..".png", 
			"furn_coffeetable_back.png",  
			"furn_longsofa_middle_front_"..color..".png",  
			"furn_sofa_back_"..color..".png",  
			"furn_sofa_left_side_"..color..".png",  
			"furn_sofa_right_side_"..color..".png"
		},
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						--legs
						{-0.4375, -0.5, -0.03125, -0.375, -0.375, 0.03125},
						{0.375, -0.5, -0.03125, 0.4375, -0.375, 0.03125},
						
						--base/cushion
						{-0.5, -0.375, -0.5, 0.5, 0, 0.5},
						
						--back
						{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{0, 0, 0, 0, 0, 0},
					}
		},
	})
	
	minetest.register_node("furn:longsofa_left_"..color, {
		drawtype = "nodebox",
		tiles = {"furn_sofa_left_top_"..color..".png", 
			"furn_coffeetable_back.png",  
			"furn_sofa_left_front_"..color..".png",  
			"furn_sofa_back_"..color..".png",  
			"furn_sofa_left_side_"..color..".png",  
			"furn_sofa_right_side_"..color..".png"
		},
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
		sounds = default.node_sound_wood_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
						--legs
						{-0.4375, -0.5, 0.375, -0.375, -0.375, 0.4375},
						{0.375, -0.5, 0.375, 0.4375, -0.375, 0.4375},
						
						--base/cushion
						{-0.5, -0.375, -0.5, 0.5, 0, 0.5},
						
						--back
						{-0.5, 0, -0.5, -0.3125, 0.5, 0.5},
						
						--arm
						{-0.3125, 0, 0.3125, 0.5, 0.25, 0.5},
					}
		},
		selection_box = {
			type = "fixed",
			fixed = {
						{0, 0, 0, 0, 0, 0},
					}
		},
	})
	
	minetest.register_alias("furn:longsofa_"..color, "furn:longsofa_right_"..color)

	minetest.register_craft({
		output = "furn:longsofa_"..color,
		recipe = {
			{"wool:"..color, "wool:"..color, "wool:"..color, },
			{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood", },
			{"default:stick", "default:stick", "default:stick", }
		}
	})
	--[[
	minetest.register_craft({
		output = "furn:longsofa_"..color,
		recipe = {
			{"wool:"..color, "wool:"..color, "wool:"..color, },
			{"moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood", },
			{"default:stick", "default:stick", "default:stick", }
		}
	})

	minetest.register_craft({
		output = "furn:longsofa_"..color,
		recipe = {
			{"wool:"..color, "wool:"..color, "wool:"..color, },
			{"group:wood_slab", "group:wood_slab", "group:wood_slab", },
			{"default:stick", "default:stick", "default:stick", }
		}
	})
--]]
end
