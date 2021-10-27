
--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

technic.register_recipe_type("grinding", {
	description = S("Grinding"),
	icon = "technic_recipe_icon_grinding.png", })


function technic.register_grinder_recipe(data)
	data.time = data.time or 3
	technic.register_recipe("grinding", data)
end

local recipes = {
	-- Dusts
	{"default:coal_lump",          "technic:coal_dust 2"},
	{"default:coal_ore",          "technic:coal_dust 3"},
	{"default:coalblock",         "technic:coal_dust 18"},
	{"default:copper_lump",        "technic:copper_dust 2"},
	{"default:copper_ore",        "technic:copper_dust 3"},
	{"default:tin_lump",          "technic:tin_dust 2"},
	{"default:tin_ore",          "technic:tin_dust 3"},
	{"default:iron_lump",          "technic:wrought_iron_dust 2"},
	{"default:iron_ore",          "technic:wrought_iron_dust 3"},
	{"default:gold_lump",          "technic:gold_dust 2"},
	{"default:gold_ore",          "technic:gold_dust 3"},
	{"technic:chromium_lump",      "technic:chromium_dust 2"},
	{"technic:chromium_ore",      "technic:chromium_dust 3"},
	{"technic:uranium_lump",       "technic:uranium_dust 2"},
	{"technic:uranium_ore",       "technic:uranium_dust 3"},
	{"technic:zinc_lump",          "technic:zinc_dust 2"},
	{"technic:zinc_ore",          "technic:zinc_dust 3"},
	{"technic:lead_lump",          "technic:lead_dust 2"},
	{"technic:lead_ore",          "technic:lead_dust 3"},
	{"technic:sulfur_lump",        "technic:sulfur_dust 2"},
	{"technic:sulfur_ore",        "technic:sulfur_dust 3"},
	{"default:desert_stone",       "default:desert_sand"},
	{"default:stone",              "technic:stone_dust"},
	{"default:sand",               "technic:stone_dust"},
	-- recycle some items:
	{"xpanes:pane_flat 8",         "vessels:glass_fragments 3"},
	{"doors:door_glass",           "vessels:glass_fragments 6"},
	{"doors:door_wood",            "technic:sawdust 24"},
	{"doors:trapdoor",             "technic:sawdust 12"},
	{"doors:trapdoor_steel",       "technic:wrought_iron_dust 4"},
	{"doors:door_obsidian_glass",  "default:obsidian_shard 6"},
	{"doors:door_steel",           "technic:wrought_iron_dust 6"},
	{"default:sign_wall_steel",    "technic:wrought_iron_dust 2"},
	{"default:sign_wall_wood",     "technic:sawdust 8"},

	-- Other
	{"default:cobble",          "default:gravel"},
	{"default:gravel",          "default:sand"},
	{"technic:stone_dust",      "default:silver_sand"},

	-- Sands: reverse recipes can be found in the compressor
	{"default:sandstone",       "default:sand 2"},
	{"default:silver_sandstone","default:silver_sand 2"},
	{"default:desert_sandstone","default:desert_sand 2"},
}

if minetest.get_modpath("australia") then
	table.insert(recipes, {"australia:red_cobble", "australia:red_gravel"})
	table.insert(recipes, {"australia:red_gravel", "australia:red_sand"})
end

if minetest.get_modpath("otherworlds") then
	table.insert(recipes, {"asteroid:cobble", "asteroid:gravel"})
	table.insert(recipes, {"asteroid:gravel", "asteroid:dust"})
	table.insert(recipes, {"asteroid:redcobble", "asteroid:redgravel"})
	table.insert(recipes, {"asteroid:redgravel", "asteroid:reddust"})
end

if minetest.get_modpath("ethereal") then
	-- the density of charcoal is ~1/10 of coal, otherwise it's the same graphitic carbon
	table.insert(recipes, {"ethereal:charcoal_lump 5", "technic:coal_dust 1"})
end

if minetest.get_modpath("bonemeal") then
	table.insert(recipes, {"bonemeal:bone", "bonemeal:bonemeal 8"})
	table.insert(recipes, {"bones:bones", "bonemeal:bonemeal 12"})
end

if minetest.get_modpath("moreblocks") and moreblocks.mod and moreblocks.mod == "undo" then
	table.insert(recipes, {"moreblocks:cobble_compressed", "default:gravel 9"})
	table.insert(recipes, {"moreblocks:cobble_condensed", "default:gravel 81"})

	-- there is no other place to throw in the cooking recipe
	minetest.register_craft({
		type = "cooking",
		cooktime = 7,
		output = "default:stone 9",
		recipe = "moreblocks:cobble_compressed"
	})

	minetest.register_craft({
                type = "cooking",
                cooktime = 15,
                output = "default:stone 81",
                recipe = "moreblocks:cobble_condensed"
        })
end


if minetest.get_modpath("farming") then
	table.insert(recipes, {"farming:seed_wheat",   "food:flour 1"})
	table.insert(recipes, {"farming:seed_barley",   "food:flour 1"})
--[[ moved to food by dhausmig
	-- added by dhausmig
	if minetest.registered_items["farming:corn"] ~= nil then
		minetest.register_craftitem("technic:cornmeal", {
			description = S("Corn Meal"),
			inventory_image = "technic_cornmeal.png",
		})
		minetest.register_craftitem("technic:cornbread", {
			description = S("Cornbread"),
			inventory_image = "technic_cornbread.png",
			on_use = minetest.item_eat(8),
      })

      minetest.register_craft({
		type = "cooking",
		cooktime = 10,
		output = "technic:cornbread",
		recipe = "technic:cornmeal"
      })

      table.insert(recipes, {"farming:corn",   "technic:cornmeal 2"})
	-- end of dhausmig's addition
	end
--]]
	if farming.mod and (farming.mod == "redo" or farming.mod == "undo") then
		table.insert(recipes, {"farming:seed_oat",   "food:flour 1"})
		table.insert(recipes, {"farming:seed_rye",   "food:flour 1"})
		table.insert(recipes, {"farming:rice",       "farming:rice_flour 1"})
		table.insert(recipes, {"farming:seed_rice",  "farming:rice_flour 1"})
	end

end

if minetest.get_modpath("moreores") then
	table.insert(recipes, {"moreores:mithril_lump",   "technic:mithril_dust 2"})
	table.insert(recipes, {"moreores:mithril_ore",   "technic:mithril_dust 3"})
	table.insert(recipes, {"moreores:silver_lump",    "technic:silver_dust 2"})
	table.insert(recipes, {"moreores:silver_ore",    "technic:silver_dust 3"})
--	table.insert(recipes, {"moreores:tin_lump",       "technic:tin_dust 2"})
end

if minetest.get_modpath("gloopores") or minetest.get_modpath("glooptest") then
	table.insert(recipes, {"gloopores:alatro_lump",   "technic:alatro_dust 2"})
	table.insert(recipes, {"gloopores:kalite_lump",   "technic:kalite_dust 2"})
	table.insert(recipes, {"gloopores:arol_lump",     "technic:arol_dust 2"})
	table.insert(recipes, {"gloopores:talinite_lump", "technic:talinite_dust 2"})
	table.insert(recipes, {"gloopores:akalin_lump",   "technic:akalin_dust 2"})
end
-- added by dhausmig
if minetest.get_modpath("xtraores") then
	table.insert(recipes, {"xtraores:nickel_lump",			"xtraores:nickel_dust 2"})
	table.insert(recipes, {"xtraores:nickel_ore",			"xtraores:nickel_dust 3"})
	table.insert(recipes, {"xtraores:platinum_lump",		"xtraores:platinum_dust 2"})
	table.insert(recipes, {"xtraores:platinum_ore",			"xtraores:platinum_dust 3"})
	table.insert(recipes, {"xtraores:palladium_lump",		"xtraores:palladium_dust 2"})
	table.insert(recipes, {"xtraores:palladium_ore",		"xtraores:palladium_dust 3"})
	table.insert(recipes, {"xtraores:cobalt_lump",			"xtraores:cobalt_dust 2"})
	table.insert(recipes, {"xtraores:cobalt_ore",			"xtraores:cobalt_dust 3"})
	table.insert(recipes, {"xtraores:thorium_lump",			"xtraores:thorium_dust 2"})
	table.insert(recipes, {"xtraores:thorium_ore",			"xtraores:thorium_dust 3"})
	table.insert(recipes, {"xtraores:osmium_lump",			"xtraores:osmium_dust 2"})
	table.insert(recipes, {"xtraores:osmium_ore",			"xtraores:osmium_dust 3"})
	table.insert(recipes, {"xtraores:rhenium_lump",			"xtraores:rhenium_dust 2"})
	table.insert(recipes, {"xtraores:rhenium_ore",			"xtraores:rhenium_dust 3"})
	table.insert(recipes, {"xtraores:vanadium_lump",		"xtraores:vanadium_dust 2"})
	table.insert(recipes, {"xtraores:vanadium_ore",			"xtraores:vanadium_dust 3"})
	table.insert(recipes, {"xtraores:rarium_lump",			"xtraores:rarium_dust 2"})
	table.insert(recipes, {"xtraores:rarium_ore",			"xtraores:rarium_dust 3"})
	table.insert(recipes, {"xtraores:orichalcum_lump",		"xtraores:orichalcum_dust 2"})
	table.insert(recipes, {"xtraores:orichalcum_ore",		"xtraores:orichalcum_dust 3"})
	table.insert(recipes, {"xtraores:titanium_lump",		"xtraores:titanium_dust 2"})
	table.insert(recipes, {"xtraores:titanium_ore",			"xtraores:titanium_dust 3"})
	table.insert(recipes, {"xtraores:iridium_lump",			"xtraores:iridium_dust 2"})
	table.insert(recipes, {"xtraores:iridium_ore",			"xtraores:iridium_dust 3"})
	table.insert(recipes, {"xtraores:neutronium_lump",		"xtraores:neutronium_dust 2"})
	table.insert(recipes, {"xtraores:neutronium_ore",		"xtraores:neutronium_dust 3"})
end
-- end of dhausmig's addition

for _, data in pairs(recipes) do
	technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end

-- dusts
local function register_dust(name, ingot)
	local lname = string.lower(name)
	lname = string.gsub(lname, ' ', '_')
	minetest.register_craftitem("technic:"..lname.."_dust", {
		description = S("%s Dust"):format(S(name)),
		inventory_image = "technic_"..lname.."_dust.png",
	})
	if ingot then
		minetest.register_craft({
			type = "cooking",
			recipe = "technic:"..lname.."_dust",
			output = ingot,
		})
		technic.register_grinder_recipe({ input = {ingot}, output = "technic:"..lname.."_dust 1" })
	end
end

-- Sorted alphibeticaly
register_dust("Brass",           "technic:brass_ingot")
register_dust("Bronze",          "default:bronze_ingot")
register_dust("Carbon Steel",    "technic:carbon_steel_ingot")
register_dust("Cast Iron",       "technic:cast_iron_ingot")
register_dust("Chernobylite",    "technic:chernobylite_block")
register_dust("Chromium",        "technic:chromium_ingot")
register_dust("Coal",            nil)
register_dust("Copper",          "default:copper_ingot")
register_dust("Lead",            "technic:lead_ingot")
register_dust("Gold",            "default:gold_ingot")
register_dust("Mithril",         "moreores:mithril_ingot")
register_dust("Silver",          "moreores:silver_ingot")
register_dust("Stainless Steel", "technic:stainless_steel_ingot")
register_dust("Stone",            "default:stone")
register_dust("Sulfur",          nil)
register_dust("Tin",             "moreores:tin_ingot")
register_dust("Wrought Iron",    "technic:wrought_iron_ingot")
register_dust("Zinc",            "technic:zinc_ingot")
if minetest.get_modpath("gloopores") or minetest.get_modpath("glooptest") then
	register_dust("Akalin",          "glooptest:akalin_ingot")
	register_dust("Alatro",          "glooptest:alatro_ingot")
	register_dust("Arol",            "glooptest:arol_ingot")
	register_dust("Kalite",          nil)
	register_dust("Talinite",        "glooptest:talinite_ingot")
end

for p = 0, 35 do
	local nici = (p ~= 0 and p ~= 7 and p ~= 35) and 1 or nil
	local psuffix = p == 7 and "" or p
	local ingot = "technic:uranium"..psuffix.."_ingot"
	local dust = "technic:uranium"..psuffix.."_dust"
	minetest.register_craftitem(dust, {
		description = S("%s Dust"):format(string.format(S("%.1f%%-Fissile Uranium"), p/10)),
		inventory_image = "technic_uranium_dust.png",
		on_place_on_ground = minetest.craftitem_place_item,
		groups = {uranium_dust=1, not_in_creative_inventory=nici},
	})
	minetest.register_craft({
		type = "cooking",
		recipe = dust,
		output = ingot,
	})
	technic.register_grinder_recipe({ input = {ingot}, output = dust })
end

local function uranium_dust(p)
	return "technic:uranium"..(p == 7 and "" or p).."_dust"
end
for pa = 0, 34 do
	for pb = pa+1, 35 do
		local pc = (pa+pb)/2
		if pc == math.floor(pc) then
			minetest.register_craft({
				type = "shapeless",
				recipe = { uranium_dust(pa), uranium_dust(pb) },
				output = uranium_dust(pc).." 2",
			})
		end
	end
end

minetest.register_craft({
	type = "fuel",
	recipe = "technic:coal_dust",
	burntime = 50,
})

if minetest.get_modpath("gloopores") or minetest.get_modpath("glooptest") then
	minetest.register_craft({
		type = "fuel",
		recipe = "technic:kalite_dust",
		burntime = 37.5,
	})
end
