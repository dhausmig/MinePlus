--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

local moretrees = minetest.get_modpath("moretrees")
local mesecons_materials = minetest.get_modpath("mesecons_materials")
local dye = minetest.get_modpath("dye")

local recipe_cache = { extracts = {}, grindings = {} }

-- sawdust, the finest wood/tree grinding
local sawdust = "technic:sawdust"
minetest.register_craftitem(sawdust, {
	description = S("Sawdust"),
	inventory_image = "technic_sawdust.png",
})
minetest.register_craft({ type = "fuel", recipe = sawdust, burntime = 6 })
technic.register_compressor_recipe({ input = {sawdust .. " 4"}, output = "default:wood" })

-- tree/wood grindings
local function register_tree_grinding(name, tree, wood, extract, grinding_color)
	local lname = string.lower(name)
	lname = string.gsub(lname, ' ', '_')
	local grindings_name = "technic:"..lname.."_grindings"
	local inventory_image = "technic_"..lname.."_grindings.png"
	if grinding_color then
		inventory_image = inventory_image .. "^[colorize:" .. grinding_color
	end
	minetest.register_craftitem(grindings_name, {
		description = S("%s Grinding"):format(S(name)),
		inventory_image = inventory_image,
	})
	minetest.register_craft({
		type = "fuel",
		recipe = grindings_name,
		burntime = 8,
	})

	technic.register_grinder_recipe({ input = { tree }, output = grindings_name .. " 4" })
	if not recipe_cache.grindings[grindings_name] then
		technic.register_grinder_recipe({ input = { grindings_name }, output = sawdust .. " 4" })
	end
	recipe_cache.grindings[grindings_name] = 1

	if wood then
		technic.register_grinder_recipe({ input = { wood }, output = grindings_name })
	end

	if extract and not recipe_cache.extracts[grindings_name] then
		technic.register_extractor_recipe({ input = { grindings_name .. " 4" }, output = extract})
		technic.register_separating_recipe({
			input = { grindings_name .. " 4" },
			output = { sawdust .. " 4", extract }
		})
		recipe_cache.extracts[grindings_name] = 1
	end
end

local rubber_tree_planks = moretrees and "moretrees:rubber_tree_planks"
local default_extract = dye and "dye:brown 2"

local grinding_recipes = {
-- group-based recipes appear to be not working
--	{"Common Tree", "group:tree",                        "group:wood",          default_extract },
	{"Tree",        "default:tree",                      "default:wood",        default_extract },
--	{"Acacia",      "default:acacia_tree",               "default:acacia_wood", default_extract },
	{"Aspen",       "default:aspen_tree",                "default:aspen_wood",  default_extract },
	{"Jungletree",  "default:jungletree",                "default:junglewood",  default_extract },
	{"Pine",        "default:pine_tree",                 "default:pine_wood",   default_extract },
	{"Rubber Tree", "moretrees:rubber_tree_trunk",       rubber_tree_planks,    "technic:raw_latex"},
	{"Rubber Tree", "moretrees:rubber_tree_trunk_empty", nil,                   "technic:raw_latex"}
}


if minetest.get_modpath("pathv7") then

	for _, s in ipairs({"stairn", "stairs", "staire", "stairw", "stairne", "stairnw", "stairse", "stairsw"}) do
		table.insert(grinding_recipes, {"Jungletree", "pathv7:"..s, nil, default_extract })
	end

	table.insert(grinding_recipes, {"Jungletree", "pathv7:junglewood", nil, default_extract })
	table.insert(grinding_recipes, {"Acacia", "pathv7:bridgewood", nil, default_extract })

end

if moretrees and dye then
	-- https://en.wikipedia.org/wiki/Catechu ancient brown dye from the wood of acacia trees
	register_tree_grinding("Acacia", "moretrees:acacia_trunk", "moretrees:acacia_planks", "dye:brown 8")
else
	table.insert(grinding_recipes, {"Acacia", "default:acacia_tree", "default:acacia_wood", default_extract})
end

for _, data in pairs(grinding_recipes) do
	register_tree_grinding(unpack(data))
end
