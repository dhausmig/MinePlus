if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- [MOD] Angled Walls [angledwalls] [1.3] by TumeniNodes 6-24-2016

dofile(minetest.get_modpath("angledwalls").."/angledwalls.lua")
dofile(minetest.get_modpath("angledwalls").."/angledglass.lua")

if minetest.get_modpath("bakedclay") then
	dofile(minetest.get_modpath("angledwalls").."/bakedclay.lua")
end

if minetest.get_modpath("quartz") then
	dofile(minetest.get_modpath("angledwalls").."/quartz.lua")
end
