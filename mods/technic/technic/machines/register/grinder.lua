
--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

function technic.register_grinder(data)
	data.typename = "grinding"
	data.machine_name = "grinder"
	data.machine_desc = S("%s Grinder")
	technic.register_base_machine(data)
end
