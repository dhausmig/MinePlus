if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
--- Worldedit.
-- @module worldedit
-- @release 1.2
-- @copyright 2013 sfan5, Anthony Zhang (Uberi/Temperest), and Brett O'Donnell (cornernote).
-- @license GNU Affero General Public License version 3 (AGPLv3)
-- @author sfan5
-- @author Anthony Zang (Uberi/Temperest)
-- @author Bret O'Donnel (cornernote)
-- @author ShadowNinja


worldedit = {}

local ver = {major=1, minor=2}
worldedit.version = ver
worldedit.version_string = string.format("%d.%d", ver.major, ver.minor)

local path = minetest.get_modpath(minetest.get_current_modname())

local function load_module(path)
	local file = io.open(path, "r")
	if not file then return end
	file:close()
	return dofile(path)
end

dofile(path .. "/common.lua")
load_module(path .. "/manipulations.lua")
load_module(path .. "/primitives.lua")
load_module(path .. "/visualization.lua")
load_module(path .. "/serialization.lua")
load_module(path .. "/code.lua")
load_module(path .. "/compatibility.lua")
load_module(path .. "/cuboid.lua")
