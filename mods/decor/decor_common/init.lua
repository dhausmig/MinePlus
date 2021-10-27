if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- Home Decor API/functions, and common textures and models
-- by VanessaE

local modpath = minetest.get_modpath("decor_common")

decor = {}
decor.modpath = modpath

-- Determine if the item being pointed at is the underside of a node (e.g a ceiling)
function decor.find_ceiling(itemstack, placer, pointed_thing)
	-- most of this is copied from the rotate-and-place function in builtin
	local unode = core.get_node_or_nil(pointed_thing.under)
	if not unode then
		return
	end
	local undef = core.registered_nodes[unode.name]
	if undef and undef.on_rightclick then
		undef.on_rightclick(pointed_thing.under, unode, placer,
				itemstack, pointed_thing)
		return
	end

	local above = pointed_thing.above
	local under = pointed_thing.under
	local iswall = (above.y == under.y)
	local isceiling = not iswall and (above.y < under.y)
	local anode = core.get_node_or_nil(above)
	if not anode then
		return
	end
	local pos = pointed_thing.above
	local node = anode

	if undef and undef.buildable_to then
		pos = pointed_thing.under
		node = unode
	end

	if core.is_protected(pos, placer:get_player_name()) then
		core.record_protection_violation(pos,
				placer:get_player_name())
		return
	end

	local ndef = core.registered_nodes[node.name]
	if not ndef or not ndef.buildable_to then
		return
	end
	return isceiling, pos
end

decor.plain_wood    = { name = "decor_generic_wood_plain.png",  color = 0xffa76820 }
decor.mahogany_wood = { name = "mahogany_wood.png" }
decor.white_wood    = "decor_generic_wood_plain.png"
decor.dark_wood     = { name = "decor_generic_wood_plain.png",  color = 0xff39240f }
decor.lux_wood      = { name = "decor_generic_wood_luxury.png", color = 0xff643f23 }

decor.color_black     = 0xff303030
decor.color_dark_grey = 0xff606060
decor.color_med_grey  = 0xffa0a0a0

-- load different handler subsystems
dofile(modpath.."/nodeboxes.lua")
dofile(modpath.."/expansion.lua")
dofile(modpath.."/furnaces.lua")
dofile(modpath.."/inventory.lua")
dofile(modpath.."/registration.lua")
dofile(modpath.."/water_particles.lua")
dofile(modpath.."/sit.lua")
dofile(modpath.."/crafts.lua")

if minetest.settings:get_bool("log_mod") then
	minetest.log("action", "[decor API] Loaded!")
end
