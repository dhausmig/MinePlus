if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
--load settings
local settings = dofile( minetest.get_modpath("tunneler") .. "/tunneler.conf" )

--functions for tunnelers
local tunneler_utils = dofile( minetest.get_modpath("tunneler") .. "/tunneler.lua" )

--generate tunnelers from settings
for name, desc in pairs( settings.tunneler_types ) do
	local toolspec = desc.toolspec
	toolspec.stack_max = 1
	toolspec.on_secondary_use = tunneler_utils.config
	toolspec.on_place = tunneler_utils.config
	minetest.register_tool( "tunneler:"..name, toolspec )
	minetest.register_craft( { output = "tunneler:"..name, recipe = desc.recipe } )
end

minetest.register_on_player_receive_fields( tunneler_utils.field_handler )

minetest.register_on_dignode( tunneler_utils.on_dig )
