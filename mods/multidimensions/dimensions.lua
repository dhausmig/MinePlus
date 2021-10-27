-- multidimensions/dimensions.lua

--edited by dhausmig

-- define some tables
local ores={
	["default:coal_ore"]=200,
	["default:iron_ore"]=400,
	["default:copper_ore"]=500,
	["default:gold_ore"]=2000,
	["default:mese_ore"]=10000,
	["default:diamond_ore"]=20000,
	["default:mese"]=40000,
	["default:goldblock"]=500,
	["default:diamondblock"]=2000,
	["moreores:silver_ore"]=1000,
	["moreores:mithril_ore"]=5000,
	["xtraores:nickel_ore"]=500,
	["xtraores:platinum_ore"]=2500,
	["xtraores:palladium_ore"]=4500,
	["xtraores:cobalt_ore"]=6500,
	["xtraores:thorium_ore"]=8500,
	["xtraores:anthracite_ore"]=10500,
	["xtraores:osmium_ore"]=12500,
	["xtraores:rhenium_ore"]=14500,
	["xtraores:vanadium_ore"]=16500,
	["xtraores:rarium_ore"]=18500,
	["xtraores:orichalcum_ore"]=20500,
	["xtraores:titanium_ore"]=22500,
	["xtraores:iridium_ore"]=24500,
	["xtraores:neutronium_ore"]=26500,
	["default:gravel"]={chance=3000,chunk=2,}
}

local plants = {
	["flowers:mushroom_brown"] = 1000,
	["flowers:mushroom_red"] = 1000,
	["flowers:rose"] = 1000,
	["flowers:tulip"] = 1000,
	["flowers:dandelion_yellow"] = 1000,
	["flowers:geranium"] = 1000,
	["flowers:viola"] = 1000,
	["flowers:dandelion_white"] = 1000,
	["default:junglegrass"] = 2000,
	["default:papyrus"] = 2000,
	["default:grass_3"] = 10,
	["multidimensions:tree"] = 1000,
	["multidimensions:aspen_tree"] = 1000,
	["multidimensions:pine_tree"] = 1000,
}

local many_plants = {
	["farming:barley_7"]=10000,
	["farming:beanbush"]=10000,
	["farming:beetroot_5"]=10000,
	["farming:blackberry_4"]=10000,
	["farming:blueberry_4"]=10000,
	["farming:cabbage_6"]=10000,
	["farming:carrot_8"]=10000,
	["farming:chili_8"]=10000,
	["farming:coffee_5"]=10000,
	["farming:corn_8"]=10000,
	["farming:cotton_wild"]=10000,
	["farming:cucumber_4"]=10000,
	["farming:garlic_5"]=10000,
	["farming:grapebush"]=10000,
	["farming:hemp_8"]=10000,
	["farming:lettuce_5"]=10000,
	["farming:mint_4"]=10000,
	["farming:oat_8"]=10000,
	["farming:onion_5"]=10000,
	["farming:pea_5"]=10000,
	["farming:pepper_5"]=10000,
	["farming:pineapple_8"]=10000,
	["farming:potato_4"]=10000,
	["farming:pumpkin_8"]=10000,
	["farming:raspberry_4"]=10000,
	["farming:rhubarb_3"]=10000,
	["farming:rice_8"]=10000,
	["farming:rye_8"]=10000,
	["farming:soy_5"]=10000,
	["farming:tomato_8"]=10000,
	["farming:vanilla_7"]=10000,
	["farming:wheat_8"]=10000,
	["flowers:mushroom_brown"] = 1000,
	["flowers:mushroom_red"] = 1000,
	["flowers:rose"] = 1000,
	["flowers:tulip"] = 1000,
	["flowers:tulip_black"] = 1000,
	["flowers:dandelion_yellow"] = 1000,
	["flowers:geranium"] = 1000,
	["flowers:viola"] = 1000,
	["flowers:dandelion_white"] = 1000,
	["flowers:chrysanthemum_green"] = 1000,
}
local jungle_list = {
	["multidimensions:mahogany_tree"] = 100,
	["multidimensions:jacaranda_tree"] = 250,
	["multidimensions:maple_tree"] = 300,
	["multidimensions:pomegranate_tree"] = 200,
	["multidimensions:ebony_tree"] = 150,
	["multidimensions:jungle_tree"] = 200,
	["multidimensions:emergent_jungle_tree"] = 3000,
	["multidimensions:metasequoia"] = 2000,
	["multidimensions:cherry_tree"] = 150,
	["multidimensions:plum_tree"] = 200,
--	["bamboo:sprout"] = 50,
	["default:junglegrass"] = 10,
	["flowers:mushroom_brown"] = 50,
	["flowers:mushroom_red"] = 1000,
	["default:papyrus"] = 2000,
	["farming:chili_8"] = 1000,
	["farming:coffee_5"] = 1000,
	["farming:pineapple_8"] = 700,
	["farming:strawberry_8"] = 25,
	["farming:vanilla_7"] = 80,
   },

minetest.register_node("multidimensions:tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:pine_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:pine_treesnow", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:jungle_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:emergent_jungle_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:aspen_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:acacia_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:metasequoia", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:maple_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:mahogany_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:ebony_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:jacaranda_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:pomegranate_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:cherry_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})
minetest.register_node("multidimensions:plum_tree", {drawtype="airlike",groups = {multidimensions_tree=1,not_in_creative_inventory=1},})

-- Register the dimensions

-- Plane Y

multidimensions.register_dimension("planeY",{
	ground_ores = table.copy(many_plants),
	enable_water=false,
	dirt="default:dirt_with_grass",
	stone="default:stone",
	stone_ores = table.copy(ores),
	flatland=true,
	gravity = 0.9,
	node={description="Plane Y"},
	craft = {
		{"caverealms:glow_emerald_ore", "default:sand", "default:sand"},
		{"default:sand","multidimensions:dimension_disc","default:sand",},
		{"default:sand", "default:sand", "default:sand"},
	}
})

-- Flat Plane

multidimensions.register_dimension("flatplane",{
	ground_ores = table.copy(many_plants),
	enable_water=true,
	dirt="default:dirt_with_grass",
	dirt_depth = 12,
	stone="default:coral_skeleton",
	stone_ores = table.copy(ores),
	flatland=true,
	gravity = 1.05,
	node={description="Flat Plane"},
	craft = {
		{"caverealms:glow_amethyst_ore", "default:sand", "default:sand"},
		{"default:sand","multidimensions:dimension_disc","default:sand",},
		{"default:sand", "default:sand", "default:sand"},
	}
})

-- Earthlike 0

multidimensions.register_dimension("earthlike0",{
	dirt="default:dirt_with_grass",
	dirt_depth = 5,
	ground_ores = table.copy(plants),
	stone="default:stone",
	stone_ores = table.copy(ores),
	sand_ores={["default:clay"]={chunk=2,chance=500}},
	node={description="Alternative Earth 0"},
	map={spread={x=32,y=16,z=32}},
	ground_limit=600,
	gravity = 0.75,
	craft = {
		{"caverealms:glow_ore", "default:dirt", "default:sand"},
		{"default:sand","multidimensions:dimension_disc","default:sand",},
		{"default:sand", "default:sand", "default:sand"},
	}
})

-- Earthlike 1

multidimensions.register_dimension("earthlike1",{
	dirt="default:dirt_with_grass",
	dirt_depth = 5,
	ground_ores = table.copy(plants),
	stone_ores = table.copy(ores),
	sand_ores={["default:clay"]={chunk=2,chance=5000}},
	grass_ores={
		["default:dirt_with_snow"]={chance=1,max_heat=20},
	},
	water_ores={
		["default:ice"]={chance=1,max_heat=20},
	},
	node={description="Alternative Earth"},
	gravity = 1.0,
	craft = {
		{"caverealms:glow_ruby_ore", "default:dirt", "default:dirt"},
		{"default:sand","multidimensions:dimension_disc","default:sand",},
		{"default:sand", "default:sand", "default:sand"},
	}
})

-- Earthlike 2

multidimensions.register_dimension("earthlike2",{
	dirt="default:dirt_with_grass",
	dirt_depth = 5,
	ground_ores = table.copy(many_plants),
	stone_ores = table.copy(ores),
	sand_ores={["default:clay"]={chunk=2,chance=5000}},
	node={description="Alternative Earth 2"},
	map={spread={x=20,y=18,z=20}},
	ground_limit=550,
	gravity = 0.5,
	craft = {
		{"caverealms:icicle_down", "default:dirt", "default:dirt"},
		{"default:sand","multidimensions:dimension_disc","default:dirt",},
		{"default:sand", "default:sand", "default:sand"},
	}
})

-- Farmland

multidimensions.register_dimension("Farmland",{
	node={description="Farmland"},
	enable_water=true,
	dirt="farming:soil_wet",
	dirt_depth = 1,
	water_depth = 1,
	stone="default:water_source",
--	stone_ores = table.copy(ores),
	flatland=true,
	gravity = 1.0,
	craft = {
		{"caverealms:icicle_up", "default:dirt", "default:sand"},
		{"default:sand","multidimensions:dimension_disc","default:sand",},
		{"default:sand", "default:sand", "default:sand"},
	},
	sky={base_color = 0xffa048d0, type = "plain"},
})

-- Savanna

multidimensions.register_dimension("savana",{
	ground_ores = {
		["default:dry_shrub"]=50,
		["default:dry_grass_4"]=10,
		["multidimensions:acacia_tree"]=5000,
		["multidimensions:jungle_tree"]=7000,
		["multidimensions:emergent_jungle_tree"]=7000,
		["multidimensions:metasequoia"]=9000,

	},
	grass="default:dirt_with_dry_grass",
	stone_ores = table.copy(ores),
	sand_ores={["default:clay"]=100},
	node={description="Savana"},
	craft = {
		{"default:dirt", "default:dirt", "default:dirt"},
		{"default:sand","multidimensions:dimension_disc","default:dirt",},
		{"default:sand", "default:dirt", "default:dirt"},
	}
})

-- Cold

multidimensions.register_dimension("cold",{
	ground_ores = {
		["default:snow"]=100,
		["multidimensions:pine_treesnow"]=8000,
	},
	dirt="default:snowblock",
	grass="default:snowblock",
	water="default:ice",
	stone="default:ice",
	sand="default:ice",
	node={description="Cold"},
	craft = {
		{"zombies:tooth", "default:dirt", "default:dirt"},
		{"default:sand","multidimensions:dimension_disc","default:dirt",},
		{"default:dirt", "default:dirt", "default:dirt"},
	}
})

-- Desert

multidimensions.register_dimension("desert",{
	dirt="default:desert_sand",
	grass="default:desert_sand",
	stone="default:desert_stone",
	sand="default:desert_sand",
	node={description="Desert"},
	enable_water=false,
	gravity=0.66,
	map={octaves=2,persist=0.3,lacunarity=2},
	craft = {
		{"scorpion:shell", "default:dirt", "default:dirt"},
		{"default:dirt","multidimensions:dimension_disc","default:dirt",},
		{"default:dirt", "default:dirt", "default:dirt"},
	},
	sky={base_color = 0xffdb7a33, type = "plain"},
})

-- Hot

multidimensions.register_dimension("hot",{
	ground_ores = {
		["fire:permanent_flame"]=100,
	},
	dirt="default:stone",
	grass="default:stone",
	sand="default:lava_source",
	stone="default:obsidian",
	water="default:lava_source",
	map={octaves=3,persist=0.6,lacunarity=2},
	node={description="Hot"},
	craft = {
		{"default:sand", "default:dirt", "default:dirt"},
		{"default:dirt","multidimensions:dimension_disc","default:dirt",},
		{"default:dirt", "default:dirt", "default:dirt"},
	},
	sky={base_color = 0xffff2828, type = "plain"},
})

-- Water

multidimensions.register_dimension("water",{
	dirt="default:water_source",
	grass="default:water_source",
	sand="default:stone",
	node={description="Water World"},
	flatland=1,
	stone="default:water_source",
	air="default:water_source",
	craft = {
		{"default:sand", "default:sand", "default:dirt"},
		{"default:dirt","multidimensions:dimension_disc","default:dirt",},
		{"default:dirt", "default:dirt", "default:dirt"},
	}
})

-- Sandstone

multidimensions.register_dimension("sandstone",{
	dirt="default:sandstone",
	grass="default:silver_sandstone",
	sand="default:silver_sandstone",
	node={description="Sandstone"},
	stone="default:desert_sandstone",
	gravity = 0.8,
	enable_water=true,
	craft = {
		{"default:sand", "default:sand", "default:sand"},
		{"default:dirt","multidimensions:dimension_disc","default:dirt",},
		{"default:dirt", "default:dirt", "default:dirt"},
	}
})

-- Flat Earth

multidimensions.register_dimension("flatearth",{
	ground_ores = table.copy(many_plants),
	enable_water=false,
	dirt="default:dirt_with_grass",
	stone="default:stone",
	stone_ores = table.copy(ores),
	flatland=true,
	node={description="Flatearth"},
	craft = {
		{"default:sand", "default:sand", "default:sand"},
		{"default:dirt","multidimensions:dimension_disc","default:sand",},
		{"default:dirt", "default:dirt", "default:dirt"},
	}
})

-- Flat Earth 2

multidimensions.register_dimension("flatearth2",{
	ground_ores = table.copy(many_plants),
	enable_water=false,
	dirt="default:dirt_with_grass",
	stone="default:stone",
	stone_ores = table.copy(ores),
	flatland=true,
	node={description="Flatearth 2"},
	craft = {
		{"default:sand", "default:sand", "default:sand"},
		{"default:dirt","multidimensions:dimension_disc","default:sand",},
		{"default:dirt", "default:dirt", "default:sand"},
	}
})

-- Floatlandlike 2

multidimensions.register_dimension("floatlandlike2",{
	ground_ores = table.copy(many_plants),
	stone_ores = table.copy(ores),
	node={description="Alternative Floatland"},
	gravity = 0.16,
	ground_limit=750,
	map={
		spread={x=30,y=30,z=30},
		octaves=3,
		persist=0.2,
		lacunarity=2,
		flags="eased",
	},
	terrain_density=0.1,
	enable_water=false,
	self={
		blocking="multidimensions:blocking",
		killing = "multidimensions:killing",
	},
	on_generate=function(self,data,id,area,x,y,z)
		if y <= self.dirt_start-70 then
			data[id] = self.killing
		elseif y <= self.dirt_start-100 then
			data[id] = self.blocking
		elseif y <= self.dirt_start+5 then
			data[id] = self.air
		else
			return
		end
		return data
	end,
	craft = {
		{"default:sand", "default:sand", "default:sand"},
		{"default:dirt","multidimensions:dimension_disc","default:sand",},
		{"default:dirt", "default:sand", "default:sand"},
	}
})

-- Rainforest (Jungle)

multidimensions.register_dimension("rainforest",{
	ground_ores = table.copy(jungle_list),
	grass="default:dirt_with_rainforest_litter",
	stone_ores = table.copy(ores),
	enable_water=true,
	dirt="default:dirt_with_rainforest_litter",
	dirt_depth = 5,
	stone="technic:marble",
	flatland=true,
	node={description="Rainforest"},
	craft = {
		{"group:spike", "default:sand", "default:sand"},
		{"default:dirt","multidimensions:dimension_disc","default:sand",},
		{"default:sand", "default:sand", "default:sand"},
	},

})

-- End of Dimension List

minetest.register_lbm({
	name = "multidimensions:lbm",
	run_at_every_load = true,
	nodenames = {"group:multidimensions_tree"},
	action = function(pos, node)
		minetest.set_node(pos, {name = "air"})
		local tree=""
		if node.name=="multidimensions:tree" then
			tree=minetest.get_modpath("default") .. "/schematics/default_tree.mts"
		elseif node.name=="multidimensions:pine_tree" then
			tree=minetest.get_modpath("default") .. "/schematics/pine_tree.mts"
		elseif node.name=="multidimensions:pine_treesnow" then
			tree=minetest.get_modpath("default") .. "/schematics/snowy_pine_tree_from_sapling.mts"
		elseif node.name=="multidimensions:jungle_tree" then
			tree=minetest.get_modpath("default") .. "/schematics/jungle_tree.mts"
		elseif node.name=="multidimensions:emergent_jungle_tree" then
			tree=minetest.get_modpath("default") .. "/schematics/emergent_jungle_tree.mts"
			pos.y = pos.y -4
		elseif node.name=="multidimensions:maple_tree" then
			tree=minetest.get_modpath("maple") .. "/schematics/maple_tree.mts"
		elseif node.name=="multidimensions:metasequoia" then
			tree=minetest.get_modpath("metasequoia") .. "/schems/metasequoia.mts"
		elseif node.name=="multidimensions:aspen_tree" then
			tree=minetest.get_modpath("default") .. "/schematics/aspen_tree.mts"
		elseif node.name=="multidimensions:acacia_tree" then
			tree=minetest.get_modpath("default") .. "/schematics/acacia_tree.mts"
		elseif node.name=="multidimensions:mahogany_tree" then
			tree=minetest.get_modpath("mahogany") .. "/schematics/mahogany.mts"
		elseif node.name=="multidimensions:ebony_tree" then
			tree=minetest.get_modpath("ebony") .. "/schematics/ebony.mts"
		elseif node.name=="multidimensions:jacaranda_tree" then
			tree=minetest.get_modpath("jacaranda") .. "/schematics/jacaranda.mts"
		elseif node.name=="multidimensions:pomegranate_tree" then
			tree=minetest.get_modpath("pomegranate") .. "/schematics/pomegranate.mts"
		elseif node.name=="multidimensions:cherry_tree" then
			tree=minetest.get_modpath("cherrytree") .. "/schematics/cherrytree.mts"
		elseif node.name=="multidimensions:plum_tree" then
			tree=minetest.get_modpath("plumtree") .. "/schematics/plumtree.mts"
		end
		minetest.place_schematic({x=pos.x,y=pos.y,z=pos.z}, tree, "random", {}, true)
	end,
})
