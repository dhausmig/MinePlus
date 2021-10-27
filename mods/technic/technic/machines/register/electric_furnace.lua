
--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

function technic.register_electric_furnace(data)
	data.typename = "cooking"
	data.machine_name = "electric_furnace"
	data.machine_desc = S("%s Furnace")
	technic.register_base_machine(data)
end
