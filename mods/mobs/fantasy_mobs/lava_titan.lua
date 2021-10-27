mobs:register_mob("fantasy_mobs:lava_titan", {
   type = "monster",
   hp_max = 180,
   hp_min = 100,
   collisionbox = {-0.45, -0.05, -0.45, 0.45, 1.8, 0.45},
   visual = "mesh",
   mesh = "fantasy_lava_titan.b3d",
   textures = {{"fantasy_lava_titan.png"}},
   visual_size = {x=2, y=2},
   makes_footstep_sound = true,
   view_range = 20,
   fear_height = 4,
   lifetimer = 500,
   walk_velocity = 0.5,
   run_velocity = 1.3,
   sounds = {
      random = "lava_titan",
   },
   damage = 8,
   damage_max = 40,
   damage_chance = 80,
   jump = false,
   jump_height=0,
   drops = {
      {name = "bucket:bucket_lava", chance = 2, min = 1, max = 3,},
 --     {name = "epic:slicer", chance = 3, min = 1, max = 2},
      {name = 'maxhp:lifeforce5', chance = 150, min = 0, max = 1},
   },
   armor = 20,
   drawtype = "front",
   water_damage = 25,
   rotate = 270,
   light_damage = 0,
   lava_damage = 0,
   on_rightclick = nil,
   floats = 0,
   knock_back=0,
   attack_type = "dogshoot",
   dogshoot_switch = true,
     arrow = "fantasy_mobs:lava_arrow",
     shoot_interval = 2,
     shoot_offset = 0,
   animation = {
      speed_normal = 25,
      speed_run = 45,
      stand_start = 120,
      stand_end = 300,
      walk_start = 10,
      walk_end = 110,
      run_start = 10,
      run_end = 110,
      punch_start = 301,
      punch_end = 340,
      shoot_start =340,
      shoot_end=400,
   },
})

mobs:register_arrow("fantasy_mobs:lava_arrow", {
   visual = "sprite",
   visual_size = {x = 1, y = 1},
   textures = {"epic_blank.png"},
   velocity = 10,
   -- direct hit
   hit_player = function(self, player)
      local pos = self.object:get_pos()
      if minetest.is_protected(pos, "") then
         return
      end
      for dy=-1, 6, 1 do
         for dx=-1, 1, 2 do
            for dz=-1, 1, 2 do
               local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
               local n = minetest.env:get_node(p).name
               if n~="default:lava_flowing" and not minetest.is_protected(p, "") then
                  minetest.set_node(p, {name="default:lava_flowing"})
               end
            end
         end
      end
   end,
})

mobs:spawn({
   name = 'fantasy_mobs:lava_titan',
   nodes = {'nether:lava_crust'},
   min_height = -31000,
   max_height = -25000,
   interval = 31,
   chance = 2000,
   active_object_count = 5,
})
