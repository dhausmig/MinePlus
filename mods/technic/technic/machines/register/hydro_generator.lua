--local S = technic.getter
local S = function ( s ) return s end
--local S = minetest.get_translator("technic")

local cable_entry = "^technic_cable_connection_overlay.png"

function technic.register_hydro_generator(data)

	local tier = data.tier
	local ltier = string.lower(tier)

	local groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
		technic_machine=1, ["technic_"..ltier]=1}
	if data.tube then
		groups.tubedevice = 1
		groups.tubedevice_receiver = 1
	end
	local active_groups = {not_in_creative_inventory = 1}
	for k, v in pairs(groups) do active_groups[k] = v end

	local function check_node_around_mill(pos)
		local node = minetest.get_node(pos)
		if node.name == "default:water_flowing"
		or node.name == "default:river_water_flowing" then
			return node.param2 -- returns approx. water flow, if any
		end
		return false
	end


	local run = function(pos, node)
		local meta             = minetest.get_meta(pos)
		local water_flow       = 0
		local lava_nodes       = 0
		local production_level = 0
		local eu_supply        = 0
		local max_output       = data.supply * 45 -- four param2's at 15 makes 60, cap it lower for "overload protection"
										-- (plus we want the gen to report 100% if three sides have full flow)

		local positions = {
			{x=pos.x+1, y=pos.y, z=pos.z},
			{x=pos.x-1, y=pos.y, z=pos.z},
			{x=pos.x,   y=pos.y, z=pos.z+1},
			{x=pos.x,   y=pos.y, z=pos.z-1},
		}

		for _, p in pairs(positions) do
			local check = check_node_around_mill(p)
			if check then
				water_flow = water_flow + check
			end
		end

		eu_supply = math.min(data.supply * water_flow, max_output)
		production_level = math.floor(100 * eu_supply / max_output)

		meta:set_int(tier .. "_EU_supply", eu_supply)

		meta:set_string("infotext",
			S("Hydro %s Generator"):format(tier).." ("..production_level.."%)")

		if production_level > 0 and
		minetest.get_node(pos).name == "technic:" .. ltier .. "_hydro_generator" then
			technic.swap_node (pos, "technic:" .. ltier .. "_hydro_generator_active")
			meta:set_int(tier .. "_EU_supply", 0)
			return
		end
		if production_level == 0 then
			technic.swap_node(pos, "technic:" .. ltier .. "_hydro_generator")
		end
	end

	minetest.register_node("technic:" .. ltier .. "_hydro_generator", {
		description = S("Hydro %s Generator"):format(tier),
		tiles = {
			"technic_" .. ltier .. "_hydro_generator_top.png",
			"technic_machine_bottom.png"..cable_entry,
			"technic_hydro_generator_side.png",
			"technic_hydro_generator_side.png",
			"technic_hydro_generator_front.png",
			"technic_hydro_generator_front.png"
		},
		paramtype2 = "facedir",
		groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
			technic_machine=1, ["technic_"..ltier]=1},
		legacy_facedir_simple = true,
		sounds = default.node_sound_wood_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("infotext", S("Hydro %s Generator"):format(tier))
			meta:set_int(tier .. "_EU_supply", 0)
		end,
		technic_run = run,
	})

	minetest.register_node("technic:" .. ltier .. "_hydro_generator_active", {
		description = S("Hydro %s Generator"):format(tier),
		tiles = {	{
					name = "technic_" .. ltier .. "_hydro_generator_top_active_animated.png",
					backface_culling = false,
					animation = {
							type = "vertical_frames",
							aspect_w = 16,
							aspect_h = 16,
							length = 1
					},
				},
				"technic_machine_bottom.png",
				"technic_hydro_generator_side.png",
				"technic_hydro_generator_side.png",
				{
					name = "technic_hydro_generator_front_active_animated.png",
					backface_culling = false,
					animation = {
							type = "vertical_frames",
							aspect_w = 32,
							aspect_h = 32,
							length = 0.25
					},
				},
				{
					name = "technic_hydro_generator_front_active_animated.png",
					backface_culling = false,
					animation = {
							type = "vertical_frames",
							aspect_w = 32,
							aspect_h = 32,
							length = 0.25
					},
				}
				},
		paramtype2 = "facedir",
		groups = {snappy=2, choppy=2, oddly_breakable_by_hand=2,
			technic_machine=1, ["technic_"..ltier]=1, not_in_creative_inventory=1},
		legacy_facedir_simple = true,
		sounds = default.node_sound_wood_defaults(),
		drop = "technic:" .. ltier .. "_hydro_generator",
		technic_run = run,
		technic_disabled_machine_name = "technic:" .. ltier .. "_hydro_generator",
	})

	technic.register_machine(tier, "technic:" .. ltier .. "_hydro_generator",        technic.producer)
	technic.register_machine(tier, "technic:" .. ltier .. "_hydro_generator_active", technic.producer)

end

-- ==============================================



-- A water mill produces LV EUs by exploiting flowing water across it
-- It is a LV EU supplyer and fairly low yield (max 120EUs)
-- It is a little under half as good as the thermal generator.
--[[
--local S = technic.getter
local S = function ( s ) return s end

local cable_entry = "^technic_cable_connection_overlay.png"

minetest.register_alias("hydro_generator", "technic:hydro_generator")

minetest.register_craft({
	output = 'technic:hydro_generator',
	recipe = {
		{'group:marble', 'default:diamond',        'group:marble'},
		{'group:wood',     'technic:machine_casing', 'group:wood'},
		{'group:marble', 'technic:lv_cable',       'group:marble'},
	}
})]]
