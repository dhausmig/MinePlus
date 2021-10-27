if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
dofile(minetest.get_modpath('arctic_life')..'/penguin.lua')
dofile(minetest.get_modpath('arctic_life')..'/walrus.lua')
