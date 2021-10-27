if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
local S = minetest.get_translator("decor_office")

decor.register("filing_cabinet", {
	description = S("Filing cabinet"),
	mesh = "decor_filing_cabinet.obj",
	tiles = {
		decor.plain_wood,
		"decor_filing_cabinet_front.png",
		"decor_filing_cabinet_bottom.png"
	},
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	infotext=S("Filing cabinet"),
	inventory = {
		size=16,
		lockable=true,
	},
})

local desk_cbox = {
	type = "fixed",
	fixed = { -0.5, -0.5, -0.5, 1.5, 0.5, 0.5 }
}
decor.register("desk", {
	description = S("Desk"),
	mesh = "decor_desk.obj",
	tiles = {
		decor.plain_wood,
		"decor_desk_drawers.png",
		{ name = "decor_generic_metal.png", color = decor.color_black }
	},
	inventory_image = "decor_desk_inv.png",
	selection_box = desk_cbox,
	collision_box = desk_cbox,
	sounds = default.node_sound_wood_defaults(),
	groups = { snappy = 3 },
	expand = { right="placeholder" },
	inventory = {
		size=24,
		lockable=true,
	},
})
minetest.register_alias("decor:desk_r", "air")

local globe_cbox = {
	type = "fixed",
	fixed = { -0.4, -0.5, -0.3, 0.3, 0.3, 0.3 }
}

decor.register("desk_globe", {
	description = S("Desk globe"),
	mesh = "decor_desk_globe.obj",
	tiles = {
		"decor_generic_wood_red.png",
		{ name = "decor_generic_metal.png", color = decor.color_med_grey },
		"decor_earth.png"
	},
	inventory_image = "decor_desk_globe_inv.png",
	selection_box = globe_cbox,
	collision_box = globe_cbox,
	groups = {choppy=2, oddly_breakable_by_hand=2},
	walkable = false,
	sounds = default.node_sound_wood_defaults(),
})

decor.register("calendar", {
	description = S("Calendar"),
	mesh = "decor_calendar.obj",
	tiles = {"decor_calendar.png"},
	inventory_image = "decor_calendar_inv.png",
	wield_image = "decor_calendar_inv.png",
	paramtype2 = "wallmounted",
	walkable = false,
	selection_box = {
		type = "wallmounted",
		wall_side =   { -8/16, -8/16, -4/16, -5/16,  5/16, 4/16 },
		wall_bottom = { -4/16, -8/16, -8/16,  4/16, -5/16, 5/16 },
		wall_top =    { -4/16,  5/16, -8/16,  4/16,  8/16, 5/16 }
	},
	groups = {choppy=2,attached_node=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	infotext = S("Date (right-click to update):\n@1", os.date("%Y-%m-%d")), -- ISO 8601 format
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		local date = os.date("%Y-%m-%d")
		meta:set_string("infotext", S("Date (right-click to update):\n@1", date))
		return itemstack
	end
})

-- crafting


minetest.register_craft({
    output = "decor:desk",
    recipe = {
		{ "stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood" },
		{ "decor:drawer_small", "group:wood", "group:wood" },
		{ "decor:drawer_small", "", "group:wood" },
    },
})

minetest.register_craft({
    output = "decor:filing_cabinet",
    recipe = {
		{ "", "group:wood", "" },
		{ "group:wood", "decor:drawer_small", "group:wood" },
		{ "", "group:wood", "" },
    },
})

minetest.register_craft({
	output = "decor:calendar",
	recipe = {
		{ "","dye:red","" },
		{ "","dye:black","" },
		{ "","default:paper","" }
	},
})

minetest.register_craft({
	output = "decor:desk_globe",
	recipe = {
		{ "group:stick", "default:plastic_sheet", "dye:green" },
		{ "group:stick", "default:plastic_sheet", "default:plastic_sheet" },
		{ "group:stick", "stairs:slab_wood", "dye:blue" }
	},
})

