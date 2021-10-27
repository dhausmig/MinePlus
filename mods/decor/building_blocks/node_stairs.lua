local S = minetest.get_translator("building_blocks")

local stairs_groups_names = {"cracky","choppy","flammable","crumbly","snappy"}

local function building_blocks_stairs(nodename, def)
	minetest.register_node(nodename, def)
	if minetest.get_modpath("moreblocks") or minetest.get_modpath("stairs") then
		local mod, name = nodename:match("(.*):(.*)")
		minetest.register_alias(mod .. ":slab_" .. name, "stairs:slab_" .. name)
		minetest.register_alias(mod .. ":stair_" .. name, "stairs:stair_" .. name)
		local stairs_groups = {}
		for _, groupname in ipairs(stairs_groups_names) do
			stairs_groups[groupname] = def.groups[groupname]
		end

		if minetest.get_modpath("moreblocks") then
			stairsplus:register_all(
				mod,
				name,
				nodename,
				{
					description = def.description,
					tiles = def.tiles,
					use_texture_alpha = "clip",
					groups = stairs_groups,
					sounds = def.sounds,
				}
			)
		else
			stairs.register_stair_and_slab(name,nodename,
				stairs_groups,
				def.tiles,
				def.stair_desc,
				def.slab_desc,
				def.sounds
				--FIXME: Missing descriptions for Inner and Outer stairs
				-- See https://github.com/minetest/minetest_game/pull/2584
			)
		end
	end
end

building_blocks_stairs("building_blocks:grate", {
	drawtype = "glasslike",
	description = S("Grate"),
	stair_desc = S("Grate Stair"),
	slab = S("Grate Slab"),
	tiles = {"building_blocks_grate.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_metal_defaults(),
})

building_blocks_stairs("building_blocks:smoothglass", {
	drawtype = "glasslike",
	description = S("Streak Free Glass"),
	stair_desc = S("Streak Free Glass Stair"),
	slab_desc = S("Streak Free Glass Slab"),
	tiles = {"building_blocks_sglass.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=3,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

building_blocks_stairs("building_blocks:woodglass", {
	drawtype = "glasslike",
	description = S("Wood Framed Glass"),
	stair_desc = S("Wood Framed Glass Stair"),
	slab_desc = S("Wood Framed Glass Slab"),
	tiles = {"building_blocks_wglass.png"},
	use_texture_alpha = "clip",
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=3,cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

building_blocks_stairs("building_blocks:Adobe", {
	tiles = {"building_blocks_Adobe.png"},
	use_texture_alpha = "clip",
	description = S("Adobe"),
	stair_desc = S("Adobe Stair"),
	slab_desc = S("Adobe Slab"),
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_stone_defaults(),
})

building_blocks_stairs("building_blocks:fakegrass", {
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	use_texture_alpha = "clip",
	description = S("Fake Grass"),
	stair_desc = S("Fake Grass Stair"),
	slab_desc = S("Fake Grass Slab"),
	is_ground_content = true,
	groups = {crumbly=3},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.4},
	}),
})

building_blocks_stairs("building_blocks:hardwood", {
	tiles = {"building_blocks_hardwood.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	description = S("Hardwood"),
	stair_desc = S("Hardwood Stair"),
	slab_desc = S("Hardwood Slab"),
	groups = {choppy=1,flammable=1},
	sounds = default.node_sound_wood_defaults(),
})

building_blocks_stairs("building_blocks:Roofing", {
	tiles = {"building_blocks_Roofing.png"},
	use_texture_alpha = "clip",
	is_ground_content = true,
	description = S("Roof block"),
	stair_desc = S("Roof block Stair"),
	slab_desc = S("Roof block Slab"),
	groups = {snappy=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("building_blocks:brobble_spread", {
	drawtype = "raillike",
	-- Translators: "Brobble" is a portmanteau of "Brick" and "Cobble".
	-- Translate however you see fit.
	description = S("Brobble Spread"),
	tiles = {"building_blocks_brobble.png"},
	use_texture_alpha = "clip",
	inventory_image = "building_blocks_brobble_spread_inv.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
})

if not minetest.get_modpath("moreblocks") or not minetest.get_modpath("gloopblocks") then
	minetest.register_node("building_blocks:gravel_spread", {
		drawtype = "raillike",
		description = S("Gravel Spread"),
		tiles = {"default_gravel.png"},
		use_texture_alpha = "clip",
		inventory_image = "building_blocks_gravel_spread_inv.png",
		paramtype = "light",
		walkable = false,
		selection_box = {
			type = "fixed",
					-- but how to specify the dimensions for curved and sideways rails?
					fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
		},
		sunlight_propagates = true,
		is_ground_content = true,
		groups = {crumbly=2},
		sounds = default.node_sound_dirt_defaults({
			footstep = {name="default_gravel_footstep", gain=0.5},
			dug = {name="default_gravel_footstep", gain=1.0},
		}),
	})
end

minetest.register_node("building_blocks:tarmac_spread", {
	drawtype = "raillike",
	description = S("Tarmac Spread"),
	tiles = {"building_blocks_tar.png"},
	use_texture_alpha = "clip",
	inventory_image = "building_blocks_tar_spread_inv.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=3},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("building_blocks:terrycloth_towel", {
	drawtype = "raillike",
	description = S("Terrycloth towel"),
	tiles = {"building_blocks_towel.png"},
	use_texture_alpha = "clip",
	inventory_image = "building_blocks_towel_inv.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
                -- but how to specify the dimensions for curved and sideways rails?
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
})

minetest.register_node("building_blocks:BWtile", {
	drawtype = "nodebox",
	description = S("Chess board tiling"),
	tiles = {
		"building_blocks_BWtile.png",
		"building_blocks_BWtile.png^[transformR90",
		"building_blocks_BWtile.png^[transformR90",
		"building_blocks_BWtile.png^[transformR90",
		"building_blocks_BWtile.png",
		"building_blocks_BWtile.png"
	},
	use_texture_alpha = "clip",
	inventory_image = "building_blocks_bwtile_inv.png",
	paramtype = "light",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {crumbly=3},
})

minetest.register_node("building_blocks:Fireplace", {
	description = S("Fireplace"),
	tiles = {
		"building_blocks_cast_iron.png",
		"building_blocks_cast_iron.png",
		"building_blocks_cast_iron.png",
		"building_blocks_cast_iron_fireplace.png"
	},
	use_texture_alpha = "clip",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = default.LIGHT_MAX,
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})
