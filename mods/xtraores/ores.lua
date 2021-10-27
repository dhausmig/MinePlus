

---------------------nickel---------------------

minetest.register_craftitem("xtraores:nickel_lump", {
	description = "" ..core.colorize("#68fff6", "Nickel Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 1"),
	stack_max= 999,
	inventory_image = "xtraores_nickel_lump.png"
})

minetest.register_craftitem("xtraores:nickel_dust", {
	description = "" ..core.colorize("#68fff6", "Nickel Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 1"),
	stack_max= 9999,
	inventory_image = "xtraores_nickel_dust.png"
})

minetest.register_node("xtraores:nickel_ore", {
	description = "" ..core.colorize("#68fff6", "Nickel ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 1"),
	tiles = {"default_stone.png^xtraores_nickel_ore.png"},
	drop = "xtraores:nickel_lump",
	stack_max= 999,
	groups = {cracky = 3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:nickel_ore",
	wherein        = "default:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min          = -31000,
	y_max          = 100,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:nickel_ore",
	wherein        = "default:stone",
	clust_scarcity = 9 * 9 * 9,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min          = -31000,
	y_max          = -1,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 2,
	output = "xtraores:nickel_ingot",
	recipe = "xtraores:nickel_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 1,
	output = "xtraores:nickel_ingot",
	recipe = "xtraores:nickel_dust",
})

---------------------platinum---------------------

minetest.register_craftitem("xtraores:platinum_lump", {
	description = "" ..core.colorize("#68fff6", "Platinum Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 2"),
	stack_max= 999,
	inventory_image = "xtraores_platinum_lump.png"
})

minetest.register_craftitem("xtraores:platinum_dust", {
	description = "" ..core.colorize("#68fff6", "Platinum Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 2"),
	stack_max= 9999,
	inventory_image = "xtraores_platinum_dust.png"
})

minetest.register_node("xtraores:platinum_ore", {
	description = "" ..core.colorize("#68fff6", "Platinum ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 2"),
	tiles = {"default_stone.png^xtraores_platinum_ore.png"},
	drop = "xtraores:platinum_lump",
	stack_max= 999,
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:platinum_ore",
	wherein        = "default:stone",
	clust_scarcity = 12 * 12 * 12,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min          = -31000,
	y_max          = -85,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 5,
	output = "xtraores:platinum_ingot",
	recipe = "xtraores:platinum_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 2,
	output = "xtraores:platinum_ingot",
	recipe = "xtraores:platinum_dust",
})

---------------------palladium---------------------

minetest.register_craftitem("xtraores:palladium_lump", {
	description = "" ..core.colorize("#68fff6", "Palladium Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 3"),
	stack_max= 999,
	inventory_image = "xtraores_platinum_lump.png"
})

minetest.register_craftitem("xtraores:palladium_dust", {
	description = "" ..core.colorize("#68fff6", "Palladium Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 3"),
	stack_max= 9999,
	inventory_image = "xtraores_platinum_dust.png"
})

minetest.register_node("xtraores:palladium_ore", {
	description = "" ..core.colorize("#68fff6", "palladium ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 3"),
	tiles = {"default_stone.png^xtraores_palladium_ore.png"},
	drop = "xtraores:palladium_lump",
	stack_max= 999,
	groups = {cracky = 1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:palladium_ore",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min          = -31000,
	y_max          = -250,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 12,
	output = "xtraores:palladium_ingot",
	recipe = "xtraores:palladium_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "xtraores:palladium_ingot",
	recipe = "xtraores:palladium_dust",
})

---------------------cobalt---------------------

minetest.register_craftitem("xtraores:cobalt_lump", {
	description = "" ..core.colorize("#68fff6", "Cobalt Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 4"),
	stack_max= 999,
	inventory_image = "xtraores_cobalt_lump.png"
})

minetest.register_craftitem("xtraores:cobalt_dust", {
	description = "" ..core.colorize("#68fff6", "Cobalt Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 4"),
	stack_max= 9999,
	inventory_image = "xtraores_cobalt_dust.png"
})

minetest.register_node("xtraores:cobalt_ore", {
	description = "" ..core.colorize("#68fff6", "Cobalt ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 4"),
	tiles = {"default_stone.png^xtraores_cobalt_ore.png"},
	drop = "xtraores:cobalt_lump",
	stack_max= 999,
	groups = {cracky = 4},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:cobalt_ore",
	wherein        = "default:stone",
	clust_scarcity = 17 * 17 * 17,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min          = -31000,
	y_max          = -600,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 20,
	output = "xtraores:cobalt_ingot",
	recipe = "xtraores:cobalt_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 5,
	output = "xtraores:cobalt_ingot",
	recipe = "xtraores:cobalt_dust",
})

---------------------thorium---------------------

minetest.register_craftitem("xtraores:thorium_lump", {
	description = "" ..core.colorize("#68fff6", "Thorium Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 5"),
	stack_max= 999,
	inventory_image = "xtraores_thorium_lump.png"
})

minetest.register_craftitem("xtraores:thorium_dust", {
	description = "" ..core.colorize("#68fff6", "Thorium Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 5"),
	stack_max= 9999,
	inventory_image = "xtraores_thorium_dust.png"
})

minetest.register_node("xtraores:thorium_ore", {
	description = "" ..core.colorize("#68fff6", "Thorium ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 5"),
	tiles = {"default_stone.png^xtraores_thorium_ore.png"},
	drop = "xtraores:thorium_lump",
	stack_max= 999,
	groups = {cracky = 5},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:thorium_ore",
	wherein        = "default:stone",
	clust_scarcity = 19 * 19 * 19,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min          = -31000,
	y_max          = -1250,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 32,
	output = "xtraores:thorium_ingot",
	recipe = "xtraores:thorium_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 8,
	output = "xtraores:thorium_ingot",
	recipe = "xtraores:thorium_dust",
})

-----------------anthracite ore--------------

minetest.register_craftitem("xtraores:anthracite_lump", {
	description = "" ..core.colorize("#68fff6", "Anthracite Lump\n")..
		core.colorize("#FFFFFF", "Combustable\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 5"),
	stack_max= 999,
	inventory_image = "xtraores_anthracite_lump.png"
})

minetest.register_node("xtraores:anthracite_ore", {
	description = "" ..core.colorize("#68fff6", "anthracite\n")..
--		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 5"),
	tiles = {"default_stone.png^xtraores_anthracite_ore.png"},
	drop = "xtraores:anthracite_lump",
	stack_max= 999,
	groups = {cracky = 5},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:anthracite_ore",
	wherein        = "default:stone",
	clust_scarcity = 15 * 15 * 15,
	clust_num_ores = 6,
	clust_size     = 5,
	y_min          = -31000,
	y_max          = -2000,
})

minetest.register_craft({
	output = 'xtraores:anthracite_torch 5',
	recipe = {
		{'', '', ''},
		{'', 'xtraores:anthracite_lump', ''},
		{'', 'xtraores:steel_handle', ''},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "xtraores:anthracite_lump",
	burntime = 164,
})

---------------------osmium---------------------

minetest.register_craftitem("xtraores:osmium_lump", {
	description = "" ..core.colorize("#68fff6", "Osmium Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 6"),
	stack_max= 999,
	inventory_image = "xtraores_osmium_lump.png"
})

minetest.register_craftitem("xtraores:osmium_dust", {
	description = "" ..core.colorize("#68fff6", "Osmium Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 6"),
	stack_max= 9999,
	inventory_image = "xtraores_osmium_dust.png"
})

minetest.register_node("xtraores:osmium_ore", {
	description = "" ..core.colorize("#68fff6", "Osmium ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 6"),
	tiles = {"default_stone.png^xtraores_osmium_ore.png"},
	drop = "xtraores:osmium_lump",
	stack_max= 999,
	groups = {cracky = 6},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:osmium_ore",
	wherein        = "default:stone",
	clust_scarcity = 21 * 21 * 21,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min          = -31000,
	y_max          = -3500,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 45,
	output = "xtraores:osmium_ingot",
	recipe = "xtraores:osmium_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 11,
	output = "xtraores:osmium_ingot",
	recipe = "xtraores:osmium_dust",
})

---------------------rhenium---------------------

minetest.register_craftitem("xtraores:rhenium_lump", {
	description = "" ..core.colorize("#68fff6", "Rhenium Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 7"),
	stack_max= 999,
	inventory_image = "xtraores_rhenium_lump.png"
})

minetest.register_craftitem("xtraores:rhenium_dust", {
	description = "" ..core.colorize("#68fff6", "Rhenium Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 7"),
	stack_max= 9999,
	inventory_image = "xtraores_rhenium_dust.png"
})

minetest.register_node("xtraores:rhenium_ore", {
	description = "" ..core.colorize("#68fff6", "Rhenium ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 7"),
	tiles = {"default_stone.png^xtraores_rhenium_ore.png"},
	drop = "xtraores:rhenium_lump",
	stack_max= 999,
	groups = {cracky = 7},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:rhenium_ore",
	wherein        = "default:stone",
	clust_scarcity = 23 * 23 * 23,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min          = -31000,
	y_max          = -5750,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 60,
	output = "xtraores:rhenium_ingot",
	recipe = "xtraores:rhenium_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "xtraores:rhenium_ingot",
	recipe = "xtraores:rhenium_dust",
})

---------------------vanadium---------------------

minetest.register_craftitem("xtraores:vanadium_lump", {
	description = "" ..core.colorize("#68fff6", "Vanadium Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 8"),
	stack_max= 999,
	inventory_image = "xtraores_vanadium_lump.png"
})

minetest.register_craftitem("xtraores:vanadium_dust", {
	description = "" ..core.colorize("#68fff6", "Vanadium Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 8"),
	stack_max= 9999,
	inventory_image = "xtraores_vanadium_dust.png"
})

minetest.register_node("xtraores:vanadium_ore", {
	description = "" ..core.colorize("#68fff6", "vanadium ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 8"),
	tiles = {"default_stone.png^xtraores_vanadium_ore.png"},
	drop = "xtraores:vanadium_lump",
	stack_max= 999,
	groups = {cracky = 8},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:vanadium_ore",
	wherein        = "default:stone",
	clust_scarcity = 26 * 26 * 26,
	clust_num_ores = 4,
	clust_size     = 4,
	y_min          = -31000,
	y_max          = -8000,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 75,
	output = "xtraores:vanadium_ingot",
	recipe = "xtraores:vanadium_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 19,
	output = "xtraores:vanadium_ingot",
	recipe = "xtraores:vanadium_dust",
})

---------------------rarium---------------------

minetest.register_craftitem("xtraores:rarium_lump", {
	description = "" ..core.colorize("#68fff6", "Rarium Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 9"),
	stack_max= 999,
	inventory_image = "xtraores_rarium_lump.png"
})

minetest.register_craftitem("xtraores:rarium_dust", {
	description = "" ..core.colorize("#68fff6", "Rarium Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 9"),
	stack_max= 9999,
	inventory_image = "xtraores_rarium_dust.png"
})

minetest.register_node("xtraores:rarium_ore", {
	description = "" ..core.colorize("#68fff6", "Rarium ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 9"),
	tiles = {{
		    name = "xtraores_rarium_ore.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.0}
	}},
	light_source = 4,
	drop = "xtraores:rarium_lump",
	stack_max= 999,
	groups = {cracky = 9},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:rarium_ore",
	wherein        = "default:stone",
	clust_scarcity = 30 * 30 * 30,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = -10000,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 90,
	output = "xtraores:rarium_ingot",
	recipe = "xtraores:rarium_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 23,
	output = "xtraores:rarium_ingot",
	recipe = "xtraores:rarium_dust",
})

---------------------orichalcum---------------------

minetest.register_craftitem("xtraores:orichalcum_lump", {
	description = "" ..core.colorize("#68fff6", "Orichalcum Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 10"),
	stack_max= 999,
	inventory_image = "xtraores_orichalcum_lump.png"
})

minetest.register_craftitem("xtraores:orichalcum_dust", {
	description = "" ..core.colorize("#68fff6", "Orichalcum Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 10"),
	stack_max= 9999,
	inventory_image = "xtraores_orichalcum_dust.png"
})

minetest.register_node("xtraores:orichalcum_ore", {
	description = "" ..core.colorize("#68fff6", "Orichalcum ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 10"),
	tiles = {"default_stone.png^xtraores_orichalcum_ore.png"},
	drop = "xtraores:orichalcum_lump",
	stack_max= 999,
	groups = {cracky = 10},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:orichalcum_ore",
	wherein        = "default:stone",
	clust_scarcity = 34 * 34 * 34,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = -12500,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 120,
	output = "xtraores:orichalcum_ingot",
	recipe = "xtraores:orichalcum_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 30,
	output = "xtraores:orichalcum_ingot",
	recipe = "xtraores:orichalcum_dust",
})

---------------------titanium---------------------

minetest.register_craftitem("xtraores:titanium_lump", {
	description = "" ..core.colorize("#68fff6", "Titanium Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 11"),
	stack_max= 999,
	inventory_image = "xtraores_titanium_lump.png"
})

minetest.register_craftitem("xtraores:titanium_dust", {
	description = "" ..core.colorize("#68fff6", "Titanium Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 11"),
	stack_max= 9999,
	inventory_image = "xtraores_titanium_dust.png"
})

minetest.register_node("xtraores:titanium_ore", {
	description = "" ..core.colorize("#68fff6", "titanium ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 11"),
	tiles = {"default_stone.png^xtraores_titanium_ore.png"},
	drop = "xtraores:titanium_lump",
	stack_max= 999,
	groups = {cracky = 11},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:titanium_ore",
	wherein        = "default:stone",
	clust_scarcity = 36 * 36 * 36,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = -15000,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 145,
	output = "xtraores:titanium_ingot",
	recipe = "xtraores:titanium_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 36,
	output = "xtraores:titanium_ingot",
	recipe = "xtraores:titanium_dust",
})

---------------------iridium---------------------

minetest.register_craftitem("xtraores:iridium_lump", {
	description = "" ..core.colorize("#68fff6", "Iridium Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 11"),
	stack_max= 999,
	inventory_image = "xtraores_iridium_lump.png"
})

minetest.register_craftitem("xtraores:iridium_dust", {
	description = "" ..core.colorize("#68fff6", "Iridium Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 11"),
	stack_max= 9999,
	inventory_image = "xtraores_iridium_dust.png"
})

minetest.register_node("xtraores:iridium_ore", {
	description = "" ..core.colorize("#68fff6", "iridium ore\n")..
	core.colorize("#FFFFFF", "Can be placed\n")..
	core.colorize("#FFFFFF", "Material\n")..
	core.colorize("#FFFFFF", "Xtraores ore level: 11"),
	tiles = {{
		    name = "xtraores_iridium_ore.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1.0}
	}},
	light_source = 7,
	drop = "xtraores:iridium_lump",
	stack_max= 999,
	groups = {cracky = 11},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:iridium_ore",
	wherein        = "default:stone",
	clust_scarcity = 37 * 37 * 37,
	clust_num_ores = 2,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = -15000,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 145,
	output = "xtraores:iridium_ingot",
	recipe = "xtraores:iridium_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 36,
	output = "xtraores:iridium_ingot",
	recipe = "xtraores:iridium_dust",
})

---------------------neutronium---------------------

minetest.register_craftitem("xtraores:neutronium_lump", {
	description = "" ..core.colorize("#68fff6", "Neutronium Lump\n")..
		core.colorize("#FFFFFF", "Xtraores lump level: 12"),
	stack_max= 999,
	inventory_image = "xtraores_neutronium_lump.png"
})

minetest.register_craftitem("xtraores:neutronium_dust", {
	description = "" ..core.colorize("#68fff6", "Neutronium Dust\n")..
		core.colorize("#FFFFFF", "Xtraores dust level: 12"),
	stack_max= 9999,
	inventory_image = "xtraores_neutronium_dust.png"
})

minetest.register_node("xtraores:neutronium_ore", {
	description = "" ..core.colorize("#68fff6", "Neutronium Ore\n")..
		core.colorize("#FFFFFF", "Can be placed\n")..
		core.colorize("#FFFFFF", "Material\n")..
		core.colorize("#FFFFFF", "Xtraores ore level: 12"),
	tiles = {"default_stone.png^xtraores_neutronium_ore.png"},
	drop = "xtraores:neutronium_lump",
	stack_max= 999,
	groups = {cracky = 12},
	on_blast = function() end,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "xtraores:neutronium_ore",
	wherein        = "default:stone",
	clust_scarcity = 38 * 38 * 38,
	clust_num_ores = 3,
	clust_size     = 3,
	y_min          = -31000,
	y_max          = -18000,
})

minetest.register_craft({
	type = "cooking",
	cooktime = 180,
	output = "xtraores:neutronium_ingot",
	recipe = "xtraores:neutronium_lump",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 45,
	output = "xtraores:neutronium_ingot",
	recipe = "xtraores:neutronium_dust",
})
