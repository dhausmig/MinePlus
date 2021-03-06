mobs:register_mob('scorpion:little', {
   type = 'monster',
   passive = false,
   attack_type = 'dogfight',
   damage = 5,
   damage_max = 10,
   damage_chance = 110,
   hp_min = 30, hp_max = 75, armor = 45,
   collisionbox = {-0.6, -0.35, -0.5, 0.6, 0.3, 0.5},
   visual = 'mesh',
   mesh = 'scorpion.b3d',
   textures = {
      {'scorpion_red.png'},
      {'scorpion_green.png'},
      {'scorpion_tan.png'},
   },
   blood_texture = 'mobs_blood.png',
   visual_size = {x=7,y=7},
   makes_footstep_sound = true,
   sounds = {
      war_cry = 'scorpion_squeak',
   },
   walk_velocity = 2,
   run_velocity = 6,
   jump = true,
   stepheight = 1.7,
   reach = 3,
   view_range = 6,
   fear_height = 2,
   drops = {
      {name = 'mobs:meat_raw', chance = 1, min = 2, max = 8},
      {name = 'scorpion:shell', chance = 1, min = 1, max = 10},
   },
   water_damage = 2,
   lava_damage = 60,
   light_damage = 0,
   runaway_from = {'fantasy_mobs:larva_pet'},
   animation = {
      speed_normal = 45,   speed_run = 90,
      stand_start = 0,     stand_end = 60,
      walk_start = 150,    walk_end = 210,
      run_start = 150,     run_end = 210,
      punch_start = 220,   punch_end = 260,
      punch2_start = 265,  punch2_end = 305,
      punch3_start = 70,   punch3_end = 140,
   },
})

mobs:spawn({
   name = 'scorpion:little',
   nodes = {'default:desert_sand', 'default:dirt_with_rainforest_litter', 'default:dry_dirt_with_grass'},
   max_light = 10,
   min_height = -60,
   max_height = 200,
   interval = 45,
   chance = 3000,
   active_object_count = 5,
})
