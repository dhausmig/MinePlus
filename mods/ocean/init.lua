if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
ocean = {}

dofile(minetest.get_modpath("ocean").."/monuments.lua")

-- minetest.log("action", "Ocean monuments mod loaded")
