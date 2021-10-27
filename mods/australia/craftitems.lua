-- mods/australia/craftitems.lua
if minetest.settings:get_bool("log_files") then minetest.log("australia/craftitems" ) end

	-- Fiddlehead
minetest.register_craftitem("australia:fiddlehead", {
	description = "Fiddlehead",
	inventory_image = "aus_fiddlehead.png",
	on_use = minetest.item_eat(-1), -- slightly poisonous when raw
})

minetest.register_craftitem("australia:fiddlehead_roasted", {
	description = "Roasted Fiddlehead",
	inventory_image = "aus_fiddlehead_roasted.png",
	on_use = minetest.item_eat(1), -- edible when cooked
})

	-- Fern tuber
minetest.register_craftitem("australia:ferntuber", {
	description = "Fern Tuber",
	inventory_image = "aus_ferntuber.png",
})

minetest.register_craftitem("australia:ferntuber_roasted", {
	description = "Roasted Fern Tuber",
	inventory_image = "aus_ferntuber_roasted.png",
	on_use = minetest.item_eat(3),
})

	-- Bucket muddy_water
bucket.register_liquid(
	"australia:muddy_river_water_source",
	"australia:muddy_river_water_flowing",
	"australia:bucket_muddy_river_water",
	"aus_bucket_muddy_water.png",
	"Muddy Water Bucket",
	{water_bucket = 1}
)

	-- Registrations
for i in ipairs(aus.treelist) do
	local treename			= aus.treelist[i][1]
	local treedesc			= aus.treelist[i][2]
	local texname		= "aus_"..treename.."_wood.png"
	local matname		= "australia:"..treename.."_wood"

--Support for Bonemeal lacks tree generate functions
--[[
	if minetest.get_modpath("bonemeal") ~= nil then
		bonemeal:add_sapling({
			{"australia:"..treename.."_sapling", grow_new_..treename.._tree, "soil"},
		})
	end
--]]
-- Door and Gate

	doors.register_fencegate(":doors:gate_"..treename, {
		description = ""..treedesc.." Wood Fence Gate",
		texture = texname,
		material = matname,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
	})

-- Fence

	default.register_fence("australia:"..treename.."_fence", {
		description = ""..treedesc.." Wood Fence",
		texture = texname,
		inventory_image = "default_fence_overlay.png^"..texname.."^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
		wield_image = "default_fence_overlay.png^"..texname.."^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
		material = matname,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults()
	})

	default.register_fence_rail("australia:"..treename.."_fence_rail", {
		description = ""..treedesc.." Wood Fence Rail",
		texture = texname,
		inventory_image = "default_fence_rail_overlay.png^"..texname.."^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
		wield_image = "default_fence_rail_overlay.png^"..texname.."^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
		material = matname,
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
		sounds = default.node_sound_wood_defaults()
	})

-- Shelves

	vessels.register_shelf("australia:"..treename.."_shelf", {
		description = ""..treedesc.." Vessels Shelf",
		tiles = {""..texname.."^[transformR90", ""..texname.."^[transformR90", texname,
			texname, "vessels_shelf.png", "vessels_shelf.png"},
		groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		sounds = default.node_sound_wood_defaults(),
		recipe = {
			{matname, matname, matname},
			{"group:vessel", "group:vessel", "group:vessel"},
			{matname, matname, matname},
		},
	})

	default.register_bookshelf("australia:"..treename, {
		description = ""..treedesc.." Bookshelf",
		tiles = {""..texname.."^[transformR90", ""..texname.."^[transformR90", texname,
			texname, "default_bookshelf.png", "default_bookshelf.png"},
		groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
		sounds = default.node_sound_wood_defaults(),
	})

	minetest.register_craft({
		output = "australia:"..treename.."_bookshelf",
		recipe = {
			{matname, matname, matname},
			{'default:book', 'default:book', 'default:book'},
			{matname, matname, matname},
		}
	})

-- Stairs

	if minetest.get_modpath("stairs") ~= nil then
		stairs.register_stair_and_slab(
			treename.."_wood",
			"australia:"..treename.."_wood",
			{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
			{"aus_"..treename.."_wood.png" },
			treedesc.." Wood Stair",
			treedesc.." Wood Slab",
			default.node_sound_wood_defaults()
		)
		stairs.register_stair_and_slab(
			treename.."_trunk",
			"australia:"..treename.."_trunk",
			{snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3},
			{"aus_"..treename.."_trunk_top.png",
			 "aus_"..treename.."_trunk_top.png",
			 "aus_"..treename.."_trunk.png" },
			treedesc.." Trunk Stair",
			treedesc.." Trunk Slab",
			default.node_sound_wood_defaults()
		)
	end
	if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"australia",
		treename,
		"australia:"..treename.."_trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"aus_"..treename.."_trunk_top.png",
				"aus_"..treename.."_trunk_top.png",
				"aus_"..treename.."_trunk.png",
			},
			description = treedesc,
			drop = treename.."_trunk",
		}
	)

		stairsplus:register_all(
			"australia",
			""..treename.."_wood",
			matname,
			{
				groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
				tiles = { texname },
				description = treedesc,
			drop = treename.."_wood",
			}
		)
	end
end
