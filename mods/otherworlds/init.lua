if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end


local modpath = minetest.get_modpath("otherworlds").. DIR_DELIM

otherworlds = {}

dofile(modpath .. "settings.lua")
dofile(modpath .. "mars_plants.lua")
dofile(modpath .. "crystals.lua")
dofile(modpath .. "space_nodes.lua")
dofile(modpath .. "crafting.lua") 
dofile(modpath .. "skybox.lua")
dofile(modpath .. "asteroid_layer_helpers.lua") -- required helpers for mapgen options below
dofile(modpath .. "space_asteroids.lua") 
dofile(modpath .. "redsky_asteroids.lua") 
