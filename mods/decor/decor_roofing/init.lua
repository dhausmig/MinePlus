if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local S = minetest.get_translator("decor_roofing")

decor_roofing = {}

minetest.register_node(":decor:skylight", {
	description = S("Glass Skylight"),
	drawtype = "raillike",
	tiles = { "default_glass.png" },
	use_texture_alpha = "clip",
	wield_image = "default_glass.png",
	inventory_image = "decor_skylight_inv.png",
	groups = { snappy = 3 },
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
	selection_box = decor.nodebox.slab_y(0.1),
})

minetest.register_node(":decor:skylight_frosted", {
	description = S("Glass Skylight Frosted"),
	drawtype = "raillike",
	tiles = { "decor_skylight_frosted.png" },
	use_texture_alpha = "clip",
	wield_image = "decor_skylight_frosted.png",
	inventory_image = "decor_skylight_frosted_inv.png",
	use_texture_alpha = "clip",
	groups = { snappy = 3 },
	paramtype = "light",
	sounds = default.node_sound_glass_defaults(),
	selection_box = decor.nodebox.slab_y(0.1),
})

for s, s_loc in pairs({ ["asphalt"] = S("asphalt"), ["terracotta"] = S("terracotta"), ["wood"] = S("wood") }) do
	minetest.register_node(":decor:shingles_"..s, {
		description = S("Shingles (@1)", s_loc),
		drawtype = "raillike",
		tiles = { "decor_shingles_"..s..".png" },
		use_texture_alpha = "clip",
		wield_image = "decor_shingles_"..s..".png",
		inventory_image = "decor_shingles_"..s.."_inv.png",
		paramtype = "light",
		walkable = false,
		groups = { snappy = 3 },
		sounds = default.node_sound_wood_defaults(),
		selection_box = decor.nodebox.slab_y(0.1),
	})
end

local slope_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5, 0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25, 0.5,     0, 0.5},
		{-0.5,     0,     0, 0.5,  0.25, 0.5},
		{-0.5,  0.25,  0.25, 0.5,   0.5, 0.5}
	}
}

local ocorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5,  -0.5,  -0.5,   0.5, -0.25, 0.5},
		{-0.5, -0.25, -0.25,  0.25,     0, 0.5},
		{-0.5,     0,     0,     0,  0.25, 0.5},
		{-0.5,  0.25,  0.25, -0.25,   0.5, 0.5}
	}
}

local icorner_cbox = {
	type = "fixed",
	fixed = {
		{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5}, -- NodeBox5
		{-0.5, -0.5, -0.25, 0.5, 0, 0.5}, -- NodeBox6
		{-0.5, -0.5, -0.5, 0.25, 0, 0.5}, -- NodeBox7
		{-0.5, 0, -0.5, 0, 0.25, 0.5}, -- NodeBox8
		{-0.5, 0, 0, 0.5, 0.25, 0.5}, -- NodeBox9
		{-0.5, 0.25, 0.25, 0.5, 0.5, 0.5}, -- NodeBox10
		{-0.5, 0.25, -0.5, -0.25, 0.5, 0.5}, -- NodeBox11
	}
}

decor_roofing.register_outer_corner = function(modname, subname, groups, slope_image, description)
	local tiles = slope_image

	if type(slope_image) ~= "table" then
		tiles = { "decor_slope_outer_corner_"..slope_image..".png" }
	end

	minetest.register_node(":"..modname..":shingle_outer_corner_" .. subname, {
		description = S("@1 (outer corner)", description),
		drawtype = "mesh",
		mesh = "decor_slope_outer_corner.obj",
		tiles = tiles,
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = ocorner_cbox,
		collision_box = ocorner_cbox,
		groups = groups,
		on_place = minetest.rotate_node,
		sounds = default.node_sound_wood_defaults()
	})
end

decor_roofing.register_inner_corner = function(modname, subname, groups, slope_image, description)
	local tiles = slope_image

	if type(slope_image) ~= "table" then
		tiles = { "decor_slope_outer_corner_"..slope_image..".png" }
	end

	minetest.register_node(":"..modname..":shingle_inner_corner_" .. subname, {
		description = S("@1 (inner corner)", description),
		drawtype = "mesh",
		mesh = "decor_slope_inner_corner.obj",
		tiles = tiles,
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		collision_box = icorner_cbox,
		groups = groups,
		on_place = minetest.rotate_node,
		sounds = default.node_sound_wood_defaults()
	})
end

decor_roofing.register_slope = function(modname, subname, recipeitem, groups, slope_image, description)
	local tiles = slope_image

	if type(slope_image) ~= "table" then
		tiles = { "decor_slope_outer_corner_"..slope_image..".png" }
	end

	minetest.register_node(":"..modname..":shingle_side_" .. subname, {
		description = description,
		drawtype = "mesh",
		mesh = "decor_slope.obj",
		tiles = tiles,
		use_texture_alpha = "clip",
		paramtype = "light",
		paramtype2 = "facedir",
		selection_box = slope_cbox,
		collision_box = slope_cbox,
		groups = groups,
		on_place = minetest.rotate_node,
		sounds = default.node_sound_wood_defaults()
	})

	-- convert between flat shingles and slopes

	minetest.register_craft({
		output = modname..":shingle_side_"..subname.." 3",
		recipe = {
			{recipeitem, recipeitem, recipeitem}
		}
	})

	minetest.register_craft({
		output = recipeitem.." 3",
		recipe = {
			{modname..":shingle_side_"..subname, modname..":shingle_side_"..subname, modname..":shingle_side_"..subname},
		}
	})

	-- craft outer corners

	minetest.register_craft({
		output = modname..":shingle_outer_corner_"..subname.." 3",
		recipe = {
			{ "", recipeitem, "" },
			{ recipeitem, "", recipeitem }
		}
	})

	minetest.register_craft({
		output = modname..":shingle_outer_corner_"..subname.." 3",
		recipe = {
			{ "", modname..":shingle_side_"..subname, "" },
			{ modname..":shingle_side_"..subname, "", modname..":shingle_side_"..subname },
		}
	})

	-- craft inner corners

	minetest.register_craft({
		output = modname..":shingle_inner_corner_"..subname.." 3",
		recipe = {
			{recipeitem, recipeitem},
			{"", recipeitem}
		}
	})

	minetest.register_craft({
		output = modname..":shingle_inner_corner_"..subname.." 3",
		recipe = {
			{modname..":shingle_side_"..subname, modname..":shingle_side_"..subname},
			{"", modname..":shingle_side_"..subname}
		}
	})
	-- convert between flat shingles and inner/outer corners

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem.." 1",
		recipe = { modname..":shingle_outer_corner_"..subname }
	})

	minetest.register_craft({
		type = "shapeless",
		output = recipeitem.." 1",
		recipe = { modname..":shingle_inner_corner_"..subname }
	})
end

minetest.register_craft( {
	output = "decor:shingle_side_glass",
	recipe = {
		{ "decor:skylight", "decor:skylight", "decor:skylight" }
	}
})

minetest.register_craft( {
	output = "decor:roof_tile_terracotta 8",
	recipe = {
		{ "decor:shingle_outer_corner_terracotta", "decor:shingle_outer_corner_terracotta" }
	}
})

minetest.register_craft( {
	output = "decor:roof_tile_terracotta 8",
	recipe = {
		{ "decor:shingle_inner_corner_terracotta", "decor:shingle_inner_corner_terracotta" }
	}
})

minetest.register_craft( {
	output = "decor:roof_tile_terracotta 8",
	recipe = {
		{ "decor:shingle_side_terracotta", "decor:shingle_side_terracotta" }
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:shingle_inner_corner_wood",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:shingle_outer_corner_wood",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:shingle_side_wood",
	burntime = 30,
})

decor_roofing.register_roof = function(modname, subname, groups, slope_image , description)
	decor_roofing.register_outer_corner(modname, subname, groups, slope_image, description)
	decor_roofing.register_inner_corner(modname, subname, groups, slope_image, description)
end

-- corners

decor_roofing.register_roof("decor", "wood",
	{ snappy = 3 },
	{ "decor_shingles_wood.png" },
	S("Wood Shingles")
)

decor_roofing.register_roof("decor", "asphalt",
	{ snappy = 3 },
	{ "decor_shingles_asphalt.png" },
	S("Asphalt Shingles")
)

decor_roofing.register_roof("decor", "terracotta",
	{ snappy = 3 },
	{ "decor_shingles_terracotta.png" },
	S("Terracotta Shingles")
)

-- register just the slopes

decor_roofing.register_slope("decor", "wood",
	"decor:shingles_wood",
	{ snappy = 3 },
	{ "decor_shingles_wood.png" },
	S("Wood Shingles")
)

decor_roofing.register_slope("decor", "asphalt",
	"decor:shingles_asphalt",
	{ snappy = 3 },
	{ "decor_shingles_asphalt.png" },
	S("Asphalt Shingles")
)

decor_roofing.register_slope("decor", "terracotta",
	"decor:shingles_terracotta",
	{ snappy = 3 },
	{ "decor_shingles_terracotta.png" },
	S("Terracotta Shingles")
)

decor_roofing.register_slope("decor", "glass",
	"decor:shingles_glass",
	{ snappy = 3 },
	{ "decor_shingles_glass.png", "decor_shingles_wood.png" },
	S("Glass Shingles")
)


decor.register("chimney", {
	description = S("Chimney"),
	mesh = "decor_chimney.obj",
	tiles = {
		"decor_chimney_tb.png",
		"default_brick.png"
	},
	use_texture_alpha = "clip",
	selection_box = decor.nodebox.bar_y(0.25),
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults()
})

-- crafting

minetest.register_craft( {
        output = "decor:skylight 4",
        recipe = {
		{ "decor:glass_table_large", "decor:glass_table_large" },
		{ "decor:glass_table_large", "decor:glass_table_large" },
        },
})

minetest.register_craft( {
	type = "shapeless",
        output = "decor:skylight_frosted",
        recipe = {
			"dye:white",
			"decor:skylight"
		},
})

minetest.register_craft({
        type = "cooking",
        output = "decor:skylight",
        recipe = "decor:skylight_frosted",
})

-- recycling

minetest.register_craft({
        type = "shapeless",
        output = "vessels:glass_fragments 2",
        recipe = {
		"decor:skylight",
		"decor:skylight",
		"decor:skylight",
		"decor:skylight",
		"decor:skylight",
		"decor:skylight"
	}
})
