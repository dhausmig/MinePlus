
--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

technic.register_recipe_type("extracting", {
	description = S("Extracting"),
	icon = "technic_recipe_icon_extracting.png"})

function technic.register_extractor_recipe(data)
	data.time = data.time or 4
	technic.register_recipe("extracting", data)
end

if minetest.get_modpath("dye") then
	-- check if we are using dye or unifieddyes
	local unifieddyes = minetest.get_modpath("unifieddyes")

	-- register recipes with the same crafting ratios as `dye` provides
	local dye_recipes = {
		{"technic:coal_dust",                 "dye:black 2"},
		{"default:grass_1",                   "dye:green 1"},
 		{"default:dry_shrub",                 "dye:brown 6"},
		{"default:junglegrass",               "dye:green 2"},
		{"default:cactus",                    "dye:green 4"},
		{"flowers:geranium",                  "dye:blue 4"},
		{"flowers:dandelion_white",           "dye:white 4"},
		{"flowers:dandelion_yellow",          "dye:yellow 4"},
		{"flowers:tulip",                     "dye:orange 4"},
		{"flowers:rose",                      "dye:red 4"},
		{"flowers:viola",                     "dye:violet 4"},
		{"flowers:chrysanthemum_green",       "dye:green 4"},
		{"flowers:tulip_black",               "dye:black 4"},
		{"bones:bones",                       "dye:black 4"},
	}

	if minetest.get_modpath("beautiflowers") then
		-- bonsai
		table.insert(dye_recipes, { "beautiflowers:bonsai_1", "dye:green 4"})      
		table.insert(dye_recipes, { "beautiflowers:bonsai_2", "dye:brown 4"})      
		table.insert(dye_recipes, { "beautiflowers:bonsai_3", "dye:green 4"})      
		table.insert(dye_recipes, { "beautiflowers:bonsai_4", "dye:brown 4"})      
		table.insert(dye_recipes, { "beautiflowers:bonsai_5", "dye:dark_green 4"})      
		-- pasto
		table.insert(dye_recipes, { "beautiflowers:pasto_1", "dye:dark_green 4"})      
		table.insert(dye_recipes, { "beautiflowers:pasto_2", "dye:dark_green 4"})      
		table.insert(dye_recipes, { "beautiflowers:pasto_3", "dye:dark_green 4"})      
		table.insert(dye_recipes, { "beautiflowers:pasto_4", "dye:dark_green 4"})      
		table.insert(dye_recipes, { "beautiflowers:pasto_5", "dye:dark_green 4"})      
		table.insert(dye_recipes, { "beautiflowers:pasto_6", "dye:dark_green 4"})      
		table.insert(dye_recipes, { "beautiflowers:pasto_7", "dye:dark_green 4"})      
		table.insert(dye_recipes, { "beautiflowers:pasto_8", "dye:dark_green 4"})      
		table.insert(dye_recipes, { "beautiflowers:pasto_9", "dye:dark_green 4"})      
		table.insert(dye_recipes, { "beautiflowers:pasto_10", "dye:dark_green 4"})      
		-- flowers
		table.insert(dye_recipes, { "beautiflowers:arcoiris", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:ada", "dye:yellow 4"})      
		table.insert(dye_recipes, { "beautiflowers:agnes", "dye:yellow 4"})      
		table.insert(dye_recipes, { "beautiflowers:alicia", "dye:yellow 4"})      
		table.insert(dye_recipes, { "beautiflowers:alma", "dye:yellow 4"})      
		table.insert(dye_recipes, { "beautiflowers:amaia", "dye:yellow 4"})      
		table.insert(dye_recipes, { "beautiflowers:any", "dye:yellow 4"})      
		table.insert(dye_recipes, { "beautiflowers:anastasia", "dye:yellow 4"})      
		table.insert(dye_recipes, { "beautiflowers:astrid", "dye:blue 4"})      
		table.insert(dye_recipes, { "beautiflowers:beatriz", "dye:blue 4"})      
		table.insert(dye_recipes, { "beautiflowers:belen", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:berta", "dye:blue 4"})      
		table.insert(dye_recipes, { "beautiflowers:blanca", "dye:blue 4"})      
		table.insert(dye_recipes, { "beautiflowers:carla", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:casandra", "dye:blue 4"})      
		table.insert(dye_recipes, { "beautiflowers:clara", "dye:blue 4"})      
		table.insert(dye_recipes, { "beautiflowers:claudia", "dye:blue 4"})      
		table.insert(dye_recipes, { "beautiflowers:cloe", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:cristina", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:dafne", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:dana", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:delia", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:elena", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:erica", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:estela", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:eva", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:fabiola", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:fiona", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:gala", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:gisela", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:gloria", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:irene", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:ingrid", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:iris", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:ivette", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:jennifer", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:lara", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:laura", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:lidia", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:lucia", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:mara", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:martina", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:melania", "dye:orange 4"})      
		table.insert(dye_recipes, { "beautiflowers:mireia", "dye:red 4"})       
		table.insert(dye_recipes, { "beautiflowers:nadia", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:nerea", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:noelia", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:noemi", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:olimpia", "dye:magenta 4"})      
		table.insert(dye_recipes, { "beautiflowers:oriana", "dye:magenta 4"})      
		table.insert(dye_recipes, { "beautiflowers:pia", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:raquel", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:ruth", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:sandra", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:sara", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:silvia", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:sofia", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:sonia", "dye:pinkw 4"})      
		table.insert(dye_recipes, { "beautiflowers:talia", "dye:pink 4"})      
		table.insert(dye_recipes, { "beautiflowers:thais", "dye:cyan 4"})      
		table.insert(dye_recipes, { "beautiflowers:valeria", "dye:cyan 4"})      
		table.insert(dye_recipes, { "beautiflowers:valentina", "dye:cyan 4"})      
		table.insert(dye_recipes, { "beautiflowers:vera", "dye:cyan 4"})      
		table.insert(dye_recipes, { "beautiflowers:victoria", "dye:cyan 4"})      
		table.insert(dye_recipes, { "beautiflowers:xenia", "dye:cyan 4"})      
		table.insert(dye_recipes, { "beautiflowers:zaida", "dye:cyan 4"})      
		table.insert(dye_recipes, { "beautiflowers:virginia", "dye:cyan 4"})      
		table.insert(dye_recipes, { "beautiflowers:nazareth", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:arleth", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:miriam", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:minerva", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:vanesa", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:sabrina", "dye:red 4"})      
		table.insert(dye_recipes, { "beautiflowers:rocio", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:regina", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:paula", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:olga", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:xena", "dye:violet 4"})      
		table.insert(dye_recipes, { "beautiflowers:diana", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:michelle", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:genesis", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:suri", "dye:white 4"})      
		table.insert(dye_recipes, { "beautiflowers:hadassa", "dye:white 4"})      
	end

	if minetest.get_modpath("bushes") then
		table.insert(dye_recipes, {"bushes:blackberry", unifieddyes and "unifieddyes:magenta_s50 4" or "dye:violet 4"})
		table.insert(dye_recipes, {"bushes:blueberry", unifieddyes and "unifieddyes:magenta_s50 4" or "dye:magenta 4"})
	end

	if (minetest.get_modpath("hunger") or minetest.get_modpath("hbhunger"))  and minetest.get_modpath("ethereal") then
		table.insert(dye_recipes, {"ethereal:willow_twig 12", "technic:aspirin_pill"})
	end

	if minetest.get_modpath("farming") then
		-- Cottonseed oil: a fuel and a potent fertilizer (irl: pesticide) ---
		-- hemp oil calls for 8 seeds, but extractor recipes are normally twice as potent
-- food mod registers cottonseed and hemp oils
--		table.insert(dye_recipes, {"farming:seed_cotton 4", "technic:cottonseed_oil"})

		-- Dyes ---
		-- better recipes for farming's crafting methods (twice the output)
		table.insert(dye_recipes, {"farming:chili_pepper", "dye:red 4"})
		table.insert(dye_recipes, {"farming:beans", "dye:green 4"})
		table.insert(dye_recipes, {"farming:grapes", "dye:violet 4"})
		table.insert(dye_recipes, {"farming:cocoa_beans", "dye:brown 4"})
		table.insert(dye_recipes, {"farming:beetroot", "dye:red 2"})
		-- Some extra recipes:
		-- Himalayan rhubarb root can give yellow dye IRL
		table.insert(dye_recipes, {"farming:rhubarb", "dye:yellow 4"})
		table.insert(dye_recipes, {"farming:onion", "dye:yellow 4"})
		table.insert(dye_recipes, {"farming:blueberries", "dye:blue 4"})
		table.insert(dye_recipes, {"farming:raspberries", "dye:red 4"})

		if farming.mod and farming.mod == "undo" then
			table.insert(dye_recipes, {"farming:blackberry", "dye:violet 4"})
		end

	end

	if minetest.get_modpath("ethereal") then
		table.insert(dye_recipes, {"ethereal:seaweed", "dye:dark_green 6"})
		table.insert(dye_recipes, {"ethereal:coral2", "dye:cyan 6"})
		table.insert(dye_recipes, {"ethereal:coral3", "dye:orange 6"})
		table.insert(dye_recipes, {"ethereal:coral4", "dye:pink 6"})
		table.insert(dye_recipes, {"ethereal:coral5", "dye:green 6"})
		table.insert(dye_recipes, {"ethereal:fern", "dye:dark_green 4"})
		table.insert(dye_recipes, {"ethereal:snowygrass", "dye:grey 4"})
		table.insert(dye_recipes, {"ethereal:crystalgrass", "dye:blue 4"})
		table.insert(dye_recipes, {"ethereal:mushroom", "dye:white 4"})
		if minetest.get_modpath("flowers") then
			-- Mushroom biome convertion serum
			table.insert(dye_recipes, {"flowers:mushroom_red 3", "technic:antishroom"})
		end
	end


	if minetest.get_modpath("bakedclay") then
		table.insert(dye_recipes, {"bakedclay:delphinium", "dye:cyan 4"})
		table.insert(dye_recipes, {"bakedclay:thistle", "dye:magenta 4"})
		table.insert(dye_recipes, {"bakedclay:lazarus", "dye:pink 4"})
		table.insert(dye_recipes, {"bakedclay:mannagrass", "dye:dark_green 4"})
	end

	if minetest.get_modpath("wine") then
		table.insert(dye_recipes, {"wine:blue_agave", "dye:cyan 6"})
	end

	if minetest.get_modpath("bonemeal") then
		table.insert(dye_recipes, {"bonemeal:bone", "dye:white 8"})
		table.insert(dye_recipes, {"bonemeal:bonemeal", "dye:white 4"})
	end


	for _, data in ipairs(dye_recipes) do
		technic.register_extractor_recipe({input = {data[1]}, output = data[2]})
	end

	--[[ this is not needed - recipes were changed in dyes
	-- overwrite the existing crafting recipes
	-- it appears impossible to use clear_craft by recipe, and using it by output could
	-- elimiate completely unrelated recipes
	local dyes = {"white", "red", "yellow", "blue", "violet", "orange", "green", "black"}
	if minetest.get_modpath("bakedclay") then
		table.insert(dyes, "cyan")
		table.insert(dyes, "magenta")
		table.insert(dyes, "pink")
		table.insert(dyes, "dark_green")
	end
	for _, color in ipairs(dyes) do

		minetest.register_craft({
		        type = "shapeless",
		        output = "dye:"..color.." 1",
		        recipe = {"group:flower,color_"..color},
		})

	end


	minetest.register_craft({
		type = "shapeless",
		output = "dye:black 1",
		recipe = {"group:coal"},
	})

	if unifieddyes then
		minetest.register_craft({
			type = "shapeless",
			output = "dye:green 1",
			recipe = {"default:cactus"},
		})
	end
	--]]
end
