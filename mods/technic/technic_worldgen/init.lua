if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

local modpath = minetest.get_modpath("technic_worldgen")

technic = rawget(_G, "technic") or {}
technic_worldgen = {}
local S = function(s) return s end


dofile(modpath.."/config.lua")
dofile(modpath.."/nodes.lua")
dofile(modpath.."/oregen.lua")
dofile(modpath.."/crafts.lua")

-- Rubber trees, moretrees also supplies these
if not minetest.get_modpath("moretrees") then
	dofile(modpath.."/rubber.lua")
else
	-- older versions of technic provided rubber trees regardless
	minetest.register_alias("technic:rubber_sapling", "moretrees:rubber_tree_sapling")
	minetest.register_alias("technic:rubber_tree_empty", "moretrees:rubber_tree_trunk_empty")
end

-- mg suppport
if minetest.get_modpath("mg") then
	dofile(modpath.."/mg.lua")
end

stairsplus:register_all(
	":technic",
	"granite",
	"technic:granite",
	{
		groups = { cracky=2, oddly_breakable_by_hand=2 },
		tiles = { "technic_granite.png" },
		description = "Technic Granite",
		drop = "technic_granite",
	}
)

stairsplus:register_all(
	":technic",
	"marble",
	"technic:marble",
	{
		groups = { cracky=2, oddly_breakable_by_hand=2 },
		tiles = { "technic_marble.png" },
		description = "Technic Marble",
		drop = "technic_marble",
	}
)

