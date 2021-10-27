if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- Nodes that would affect the local temperature e.g. fans, heater, A/C

local S = minetest.get_translator("decor_climate_control")

decor.register("air_conditioner", {
	description = S("Air Conditioner"),
	mesh = "decor_ac.obj",
	tiles = {
		"decor_ac.png",
		"default_glass.png"
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = { type="regular" },
})

-- fans

minetest.register_entity(":decor:mesh_desk_fan", {
	collisionbox = decor.nodebox.null,
	visual = "mesh",
	mesh = "decor_desk_fan.b3d",
	textures = {"decor_desk_fan_uv.png"},
	visual_size = {x=10, y=10},
})

local add_mesh_desk_fan_entity = function(pos)
	local param2 = minetest.get_node(pos).param2
	local entity = minetest.add_entity(pos, "decor:mesh_desk_fan")
	if param2 == 0 then
		entity:setyaw(3.142) -- 180 degrees
	elseif minetest.get_node(pos).param2 == 1 then
		entity:setyaw(3.142/2) -- 90 degrees
	elseif minetest.get_node(pos).param2 == 3 then
		entity:setyaw((-3.142/2)) -- 270 degrees
	else
		entity:setyaw(0)
	end
	return entity
end

decor.register("desk_fan", {
	description = S("Desk Fan"),
	groups = {oddly_breakable_by_hand=2},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875}, -- NodeBox1
		}
	},
	tiles = {"decor_desk_fan_body.png"},
	inventory_image = "decor_desk_fan_inv.png",
	wield_image = "decor_desk_fan_inv.png",
	selection_box = { type = "regular" },
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.disallow or nil,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("active", "no")
		add_mesh_desk_fan_entity(pos)
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local entities = minetest.get_objects_inside_radius(pos, 0.1)
		local entity = entities[1] or add_mesh_desk_fan_entity(pos)
		if meta:get_string("active") == "no" then
			meta:set_string("active", "yes")
			entity:set_animation({x=0,y=96}, 24, 0)
		else
			meta:set_string("active", "no")
			entity:set_animation({x=0,y=0}, 1, 0)
		end
	end,
	after_dig_node = function(pos)
		local entities = minetest.get_objects_inside_radius(pos, 0.1)
		if entities[1] then entities[1]:remove() end
	end,
})

-- ceiling fan

decor.register("ceiling_fan", {
	description = S("Ceiling Fan"),
	tiles = {
		{	name="decor_ceiling_fan_top.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.5} },
		{	name="decor_ceiling_fan_bottom.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.5} },
		'decor_ceiling_fan_sides.png',
	},
	inventory_image = "decor_ceiling_fan_inv.png",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, 0.495, -0.5, 0.5, 0.495, 0.5 },
			{ -0.0625, 0.375, -0.0625, 0.0625, 0.5, 0.0625 }
		}
	},
	groups = { snappy = 3 },
	light_source = default.LIGHT_MAX-1,
	sounds = default.node_sound_glass_defaults(),
})

-- heating devices

decor.register("space_heater", {
	description = S("Space heater"),
	tiles = { 'decor_heater_tb.png',
		  'decor_heater_tb.png',
		  'decor_heater_sides.png',
		  'decor_heater_sides.png',
		  'decor_heater_back.png',
		  'decor_heater_front.png'
	},
	inventory_image = "decor_heater_inv.png",
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.5, 0.0625, 0.1875, 0, 0.3125},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.1875, -0.5, 0.0625, 0.1875, 0, 0.3125}
	}
})

local r_cbox = decor.nodebox.slab_z(-0.25)
decor.register("radiator", {
	mesh = "decor_radiator.obj",
	tiles = {
		"decor_generic_metal.png",
		"decor_radiator_controls.png"
	},
	inventory_image = "decor_radiator_inv.png",
	description = S("Radiator heater"),
	groups = {snappy=3},
	selection_box = r_cbox,
	collision_box = r_cbox,
	sounds = default.node_sound_wood_defaults(),
})

-- crafting
minetest.register_craftitem(":decor:fan_blades", {
	description = S("Fan blades"),
	inventory_image = "decor_fan_blades.png"
})

minetest.register_craft( {
    output = "decor:fan_blades 2",
    recipe = {
		{ "", "default:plastic_sheet", "" },
		{ "", "default:steel_ingot", "" },
		{ "default:plastic_sheet", "", "default:plastic_sheet" }
    },
})

minetest.register_craft({
    output = "decor:air_conditioner",
    recipe = {
		{ "default:steel_ingot", "building_blocks:grate", "default:steel_ingot" },
		{ "default:steel_ingot", "decor:fan_blades", "technic:motor" },
		{ "default:steel_ingot", "technic:motor", "default:steel_ingot" },
    },
})

minetest.register_craft({
    output = "decor:air_conditioner",
    recipe = {
		{ "default:steel_ingot", "building_blocks:grate", "default:steel_ingot" },
		{ "default:steel_ingot", "technic:motor", "default:steel_ingot" },
		{ "default:steel_ingot", "technic:motor", "default:steel_ingot" },
    },
})

minetest.register_craft({
    output = "decor:ceiling_fan",
    recipe = {
		{ "technic:motor" },
		{ "decor:fan_blades" },
		{ "decor:glowlight_small_cube" }
	}
})

minetest.register_craft( {
        output = "decor:desk_fan",
        recipe = {
			{"default:steel_ingot", "decor:fan_blades", "technic:motor"},
			{"", "default:steel_ingot", ""}
        },
})

minetest.register_craft( {
        output = "decor:space_heater",
        recipe = {
			{"default:plastic_sheet", "decor:heating_element", "default:plastic_sheet"},
			{"default:plastic_sheet", "decor:fan_blades", "technic:motor"},
			{"default:plastic_sheet", "decor:heating_element", "default:plastic_sheet"}
        },
})

minetest.register_craft( {
        output = "decor:radiator",
        recipe = {
			{ "default:steel_ingot", "decor:heating_element", "default:steel_ingot" },
			{ "decor:ic", "decor:heating_element", "" },
			{ "default:steel_ingot", "decor:heating_element", "default:steel_ingot" }
        },
})
