if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local modpath = minetest.get_modpath("decor_tables")

dofile(modpath.."/misc.lua")
-- these are in furn mod
--dofile(modpath.."/endtable.lua")
--dofile(modpath.."/coffeetable.lua")

