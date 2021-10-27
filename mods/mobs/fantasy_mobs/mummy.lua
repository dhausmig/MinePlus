mobs:register_mob('fantasy_mobs:mummy', {
   description = 'Mummy',
   type = 'monster',
   damage = 15,
   damage_max = 30,
   damage_chance = 105,
   attack_type = 'dogfight',
   hp_min = 100,
   hp_max = 200,
   armor = 50,
   collisionbox = {-0.4, -0.01, -0.4, 0.4, 1.9, 0.4},
   visual = 'mesh',
   mesh = 'fantasy_mummy.x',
      textures = {
         {'fantasy_mummy.png'},
      },
   visual_size = {x = 8, y = 8},
   walk_velocity = 2,
   run_velocity = 4,
   jump = true,
   water_damage = 15,
   lava_damage = 30,
   light_damage = 10,
   reach = 3,
   view_range = 7,
   drops = {
      {name = 'bonemeal:bone', chance = 2, min = 1, max = 10},
      {name = 'currency:minegeld_10', chance = 2, min = 1, max = 21}
   },
   animation = {
      stand_start = 74,
      stand_end = 74,
      walk_start = 74,
      walk_end = 105,
      punch_start = 74,
      punch_end = 105,
   },
})

mobs:spawn({
   name = 'fantasy_mobs:mummy',
   nodes = {'pyramids:deco_stone1', 'pyramids:deco_stone2', 'pyramids:deco_stone3', 'pyramids:trap'},
   max_light = 13,
   min_height = -3,
   max_height = 150,
   interval = 30,
   chance = 200,
   active_object_count = 10,
})
