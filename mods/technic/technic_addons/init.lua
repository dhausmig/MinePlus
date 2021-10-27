if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

local S = function ( s ) return s end

local modpath = minetest.get_modpath("technic_addons")
--technic.modpath = modpath
dofile(modpath.."/chainsaws/chainsawmk2.lua")
dofile(modpath.."/chainsaws/chainsawmk3.lua")
dofile(modpath.."/cans/mediumcans.lua")
dofile(modpath.."/cans/largecans.lua")
dofile(modpath.."/vacuums/vacuummk2.lua")
dofile(modpath.."/vacuums/vacuummk3.lua")
