--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

function technic.register_centrifuge(data)
	data.typename = "separating"
	data.machine_name = "centrifuge"
	data.machine_desc = S("%s Centrifuge")
	technic.register_base_machine(data)
end
