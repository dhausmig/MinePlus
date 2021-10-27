-- formerly decor's misc tables component

local S = minetest.get_translator("decor_tables")

-- Various kinds of table legs

local table_shapes = {"large_square", "small_square", "small_round"}

local tabletop_materials = {
	{ "glass",
		S("Small square glass tabletop"),
		S("Small round glass tabletop"),
		S("Large glass tabletop piece"),
	},
	{ "wood",
		S("Small square wooden tabletop"),
		S("Small round wooden tabletop"),
		S("Large wooden tabletop piece"),
	}
}

leg_materials = {
	{ "brass",          S("brass") },
	{ "wrought_iron",   S("wrought iron") },
	{ "wood",           S("wood") }
}

for _, t in ipairs(leg_materials) do
	local name, desc = unpack(t)
	decor.register("table_legs_"..name, {
		description = S("Table Legs (@1)", desc),
		drawtype = "plantlike",
		tiles = {"decor_table_legs_"..name..".png"},
		use_texture_alpha = "clip",
		inventory_image = "decor_table_legs_"..name..".png",
		wield_image = "decor_table_legs_"..name..".png",
		walkable = false,
		groups = {snappy=3},
		sounds = default.node_sound_wood_defaults(),
		selection_box = {
			type = "fixed",
			fixed = { -0.37, -0.5, -0.37, 0.37, 0.5, 0.37 }
		},
	})
end

minetest.register_alias("decor:utility_table_legs", "decor:table_legs_wood")
minetest.register_alias("decor:utility_table_top",  "decor:wood_table_small_square")

-- table tops and combined tables

local tables_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5,    -0.5,  0.5,    -0.4375, 0.5 },
}

for i, mat in ipairs(tabletop_materials) do
	local m, small_s, small_r, large = unpack(mat)
	local s

	if m == "glass" then
		s = default.node_sound_glass_defaults()
	else
		s = default.node_sound_wood_defaults()
	end

	for _, shape in ipairs(table_shapes) do

		decor.register(m.."_table_"..shape, {
			description = shape.." "..m.." tabletop",
			mesh = "decor_table_"..shape..".obj",
			tiles = {
				'decor_'..m..'_table_'..shape..'.png',
				'decor_'..m..'_table_edges.png',
				'decor_blanktile.png',
				'decor_blanktile.png',
				'decor_blanktile.png',
			},
			use_texture_alpha = "clip",
			wield_image = 'decor_'..m..'_table_'..shape..'_inv.png',
			groups = { snappy = 3 },
			sounds = s,
			selection_box = tables_cbox,
			collision_box = tables_cbox,
			on_place = function(itemstack, placer, pointed_thing)
				local player_name = placer:get_player_name()
				if minetest.is_protected(pointed_thing.under, player_name) then return end
				local node = minetest.get_node(pointed_thing.under)
				if string.find(node.name, "decor:table_legs") then
					local newname = string.format("decor:%s_table_%s_with_%s_legs",
						m, shape, string.sub(node.name, 22))
					minetest.set_node(pointed_thing.under, {name = newname})
					if not creative.is_enabled_for(player_name) then
						itemstack:take_item()
						return itemstack
					end
				else
					return minetest.rotate_node(itemstack, placer, pointed_thing)
				end
			end
		})

		for _, l in ipairs(leg_materials) do
			local leg_mat, desc = unpack(l)

			decor.register(string.format("%s_table_%s_with_%s_legs", m, shape, leg_mat), {
				description = string.format("%s %s table with %s legs", shape, m, leg_mat),
				mesh = "decor_table_"..shape..".obj",
				tiles = {
					'decor_blanktile.png',
					'decor_blanktile.png',
					'decor_'..m..'_table_'..shape..'.png',
					'decor_'..m..'_table_edges.png',
					"decor_table_legs_"..leg_mat..".png",
				},
				use_texture_alpha = "clip",
				groups = { snappy = 3 },
				sounds = s,
			})
		end
	end

--	minetest.register_alias('decor:'..m..'_table_large_b', 'decor:'..m..'_table_large')
--	minetest.register_alias('decor:'..m..'_table_small_square_b', 'decor:'..m..'_table_small_square')
--	minetest.register_alias('decor:'..m..'_table_small_round_b', 'decor:'..m..'_table_small_round')
	minetest.register_alias('decor:'..m..'_table_large', 'decor:'..m..'_table_large_square')

end

-- old-style tables that used to be from 3dforniture.

local table_colors = {
	{ "",           S("Table"),           decor.plain_wood },
	{ "_mahogany",  S("Mahogany Table"),  decor.mahogany_wood },
	{ "_white",     S("White Table"),     decor.white_wood }
}

for _, t in ipairs(table_colors) do
	local suffix, desc, texture = unpack(t)

	decor.register("table"..suffix, {
		description = desc,
		tiles = { texture },
		use_texture_alpha = "clip",
		node_box = {
			type = "fixed",
			fixed = {
				{ -0.4, -0.5, -0.4, -0.3,  0.4, -0.3 },
				{  0.3, -0.5, -0.4,  0.4,  0.4, -0.3 },
				{ -0.4, -0.5,  0.3, -0.3,  0.4,  0.4 },
				{  0.3, -0.5,  0.3,  0.4,  0.4,  0.4 },
				{ -0.5,  0.4, -0.5,  0.5,  0.5,  0.5 },
				{ -0.4, -0.2, -0.3, -0.3, -0.1,  0.3 },
				{  0.3, -0.2, -0.4,  0.4, -0.1,  0.3 },
				{ -0.3, -0.2, -0.4,  0.4, -0.1, -0.3 },
				{ -0.3, -0.2,  0.3,  0.3, -0.1,  0.4 },
			},
		},
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2},
		sounds = default.node_sound_wood_defaults(),
	})
end

-- crafting

minetest.register_craft( {
        output = "decor:glass_table_small_round 15",
        recipe = {
                { "", "default:glass", "" },
                { "default:glass", "default:glass", "default:glass" },
                { "", "default:glass", "" },
        },
})

minetest.register_craft( {
        output = "decor:glass_table_small_square 2",
        recipe = {
		{"decor:glass_table_small_round", "decor:glass_table_small_round" },
	}
})

minetest.register_craft( {
        output = "decor:glass_table_large 2",
        recipe = {
		{ "decor:glass_table_small_square", "decor:glass_table_small_square" },
	}
})

minetest.register_craft( {
        output = "decor:wood_table_small_round 15",
        recipe = {
                { "", "group:wood", "" },
                { "group:wood", "group:wood", "group:wood" },
                { "", "group:wood", "" },
        },
})

minetest.register_craft( {
        output = "decor:wood_table_small_square 2",
        recipe = {
		{ "decor:wood_table_small_round","decor:wood_table_small_round" },
	}
})

minetest.register_craft( {
        output = "decor:wood_table_large 2",
        recipe = {
		{ "decor:wood_table_small_square", "decor:wood_table_small_square" },
	}
})

--

minetest.register_craft({
        type = "fuel",
        recipe = "decor:wood_table_small_round",
        burntime = 30,
})

minetest.register_craft({
        type = "fuel",
        recipe = "decor:wood_table_small_square",
        burntime = 30,
})

minetest.register_craft({
        type = "fuel",
        recipe = "decor:wood_table_large",
        burntime = 30,
})


minetest.register_craft( {
        output = "decor:table_legs_wrought_iron 3",
        recipe = {
                { "", "default:iron_lump", "" },
                { "", "default:iron_lump", "" },
                { "default:iron_lump", "default:iron_lump", "default:iron_lump" },
        },
})

minetest.register_craft( {
        output = "decor:table_legs_brass 3",
	recipe = {
		{ "", "technic:brass_ingot", "" },
		{ "", "technic:brass_ingot", "" },
		{ "technic:brass_ingot", "technic:brass_ingot", "technic:brass_ingot" }
	},
})

minetest.register_craft( {
        output = "decor:utility_table_legs",
        recipe = {
                { "group:stick", "group:stick", "group:stick" },
                { "group:stick", "", "group:stick" },
                { "group:stick", "", "group:stick" },
        },
})

minetest.register_craft({
        type = "fuel",
        recipe = "decor:utility_table_legs",
        burntime = 30,
})

for _, shape in ipairs (table_shapes) do
	for _, leg in ipairs(leg_materials) do
		for _, mat in ipairs(tabletop_materials) do
			minetest.register_craft({
				output = "decor:"..mat[1].."_table_"..shape.."_with_"..leg[1].."_legs",
				type = "shapeless",
				recipe = {
					"decor:"..mat[1].."_table_"..shape,
					"decor:table_legs_"..leg[1]
				},
			})
		end
	end
end

minetest.register_craft({
	output = "decor:table",
	recipe = {
		{ "group:wood","group:wood", "group:wood" },
		{ "group:stick", "", "group:stick" },
	},
})

minetest.register_craft({
	output = "decor:table_mahogany",
	recipe = {
		{ "mahogany:wood","mahogany:wood", "mahogany:wood" },
		{ "group:stick", "", "group:stick" },
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "decor:table_white",
	recipe = {
		"decor:table",
		"dye:white",
	},
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:table",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:table_mahogany",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "decor:table_white",
	burntime = 30,
})

-- recycling

minetest.register_craft({
        type = "shapeless",
        output = "vessels:glass_fragments",
        recipe = {
		"decor:glass_table_small_round",
		"decor:glass_table_small_round",
		"decor:glass_table_small_round"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "vessels:glass_fragments",
        recipe = {
		"decor:glass_table_small_square",
		"decor:glass_table_small_square",
		"decor:glass_table_small_square"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "vessels:glass_fragments",
        recipe = {
		"decor:glass_table_large",
		"decor:glass_table_large",
		"decor:glass_table_large"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "default:stick 4",
        recipe = {
		"decor:wood_table_small_round",
		"decor:wood_table_small_round",
		"decor:wood_table_small_round"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "default:stick 4",
        recipe = {
		"decor:wood_table_small_square",
		"decor:wood_table_small_square",
		"decor:wood_table_small_square"
	}
})

minetest.register_craft({
        type = "shapeless",
        output = "default:stick 4",
        recipe = {
		"decor:wood_table_large",
		"decor:wood_table_large",
		"decor:wood_table_large"
	}
})

-- Aliases for the above 3dforniture-like tables

minetest.register_alias("3dforniture:table", "decor:table")
minetest.register_alias('table', 'decor:table')
