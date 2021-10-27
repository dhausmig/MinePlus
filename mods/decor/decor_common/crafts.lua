-- crafts for common items that are used by more than one home decor component

local S = minetest.get_translator("decor_common")

-- items

minetest.register_craftitem(":decor:terracotta_base", {
	description = S("Uncooked Terracotta Base"),
	inventory_image = "decor_terracotta_base.png",
})

minetest.register_craftitem(":decor:roof_tile_terracotta", {
        description = S("Terracotta Roof Tile"),
        inventory_image = "decor_roof_tile_terracotta.png",
})

minetest.register_craftitem(":decor:drawer_small", {
        description = S("Small Wooden Drawer"),
        inventory_image = "decor_drawer_small.png",
})

minetest.register_craftitem(":decor:heating_element", {
	description = S("Heating element"),
	inventory_image = "decor_heating_element.png",
})

minetest.register_craftitem(":decor:ic", {
	description = S("Simple Integrated Circuit"),
	inventory_image = "decor_ic.png",
})

-- cooking/fuel

minetest.register_craft({
        type = "cooking",
        output = "decor:roof_tile_terracotta",
        recipe = "decor:terracotta_base",
})

minetest.register_craft({
        type = "fuel",
        recipe = "decor:shingles_wood",
        burntime = 30,
})

minetest.register_craftitem(":decor:steel_wire", {
	description = S("Spool of steel wire"),
	groups = { wire = 1 },
	inventory_image = "decor_steel_wire.png"
})

minetest.register_craftitem(":decor:steel_strip", {
	description = S("Steel Strip"),
	groups = { strip = 1 },
	inventory_image = "decor_steel_strip.png"
})

minetest.register_craftitem(":decor:copper_strip", {
	description = S("Copper Strip"),
	groups = { strip = 1 },
	inventory_image = "decor_copper_strip.png"
})

minetest.register_craftitem(":decor:chainlink_brass", {
	description = S("Chainlinks (brass)"),
	groups = { chainlinks = 1 },
	inventory_image = "decor_chainlink_brass.png"
})

minetest.register_craftitem(":decor:chainlink_steel", {
	description = S("Chainlinks (steel)"),
	groups = { chainlinks = 1 },
	inventory_image = "decor_chainlink_steel.png"
})

local chains_sbox = {
	type = "fixed",
	fixed = { -0.1, -0.5, -0.1, 0.1, 0.5, 0.1 }
}

minetest.register_node(":decor:chain_steel", {
	description = S("Chain (steel, hanging)"),
	drawtype = "mesh",
	mesh = "decor_chains.obj",
	tiles = {"decor_chain_steel.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "decor_chain_steel_inv.png",
	groups = {cracky=3},
	selection_box = chains_sbox,
})

minetest.register_node(":decor:chain_brass", {
	description = S("Chain (brass, hanging)"),
	drawtype = "mesh",
	mesh = "decor_chains.obj",
	tiles = {"decor_chain_brass.png"},
	walkable = false,
	climbable = true,
	sunlight_propagates = true,
	paramtype = "light",
	inventory_image = "decor_chain_brass_inv.png",
	groups = {cracky=3},
	selection_box = chains_sbox,
})


-- crafing

minetest.register_craft( {
	output = "decor:steel_wire 4",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"", "default:steel_ingot", ""},
		{"", "default:steel_ingot", ""},
	},
})

minetest.register_craft( {
	output = "decor:steel_strip 12",
	recipe = {
		{ "", "default:steel_ingot", "" },
		{ "default:steel_ingot", "", "" },
	},
})

minetest.register_craft( {
	output = "decor:copper_strip 12",
	recipe = {
		{ "", "default:copper_ingot", "" },
		{ "default:copper_ingot", "", "" },
	},
})

minetest.register_craft({
	output = "decor:chainlink_steel 12",
	recipe = {
		{"", "default:steel_ingot", "default:steel_ingot"},
		{ "default:steel_ingot", "", "default:steel_ingot" },
		{ "default:steel_ingot", "default:steel_ingot", "" },
	},
})

minetest.register_craft({
	output = "decor:chainlink_brass 12",
	recipe = {
		{"", "technic:brass_ingot", "technic:brass_ingot"},
		{ "technic:brass_ingot", "", "technic:brass_ingot" },
		{ "technic:brass_ingot", "technic:brass_ingot", "" },
	},
})

minetest.register_craft({
	output = 'decor:chain_steel 2',
	recipe = {
		{"decor:chainlink_steel"},
		{"decor:chainlink_steel"},
		{"decor:chainlink_steel"}
	}
})

minetest.register_craft({
	output = 'decor:chain_brass 2',
	recipe = {
		{"decor:chainlink_brass"},
		{"decor:chainlink_brass"},
		{"decor:chainlink_brass"}
	}
})

minetest.register_craft( {
	type = "shapeless",
	output = "decor:terracotta_base 8",
	recipe = {
		"bucket:bucket_water",
		"default:clay_lump",
		"default:gravel",
	},
	replacements = { {"bucket:bucket_water", "bucket:bucket_empty"}, },
})

minetest.register_craft( {
        output = "decor:shingles_terracotta",
        recipe = {
                { "decor:roof_tile_terracotta", "decor:roof_tile_terracotta"},
                { "decor:roof_tile_terracotta", "decor:roof_tile_terracotta"},
        },
})

minetest.register_craft( {
        output = "decor:roof_tile_terracotta 8",
        recipe = {
			{ "decor:shingles_terracotta", "decor:shingles_terracotta" }
		}
})

minetest.register_craft( {
        output = "decor:shingles_wood 12",
        recipe = {
                { "group:stick", "group:wood"},
                { "group:wood", "group:stick"},
        },
})

minetest.register_craft( {
        output = "decor:shingles_wood 12",
        recipe = {
                { "group:wood", "group:stick"},
                { "group:stick", "group:wood"},
        },
})

minetest.register_craft( {
        output = "decor:shingles_asphalt 6",
        recipe = {
                { "", "cottages:roof_asphalt", "" },
                { "cottages:roof_asphalt", "", "cottages:roof_asphalt" },
        },
})

minetest.register_craft( {
    output = "decor:heating_element 2",
    recipe = {
		{ "default:copper_ingot", "default:mese_crystal_fragment", "default:copper_ingot" }
    },
})

minetest.register_craft( {
	output = "decor:ic 4",
	recipe = {
		{ "mesecons_materials:silicon", "mesecons_materials:silicon" },
		{ "mesecons_materials:silicon", "default:copper_ingot" },
	},
})
