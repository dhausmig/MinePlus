-----nickel--------

minetest.register_node("xtraores:brick_nickel", {
		description = "" ..core.colorize("#68fff6", "Nickel Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_brick_nickel.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_nickel",
	recipe = {"xtraores:nickel_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_nickel", {
		description = "" ..core.colorize("#68fff6", "Nickel Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_block_nickel.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_nickel',
	recipe = {
		{'xtraores:nickel_ingot', 'xtraores:nickel_ingot', 'xtraores:nickel_ingot'},
		{'xtraores:nickel_ingot', 'xtraores:nickel_ingot', 'xtraores:nickel_ingot'},
		{'xtraores:nickel_ingot', 'xtraores:nickel_ingot', 'xtraores:nickel_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:nickel_ingot 9',
	recipe = {
		{'xtraores:block_nickel'},
	}
})
minetest.register_node("xtraores:decobrick_nickel", {
		description = "" ..core.colorize("#68fff6", "Decorative Nickel Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_decobrick_nickel.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_nickel 4',
	recipe = {
		{'xtraores:brick_nickel', 'xtraores:brick_nickel', ''},
		{'xtraores:brick_nickel', 'xtraores:brick_nickel', ''},

	}
})

-----platinum--------

minetest.register_node("xtraores:brick_platinum", {
		description = "" ..core.colorize("#68fff6", "Platinum Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_brick_platinum.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_platinum",
	recipe = {"xtraores:platinum_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_platinum", {
		description = "" ..core.colorize("#68fff6", "Platinum Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_block_platinum.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_platinum',
	recipe = {
		{'xtraores:platinum_ingot', 'xtraores:platinum_ingot', 'xtraores:platinum_ingot'},
		{'xtraores:platinum_ingot', 'xtraores:platinum_ingot', 'xtraores:platinum_ingot'},
		{'xtraores:platinum_ingot', 'xtraores:platinum_ingot', 'xtraores:platinum_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:platinum_ingot 9',
	recipe = {
		{'xtraores:block_platinum'},
	}
})
minetest.register_node("xtraores:decobrick_platinum", {
		description = "" ..core.colorize("#68fff6", "Decorative Pplatinum Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_decobrick_platinum.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_platinum 4',
	recipe = {
		{'xtraores:brick_platinum', 'xtraores:brick_platinum', ''},
		{'xtraores:brick_platinum', 'xtraores:brick_platinum', ''},

	}
})

-----palladium--------

minetest.register_node("xtraores:brick_palladium", {
		description = "" ..core.colorize("#68fff6", "Palladium Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_brick_palladium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_palladium",
	recipe = {"xtraores:palladium_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_palladium", {
		description = "" ..core.colorize("#68fff6", "Palladium Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_block_palladium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_palladium',
	recipe = {
		{'xtraores:palladium_ingot', 'xtraores:palladium_ingot', 'xtraores:palladium_ingot'},
		{'xtraores:palladium_ingot', 'xtraores:palladium_ingot', 'xtraores:palladium_ingot'},
		{'xtraores:palladium_ingot', 'xtraores:palladium_ingot', 'xtraores:palladium_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:palladium_ingot 9',
	recipe = {
		{'xtraores:block_palladium'},
	}
})
minetest.register_node("xtraores:decobrick_palladium", {
		description = "" ..core.colorize("#68fff6", "Decorative Palladium Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_decobrick_palladium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_palladium 4',
	recipe = {
		{'xtraores:brick_palladium', 'xtraores:brick_palladium', ''},
		{'xtraores:brick_palladium', 'xtraores:brick_palladium', ''},

	}
})

-----cobalt--------

minetest.register_node("xtraores:brick_cobalt", {
		description = "" ..core.colorize("#68fff6", "Cobalt Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_brick_cobalt.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 4},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_cobalt",
	recipe = {"xtraores:cobalt_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_cobalt", {
		description = "" ..core.colorize("#68fff6", "Cobalt Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_block_cobalt.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 4},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_cobalt',
	recipe = {
		{'xtraores:cobalt_ingot', 'xtraores:cobalt_ingot', 'xtraores:cobalt_ingot'},
		{'xtraores:cobalt_ingot', 'xtraores:cobalt_ingot', 'xtraores:cobalt_ingot'},
		{'xtraores:cobalt_ingot', 'xtraores:cobalt_ingot', 'xtraores:cobalt_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:cobalt_ingot 9',
	recipe = {
		{'xtraores:block_cobalt'},
	}
})
minetest.register_node("xtraores:decobrick_cobalt", {
		description = "" ..core.colorize("#68fff6", "Decorative Cobalt Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_decobrick_cobalt.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 4},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_cobalt 4',
	recipe = {
		{'xtraores:brick_cobalt', 'xtraores:brick_cobalt', ''},
		{'xtraores:brick_cobalt', 'xtraores:brick_cobalt', ''},

	}
})

-----thorium--------

minetest.register_node("xtraores:brick_thorium", {
		description = "" ..core.colorize("#68fff6", "Thorium Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_brick_thorium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 5},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_thorium",
	recipe = {"xtraores:thorium_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_thorium", {
		description = "" ..core.colorize("#68fff6", "Thorium Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_block_thorium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 5},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_thorium',
	recipe = {
		{'xtraores:thorium_ingot', 'xtraores:thorium_ingot', 'xtraores:thorium_ingot'},
		{'xtraores:thorium_ingot', 'xtraores:thorium_ingot', 'xtraores:thorium_ingot'},
		{'xtraores:thorium_ingot', 'xtraores:thorium_ingot', 'xtraores:thorium_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:thorium_ingot 9',
	recipe = {
		{'xtraores:block_thorium'},
	}
})
minetest.register_node("xtraores:decobrick_thorium", {
		description = "" ..core.colorize("#68fff6", "Decorative Thorium Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_decobrick_thorium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 5},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_thorium 4',
	recipe = {
		{'xtraores:brick_thorium', 'xtraores:brick_thorium', ''},
		{'xtraores:brick_thorium', 'xtraores:brick_thorium', ''},

	}
})

-----anthracite-----

minetest.register_node("xtraores:block_anthracite", {
		description = "" ..core.colorize("#68fff6", "Anthracite Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_block_anthracite.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 6},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_anthracite',
	recipe = {
		{'xtraores:anthracite_lump', 'xtraores:anthracite_lump', 'xtraores:anthracite_lump'},
		{'xtraores:anthracite_lump', 'xtraores:anthracite_lump', 'xtraores:anthracite_lump'},
		{'xtraores:anthracite_lump', 'xtraores:anthracite_lump', 'xtraores:anthracite_lump'},
	}
})

minetest.register_craft({
	output = 'xtraores:anthracite_lump 9',
	recipe = {
		{'xtraores:block_anthracite'},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "xtraores:block_antracit",
	burntime = 1476,
})


-----osmium--------

minetest.register_node("xtraores:brick_osmium", {
		description = "" ..core.colorize("#68fff6", "Osmium Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_brick_osmium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 6},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_osmium",
	recipe = {"xtraores:osmium_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_osmium", {
		description = "" ..core.colorize("#68fff6", "Osmium Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_block_osmium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 6},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_osmium',
	recipe = {
		{'xtraores:osmium_ingot', 'xtraores:osmium_ingot', 'xtraores:osmium_ingot'},
		{'xtraores:osmium_ingot', 'xtraores:osmium_ingot', 'xtraores:osmium_ingot'},
		{'xtraores:osmium_ingot', 'xtraores:osmium_ingot', 'xtraores:osmium_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:osmium_ingot 9',
	recipe = {
		{'xtraores:block_osmium'},
	}
})
minetest.register_node("xtraores:decobrick_osmium", {
		description = "" ..core.colorize("#68fff6", "Decorative Osmium Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_decobrick_osmium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 6},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_osmium 4',
	recipe = {
		{'xtraores:brick_osmium', 'xtraores:brick_osmium', ''},
		{'xtraores:brick_osmium', 'xtraores:brick_osmium', ''},

	}
})

-----rhenium--------

minetest.register_node("xtraores:brick_rhenium", {
		description = "" ..core.colorize("#68fff6", "Rhenium Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_brick_rhenium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 7},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_rhenium",
	recipe = {"xtraores:rhenium_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_rhenium", {
		description = "" ..core.colorize("#68fff6", "Rhenium Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_block_rhenium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 7},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_rhenium',
	recipe = {
		{'xtraores:rhenium_ingot', 'xtraores:rhenium_ingot', 'xtraores:rhenium_ingot'},
		{'xtraores:rhenium_ingot', 'xtraores:rhenium_ingot', 'xtraores:rhenium_ingot'},
		{'xtraores:rhenium_ingot', 'xtraores:rhenium_ingot', 'xtraores:rhenium_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:rhenium_ingot 9',
	recipe = {
		{'xtraores:block_rhenium'},
	}
})
minetest.register_node("xtraores:decobrick_rhenium", {
		description = "" ..core.colorize("#68fff6", "Decorative Rhenium Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_decobrick_rhenium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 7},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_rhenium 4',
	recipe = {
		{'xtraores:brick_rhenium', 'xtraores:brick_rhenium', ''},
		{'xtraores:brick_rhenium', 'xtraores:brick_rhenium', ''},

	}
})

-----vanadium--------

minetest.register_node("xtraores:brick_vanadium", {
		description = "" ..core.colorize("#68fff6", "Vanadium Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_brick_vanadium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 8},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_vanadium",
	recipe = {"xtraores:vanadium_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_vanadium", {
		description = "" ..core.colorize("#68fff6", "Vanadium Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_block_vanadium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 8},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_vanadium',
	recipe = {
		{'xtraores:vanadium_ingot', 'xtraores:vanadium_ingot', 'xtraores:vanadium_ingot'},
		{'xtraores:vanadium_ingot', 'xtraores:vanadium_ingot', 'xtraores:vanadium_ingot'},
		{'xtraores:vanadium_ingot', 'xtraores:vanadium_ingot', 'xtraores:vanadium_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:vanadium_ingot 9',
	recipe = {
		{'xtraores:block_vanadium'},
	}
})
minetest.register_node("xtraores:decobrick_vanadium", {
		description = "" ..core.colorize("#68fff6", "Decorative Vanadium Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {"xtraores_decobrick_vanadium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 8},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_vanadium 4',
	recipe = {
		{'xtraores:brick_vanadium', 'xtraores:brick_vanadium', ''},
		{'xtraores:brick_vanadium', 'xtraores:brick_vanadium', ''},

	}
})

-----rarium--------

minetest.register_node("xtraores:brick_rarium", {
		description = "" ..core.colorize("#68fff6", "Rarium Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {{
		    name = "xtraores_brick_rarium.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.66}
	}},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 9},
	light_source = 5,
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_rarium",
	recipe = {"xtraores:rarium_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_rarium", {
		description = "" ..core.colorize("#68fff6", "Rarium Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {{
		    name = "xtraores_block_rarium.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.66}
	}},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 9},
	light_source = 5,
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_rarium',
	recipe = {
		{'xtraores:rarium_ingot', 'xtraores:rarium_ingot', 'xtraores:rarium_ingot'},
		{'xtraores:rarium_ingot', 'xtraores:rarium_ingot', 'xtraores:rarium_ingot'},
		{'xtraores:rarium_ingot', 'xtraores:rarium_ingot', 'xtraores:rarium_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:rarium_ingot 9',
	recipe = {
		{'xtraores:block_rarium'},
	}
})
minetest.register_node("xtraores:decobrick_rarium", {
		description = "" ..core.colorize("#68fff6", "Decorative Rarium Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	paramtype2 = "facedir",
	place_param2 = 0,
	tiles = {{
		    name = "xtraores_decobrick_rarium.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.66}
	}},
	is_ground_content = false,
	light_source = 5,
	stack_max= 999,
	groups = {cracky = 9},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_rarium 4',
	recipe = {
		{'xtraores:brick_rarium', 'xtraores:brick_rarium', ''},
		{'xtraores:brick_rarium', 'xtraores:brick_rarium', ''},

	}
})

-----orichalcum--------

minetest.register_node("xtraores:brick_orichalcum", {
		description = "" ..core.colorize("#68fff6", "Orichalcum Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {"xtraores_brick_orichalcum.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 10},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_orichalcum",
	recipe = {"xtraores:orichalcum_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_orichalcum", {
		description = "" ..core.colorize("#68fff6", "Orichalcum Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {"xtraores_block_orichalcum.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 10},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_orichalcum',
	recipe = {
		{'xtraores:orichalcum_ingot', 'xtraores:orichalcum_ingot', 'xtraores:orichalcum_ingot'},
		{'xtraores:orichalcum_ingot', 'xtraores:orichalcum_ingot', 'xtraores:orichalcum_ingot'},
		{'xtraores:orichalcum_ingot', 'xtraores:orichalcum_ingot', 'xtraores:orichalcum_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:orichalcum_ingot 9',
	recipe = {
		{'xtraores:block_orichalcum'},
	}
})
minetest.register_node("xtraores:decobrick_orichalcum", {
		description = "" ..core.colorize("#68fff6", "Decorative Orichalcum Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	tiles = {"xtraores_decobrick_orichalcum.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 10},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_orichalcum 4',
	recipe = {
		{'xtraores:brick_orichalcum', 'xtraores:brick_orichalcum', ''},
		{'xtraores:brick_orichalcum', 'xtraores:brick_orichalcum', ''},

	}
})

-----titanium--------

minetest.register_node("xtraores:brick_titanium", {
		description = "" ..core.colorize("#68fff6", "Titanium Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {"xtraores_brick_titanium.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 11},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_titanium",
	recipe = {"xtraores:titanium_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_titanium", {
		description = "" ..core.colorize("#68fff6", "Titanium Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {"xtraores_block_titanium.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 11},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_titanium',
	recipe = {
		{'xtraores:titanium_ingot', 'xtraores:titanium_ingot', 'xtraores:titanium_ingot'},
		{'xtraores:titanium_ingot', 'xtraores:titanium_ingot', 'xtraores:titanium_ingot'},
		{'xtraores:titanium_ingot', 'xtraores:titanium_ingot', 'xtraores:titanium_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:titanium_ingot 9',
	recipe = {
		{'xtraores:block_titanium'},
	}
})
minetest.register_node("xtraores:decobrick_titanium", {
		description = "" ..core.colorize("#68fff6", "Decorative Titanium Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	tiles = {"xtraores_decobrick_titanium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 11},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_titanium 4',
	recipe = {
		{'xtraores:brick_titanium', 'xtraores:brick_titanium', ''},
		{'xtraores:brick_titanium', 'xtraores:brick_titanium', ''},

	}
})

-----iridium--------

minetest.register_node("xtraores:brick_iridium", {
		description = "" ..core.colorize("#68fff6", "Iridium Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {{
		    name = "xtraores_brick_iridium.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.75}
	}},
	paramtype2 = "facedir",
	place_param2 = 0,
	light_source = 10,
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 11},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_iridium",
	recipe = {"xtraores:iridium_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_iridium", {
		description = "" ..core.colorize("#68fff6", "Iridium Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {{
		    name = "xtraores_block_iridium.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.75}
	}},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	stack_max= 999,
	light_source = 14,
	groups = {cracky = 11},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_iridium',
	recipe = {
		{'xtraores:iridium_ingot', 'xtraores:iridium_ingot', 'xtraores:iridium_ingot'},
		{'xtraores:iridium_ingot', 'xtraores:iridium_ingot', 'xtraores:iridium_ingot'},
		{'xtraores:iridium_ingot', 'xtraores:iridium_ingot', 'xtraores:iridium_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:iridium_ingot 9',
	recipe = {
		{'xtraores:block_iridium'},
	}
})
minetest.register_node("xtraores:decobrick_iridium", {
		description = "" ..core.colorize("#68fff6", "Decorative Iridium Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	tiles = {{
		    name = "xtraores_decobrick_iridium.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 0.75}
	}},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 11},
	light_source = 8,
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_iridium 4',
	recipe = {
		{'xtraores:brick_iridium', 'xtraores:brick_iridium', ''},
		{'xtraores:brick_iridium', 'xtraores:brick_iridium', ''},

	}
})

-----neutronium--------

minetest.register_node("xtraores:brick_neutronium", {
		description = "" ..core.colorize("#68fff6", "Neutronium Brick\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {"xtraores_brick_neutronium.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 12},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft( {
	type = "shapeless",
	output = "xtraores:brick_neutronium",
	recipe = {"xtraores:neutronium_lump", "default:cobble"},
})

minetest.register_node("xtraores:block_neutronium", {
		description = "" ..core.colorize("#68fff6", "Neutronium Block\n")..core.colorize("#FFFFFF", "Can be placed\n")..core.colorize("#FFFFFF", "Material"),
	tiles = {"xtraores_block_neutronium.png"},
	paramtype2 = "facedir",
	place_param2 = 0,
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 12},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_craft({
	output = 'xtraores:block_neutronium',
	recipe = {
		{'xtraores:neutronium_ingot', 'xtraores:neutronium_ingot', 'xtraores:neutronium_ingot'},
		{'xtraores:neutronium_ingot', 'xtraores:neutronium_ingot', 'xtraores:neutronium_ingot'},
		{'xtraores:neutronium_ingot', 'xtraores:neutronium_ingot', 'xtraores:neutronium_ingot'},
	}
})

minetest.register_craft({
	output = 'xtraores:neutronium_ingot 9',
	recipe = {
		{'xtraores:block_neutronium'},
	}
})
minetest.register_node("xtraores:decobrick_neutronium", {
		description = "" ..core.colorize("#68fff6", "Decorative Neutronium Brick\n")..core.colorize("#FFFFFF", "Can be placed"),
	tiles = {"xtraores_decobrick_neutronium.png"},
	is_ground_content = false,
	stack_max= 999,
	groups = {cracky = 12},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = 'xtraores:decobrick_neutronium 4',
	recipe = {
		{'xtraores:brick_neutronium', 'xtraores:brick_neutronium', ''},
		{'xtraores:brick_neutronium', 'xtraores:brick_neutronium', ''},

	}
})

minetest.register_craft({
   output = 'xtraores:nickel_ore 4',
   recipe = {
      {'xtraores:nickel_lump', 'xtraores:nickel_lump'},
      {'xtraores:nickel_lump', 'xtraores:nickel_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:platinum_ore 4',
   recipe = {
      {'xtraores:platinum_lump', 'xtraores:platinum_lump'},
      {'xtraores:platinum_lump', 'xtraores:platinum_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:palladium_ore 4',
   recipe = {
      {'xtraores:palladium_lump', 'xtraores:palladium_lump'},
      {'xtraores:palladium_lump', 'xtraores:palladium_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:cobalt_ore 4',
   recipe = {
      {'xtraores:cobalt_lump', 'xtraores:cobalt_lump'},
      {'xtraores:cobalt_lump', 'xtraores:cobalt_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:thorium_ore 4',
   recipe = {
      {'xtraores:thorium_lump', 'xtraores:thorium_lump'},
      {'xtraores:thorium_lump', 'xtraores:thorium_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:anthracite_ore 4',
   recipe = {
      {'xtraores:anthracite_lump', 'xtraores:anthracite_lump'},
      {'xtraores:anthracite_lump', 'xtraores:anthracite_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:osmium_ore 4',
   recipe = {
      {'xtraores:osmium_lump', 'xtraores:osmium_lump'},
      {'xtraores:osmium_lump', 'xtraores:osmium_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:rhenium_ore 4',
   recipe = {
      {'xtraores:rhenium_lump', 'xtraores:rhenium_lump'},
      {'xtraores:rhenium_lump', 'xtraores:rhenium_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:vanadium_ore 4',
   recipe = {
      {'xtraores:vanadium_lump', 'xtraores:vanadium_lump'},
      {'xtraores:vanadium_lump', 'xtraores:vanadium_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:rarium_ore 4',
   recipe = {
      {'xtraores:rarium_lump', 'xtraores:rarium_lump'},
      {'xtraores:rarium_lump', 'xtraores:rarium_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:orichalcum_ore 4',
   recipe = {
      {'xtraores:orichalcum_lump', 'xtraores:orichalcum_lump'},
      {'xtraores:orichalcum_lump', 'xtraores:orichalcum_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:titanium_ore 4',
   recipe = {
      {'xtraores:titanium_lump', 'xtraores:titanium_lump'},
      {'xtraores:titanium_lump', 'xtraores:titanium_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:iridium_ore 4',
   recipe = {
      {'xtraores:iridium_lump', 'xtraores:iridium_lump'},
      {'xtraores:iridium_lump', 'xtraores:iridium_lump'},
   }
})

minetest.register_craft({
   output = 'xtraores:neutronium_ore 4',
   recipe = {
      {'xtraores:neutronium_lump', 'xtraores:neutronium_lump'},
      {'xtraores:neutronium_lump', 'xtraores:neutronium_lump'},
   }
})
