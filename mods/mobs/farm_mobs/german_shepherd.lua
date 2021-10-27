local get_distance = function(a, b)
   local x, y, z = a.x - b.x, a.y - b.y, a.z - b.z
   return (x * x + y * y + z * z)
end

mobs:register_mob('farm_mobs:german_shepherd', {
   type = 'animal',
   passive = false,
   attack_type = 'dogfight',
   group_attack = true,
   reach = 3,
   damage = 10,
   damage_max = 20,
   damage_chance = 150,
   hp_min = 50,
   hp_max = 150,
   armor = 75,
   collisionbox = {-0.3, -0.01, -0.3, 0.3, .7, 0.3},
   visual = 'mesh',
   visual_size = {x=4,y=4},
   rotate = 180,
   mesh = 'farm_mobs_german_shepherd.b3d',
   textures = {
      {'farm_mobs_german_shepherd.png'},
   },
   makes_footstep_sound = true,
   sounds = {
      random = 'farm_mobs_dog',
      attack = 'farm_mobs_dog',
   },
   walk_velocity = 2,
   run_velocity = 5,
   jump = true,
   follow = {'mobs:meat_raw'},
   drops = {
      {name = 'mobs:meat_raw', chance = 1, min = 1, max = 3},
   },
   water_damage = 0,
   lava_damage = 5,
   light_damage = 0,
   animation = {
      speed_normal = 40,
      speed_run = 30,
      stand_speed = 7,
      stand_start = 75,
      stand_end = 95,
      stand1_start = 100,
      stand1_end = 130,
      walk_start = 135,
      walk_end = 195,
      run_start = 135,
      run_end = 195,
      punch_start = 200,
      punch_end = 250,
      sit_start = 0,
      sit_end = 20,
   },
   follow = 'mobs:meat_raw',
   view_range = 7,
   fear_height = 2,
   on_rightclick = function(self, clicker)
      if mobs:protect(self, clicker) then return end
      local name = clicker:get_player_name()
      local inv = clicker:get_inventory()
      local tool = clicker:get_wielded_item()
      local item = tool:get_name()
      if mobs:feed_tame(self, clicker, 10, false, true) then
         self.type = 'npc'
         self.owner_loyal = true
         self.pathfinding = true
         self.owner = name
         return
      end
      if mobs:protect(self, clicker) then return end
      if self.owner and self.owner == name then
         if self.order == 'follow' then
            self.order = 'stand'
            minetest.chat_send_player(name, ('Dog holding ground.'))
         else
            self.order = 'follow'
            minetest.chat_send_player(name, ('Dog following you.'))
         end
         mobs:capture_mob(self, clicker, 20, 0, 100, false, nil)
      end
   end,
   on_spawn = function(self)
      local pos = self.object:get_pos()
      local objs = minetest.get_objects_inside_radius(pos, 4)
      for _, obj in pairs(objs) do
         if obj:is_player() then
            local owner = obj:get_player_name()
            self.type = 'npc'
            self.owner_loyal = true
            self.pathfinding = true
            self.owner = owner
         end
      end
      return true
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
   end,
})

mobs:spawn({
   name = 'farm_mobs:german_shepherd',
   nodes = {'default:dirt_with_coniferous_litter'},
   min_height = -15,
   max_height = 300,
   interval = 100,
   chance = 8000,
   active_object_count = 3,
})
--[[
minetest.register_craftitem('farm_mobs:dog_treat', {
   description = 'Dog Treat',
   inventory_image = 'farm_mobs_dog_treat.png'
})

stations.dual_register_recipe('food_prep', {
   input = {
      ['group:food_flour'] = 3,
      ['mobs:egg'] = 3,
      ['farming:pumpkin_slice'] = 1,
      ['farming:hemp_oil'] = 1,
      ['default:apple'] = 1,
      ['mobs:honey'] = 1
   },
   output = 'farm_mobs:dog_treat 6',
})
--]]
mobs:register_egg("farm_mobs:german_shepherd", "German Shepherd", "default_grass.png", 1)
