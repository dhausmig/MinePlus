

function darkage.register_stairs(nodeName)
-- Stairs
	local ndef = assert(minetest.registered_nodes[nodeName], "Error: "..nodeName.." is not registered")

	local node = nodeName:split(":")[2]

	local subname = node; 
	stairs.register_stair_and_slab(subname, nodeName,
		ndef.groups, ndef.tiles, 
		ndef.description.." Stair", ndef.description.." Slab",
		ndef.sounds)
-- Stairsplus
	local mod = "darkage"
	local node = nodeName:split(":")[2]

	local def = table.copy(ndef)
	def.drop = nil

	stairsplus:register_all(mod, node, nodeName, def)
end
