minetest.register_node("furn:coffeetable_back", {
	description = "Coffee Table",
	drawtype = "nodebox",
	tiles = {"furn_coffeetable_back.png", "furn_coffeetable_back.png",  "furn_coffeetable_back.png",  "furn_coffeetable_back.png",  "furn_coffeetable_back.png",  "furn_coffeetable_back.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	stack_max = 1,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					--legs
					{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.3125},
					{0.3125, -0.5, -0.375, 0.375, -0.0625, -0.3125},
					
					--tabletop
					{-0.4375, -0.0625, -0.4375, 0.4375, 0, 0.5},	
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.4375, -0.5, -0.4375, 0.4375, 0.0, 1.4375},
				}
	},

	on_construct = function(pos)
		local node = minetest.env:get_node(pos)
		local param2 = node.param2
		node.name = "furn:coffeetable_front"
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
		if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).name == "furn:coffeetable_front" ) then
			if( minetest.env:get_node({x=pos.x, y=pos.y, z=pos.z}).param2 == param2 ) then
				minetest.env:remove_node(pos)
			end	
		end
	end,
})

minetest.register_node("furn:coffeetable_front", {
	drawtype = "nodebox",
	tiles = {"furn_coffeetable_front.png", "furn_coffeetable_front.png",  "furn_coffeetable_front.png",  "furn_coffeetable_front.png",  "furn_coffeetable_front.png",  "furn_coffeetable_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					--legs
					{-0.375, -0.5, 0.3125, -0.3125, -0.0625, 0.375},
					{0.3125, -0.5, 0.3125, 0.375, -0.0625, 0.375},
					
					--tabletop
					{-0.4375, -0.0625, -0.5, 0.4375, 0, 0.4375},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{0, 0, 0, 0, 0, 0},
				}
	},
})

minetest.register_alias("furn:coffeetable", "furn:coffeetable_back")

minetest.register_craft({
	output = "furn:coffeetable",
	recipe = {
		{"", "", "", },
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood", },
		{"default:stick", "", "default:stick", }
	}
})

minetest.register_craft({
	output = "furn:coffeetable",
	recipe = {
		{"", "", "", },
		{"moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood", },
		{"default:stick", "", "default:stick", }
	}
})

minetest.register_craft({
	output = "furn:coffeetable",
	recipe = {
		{"", "", "", },
		{"group:wood_slab", "group:wood_slab", "group:wood_slab", },
		{"default:stick", "", "default:stick", }
	}
})

minetest.register_node("furn:endtable", {
	description = "End Table",
	drawtype = "nodebox",
	tiles = {"furn_coffeetable_back.png", "furn_coffeetable_back.png",  "furn_coffeetable_back.png",  "furn_coffeetable_back.png",  "furn_coffeetable_back.png",  "furn_coffeetable_back.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	stack_max = 1,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					--legs
					{-0.375, -0.5, -0.375, -0.3125, -0.0625, -0.3125},
					{0.3125, -0.5, -0.375, 0.375, -0.0625, -0.3125},
					{-0.375, -0.5, 0.3125, -0.3125, -0.0625, 0.375},
					{0.3125, -0.5, 0.3125, 0.375, -0.0625, 0.375},
					
					--tabletop
					{-0.4375, -0.0625, -0.4375, 0.4375, 0, 0.4375},	
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.4375, -0.5, -0.4375, 0.4375, 0.0, 0.4375},
				}
	},
})

minetest.register_craft({
	output = "furn:endtable",
	recipe = {
		{"", "", "", },
		{"stairs:slab_wood", "stairs:slab_wood", "", },
		{"default:stick", "default:stick", "", }
	}
})

minetest.register_craft({
	output = "furn:endtable",
	recipe = {
		{"", "", "", },
		{"moreblocks:slab_wood", "moreblocks:slab_wood", "", },
		{"default:stick", "default:stick", "", }
	}
})

minetest.register_craft({
	output = "furn:endtable",
	recipe = {
		{"", "", "", },
		{"group:wood_slab", "group:wood_slab", "", },
		{"default:stick", "default:stick", "", }
	}
})
