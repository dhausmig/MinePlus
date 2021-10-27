mobs:register_mob("desert_life:ostrich", {
   type = "animal",
   passive = false,
   attack_type = "dogfight",
   group_attack = true,
   reach = 2,
   damage = 2,
   damage_max = 8,
   damage_chance = 80,
   hp_min = 5,
   hp_max = 10,
   armor = 200,
   collisionbox = {-0.4, -0.575, -0.4, 0.4, 0.75, 0.4},
   visual = "mesh",
   mesh = "dl_ostrich.b3d",
   textures = {
      {'dl_ostrich.png'},
   },
   visual_size = {x=11, y=11},
   makes_footstep_sound = true,
   walk_velocity = 1,
   run_velocity = 3,
   jump = true,
   drops = {
      {name = "mobs:chicken_raw", chance = 1, min = 2, max = 6},
   },
   water_damage = 1,
   lava_damage = 5,
   light_damage = 0,
   fall_damage = 0,
   fall_speed = -8,
   fear_height = 5,
   animation = {
      speed_normal = 15,
      speed_run = 30,
      stand_start = 0,
      stand_end = 60,
      walk_start = 180,
      walk_end = 229,
      run_start = 180,
      run_end = 229,
      punch_start = 65,
      punch_end = 90,
      punch2_start = 95,
      punch2_end = 125,
   },
   follow = {"farming:seed_wheat", "farming:seed_cotton"},
   view_range = 5,
   replace_what = {'group:flora', 'group:plant'},
   replace_with = 'air',
   replace_rate = 1,
   do_custom = function(self, dtime)
      -- set needed values if not already present
      if not self.v2 then
         self.v2 = 0
         self.max_speed_forward = 6
         self.max_speed_reverse = 2
         self.accel = 6
         self.terrain_type = 3
         self.driver_attach_at = {x = 0, y = .5, z = -0.25}
         self.driver_eye_offset = {x = 0, y = 3, z = 0}
         self.driver_scale = {x = .09, y = .09}
      end
      -- if driver present allow control of ostrich
      if self.driver then
         mobs.drive(self, "walk", "stand", false, dtime)
         return false -- skip rest of mob functions
      end
      return true
   end,
   on_die = function(self, pos)
      -- drop saddle when ostrich is killed while riding
      -- also detach from ostrich properly
      if self.driver then
         minetest.add_item(pos, "mobs:saddle")
         mobs.detach(self.driver, {x = 1, y = 0, z = 1})
         self.saddle = nil
      end
      -- drop any ostrichshoes added
      if self.shoed then
         minetest.add_item(pos, self.shoed)
      end

   end,
   on_rightclick = function(self, clicker)
      -- make sure player is clicking
      if not clicker or not clicker:is_player() then
         return
      end
      -- feed, tame or heal ostrich
      if mobs:feed_tame(self, clicker, 10, true, true) then
         return
      end
      -- applying protection rune
      if mobs:protect(self, clicker) then
         return
      end
      -- make sure tamed ostrich is being clicked by owner only
      if self.tamed and self.owner == clicker:get_player_name() then
         local inv = clicker:get_inventory()
         local tool = clicker:get_wielded_item()
         local item = tool:get_name()
         -- detatch player already riding ostrich
         if self.driver and clicker == self.driver then
            mobs.detach(clicker, {x = 1, y = 0, z = 1})
            -- add saddle back to inventory
            if inv:room_for_item("main", "mobs:saddle") then
               inv:add_item("main", "mobs:saddle")
            else
               minetest.add_item(clicker:get_pos(), "mobs:saddle")
            end
            self.saddle = nil
         -- attach player to ostrich
         elseif (not self.driver and not self.child
         and clicker:get_wielded_item():get_name() == "mobs:saddle")
         or self.saddle then
            --self.object:set_properties()
            --print(self.object)
            mobs.attach(self, clicker)
            -- take saddle from inventory
            if not self.saddle then
               inv:remove_item("main", "mobs:saddle")
            end
            self.saddle = true
         end
      end
      -- used to capture ostrich with magic lasso
      mobs:capture_mob(self, clicker, 0, 0, 80, false, nil)
   end
})

mobs:spawn({
   name = 'desert_life:ostrich',
   nodes = {'default:desert_sand', 'default:desert_stone'},
   min_height = 0,
   max_height = 150,
   interval = 60,
   chance = 10000,
   active_object_count = 5,
})

mobs:register_egg("desert_life:ostrich", "Ostrich", "wool_white.png^[multiply:#40230f", 1)
