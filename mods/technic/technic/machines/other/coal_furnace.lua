--local S = technic.getter
--local S = function ( s ) return s end
local S = minetest.get_translator("technic")

if minetest.registered_nodes["default:furnace"].description == "Furnace" then
	minetest.override_item("default:furnace", { description = S("Fuel-Fired Furnace") })
end
