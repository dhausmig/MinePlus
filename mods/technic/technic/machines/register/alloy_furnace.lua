
--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

function technic.register_alloy_furnace(data)
	data.typename = "alloy"
	data.machine_name = "alloy_furnace"
	data.machine_desc = S(" Alloy Furnace")
	technic.register_base_machine(data)
end
