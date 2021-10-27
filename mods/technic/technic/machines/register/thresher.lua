--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

function technic.register_thresher(data)
	data.typename = "threshing"
	data.machine_name = "thresher"
	data.machine_desc = S("%s Thresher")
	technic.register_base_machine(data)
end
