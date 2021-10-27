if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- Minetest 0.4.7 mod: technic
-- namespace: technic
-- (c) 2012-2013 by RealBadAngel <mk@realbadangel.pl>

local load_start = os.clock()

technic = rawget(_G, "technic") or {}
technic.creative_mode = minetest.settings:get_bool("creative_mode")


local modpath = minetest.get_modpath("technic")
technic.modpath = modpath
if modpath:sub(1,1) == "/" then
    technic.pathsep = "/"
else
    technic.pathsep = "\\"
end

-- there should be a way to distinguish this fork from others
technic.mod = "MinePlus"

--[[-- Boilerplate to support intllib
if rawget(_G, "intllib") then
	technic.getter = intllib.Getter()
else
	technic.getter = function(s,a,...)if a==nil then return s end a={a,...}return s:gsub("(@?)@(%(?)(%d+)(%)?)",function(e,o,n,c)if e==""then return a[tonumber(n)]..(o==""and c or"")else return"@"..o..n..c end end) end
end
local S = technic.getter--]]
local S = function ( s ) return s end

-- Read configuration file
dofile(modpath.."/config.lua")

-- Helper functions
dofile(modpath.."/helpers.lua")

-- Items 
dofile(modpath.."/items.lua")

-- Craft recipes for items 
dofile(modpath.."/crafts.lua")

-- Register functions
dofile(modpath.."/register.lua")

-- Radiation
dofile(modpath.."/radiation.lua")

-- Tools
-- tools precede machines to allow using cans in recipes
dofile(modpath.."/tools/init.lua")

-- Machines
dofile(modpath.."/machines/init.lua")

-- Aliases for legacy node/item names
dofile(modpath.."/legacy.lua")
