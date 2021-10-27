if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

-- =====================================
-- FOOD MOD
-- A mod written by dhausmig that adds
-- food to MinePlus
-- =====================================

--[[
	recipes from farming and mobs have been moved here
	as well as many original recipes
--]]

food = {
	version = 5.41,
	path = minetest.get_modpath("food"),
	utensils = false,
	debug = true,
}
if minetest.settings:get_bool("food_utensils") then food.utensils = true end
-- Intllib
local S = minetest.get_translator and minetest.get_translator("food") or
		dofile(food.path .. "/intllib.lua")

food.intllib = S

if (food.utensils) then
	dofile(minetest.get_modpath("food").."/utensils.lua")
end
dofile(minetest.get_modpath("food").."/food.lua")
dofile(minetest.get_modpath("food").."/canned.lua")
dofile(minetest.get_modpath("food").."/extra.lua")
