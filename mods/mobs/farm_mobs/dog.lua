mobs:register_mob('farm_mobs:dog', {
   type = 'animal',
   passive = true,
   attack_type = 'dogfight',
   group_attack = true,
   reach = 2,
   damage = 4,
   hp_min = 5,
   hp_max = 20,
   armor = 200,
   collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
   visual = 'mesh',
   visual_size = {x=7,y=7},
   mesh = 'farm_mobs_dog.b3d',
   textures = {
      {'farm_mobs_dog.png'},
    {'farm_mobs_dog1.png'},
   },
   makes_footstep_sound = true,
   sounds = {
      random = 'farm_mobs_dog',
      attack = 'farm_mobs_dog',
   },
   walk_velocity = 1,
   run_velocity = 2,
   jump = true,
   drops = {
      {name = 'mobs:meat_raw', chance = 1, min = 1, max = 3},
   },
   water_damage = 0,
   lava_damage = 5,
   light_damage = 0,
   animation = {
      speed_normal = 10,
      speed_run = 15,
      stand_start = 110,
      stand_end = 140,
      walk_start = 50,
      walk_end = 90,
      run_start = 50,
      run_end = 90,
      punch_start = 0,
      punch_end = 40,
   },
   follow = 'mobs:meat_raw',
   view_range = 7,
   fear_height = 2,
   on_rightclick = function(self, clicker)
      if mobs:feed_tame(self, clicker, 8, true, true) then
         return
      end
      mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)
   end,
})

mobs:register_egg("farm_mobs:dog", "Dog", "default_grass.png", 1)

mobs:spawn({
   name = 'farm_mobs:dog',
   nodes = {'default:dirt_with_grass', 'default:dirt_with_dry_grass', 'default:dirt'},
   min_height = -5,
   max_height = 100,
   interval = 63,
   chance = 10000,
   active_object_count = 5,
})
