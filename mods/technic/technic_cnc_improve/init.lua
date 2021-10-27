if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

local modname = minetest.get_current_modname()
local path = minetest.get_modpath(modname)

dofile(path.."/cnc.lua")
dofile(path.."/cnc_api.lua")
dofile(path.."/cnc_nodes.lua")
