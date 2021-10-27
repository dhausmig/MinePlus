if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

local path = minetest.get_modpath("mobs")

-- Mob API
dofile(path .. "/api.lua")

-- Rideable Mobs
dofile(path .. "/mount.lua")

-- Mob Items
dofile(path .. "/crafts.lua")

-- Mob Spawner
dofile(path .. "/spawner.lua")

-- Lucky Blocks
dofile(path .. "/lucky_block.lua")

-- Fish
dofile(path .. "/fishing.lua")

-- minetest.log("action", "[MOD] Mobs Redo loaded")
