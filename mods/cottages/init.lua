if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

-- Version: 2.2
-- Autor:   Sokomine
-- License: GPLv3
--
-- Modified:
-- 24.08.21 Modified for use in mineplus
--				Removed checks for other games
--				Removed duplicate recipes
--				Modified to use playerphysics
-- 27.07.15 Moved into its own repository.
--          Made sure textures and craft receipe indigrents are available or can be replaced.
--          Took care of "unregistered globals" warnings.
-- 23.01.14 Added conversion receipes in case of installed castle-mod (has its own anvil)
-- 23.01.14 Added hammer and anvil as decoration and for repairing tools.
--          Added hatches (wood and steel).
--          Changed the texture of the fence/handrail.
-- 17.01.13 Added alternate receipe for fences in case of interference due to xfences
-- 14.01.13 Added alternate receipes for roof parts in case homedecor is not installed.
--          Added receipe for stove pipe, tub and barrel.
--          Added stairs/slabs for dirt road, loam and clay
--          Added fence_small, fence_corner and fence_end, which are useful as handrails and fences
--          If two or more window shutters are placed above each other, they will now all close/open simultaneously.
--          Added threshing floor.
--          Added hand-driven mill.

cottages = {}


-- there should be a way to distinguish this fork from others
cottages.mod = "mineplus"

-- Boilerplate to support localized strings if intllib mod is installed.
--if minetest.get_modpath( "intllib" ) and intllib then
--	cottages.S = intllib.Getter()
--else
	cottages.S = function(s) return s end
--end

cottages.sounds = {}

cottages.sounds.wood   = default.node_sound_wood_defaults()
cottages.sounds.dirt   = default.node_sound_dirt_defaults()
cottages.sounds.stone  = default.node_sound_stone_defaults()
cottages.sounds.leaves = default.node_sound_leaves_defaults()



cottages.straw_texture = "cottages_darkage_straw.png"

--cottages.config_use_mesh_barrel   = false;
--cottages.config_use_mesh_handmill = true;

-- add to this table what you want the handmill to convert;
-- add a stack size if you want a higher yield
cottages.handmill_product = {};
cottages.handmill_product[ "farming:seed_wheat" ] = 'food:flour 1';
cottages.handmill_product[ "farming:seed_barley" ] = 'food:flour 1';
if farming.mod and (farming.mod == "redo" or farming.mod == "undo") then
	cottages.handmill_product[ "farming:seed_oat" ] = 'food:flour 1';
	cottages.handmill_product[ "farming:seed_rye" ] = 'food:flour 1';
	cottages.handmill_product[ "farming:seed_rice" ] = 'farming:rice_flour 1';
	cottages.handmill_product[ "farming:rice" ] = 'farming:rice_flour 1';
end

--[[ some examples:
cottages.handmill_product[ 'default:cobble' ] = 'default:gravel';
cottages.handmill_product[ 'default:gravel' ] = 'default:sand';
cottages.handmill_product[ 'default:sand'   ] = 'default:dirt 2';
cottages.handmill_product[ 'flowers:rose'   ] = 'dye:red 6';
cottages.handmill_product[ 'default:cactus' ] = 'dye:green 6';
cottages.handmill_product[ 'default:coal_lump' ] = 'dye:black 6';
--]]

-- same for the threshing floor
cottages.threshing_product = {};
cottages.threshing_product[ "default:grass_1" ] = "farming:seed_wheat";
cottages.threshing_product[ "farming:wheat" ] = "farming:seed_wheat";
cottages.threshing_product[ "farming:barley" ] = "farming:seed_barley";
if farming.mod and (farming.mod == "redo" or farming.mod == "undo") then
	cottages.threshing_product[ "farming:oat" ] = 'farming:seed_oat';
	cottages.threshing_product[ "farming:rye" ] = 'farming:seed_rye';
-- 	cottages.threshing_product[ "farming:rice" ] = 'farming:seed_rice';
end

-- API to add items to the handmill and threshing floor

function cottages:add_threshing_product(input, output)
--Probably pretty obvious, but, for instance, 
--	cottages:add_threshing_product("default:grass_1",{"farming:seed_wheat", "farming:seed_oat"})
--	supports the two possible grains that can come from grass_1, 50/50 chance  of each
--maybe should add some error checking sometime...
	cottages.threshing_product[input] = output
end

function cottages:add_handmill_product(input, output)
	cottages.handmill_product[input] = output
end


-- process that many inputs per turn
cottages.handmill_max_per_turn = 20;
cottages.handmill_min_per_turn = 0;


dofile(minetest.get_modpath("cottages").."/functions.lua");
-- uncomment parts you do not want
dofile(minetest.get_modpath("cottages").."/nodes_furniture.lua");
dofile(minetest.get_modpath("cottages").."/nodes_historic.lua");
dofile(minetest.get_modpath("cottages").."/nodes_feldweg.lua");
-- allows to dig hay and straw fast
dofile(minetest.get_modpath("cottages").."/nodes_pitchfork.lua");
dofile(minetest.get_modpath("cottages").."/nodes_straw.lua");
dofile(minetest.get_modpath("cottages").."/nodes_hay.lua");
dofile(minetest.get_modpath("cottages").."/nodes_anvil.lua");
dofile(minetest.get_modpath("cottages").."/nodes_doorlike.lua");
dofile(minetest.get_modpath("cottages").."/nodes_fences.lua");
dofile(minetest.get_modpath("cottages").."/nodes_roof.lua");
dofile(minetest.get_modpath("cottages").."/nodes_barrel.lua");
dofile(minetest.get_modpath("cottages").."/nodes_mining.lua");
dofile(minetest.get_modpath("cottages").."/nodes_fireplace.lua");
dofile(minetest.get_modpath("cottages").."/nodes_water.lua");
--dofile(minetest.get_modpath("cottages").."/nodes_chests.lua");

-- this is only required and useful if you run versions of the random_buildings mod where the nodes where defined inside that mod
dofile(minetest.get_modpath("cottages").."/alias.lua");

-- variable no longer needed
cottages.S = nil;
