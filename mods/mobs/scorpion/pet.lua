local get_distance = function(a, b)
   local x, y, z = a.x - b.x, a.y - b.y, a.z - b.z
   return (x * x + y * y + z * z)
end

mobs:register_mob('scorpion:pet', {
   type = 'npc',
   passive = false,
   attack_type = 'dogfight',
   owner_loyal = true,
   pathfinding = true,
   damage = 10,
   damage_max = 10,
   damage_chance = 110,
   hp_min = 30, hp_max = 75, armor = 20,
   collisionbox = {-0.6, -0.35, -0.5, 0.6, 0.3, 0.5},
   visual = 'mesh',
   mesh = 'scorpion.b3d',
   drawtype = 'front',
   textures = {
      {'scorpion_red.png^scorpion_pet.png'},
      {'scorpion_green.png^scorpion_pet.png'},
      {'scorpion_tan.png^scorpion_pet.png'},
   },
   follow = {'mobs:meat_raw', 'mobs:chicken_raw'},
   blood_texture = 'mobs_blood.png',
   visual_size = {x=8,y=8},
   makes_footstep_sound = true,
   sounds = {
      war_cry = 'scorpion_squeak',
   },
   walk_velocity = 3,
   run_velocity = 6,
   jump = true,
   stepheight = 1.7,
   reach = 4,
   view_range = 15,
   fear_height = 2,
   owner = '',
   order = 'follow',
   drops = {
      {name = 'mobs:meat_raw', chance = 1, min = 2, max = 8},
      {name = 'scorpion:shell', chance = 1, min = 5, max = 20},
   },
   water_damage = 1,
   lava_damage = 6,
   light_damage = 0,
   animation = {
      speed_normal = 45,   speed_run = 90,
      stand_start = 0,     stand_end = 60,
      walk_start = 150,    walk_end = 210,
      run_start = 150,     run_end = 210,
      punch_start = 220,   punch_end = 260,
      punch2_start = 265,  punch2_end = 305,
      punch3_start = 70,   punch3_end = 140,
   },

   on_spawn = function(self)
      local pos = self.object:get_pos()
      local objs = minetest.get_objects_inside_radius(pos, 4)
      for _, obj in pairs(objs) do
         if obj:is_player() then
            local owner = obj:get_player_name()
            self.owner = owner
            minetest.chat_send_player(owner, "Aww, a baby scorpion thinks you're its parent!")
            --This should only send to the player that is chosen to be the owner.
         end
      end
      return true
   end,

   on_rightclick = function(self, clicker)
      if mobs:protect(self, clicker) then return end
      local name = clicker:get_player_name()
      local inv = clicker:get_inventory()
      local tool = clicker:get_wielded_item()
      local item = tool:get_name()
      if mobs:feed_tame(self, clicker, 10, false, true) then
         return
      end
      if mobs:protect(self, clicker) then return end
      if self.owner and self.owner == name then
         if item ~= 'scorpion:saddle' then
            if self.order == 'follow' then
               self.order = 'stand'
               minetest.chat_send_player(name, ('Scorpion holding ground.'))
            else
               self.order = 'follow'
               minetest.chat_send_player(name, ('Scorpion following you.'))
            end
            mobs:capture_mob(self, clicker, 20, 0, 100, false, nil)
         end
         -- detatch player
         if self.driver and clicker == self.driver then
            mobs.detach(clicker, {x = 1, y = 0, z = 1})
            -- add saddle back to inventory
            if inv:room_for_item("main", "scorpion:saddle") then
               inv:add_item("main", "scorpion:saddle")
            else
               minetest.add_item(clicker:get_pos(), "scorpion:saddle")
            end
            self.saddle = nil
         -- attach player
         elseif (not self.driver and not self.child and item == "scorpion:saddle")
         or self.saddle then
            self.object:set_properties({stepheight = 1.1})
            mobs.attach(self, clicker)
            if not self.saddle then
               inv:remove_item("main", "scorpion:saddle")
            end
            self.saddle = true
         end
      end
   end,

   on_grown = function(self)
      local owner = self.owner
      minetest.chat_send_player(owner, ('Your pet scorpion grew up!'))
   end,

   do_custom = function(self, dtime) --Thanks to IhrFussel for many ideas used in this code block.
      local pet_pos = self.object:get_pos()
      local owner = minetest.get_player_by_name(self.owner) or false
      if owner and self.order == 'follow' then --and self.state == "walk
         self.dtime = (self.dtime or 0) + dtime
         if self.dtime > 5 then
            local distance = get_distance(owner:get_pos(), pet_pos)
            if distance > 1000 then --should teleport to player
               self.object:set_pos(owner:get_pos())
            end
            self.dtime = 0
         end
      end
      -- set needed values if not already present
      if not self.v2 then
         self.v2 = 0
         self.max_speed_forward = 6
         self.max_speed_reverse = 2
         self.accel = 6
         self.terrain_type = 3
         self.driver_attach_at = {x = 0, y = y_off, z = -0.25}
         self.driver_eye_offset = {x = 0, y = 2, z = 0}
         self.driver_scale = {x = .125, y = .125}
      end
      -- if driver present allow control of horse
      if self.driver then
         mobs.drive(self, "walk", "stand", false, dtime)
         return false -- skip rest of mob functions
      end
      return true
   end,
   on_die = function(self, pos)
      if self.driver then
         minetest.add_item(pos, "scorpion:saddle")
         mobs.detach(self.driver, {x = 1, y = 0, z = 1})
         self.saddle = nil
      end
   end,
})

mobs:register_egg('scorpion:pet', 'Pet Scorpion', 'default_grass.png', 1)

minetest.register_craftitem('scorpion:saddle', {
   description = 'Scorpion Saddle',
   inventory_image = 'scorpion_saddle.png'
})
