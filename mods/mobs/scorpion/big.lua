mobs:register_mob('scorpion:big', {
   type = 'monster',
   passive = false,
   attack_type = 'dogfight',
   damage = 20,
   damage_max = 30,
   damage_chance = 160,
   hp_min = 50, hp_max = 100, armor = 30,
   collisionbox = {-1.2, -.6, -1, 1.2, 0.6, 1},
   visual = 'mesh',
   mesh = 'scorpion.b3d',
   drawtype = 'front',
   textures = {
      {'scorpion_red.png'},
      {'scorpion_green.png'},
      {'scorpion_tan.png'},
   },
   blood_texture = 'mobs_blood.png',
   visual_size = {x=13,y=13},
   makes_footstep_sound = true,
   sounds = {
      war_cry = 'scorpion_squeak',
   },
   walk_velocity = .5,
   run_velocity = 2,
   jump = true,
   stepheight = 2.2,
   reach = 4,
   view_range = 8,
   fear_height = 5,
   drops = {
      {name = 'mobs:meat_raw', chance = 1, min = 5, max = 20},
      {name = 'scorpion:shell', chance = 1, min = 5, max = 20},
      {name = 'maxhp:lifeforce3', chance = 12, min = 0, max = 2},
   },
   water_damage = 2,
   lava_damage = 60,
   light_damage = 0,
   runaway_from = {'fantasy_mobs:larva_pet'},
   animation = {
      speed_normal = 15,   speed_run = 15,
      stand_start = 0,     stand_end = 60,
      walk_start = 150,    walk_end = 210,
      run_start = 150,     run_end = 210,
      punch_start = 220,   punch_end = 260,
      punch2_start = 265,  punch2_end = 305,
      punch3_start = 70,   punch3_end = 140,
   },
})

mobs:spawn({
   name = 'scorpion:big',
   nodes = {'default:desert_sand'},
   max_light = 10,
   min_height = -10,
   max_height = 150,
   interval = 30,
   chance = 4000,
   active_object_count = 5,
})