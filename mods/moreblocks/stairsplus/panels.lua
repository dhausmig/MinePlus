--[[
More Blocks: panel definitions

Copyright © 2011-2020 Hugo Locurcio and contributors.
Licensed under the zlib license. See LICENSE.md for more information.
--]]

-- Node will be called <modname>:panel_<subname>

-- luacheck: no unused
local function register_panel(modname, subname, recipeitem, groups, images, description, drop, light)
	stairsplus:register_panel(modname, subname, recipeitem, {
		groups = groups,
		tiles = images,
		description = description,
		drop = drop,
		light_source = light,
		sounds = default.node_sound_stone_defaults(),
	})
end

function stairsplus:register_panel_alias(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["panel"])
	for alternate, def in pairs(defs) do
		minetest.register_alias(modname_old .. ":panel_" .. subname_old .. alternate, modname_new .. ":panel_" .. subname_new .. alternate)
	end
end

function stairsplus:register_panel_alias_force(modname_old, subname_old, modname_new, subname_new)
	local defs = table.copy(stairsplus.defs["panel"])
	for alternate, def in pairs(defs) do
		minetest.register_alias_force(modname_old .. ":panel_" .. subname_old .. alternate, modname_new .. ":panel_" .. subname_new .. alternate)
	end
end

function stairsplus:register_panel(modname, subname, recipeitem, fields)
	local defs = table.copy(stairsplus.defs["panel"])
	for alternate, def in pairs(defs) do
		stairsplus.register_single("panel", alternate, def, modname, subname, recipeitem, fields)
	end

	table_saw.known_nodes[recipeitem] = {modname, subname}
end
