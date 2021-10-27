-- 22.01.13 Changed texture to that of the wood from the minimal development game

local S = cottages.S

minetest.register_node("cottages:fence_small", {
		description = S("Small fence"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
				{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
				{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},

				{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
				{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
				{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
				{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},

				{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
				{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},
			},
		},
		is_ground_content = false,
})


minetest.register_node("cottages:fence_corner", {
		description = S("Small fence (corner)"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
				{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
				{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},

				{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
				{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},

				{  0.46, -0.35, -0.45,  0.50, -0.20,  0.45},
				{  0.46,  0.00, -0.45,  0.50,  0.15,  0.45},
				{  0.46,  0.35, -0.45,  0.50,  0.50,  0.45},

				{  0.46, -0.50, -0.50,  0.50,  0.50, -0.45},
				{  0.46, -0.50,  0.45,  0.50,  0.50,  0.50},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
				{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
				{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},

				{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
				{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},

				{  0.46, -0.35, -0.45,  0.50, -0.20,  0.45},
				{  0.46,  0.00, -0.45,  0.50,  0.15,  0.45},
				{  0.46,  0.35, -0.45,  0.50,  0.50,  0.45},

				{  0.46, -0.50, -0.50,  0.50,  0.50, -0.45},
				{  0.46, -0.50,  0.45,  0.50,  0.50,  0.50},
			},
		},
		is_ground_content = false,
})


minetest.register_node("cottages:fence_end", {
		description = S("Small fence (end)"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
				{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
				{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},

				{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
				{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},

				{  0.46, -0.35, -0.45,  0.50, -0.20,  0.45},
				{  0.46,  0.00, -0.45,  0.50,  0.15,  0.45},
				{  0.46,  0.35, -0.45,  0.50,  0.50,  0.45},

				{  0.46, -0.50, -0.50,  0.50,  0.50, -0.45},
				{  0.46, -0.50,  0.45,  0.50,  0.50,  0.50},

				{ -0.50, -0.35, -0.45, -0.46, -0.20,  0.45},
				{ -0.50,  0.00, -0.45, -0.46,  0.15,  0.45},
				{ -0.50,  0.35, -0.45, -0.46,  0.50,  0.45},

				{ -0.50, -0.50, -0.50, -0.46,  0.50, -0.45},
				{ -0.50, -0.50,  0.45, -0.46,  0.50,  0.50},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
				{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
				{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},

				{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
				{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},

				{  0.46, -0.35, -0.45,  0.50, -0.20,  0.45},
				{  0.46,  0.00, -0.45,  0.50,  0.15,  0.45},
				{  0.46,  0.35, -0.45,  0.50,  0.50,  0.45},

				{  0.46, -0.50, -0.50,  0.50,  0.50, -0.45},
				{  0.46, -0.50,  0.45,  0.50,  0.50,  0.50},

				{ -0.50, -0.35, -0.45, -0.46, -0.20,  0.45},
				{ -0.50,  0.00, -0.45, -0.46,  0.15,  0.45},
				{ -0.50,  0.35, -0.45, -0.46,  0.50,  0.45},

				{ -0.50, -0.50, -0.50, -0.46,  0.50, -0.45},
				{ -0.50, -0.50,  0.45, -0.46,  0.50,  0.50},
			},
		},
		is_ground_content = false,
})

minetest.register_node("cottages:fence_double", {
		description = S("Small fence (double)"),
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		tiles = {"cottages_minimal_wood.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		node_box = {
			type = "fixed",
			fixed = {
-- 				{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
-- 				{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
-- 				{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},
-- 
-- 				{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
-- 				{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},

				{  0.46, -0.35, -0.45,  0.50, -0.20,  0.45},
				{  0.46,  0.00, -0.45,  0.50,  0.15,  0.45},
				{  0.46,  0.35, -0.45,  0.50,  0.50,  0.45},

				{  0.46, -0.50, -0.50,  0.50,  0.50, -0.45},
				{  0.46, -0.50,  0.45,  0.50,  0.50,  0.50},

				{ -0.50, -0.35, -0.45, -0.46, -0.20,  0.45},
				{ -0.50,  0.00, -0.45, -0.46,  0.15,  0.45},
				{ -0.50,  0.35, -0.45, -0.46,  0.50,  0.45},

				{ -0.50, -0.50, -0.50, -0.46,  0.50, -0.45},
				{ -0.50, -0.50,  0.45, -0.46,  0.50,  0.50},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
-- 				{ -0.45, -0.35,  0.46,  0.45, -0.20,  0.50},
-- 				{ -0.45,  0.00,  0.46,  0.45,  0.15,  0.50},
-- 				{ -0.45,  0.35,  0.46,  0.45,  0.50,  0.50},
-- 
-- 				{ -0.50, -0.50,  0.46, -0.45,  0.50,  0.50},
-- 				{  0.45, -0.50,  0.46,  0.50,  0.50,  0.50},

				{  0.46, -0.35, -0.45,  0.50, -0.20,  0.45},
				{  0.46,  0.00, -0.45,  0.50,  0.15,  0.45},
				{  0.46,  0.35, -0.45,  0.50,  0.50,  0.45},

				{  0.46, -0.50, -0.50,  0.50,  0.50, -0.45},
				{  0.46, -0.50,  0.45,  0.50,  0.50,  0.50},

				{ -0.50, -0.35, -0.45, -0.46, -0.20,  0.45},
				{ -0.50,  0.00, -0.45, -0.46,  0.15,  0.45},
				{ -0.50,  0.35, -0.45, -0.46,  0.50,  0.45},

				{ -0.50, -0.50, -0.50, -0.46,  0.50, -0.45},
				{ -0.50, -0.50,  0.45, -0.46,  0.50,  0.50},
			},
		},
		is_ground_content = false,
})

minetest.register_craft({
	output = "cottages:fence_small 4",
	recipe = {
		{"default:fence_wood", "default:fence_wood"},
	}
})

minetest.register_craft({
	output = "cottages:fence_corner",
	recipe = {
		{"cottages:fence_small", "cottages:fence_small"},
	}
})

minetest.register_craft({
	output = "cottages:fence_small 2",
	recipe = {
		{"cottages:fence_corner"},
	}
})

minetest.register_craft({
	output = "cottages:fence_end",
	recipe = {
		{"cottages:fence_small", "cottages:fence_small", "cottages:fence_small"}
	}
})

minetest.register_craft({
	output = "cottages:fence_small 3",
	recipe = {
		{"cottages:fence_end"},
	}
})

minetest.register_craft({
	output = "cottages:fence_double",
	recipe = {
		{"cottages:fence_small", "", "cottages:fence_small" },
	}
})

minetest.register_craft({
	output = "cottages:fence_small 2",
	recipe = {
		{"cottages:fence_double"},
	}
})



