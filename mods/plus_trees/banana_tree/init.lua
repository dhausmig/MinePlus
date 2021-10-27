-- banana_tree/init.lua

banana_tree = {}

S = function ( s ) return s end

local path = minetest.get_modpath("banana_tree")


-- banana trunk
minetest.register_node("banana_tree:trunk", {
	description = "Banana Trunk",
	tiles = {
		"banana_trunk_top.png",
		"banana_trunk_top.png",
		"banana_trunk.png"
	},
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	paramtype2 = "facedir",
	on_place = minetest.rotate_node,
})

-- banana wood
minetest.register_node("banana_tree:wood", {
	description = "Banana Wood",
	tiles = {"banana_wood.png"},
	is_ground_content = false,
	groups = {wood = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "banana_tree:wood 4",
	recipe = {{"banana_tree:trunk"}}
})

local add_tree = function (pos, ofx, ofy, ofz, schem, replace)
   -- check for schematic
   if not schem then
      print ("Schematic not found")
      return
   end
   -- remove sapling and place schematic
   minetest.swap_node(pos, {name = "air"})
   minetest.place_schematic(
      {x = pos.x - ofx, y = pos.y - ofy, z = pos.z - ofz},
      schem, 0, replace, false)
end

-- Register Sapling

minetest.register_node("banana_tree:sapling", {
	description = "Banana Tree Sapling",
	drawtype = "plantlike",
	tiles = {"banana_tree_sapling.png"},
	inventory_image = "banana_tree_sapling.png",
	wield_image = "banana_tree_sapling.png",
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
		banana_sapling = 1, attached_node = 1, sapling = 1
	},
	sounds = default.node_sound_leaves_defaults(),
	grown_height = 8,
})

function banana_tree.grow_banana_tree(pos)
   add_tree(pos, 3, 0, 3, banana_tree.bananatree)
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
   local nodeu = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
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
   if node.name == "banana_tree:sapling" and contains(dirts, under) then
      banana_tree.grow_banana_tree(pos)
   end
end

minetest.register_abm({
   label = "banana grow sapling",
   nodenames = {"group:banana_sapling"},
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


local path = minetest.get_modpath("banana_tree") .. "/schematics/"
local dpath = minetest.get_modpath("default") .. "/schematics/"


dofile(path .. "banana_tree.lua")

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
	banana_tree.bananatree, 1)

-- Banana (Heals one heart when eaten)
minetest.register_node("banana_tree:banana", {
	description = "Banana",
	drawtype = "torchlike",
	tiles = {"banana_single.png"},
	inventory_image = "banana_single.png",
	wield_image = "banana_single.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.31, -0.5, -0.31, 0.31, 0.5, 0.31}
	},
	groups = {
		food_banana = 1, fleshy = 3, dig_immediate = 3, flammable = 2,
		leafdecay = 1, leafdecay_drop = 1
	},
	drop = "banana_tree:banana",
	on_use = minetest.item_eat(2),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer)
		if placer:is_player() then
			minetest.set_node(pos, {name = "banana_tree:banana", param2 = 1})
		end
	end,
})

local leaftype = "plantlike"
local leafscale = 1.4


-- banana tree leaves
minetest.register_node("banana_tree:leaves", {
	description = "Banana Leaves",
	drawtype = leaftype,
	visual_scale = leafscale,
	tiles = {"banana_leaf.png"},
	use_texture_alpha = "clip",
	inventory_image = "banana_leaf.png",
	wield_image = "banana_leaf.png",
	paramtype = "light",
	walkable = false,
	waving = 1,
	groups = {snappy = 3, leafdecay = 3, leaves = 1, flammable = 2},
	drop = {
		max_items = 1,
		items = {
			{items = {"banana_tree:sapling"}, rarity = 10},
			{items = {"banana_tree:leaves"}}
		}
	},
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = default.after_place_leaves,
})

default.register_leafdecay({
	trunks = {"banana_tree:trunk"},
	leaves = {"banana_tree:leaves", "banana_tree:banana"},
	radius = 3
})

-- Registrations

--Support for Bonemeal

if minetest.get_modpath("bonemeal") and minetest.global_exists("bonemeal") then
	bonemeal:add_sapling({
		{"banana_tree:sapling", banana_tree.grow_banana_tree, "soil"},
		{"banana_tree:sapling", banana_tree.grow_banana_tree, "sand"},
	})
end

-- Door and Gate

doors.register_fencegate(":doors:gate_banana_tree", {
	description = S("Banana Wood Fence Gate"),
	texture = "banana_wood.png",
	material = "banana_tree:wood",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2}
})

-- Fence

default.register_fence("banana_tree:fence", {
    description = "Banana Wood Fence",
    texture = "banana_wood.png",
    inventory_image = "default_fence_overlay.png^banana_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_overlay.png^banana_wood.png^" ..
        "default_fence_overlay.png^[makealpha:255,126,126",
    material = "banana_tree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

default.register_fence_rail("banana_tree:fence_rail", {
    description = "Banana Wood Fence Rail",
    texture = "banana_wood.png",
    inventory_image = "default_fence_rail_overlay.png^banana_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    wield_image = "default_fence_rail_overlay.png^banana_wood.png^" ..
        "default_fence_rail_overlay.png^[makealpha:255,126,126",
    material = "banana_tree:wood",
    groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
    sounds = default.node_sound_wood_defaults()
})

--Support for Lumberjack

if minetest.get_modpath("lumberjack") and minetest.global_exists("lumberjack") then
	lumberjack.register_tree("banana_tree:trunk", "banana_tree:sapling", 1, 3)
end

-- Shelves

vessels.register_shelf("banana_tree:banana_shelf", {
	description = "BananaWood Vessels Shelf",
	tiles = {"banana_wood.png^[transformR90", "banana_wood.png^[transformR90", "banana_wood.png",
		"banana_wood.png", "vessels_shelf.png", "vessels_shelf.png"},
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	recipe = {
		{"banana_tree:wood", "banana_tree:wood", "banana_tree:wood"},
		{"group:vessel", "group:vessel", "group:vessel"},
		{"banana_tree:wood", "banana_tree:wood", "banana_tree:wood"},
	},
})

default.register_bookshelf("banana_tree:banana", {
	description = "Banana Bookshelf",
	tiles = {"banana_wood.png^[transformR90", "banana_wood.png^[transformR90", "banana_wood.png",
		"banana_wood.png", "default_bookshelf.png", "default_bookshelf.png"},
	groups = {bookshelf = 1, choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = 'banana_tree:banana_bookshelf',
	recipe = {
		{'banana_tree:wood', 'banana_tree:wood', 'banana_tree:wood'},
		{'default:book', 'default:book', 'default:book'},
		{'banana_tree:wood', 'banana_tree:wood', 'banana_tree:wood'},
	}
})

-- Stairs
if minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab(
		"banana_tree_trunk",
		"banana_tree:trunk",
		{ snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
		{	"banana_trunk_top.png",
			"banana_trunk_top.png",
			"banana_trunk.png"
		},
		S("Banana Trunk Stair"),
		S("Banana Trunk Slab"),
		default.node_sound_wood_defaults()
	)

	stairs.register_stair_and_slab(
		"banana_tree",
		"banana_tree:wood",
		{ snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
		{ "banana_wood.png" },
		S("Banana Wood Stair"),
		S("Banana Wood Slab"),
		default.node_sound_wood_defaults()
	)
end

if minetest.get_modpath("moreblocks") then

	--			stairsplus:register_all(modname, subname, recipeitem, {fields})

	stairsplus:register_all(
		"banana_tree",
		"trunk",
		"banana_tree:trunk",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=1, flammable=2 },
			tiles =	{
				"banana_trunk_top.png",
				"banana_trunk_top.png",
				"banana_trunk.png"
			},
			description = S("Banana Tree Trunk"),
			drop = "trunk",
		}
	)
	stairsplus:register_all(
		"banana_tree",
		"banana_wood",
		"banana_tree:wood",
		{
			groups = { snappy=1, choppy=2, oddly_breakable_by_hand=2, flammable=3 },
			tiles = { "banana_wood.png" },
			description = S("Banana Wood"),
			drop = "banana_wood",
		}
	)
end
