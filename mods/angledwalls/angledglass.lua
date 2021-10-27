angledglass = {}
-- edited for MinePlus by dhausmig

-- Angled place function
-- To use put "on_place = angledglass.angled_place" in the node def

function angledglass.angled_place(itemstack, placer, pointed_thing)
	local placer_pos = placer:get_pos()
	local pos = pointed_thing.above
	local param2
	if pos.x > placer_pos.x then
		if pos.z > placer_pos.z then
			param2 = 1
		else
			param2 = 2
		end
	else
		if pos.z > placer_pos.z then
			param2 = 0
		else
			param2 = 3
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end


--Register angledglass.
--Node will be called angledglass:<subname>

function angledglass.register_glass(subname, recipeitem, glasstype, groups, images, description, sounds)
	groups.glass = 1

minetest.register_node(":angledglass:" .. subname, {
	description = description,
	drawtype = "mesh",
	mesh = "angled_glass.obj",
	tiles = images,
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propogates = true,
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = groups,
	sounds = sounds,
	collision_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375},
			{-0.4375, -0.5, -0.4375, -0.3125, 0.5, -0.3125},
			{0.3125, -0.5, 0.3125, 0.4375, 0.5, 0.4375},
			{0.25, -0.5, 0.25, 0.375, 0.5, 0.375},
			{-0.375, -0.5, -0.375, -0.25, 0.5, -0.25},
			{0.1875, -0.5, 0.1875, 0.3125, 0.5, 0.3125},
			{-0.3125, -0.5, -0.3125, -0.1875, 0.5, -0.1875},
			{0.125, -0.5, 0.125, 0.25, 0.5, 0.25},
			{-0.25, -0.5, -0.25, -0.125, 0.5, -0.125},
			{0.0625, -0.5, 0.0625, 0.1875, 0.5, 0.1875},
			{-0.1875, -0.5, -0.1875, -0.0625, 0.5, -0.0625},
			{0, -0.5, 0, 0.125, 0.5, 0.125},
			{-0.125, -0.5, -0.125, 0, 0.5, 0},
			{-0.0625, -0.5, -0.0625, 0.0625, 0.5, 0.0625},
		}
	},
	on_place = angledglass.angled_place
})

minetest.register_craft({
	output = "angledglass:" .. subname,
	recipe = {
		{glasstype, "", recipeitem},
		{"", glasstype, ""},
		{recipeitem, "", glasstype},
	},
})

end


-- Register glass types

angledglass.register_glass("acacia_wood_glass", "default:acacia_wood", "default:glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_glass.png", "default_acacia_wood.png"},
		"Acacia Wood Glass",
		default.node_sound_glass_defaults())
		
angledglass.register_glass("acacia_wood_obsidian_glass", "default:acacia_wood", "default:obsidian_glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_obsidian_glass.png", "default_acacia_wood.png"},
		"Acacia Wood Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("aspen_wood_glass", "default:aspen_wood", "default:glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_glass.png", "default_aspen_wood.png"},
		"Aspen Wood Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("aspen_wood_obsidian_glass", "default:aspen_wood", "default:obsidian_glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_obsidian_glass.png", "default_aspen_wood.png"},
		"Aspen Wood Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("junglewood_glass", "default:junglewood", "default:glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_glass.png", "default_junglewood.png"},
		"Junglewood Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("junglewood_obsidian_glass", "default:junglewood", "default:obsidian_glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_obsidian_glass.png", "default_junglewood.png",},
		"Junglewood Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("pine_wood_glass", "default:pine_wood", "default:glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_glass.png", "default_pine_wood.png"},
		"Pine Wood Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("pine_wood_obsidian_glass", "default:pine_wood", "default:obsidian_glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_obsidian_glass.png", "default_pine_wood.png"},
		"Pine Wood Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("wooden_glass", "default:wood", "default:glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_glass.png", "default_wood.png"},
		"Wooden Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("wooden_obsidian_glass", "default:wood", "default:obsidian_glass",
		{choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, wood = 1},
		{"default_obsidian_glass.png", "default_wood.png"},
		"Wooden Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("brick_glass", "default:brick", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_brick.png"},
		"Brick Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("brick_obsidian_glass", "default:brick", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_brick.png"},
		"Brick Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("cobble_glass", "default:cobble", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_cobble.png"},
		"Cobble Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("cobble_obsidian_glass", "default:cobble", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_cobble.png"},
		"Cobble Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("mossycobble_glass", "default:mossycobble", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_mossycobble.png"},
		"Mossycobble Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("mossycobble_obsidian_glass", "default:mossycobble", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_mossycobble.png"},
		"Mossycobble Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("stone_glass", "default:stone", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_stone.png"},
		"Stone Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("stone_obsidian_glass", "default:stone", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_stone.png"},
		"Stone Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("stone_block_glass", "default:stone_block", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_stone_block.png"},
		"Stone Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("stone_block_obsidian_glass", "default:stone_block", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_stone_block.png"},
		"Stone Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("stone_brick_glass", "default:stonebrick", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_stone_brick.png"},
		"Stone Brick Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("stone_brick_obsidian_glass", "default:stonebrick", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_stone_brick.png"},
		"Stone Brick Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_cobble_glass", "default:desert_cobble", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_desert_cobble.png"},
		"Desert Cobble Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_cobble_obsidian_glass", "default:desert_cobble", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_desert_cobble.png"},
		"Desert Cobble Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_stone_glass", "default:desert_stone", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_desert_stone.png"},
		"Desert Stone Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_stone_obsidian_glass", "default:desert_stone", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_desert_stone.png"},
		"Desert Stone Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_stone_block_glass", "default:desert_stone_block", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_desert_stone_block.png"},
		"Desert Stone Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_stone_block_obsidian_glass", "default:desert_stone_block", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_desert_stone_block.png"},
		"Desert Stone Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_stone_brick_glass", "default:desert_stonebrick", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_desert_stone_brick.png"},
		"Desert Stone Brick Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_stone_brick_obsidian_glass", "default:desert_stonebrick", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_desert_stone_brick.png"},
		"Desert Stone Brick Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_sandstone_glass", "default:desert_sandstone", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_desert_sandstone.png"},
		"Desert Sandstone Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_sandstone_obsidian_glass", "default:desert_sandstone", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_desert_sandstone.png"},
		"Desert Sandstone Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_sandstone_block_glass", "default:desert_sandstone_block", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_desert_sandstone_block.png"},
		"Desert Sandstone Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_sandstone_block_obsidian_glass", "default:desert_sandstone_block", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_desert_sandstone_block.png"},
		"Desert Sandstone Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_sandstone_brick_glass", "default:desert_sandstone_brick", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_desert_sandstone_brick.png"},
		"Desert Sandstone Brick Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("desert_sandstone_brick_obsidian_glass", "default:desert_sandstone_brick", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_desert_sandstone_brick.png"},
		"Desert Sandstone Brick Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("sandstone_glass", "default:sandstone", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_sandstone.png"},
		"Sandstone Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("sandstone_obsidian_glass", "default:sandstone", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_sandstone.png"},
		"Sandstone Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("sandstone_block_glass", "default:sandstone_block", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_sandstone_block.png"},
		"Sandstone Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("sandstone_block_obsidian_glass", "default:sandstone_block", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_sandstone_block.png"},
		"Sandstone Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("sandstone_brick_glass", "default:sandstonebrick", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_sandstone_brick.png"},
		"Sandstone Brick Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("sandstone_brick_obsidian_glass", "default:sandstonebrick", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_sandstone_brick.png"},
		"Sandstone Brick Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("silver_sandstone_glass", "default:silver_sandstone", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_silver_sandstone.png"},
		"Silver Sandstone Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("silver_sandstone_obsidian_glass", "default:silver_sandstone", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_silver_sandstone.png"},
		"Silver Sandstone Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("silver_sandstone_block_glass", "default:silver_sandstone_block", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_silver_sandstone_block.png"},
		"Silver Sandstone Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("silver_sandstone_block_obsidian_glass", "default:silver_sandstone_block", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_silver_sandstone_block.png"},
		"Silver Sandstone Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("silver_sandstone_brick_glass", "default:silver_sandstone_brick", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_silver_sandstone_brick.png"},
		"Silver Sandstone Brick Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("silver_sandstone_brick_obsidian_glass", "default:silver_sandstone_brick", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_silver_sandstone_brick.png"},
		"Silver Sandstone Brick Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("bronze_block_glass", "default:bronzeblock", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_bronze_block.png"},
		"Bronze Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("bronze_block_obsidian_glass", "default:bronzeblock", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_bronze_block.png"},
		"Bronze Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("clay_glass", "default:clay", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_clay.png"},
		"Clay Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("clay_obsidian_glass", "default:clay", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_clay.png"},
		"Clay Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("coal_block_glass", "default:coalblock", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_coal_block.png"},
		"Coal Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("coal_block_obsidian_glass", "default:coalblock", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_coal_block.png"},
		"Coal Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("copper_block_glass", "default:copperblock", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_copper_block.png"},
		"Copper Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("copper_block_obsidian_glass", "default:copperblock", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_copper_block.png"},
		"Copper Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("diamond_block_glass", "default:diamondblock", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_diamond_block.png"},
		"Diamond Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("diamond_block_obsidian_glass", "default:diamondblock", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_diamond_block.png"},
		"Diamond Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("gold_block_glass", "default:goldblock", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_gold_block.png"},
		"Gold Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("gold_block_obsidian_glass", "default:goldblock", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_gold_block.png"},
		"Gold Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("mese_block_glass", "default:mese", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_mese_block.png"},
		"Mese Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("mese_block_obsidian_glass", "default:mese", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_mese_block.png"},
		"Mese Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("steel_block_glass", "default:steelblock", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_steel_block.png"},
		"Steel Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("steel_block_obsidian_glass", "default:steelblock", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_steel_block.png"},
		"Steel Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("tin_block_glass", "default:tinblock", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_tin_block.png"},
		"Tin Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("tin_block_obsidian_glass", "default:tinblock", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_tin_block.png"},
		"Tin Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("glass_glass", "default:glass", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_glass.png"},
		"Glass Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("glass_obsidian_glass", "default:glass", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_glass.png"},
		"Glass Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("obsidian_glass", "default:obsidian", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_obsidian.png"},
		"Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("obsidian_obsidian_glass", "default:obsidian", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_obsidian.png"},
		"Obsidian Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("obsidian_block_glass", "default:obsidian_block", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_obsidian_block.png"},
		"Obsidian Block Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("obsidian_block_obsidian_glass", "default:obsidian_block", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_obsidian_block.png"},
		"Obsidian Block Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("obsidian_brick_glass", "default:obsidianbrick", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_obsidian_brick.png"},
		"Obsidian Brick Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("obsidian_brick_obsidian_glass", "default:obsidianbrick", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_obsidian_brick.png"},
		"Obsidian Brick Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("obsidian_glass_glass", "default:obsidian_glass", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_obsidian_glass.png"},
		"Obsidian Glass Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("obsidian_glass_obsidian_glass", "default:obsidian_glass", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_obsidian_glass.png"},
		"Obsidian Glass Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("snow_glass", "default:snow", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_snow.png"},
		"Snow Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("snow_obsidian_glass", "default:snow", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_snow.png"},
		"Snow Obsidian Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("ice_glass", "default:ice", "default:glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_glass.png", "default_ice.png"},
		"Ice Glass",
		default.node_sound_glass_defaults())

angledglass.register_glass("ice_obsidian_glass", "default:ice", "default:obsidian_glass",
		{cracky = 2, oddly_breakable_by_hand = 2, stone = 1},
		{"default_obsidian_glass.png", "default_ice.png"},
		"Ice Obsidian Glass",
		default.node_sound_glass_defaults())





