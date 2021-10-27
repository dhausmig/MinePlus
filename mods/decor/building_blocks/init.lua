if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local modpath = minetest.get_modpath("building_blocks")

dofile(modpath.."/alias.lua")
dofile(modpath.."/node_stairs.lua")
dofile(modpath.."/others.lua")
dofile(modpath.."/recipes.lua")
