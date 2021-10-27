if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
desert_life = {}
dofile(minetest.get_modpath('desert_life')..'/functions.lua')
dofile(minetest.get_modpath('desert_life')..'/prickly_pear.lua')
dofile(minetest.get_modpath('desert_life')..'/barrel_cacti.lua')
dofile(minetest.get_modpath('desert_life')..'/armadillo.lua')
dofile(minetest.get_modpath('desert_life')..'/ostrich.lua')
