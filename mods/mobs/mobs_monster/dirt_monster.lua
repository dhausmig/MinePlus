
local S = mobs.intllib


-- Dirt Monster by PilzAdam

mobs:register_mob("mobs_monster:dirt_monster", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	pathfinding = true,
	reach = 2,
	damage = 2,
   damage_max = 4,
   damage_chance = 50,
	hp_min = 3,
	hp_max = 27,
	armor = 100,
	collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
	visual = "mesh",
	mesh = "mobs_stone_monster.b3d",
	textures = {
		{"mobs_dirt_monster.png"},
	},
	blood_texture = "default_dirt.png",
	makes_footstep_sound = true,
	sounds = {
		random = "mobs_dirtmonster",
	},
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	jump = true,
	drops = {
		{name = "currency:minegeld_5", chance = 3, min = 0, max = 4},
		{name = "default:dirt", chance = 1, min = 0, max = 2},
	},
	water_damage = 1,
	lava_damage = 5,
	light_damage = 3,
	fear_height = 4,
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 14,
		walk_start = 15,
		walk_end = 38,
		run_start = 40,
		run_end = 63,
		punch_start = 40,
		punch_end = 63,
	},
   immune_to = {
		{"default:shovel_wood", 1},
		{"default:shovel_stone", 4},
		{"default:shovel_bronze", 5},
		{"default:shovel_steel", 5},
		{"default:shovel_mese", 6},
		{"default:shovel_diamond", 7},
--      {"epic:shovel_titanium", 9},
	},
})


local spawn_on = "default:dirt_with_grass"

mobs:spawn({
	name = "mobs_monster:dirt_monster",
	nodes = {spawn_on},
	min_light = 0,
	max_light = 7,
	chance = 6000,
	active_object_count = 2,
	min_height = 0,
   max_height = 190,
	day_toggle = false,
})


mobs:register_egg("mobs_monster:dirt_monster", S("Dirt Monster"), "default_dirt.png", 1)


mobs:alias_mob("mobs:dirt_monster", "mobs_monster:dirt_monster") -- compatibility
