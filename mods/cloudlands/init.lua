if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local path = minetest.get_modpath(minetest.get_current_modname())

dofile(path.."/cloudlands.lua")
