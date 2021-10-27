if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
zombies = {
   skins = {}
}

minetest.register_craftitem('zombies:tooth', {
   description = 'Zombie Tooth',
   inventory_image = 'zombies_tooth.png'
})

--Skin gen
local skin_base = {'zombies_skin-tan.png', 'zombies_skin-green.png', 'zombies_skin-ash.png'}
local hair_base = {'zombies_hair-1.png', 'zombies_hair-2.png', 'zombies_hair-3.png', 'zombies_hair-4.png', 'zombies_blank.png'}
local shirt_base = {'zombies_shirt-blue.png', 'zombies_shirt-white.png', 'zombies_shirt-rags.png', 'zombies_blank.png'}
local pants_base = {'zombies_pants-blue.png', 'zombies_pants-green.png', 'zombies_pants-brown.png', 'zombies_pants-black.png', 'zombies_pants-purple.png', 'zombies_blank.png'}
local face_base = {'zombies_face-1.png', 'zombies_face-2.png', 'zombies_face-3.png', 'zombies_face-4.png', 'zombies_face-5.png'}

for i = 1, 16 do
   table.insert(zombies.skins, {skin_base[math.random(3)]..'^'..face_base[math.random(5)]..'^'..shirt_base[math.random(4)]..'^'..pants_base[math.random(4)]..'^'..hair_base[math.random(5)]})
end

local inventory = {
   {name = 'default:dirt', chance = 2, min = 3, max = 5},
   {name = 'default:apple', chance = 6, min = 2, max = 5},
   {name = 'default:clay_lump', chance = 10, min = 1, max = 4},
   {name = 'bonemeal:bone', chance = 3, min = 0, max = 10},
   {name = 'zombies:tooth', chance = 10, min = 0, max = 3},
   {name = 'maxhp:lifeforce1', chance = 7, min = 0, max = 4},
   {name = 'currency:minegeld', chance = 50, min = 1, max = 20},
--   {name = 'epic:float_crystal_shard', chance = 100, min = 1, max = 2},
--   {name = 'epic:burlap_tattered', chance = 4, min = 1, max = 3},
--   {name = 'stations:scroll_gunpowder', chance = 100, min = 0, max = 1},
--   {name = 'stations:scroll_ash', chance = 5, min = 0, max = 1},
--   {name = 'epic:slicer', chance = 1000, min = 0, max = 1}
}

local noise = {
   distance = 8,
   random = 'groan',
--   random = 'eating-brains',
}

mobs:register_mob('zombies:1arm', {
   type = 'monster',
   passive = false,
   attack_type = 'dogfight',
   pathfinding = true,
   reach = 2,
   damage = 4,
   damage_max = 4,
   damage_chance = 75,
   hp_min = 3,
   hp_max = 30,
   armor = 80,
   collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
   visual = 'mesh',
   mesh = 'zombie_one-arm.b3d',
   textures = zombies.skins,
   blood_texture = 'default_wood.png',
   makes_footstep_sound = true,
   sounds = noise,
   walk_velocity = 2,
   run_velocity = 4,
   jump = true,
   view_range = 15,
   drops = inventory,
   lava_damage = 5,
   light_damage = 1,
   fall_damage = 2,
   animation = {
      speed_normal = 10,
      speed_run = 10,
      punch_speed = 20,
      walk_start = 0,
      walk_end = 20,
      run_start = 0,
      run_end = 20,
      punch_start = 21,
      punch_end = 51,
   },
})

mobs:register_mob('zombies:crawler', {
   type = 'monster',
   passive = false,
   attack_type = 'dogfight',
   pathfinding = true,
   reach = 2,
   damage = 4,
   damage_max = 4,
   damage_chance = 75,
   hp_min = 1,
   hp_max = 20,
   armor = 80,
   collisionbox = {-0.5, -.5, -0.4, 0.5, 0.2, 0.4},
   visual = 'mesh',
   mesh = 'zombie_crawler.b3d',
   textures = zombies.skins,
   blood_texture = 'default_wood.png',
   makes_footstep_sound = true,
   sounds = noise,
   walk_velocity = .5,
   run_velocity = 1,
   jump = true,
   view_range = 15,
   drops = inventory,
   lava_damage = 5,
   light_damage = 1,
   fall_damage = 2,
   animation = {
      speed_normal = 10,
      speed_run = 10,
      punch_speed = 60,
      walk_start = 0,
      walk_end = 40,
      run_start = 0,
      run_end = 40,
      punch_start = 41,
      punch_end = 71,
   },
})

mobs:register_mob('zombies:normal', {
   type = 'monster',
   passive = false,
   attack_type = 'dogfight',
   pathfinding = true,
   reach = 3,
   damage = 4,
   damage_max = 4,
   damage_chance = 75,
   hp_min = 1,
   hp_max = 40,
   armor = 80,
   collisionbox = {-0.4, -1, -0.4, 0.4, 0.8, 0.4},
   visual = 'mesh',
   mesh = 'zombie_normal.b3d',
   textures = zombies.skins,
   blood_texture = 'default_wood.png',
   makes_footstep_sound = true,
   sounds = noise,
   walk_velocity = 2,
   run_velocity = 4,
   jump = true,
   view_range = 15,
   drops = inventory,
   lava_damage = 5,
   light_damage = 1,
   fall_damage = 2,
   animation = {
      speed_normal = 20,
      speed_run = 20,
      punch_speed = 20,
      stand_start = 0,
      stand_end = 40,
      walk_start = 41,
      walk_end = 101,
      run_start = 41,
      run_end = 101,
      punch_start = 102,
      punch_end = 142,
   },
   on_spawn = function(self)
      local phase = moon_phases.get_phase()
      if phase == 4 then
         self.object:set_properties({
            visual_size = {
               x = self.base_size.x * 2,
               y = self.base_size.y * 2
            },
            collisionbox = {
               self.base_colbox[1] * 2,
               self.base_colbox[2] * 2,
               self.base_colbox[3] * 2,
               self.base_colbox[4] * 2,
               self.base_colbox[5] * 2,
               self.base_colbox[6] * 2
            },
         })
      end
   end,
})


--Spawn Functions
mobs:spawn({
   name = 'zombies:1arm',
   nodes = {'defaut:dirt', 'default:cobble', 'default:gravel'},
   max_light = 9,
   min_height = -20,
   max_height = 150,
   interval = 30,
   chance = 500,
   active_object_count = 5,
})

mobs:spawn({
   name = 'zombies:crawler',
   nodes = {'defaut:dirt', 'default:cobble', 'default:gravel'},
   max_light = 9,
   min_height = -20,
   max_height = 150,
   interval = 30,
   chance = 500,
   active_object_count = 5,
})

mobs:spawn({
   name = 'zombies:normal',
   nodes = {'defaut:dirt', 'default:cobble', 'default:gravel'},
   max_light = 9,
   min_height = -20,
   max_height = 150,
   interval = 30,
   chance = 500,
   active_object_count = 5,
})
