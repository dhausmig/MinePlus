--[[
Animation Data:
1-60 Eating
61-121 Tail wiggle
122-182 Walking
246-330 Attack
]]

mobs:register_mob('farm_mobs:goat_she', {
   type = 'animal',
   passive = true,
   attack_type = 'dogfight',
   damage = 8,
   damage_chance = 40,
   hp_min = 5, hp_max = 15, armor = 200,
   collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.75, 0.3},
   visual = 'mesh',
   mesh = 'farm_mobs_she_goat.b3d',
   textures = {
      {'farm_mobs_goat_brown.png'},
      {'farm_mobs_goat_grey.png'},
   },
   blood_texture = 'mobs_blood.png',
   visual_size = {x=2,y=2},
   makes_footstep_sound = true,
   sounds = {
      random = 'mobs_sheep',
   },
   walk_velocity = 1,
   run_velocity = 2,
   jump = true,
   stepheight = 1.1,
   drops = {
      {name = 'mobs:meat_raw', chance = 1, min = 1, max = 4},
      {name = 'mobs:leather', chance = 2, min = 1, max = 2},
      {name = 'bonemeal:bone', chance = 2, min = 1, max = 5},
   },
   water_damage = 0,
   lava_damage = 5,
   light_damage = 0,
   animation = {
      speed_normal = 30,      speed_run = 45,
      stand_start = 1,      stand_end = 60, -- head down/up
      walk_start = 122,      walk_end = 182, -- walk
      run_start = 122,      run_end = 182, -- walk
      punch_start = 246,      punch_end = 330, -- attack
   },
   follow = 'farming:wheat',
   view_range = 7,
   replace_rate = 7,
   replace_what = {
      {'group:flora', 'air', 0},
      {'group:grain', 'air', 0},
      {'group:veggie', 'air', 0},
      {'epic:poison', 'air', 0}
   },
   on_replace = function(self, pos, oldnode, newnode)
      if oldnode.name == 'epic:poison' then
         self.health = 0
      end
   end,
   on_rightclick = function(self, clicker)
      if mobs:protect(self, clicker) then return end
      if mobs:feed_tame(self, clicker, 8, true, true) then
         if self.food and self.food >= 7 then
            self.gotten = false
         end
         return
      end
      mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)
      local tool = clicker:get_wielded_item()
      local name = clicker:get_player_name()
      if tool:get_name() == 'bucket:bucket_empty' then

         if self.child == true then
            return
         end
         if self.gotten == true then
            minetest.chat_send_player(name,'Goat already milked!')
            return
         end
         local inv = clicker:get_inventory()
         tool:take_item()
         clicker:set_wielded_item(tool)
         if inv:room_for_item('main', {name = 'mobs:bucket_milk'}) then
            clicker:get_inventory():add_item('main', 'mobs:bucket_milk')
         else
            local pos = self.object:get_pos()
            pos.y = pos.y + 0.5
            minetest.add_item(pos, {name = 'mobs:bucket_milk'})
         end
         self.gotten = true -- milked
         return
      end
   end,
})

mobs:register_mob('farm_mobs:goat_he', {
   type = 'animal',
   passive = true,
   attack_type = 'dogfight',
   attack_npcs = false,
   damage = 10,
   damage_chance = 50,
   hp_min = 5, hp_max = 15, armor = 200,
   collisionbox = {-0.3, -0.01, -0.3, 0.3, 0.75, 0.3},
   visual = 'mesh',
   mesh = 'farm_mobs_he_goat.b3d',
   textures = {
      {'farm_mobs_goat_brown.png'},
      {'farm_mobs_goat_grey.png'},
   },
   blood_texture = 'mobs_blood.png',
   visual_size = {x=2,y=2},
   makes_footstep_sound = true,
   sounds = {
      random = 'mobs_sheep',
   },
   walk_velocity = 1,
   run_velocity = 2,
   jump = true,
   stepheight = 1.1,
   drops = {
      {name = 'mobs:meat_raw', chance = 1, min = 1, max = 4},
      {name = 'mobs:leather', chance = 2, min = 1, max = 2},
      {name = 'bonemeal:bone', chance = 2, min = 1, max = 5},
   },
   water_damage = 0,
   lava_damage = 5,
   light_damage = 0,
   animation = {
      speed_normal = 30,      speed_run = 45,
      stand_start = 1,      stand_end = 60, -- head down/up
      walk_start = 122,      walk_end = 182, -- walk
      run_start = 122,      run_end = 182, -- walk
      punch_start = 246,      punch_end = 330, -- attack
   },
   follow = 'farming:wheat',
   view_range = 7,
   replace_rate = 7,
   replace_what = {
      {'group:flora', 'air', 0},
      {'group:grain', 'air', 0},
      {'group:veggie', 'air', 0},
      {'epic:poison', 'air', 0}
   },
   on_replace = function(self, pos, oldnode, newnode)
      if oldnode.name == 'epic:poison' then
         self.health = 0
      end
   end,
   on_rightclick = function(self, clicker)
      if mobs:protect(self, clicker) then return end
      if mobs:feed_tame(self, clicker, 8, true, true) then
         return
      end
      mobs:capture_mob(self, clicker, 0, 5, 60, false, nil)
   end,
   })

mobs:spawn({
   name = 'farm_mobs:goat_she',
   nodes = {'default:dirt_with_grass', 'default:dirt_with_dry_grass', 'default:dirt'},
   min_height = -5,
   max_height = 100,
   interval = 63,
   chance = 10000,
   active_object_count = 5,
})

mobs:spawn({
   name = 'farm_mobs:goat_he',
   nodes = {'default:dirt_with_grass', 'default:dirt_with_dry_grass', 'default:dirt'},
   min_height = -5,
   max_height = 100,
   interval = 64,
   chance = 10000,
   active_object_count = 5,
})

mobs:register_egg('farm_mobs:goat_she', 'She Goat', 'default_grass.png', 1)
mobs:register_egg('farm_mobs:goat_he', 'He Goat', 'default_grass.png', 1)
