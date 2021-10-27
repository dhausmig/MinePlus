if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

dofile(minetest.get_modpath("mesecons_extrawires").."/crossover.lua");
dofile(minetest.get_modpath("mesecons_extrawires").."/tjunction.lua");
dofile(minetest.get_modpath("mesecons_extrawires").."/corner.lua");
dofile(minetest.get_modpath("mesecons_extrawires").."/vertical.lua");
dofile(minetest.get_modpath("mesecons_extrawires").."/mesewire.lua");
