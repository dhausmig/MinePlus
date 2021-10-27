if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- decor seating

local S = minetest.get_translator("decor_seating")
local modpath = minetest.get_modpath("decor_seating")


dofile(modpath.."/misc.lua")
