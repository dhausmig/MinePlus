if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
dofile(minetest.get_modpath('fantasy_mobs')..'/cloudpuff.lua')
dofile(minetest.get_modpath('fantasy_mobs')..'/goblins.lua')
dofile(minetest.get_modpath('fantasy_mobs')..'/fairy.lua')
dofile(minetest.get_modpath('fantasy_mobs')..'/mummy.lua')
dofile(minetest.get_modpath('fantasy_mobs')..'/larva.lua')
dofile(minetest.get_modpath('fantasy_mobs')..'/lava_titan.lua')
dofile(minetest.get_modpath('fantasy_mobs')..'/gnomes.lua')
dofile(minetest.get_modpath('fantasy_mobs')..'/cavefreak.lua')
