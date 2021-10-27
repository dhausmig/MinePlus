-- Green Slimes by TomasJLuis & TenPlus1

-- sounds
local green_sounds = {
   damage = 'slimes_damage',
   death = 'slimes_death',
   jump = 'slimes_jump',
   attack = 'slimes_attack',
}

local cloud_textures = {'fantasy_cloud_puff_sides.png', 'fantasy_cloud_puff_sides.png', 'fantasy_cloud_puff_sides.png', 'fantasy_cloud_puff_sides.png', 'fantasy_cloud_puff_front.png', 'fantasy_cloud_puff_sides.png'}

mobs:register_mob('fantasy_mobs:cloudsmall', {
   type = 'monster',
   hp_min = 1,   hp_max = 2,
   collisionbox = {-0.25, -0.25, -0.25, 0.25, 0.25, 0.25},
   visual = 'cube',
   visual_size = {x = 0.5, y = 0.5},
   textures = { cloud_textures },
   blood_texture = 'fantasy_cloud_puff_blood.png',
   makes_footstep_sound = false,
   sounds = green_sounds,
   attack_type = 'dogfight',
   damage = 4,
   damage_max = 8,
   damage_chance = 400,
   passive = false,
   walk_velocity = 2,
   run_velocity = 2,
   walk_chance = 0,
   jump_chance = 30,
   jump_height = 6,
   armor = 100,
   view_range = 15,
   drops = {
--      {name = 'epic:float_crystal', chance = 16, min = 0, max = 1},
--      {name = 'illuminati:cone_off', chance = 100, min = 0, max = 1},
--      {name = 'illuminati:core_off', chance = 100, min = 0, max = 1},
      {name = 'default:mese_crystal', chance = 16, min = 0, max = 1},
   },
   drawtype = 'front',
   water_damage = 0,
   lava_damage = 10,
   light_damage = 0,
})

mobs:register_mob('fantasy_mobs:cloudmedium', {
   type = 'monster',
   hp_min = 3,   hp_max = 4,
   collisionbox = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
   visual = 'cube',
   visual_size = {x = 1, y = 1},
   textures = { cloud_textures },
   blood_texture = 'fantasy_cloud_puff_blood.png',
   makes_footstep_sound = false,
   sounds = green_sounds,
   attack_type = 'dogfight',
   damage = 10,
   passive = false,
   walk_velocity = 2,
   run_velocity = 2,
   walk_chance = 0,
   jump_chance = 30,
   jump_height = 6,
   armor = 100,
   view_range = 15,
   on_die = function(self, pos)
      local num = math.random(2, 4)
      for i=1,num do
         minetest.add_entity({x=pos.x + math.random(-2, 2), y=pos.y + 1, z=pos.z + (math.random(-2, 2))}, 'fantasy_mobs:cloudsmall')
      end
   end,
   drawtype = 'front',
   water_damage = 0,
   lava_damage = 10,
   light_damage = 0,
})

mobs:register_mob('fantasy_mobs:cloudbig', {
   type = 'monster',
   hp_min = 5,   hp_max = 6,
   collisionbox = {-1, -1, -1, 1, 1, 1},
   visual = 'cube',
   visual_size = {x = 2, y = 2},
   textures = { cloud_textures },
   blood_texture = 'fantasy_cloud_puff_blood.png',
   makes_footstep_sound = false,
   sounds = green_sounds,
   attack_type = 'dogfight',
   attacks_monsters = true,
   damage = 15,
   passive = false,
   walk_velocity = 2,
   run_velocity = 2,
   walk_chance = 0,
   jump_chance = 30,
   jump_height = 6,
   armor = 100,
   view_range = 15,
   on_die = function(self, pos)
      local num = math.random(1, 2)
      for i=1,num do
         minetest.add_entity({x=pos.x + math.random(-2, 2), y=pos.y + 1, z=pos.z + (math.random(-2, 2))}, 'fantasy_mobs:cloudmedium')
      end
   end,
   drawtype = 'front',
   water_damage = 0,
   lava_damage = 10,
   light_damage = 0,
})

mobs:spawn({
   name = 'fantasy_mobs:cloudbig',
   nodes = {'default:water_source', 'default:water_flowing'},
   min_height = 300,
   max_height = 1000,
   interval = 60,
   chance = 2500,
   active_object_count = 4,
})
