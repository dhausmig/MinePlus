if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
facade  = {}

-- Define the shapes and registration functions
dofile (minetest.get_modpath("facade") .. "/shapes.lua")

-- Register the nodes made from compatible materials
dofile (minetest.get_modpath("facade") .. "/materials.lua")

-- Add a dedicated machine to produce the facade shapes
dofile(minetest.get_modpath("facade") .. "/shaper.lua")
