
--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

technic.register_recipe_type("alloy", {
	description = S("Alloying"),
	icon = "technic_recipe_icon_alloy.png",
	input_size = 2,
})

function technic.register_alloy_recipe(data)
	data.time = data.time or 6
	technic.register_recipe("alloy", data)
end

local recipes = {
	{"technic:copper_dust 3",         "technic:tin_dust",           "technic:bronze_dust 4"},
	{"default:copper_ingot 3",        "moreores:tin_ingot",         "default:bronze_ingot 4"},
	{"technic:wrought_iron_dust",     "technic:coal_dust",          "technic:carbon_steel_dust",        3},
	{"technic:wrought_iron_ingot",    "technic:coal_dust",          "technic:carbon_steel_ingot",       3},
	{"technic:carbon_steel_dust",     "technic:coal_dust",          "technic:cast_iron_dust",           3},
	{"technic:carbon_steel_ingot",    "technic:coal_dust",          "technic:cast_iron_ingot",          3},
	{"technic:carbon_steel_dust 3",   "technic:chromium_dust",      "technic:stainless_steel_dust 4"},
	{"technic:carbon_steel_ingot 3",  "technic:chromium_ingot",     "technic:stainless_steel_ingot 4"},
	{"technic:copper_dust 2",         "technic:zinc_dust",          "technic:brass_dust 3"},
	{"default:copper_ingot 2",        "technic:zinc_ingot",         "technic:brass_ingot 3"},
	{"default:sand 2",                "technic:coal_dust 2",        "technic:silicon_wafer"},
	{"technic:silicon_wafer",         "technic:gold_dust",          "technic:doped_silicon_wafer"},
	-- from https://en.wikipedia.org/wiki/Carbon_black
	-- The highest volume use of carbon black is as a reinforcing filler in rubber products, especially tires.
	-- "[Compounding a] pure gum vulcanizate … with 50% of its weight of carbon black improves its tensile strength and wear resistance …"
	{"technic:raw_latex 4",           "technic:coal_dust 2",        "technic:rubber 6",                  2},
	{"technic:raw_latex 3",           "technic:sulfur_dust 1",      "technic:latex_foam",                2},
	-- straightforward way to get red stone
	{"default:stone",                 "dye:red",                    "default:desert_stone",              2},
}

if minetest.get_modpath("ethereal") then
	table.insert(recipes, {"ethereal:crystal_spike", "ethereal:fire_dust",   "default:mese_crystal 2"})
	table.insert(recipes, {"ethereal:crystal_spike", "default:mese_crystal", "ethereal:crystal_ingot"})
	if not minetest.get_modpath("bakedclay") then
		table.insert(recipes, {"default:clay", "dye:red",    "bakedclay:red",    3})
		table.insert(recipes, {"default:clay", "dye:orange", "bakedclay:orange", 3})
		table.insert(recipes, {"default:clay", "dye:grey",   "bakedclay:grey",   3})
	end
	if minetest.get_modpath("bonemeal") then
		table.insert(recipes, {"default:sand", "bonemeal:mulch", "ethereal:sandy 2"})
		table.insert(recipes, {"default:sand", "bonemeal:bonemeal", "ethereal:sandy"})
	end
end

if minetest.get_modpath("moreblocks") then
	table.insert(recipes, {"default:stone", "default:steel_ingot", "moreblocks:iron_stone 4", 3})
	table.insert(recipes, {"default:stone", "default:coal_lump", "moreblocks:coal_stone 4", 3})
end

if minetest.get_modpath("bakedclay") then

	local clay = {"white", "grey", "black", "red", "yellow",
	              "green", "cyan", "blue", "magenta", "orange",
	              "violet", "brown", "pink", "dark_grey", "dark_green"}

	-- the recipe of the bakedclay mod yields 8 blocks, so we'll do two times better
	for _,c in ipairs(clay) do
		table.insert(recipes, {"default:clay 8", "dye:" .. c, "bakedclay:" .. c .. " 16"})
	end

end

for _, data in pairs(recipes) do
	technic.register_alloy_recipe({input = {data[1], data[2]}, output = data[3], time = data[4]})
end
