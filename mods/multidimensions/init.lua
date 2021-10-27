if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
multidimensions={
	start_y=4000,
	max_distance=160, --(50 is 800)
	max_distance_chatt=1000,
	limited_chat=true,
	limeted_nametag=true,
	remake_home=true,
	remake_bed=false,
	user={},
	player_pos={},
	earth = {
		above=31000,
		under=-31000,
	},
	craftable_teleporters=true,
	registered_dimensions={},
--	first_dimensions_appear_at =13000,
	calculating_dimensions_from_min_y = 0,
	map={
		offset=0,
		scale=1,
		spread={x=100,y=18,z=100},
		seeddiff=24,
		octaves=5,
		persist=0.7,
		lacunarity=1,
		flags="absvalue",
	},
}

multidimensions.first_dimensions_appear_at = tonumber(minetest.settings:get("first_dimension") or 13000)

minetest.register_craftitem("multidimensions:dimension_disc", {
   description = "Dimension Disc",
   inventory_image = "dimension_disc.png",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "default:gravel",
	recipe = "default:diamondblock",
	replacements = {{"default:diamondblock","multidimensions:dimension_disc" }}
})

local t = { {name = "multidimensions:dimension_disc", chance = 0.02, count = {1, 3}, }, }
dungeon_loot.register(t)

dofile(minetest.get_modpath("multidimensions") .. "/api.lua")
dofile(minetest.get_modpath("multidimensions") .. "/dimensions.lua")
dofile(minetest.get_modpath("multidimensions") .. "/tools.lua")