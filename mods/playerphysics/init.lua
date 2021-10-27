if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
playerphysics = {}

local function calculate_attribute_product(player, attribute)
	local a = minetest.deserialize(player:get_meta():get("playerphysics:physics"))
	local product = 1
	if a == nil or a[attribute] == nil then
		return product
	end
	local factors = a[attribute]
	if type(factors) == "table" then
		for _, factor in pairs(factors) do
			product = product * factor
		end
	end
	return product
end

function playerphysics.add_physics_factor(player, attribute, id, value)
	local a = minetest.deserialize(player:get_meta():get("playerphysics:physics"))
	if a == nil then
		a = { [attribute] = { [id] = value } }
	elseif a[attribute] == nil then
		a[attribute] = { [id] = value }
	else
		a[attribute][id] = value
	end
	player:get_meta():set_string("playerphysics:physics", minetest.serialize(a))
	local raw_value = calculate_attribute_product(player, attribute)
	player:set_physics_override({[attribute] = raw_value})
end

function playerphysics.remove_physics_factor(player, attribute, id)
	local a = minetest.deserialize(player:get_meta():get("playerphysics:physics"))
	if a == nil or a[attribute] == nil then
		-- Nothing to remove
		return
	else
		a[attribute][id] = nil
	end
	player:get_meta():set_string("playerphysics:physics", minetest.serialize(a))
	local raw_value = calculate_attribute_product(player, attribute)
	player:set_physics_override({[attribute] = raw_value})
end
