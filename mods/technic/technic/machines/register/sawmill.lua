
--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

function technic.register_sawmill(data)
	data.typename = "sawmilling"
	data.machine_name = "sawmill"
	data.machine_desc = S("%s Sawmill")
	technic.register_base_machine(data)
end
