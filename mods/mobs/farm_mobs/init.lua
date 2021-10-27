if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
dofile(minetest.get_modpath('farm_mobs')..'/dog.lua')
dofile(minetest.get_modpath('farm_mobs')..'/german_shepherd.lua')
dofile(minetest.get_modpath('farm_mobs')..'/goat.lua')
