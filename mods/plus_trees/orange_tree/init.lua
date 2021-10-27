--orange_tree/init.lua
if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

S = function ( s ) return s end

orange_tree = {}

-- orange trunk
minetest.register_node("orange_tree:trunk", {
	description = "Orange Tree Trunk",
	tiles = {
		"orange_trunk_top.png",
		"orange_trunk_top.png",
		"orange_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- orange wood
minetest.register_node("orange_tree:wood", {
	description = "Orange Wood",
	tiles = {"orange_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "orange_tree:wood 4",
	recipe = {{"orange_tree:trunk"}}
})

-- Orange Tree leaves
local leafscale = 1
minetest.register_node("orange_tree:leaves", {
	description = "Orange Leaves",
	drawtype = "allfaces_optional",
	visual_scale = leafscale,
	tiles = {"orange_leaves.png"},
	use_texture_alpha = "clip",
	inventory_image = "orange_leaves.png",
	wield_image = "orange_leaves.png",
	paramtype = "light",
	walkable = orange_tree.leafwalk,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"orange_tree:sapling"}, rarity = 15},
			{items = {"orange_tree:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

local fruit_grow_time = 1200

-- Orange (Heals 2 hearts when eaten)

minetest.register_node("orange_tree:orange", {
	description = "Orange",
	drawtype = "plantlike",
	tiles = {"orange_tree_orange.png"},
	inventory_image = "orange_tree_orange.png",
	wield_image = "orange_tree_orange.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.27, -0.37, -0.27, 0.27, 0.44, 0.27}
	},
	groups = {
		food_orange = 1, fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 3, leafdecay_drop = 1
	},
	drop = "orange_tree:orange",
	on_use = minetest.item_eat(4),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "orange_tree:orange", param2 = 1})
		end
	end,
--[[ copied from cherrytree, doesn't seem to work here
	on_dig = function(pos, node, digger)
		if digger:is_player() then
			local inv = digger:get_inventory()
			if inv:room_for_item("main", "orange_tree:orange") then
				inv:add_item("main", "orange_tree:orange")
			end
		end
		minetest.remove_node(pos)
		pos.y = pos.y + 1
		local node_above = minetest.get_node_or_nil(pos)
		if node_above and node_above.name == "orange_tree:leaves" then
			--20% of variation on time
			local twenty_percent = fruit_grow_time * 0.2
			local grow_time = math.random(fruit_grow_time - twenty_percent, fruit_grow_time + twenty_percent)
			minetest.get_node_timer(pos):start(grow_time)
		end
	end,
--]]
})

default.register_leafdecay({
	trunks = {"orange_tree:trunk"},
	leaves = {"orange_tree:leaves", "orange_tree:orange"},
	radius = 3
})

-- Register Sapling

minetest.register_node("orange_tree:sapling", {
   description = "Orange Tree Sapling",
   drawtype = "plantlike",
   tiles = {"orange_tree_sapling.png"},
   inventory_image = "orange_tree_sapling.png",
   wield_image = "orange_tree_sapling.png",
   paramtype = "light",
   sunlight_propagates = true,
   is_ground_content = false,
   walkable = false,
   selection_box = {
      type = "fixed",
      fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 7 / 16, 4 / 16}
   },
   groups = {
      snappy = 2, dig_immediate = 3, flammable = 2,
      orange_tree_sapling = 1, attached_node = 1, sapling = 1
   },
   sounds = default.node_sound_leaves_defaults(),
   grown_height = 7,
})

function orange_tree.grow_orange_tree(pos)
	local path = minetest.get_modpath("orange_tree") ..
		"/schematics/orange_tree.mts"
    minetest.swap_node(pos, {name = "air"})
	minetest.place_schematic({x = pos.x - 3, y = pos.y, z = pos.z - 3},
		path, "0", nil, false)
end

local enough_height = function(pos, height)

   local nod = minetest.line_of_sight(
      {x = pos.x, y = pos.y + 1, z = pos.z},
      {x = pos.x, y = pos.y + height, z = pos.z})

   if not nod then
      return false -- obstructed
   else
      return true -- can grow
   end
end

local function contains(table, val)
   for i=1,#table do
      if table[i] == val then
         return true
      end
   end
   return false
 end

local dirts = {
   "default:dirt",
   "default:sand",
   "default:dirt_with_grass",
   "default:dirt_with_rainforest_litter",
}

local grow_sapling = function(pos, node)
   local under = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name

   if not minetest.registered_nodes[node.name] then
      return
   end

   local height = minetest.registered_nodes[node.name].grown_height

   -- do we have enough height to grow sapling into tree?
   if not height or not enough_height(pos, height) then
      return
   end

   -- Check if sapling is growing on correct substrate
   if node.name == "orange_tree:sapling" and contains(dirts, under) then
      orange_tree.grow_orange_tree(pos)
   end
end

minetest.register_abm({
   label = "Orange Tree grow sapling",
   nodenames = {"group:orange_tree_sapling"},
   interval = 10,
   chance = 50,
   catch_up = false,
   action = function(pos, node)

      local light_level = minetest.get_node_light(pos) or 0

      if light_level < 13 then
         return
      end

      grow_sapling(pos, node)
   end,
})

local add_schem = function(place_on, fill_ratio, biomes, y_min, y_max, schematic, flags, replacements, spawn_by, num_spawn_by, rotation)

	-- if not 1 then biome disabled, don't add
	if flags ~= 1 then return end

	minetest.register_decoration({
		deco_type = "schematic",
		place_on = place_on,
		sidelen = 80,
		fill_ratio = fill_ratio,
		biomes = biomes,
		y_min = y_min,
		y_max = y_max,
		schematic = schematic,
		flags = "place_center_x, place_center_z",
		replacements = replacements,
		spawn_by = spawn_by,
		num_spawn_by = num_spawn_by,
		rotation = rotation,
	})
end

add_schem({"default:sand", "default:dirt_with_grass"}, 0.003, {"grassland", "grassland_dunes"}, 1, 100,
	orange_tree.orangetree, 1)

--Support for bonemeal

if minetest.get_modpath("bonemeal") and minetest.global_exists("bonemeal") then
	bonemeal:add_sapling({
		{"orange_tree:sapling", orange_tree.grow_orange_tree, "soil"},
		{"orange_tree:sapling", orange_tree.grow_orange_tree, "sand"}
	})
end

-- Door and Gate

doors.register_fencegate(":doors:gate_orange_tree", {
	description = S("Orange Wood Fence Gate"),
	texture = "orange_wood.png",
	material = "orange_tree:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- Fence

default.register_fence("orange_tree:fence", {
    description = "Oange Wood Fence",
    texture = "orange_wood.png",
    inventory_image = "default_fence_overlay.png^orange_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^orange_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    material = "orange_tree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("orange_tree:fence_rail", {
    description = "Oange Wood Fence Rail",
    texture = "orange_wood.png",
    inventory_image = "default_fence_rail_overlay.png^orange_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^orange_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "orange_tree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

--Support for lumberjack

if minetest.get_modpath("lumberjack") and minetest.global_exists("lumberjack") then
	lumberjack.register_tree("orange_tree:trunk", "orange_tree:sapling", 1, 3)
end

-- Shelves

vessels.register_shelf("orange_tree:orange_shelf", {
	description = "OrangeWood Vessels Shelf",
	tiles = {"orange_wood.png^[transformR90", "orange_wood.png^[transformR90", "orange_wood.png",
		"orange_wood.png", "vessels_orange_shelf.png", "vessels_orange_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"orange_tree:wood", "orange_tree:wood", "orange_tree:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"orange_tree:wood", "orange_tree:wood", "orange_tree:wood"},
	},
})

default.register_bookshelf("orange_tree:orange", {
	description = "OrangeWood Bookshelf",
	tiles = {"orange_wood.png^[transformR90", "orange_wood.png^[transformR90", "orange_wood.png",
		"orange_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'orange_tree:orange_bookshelf',
	recipe = {
		{'orange_tree:wood', 'orange_tree:wood', 'orange_tree:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'orange_tree:wood', 'orange_tree:wood', 'orange_tree:wood'},
	}
})
-- Stairs

if minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab(
		"orange_tree_trunk",
		"orange_tree:trunk",
		{ snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
		{	"orange_trunk_top.png",
			"orange_trunk_top.png",
			"orange_trunk.png"
		},
		S("Orange Tree Trunk Stair"),
		S("Orange Tree Trunk Slab"),
		default.node_sound_wood_defaults()
	)

	stairs.register_stair_and_slab(
		"orange_tree",
		"orange_tree:wood",
		{ snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
		{ "orange_wood.png" },
		S("Orange Wood Stair"),
		S("Orange Wood Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"orange_tree",
		"trunk",
		"orange_tree:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"orange_trunk_top.png",
				"orange_trunk_top.png",
				"orange_trunk.png"
			},
			description = S("Orange Trunk"),
			drop = "trunk",
		}
	)

	stairsplus:register_all(
		"orange_tree",
		"wood",
		"orange_tree:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "orange_wood.png" },
			description = S("Orange wood"),
			drop = "wood",
		}
	)
end
