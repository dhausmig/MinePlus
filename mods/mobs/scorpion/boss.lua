mobs:register_mob('scorpion:boss', {
   type = 'monster',
   passive = false,
   attack_type = 'dogfight',
   damage = 8,
   damage_max = 12,
   damage_chance = 200,
   hp_min = 75, hp_max = 175, armor = 20,
   collisionbox = {-1, -0.95, -1, 1, .35, 1},
   visual = 'mesh',
   mesh = 'scorpion.b3d',
   drawtype = 'front',
   textures = {
      {'scorpion_red.png^scorpion_armor.png'},
      {'scorpion_green.png^scorpion_armor.png'},
      {'scorpion_tan.png^scorpion_armor.png'},
   },
   blood_texture = 'mobs_blood.png',
   visual_size = {x=20,y=20},
   makes_footstep_sound = true,
   sounds = {
      war_cry = 'scorpion_squeak',
   },
   walk_velocity = 3,
   run_velocity = 7,
   jump = true,
   stepheight = 3,
   drops = {
      {name = 'mobs:meat_raw', chance = 1, min = 5, max = 15},
      {name = 'default:diamondblock', chance = 3, min = 4, max = 15},
      {name = 'default:mese', chance = 3, min = 4, max = 15},
      {name = 'default:steel_ingot', chance = 2, min = 10, max = 40},
--      {name = 'stations:scroll_teleport', chance = 5, min = 1, max = 1},
--      {name = 'stations:healing', chance = 5, min = 1, max = 1},
--      {name = 'stations:bloodstone_powder', chance = 5, min = 1, max = 1},
      {name = 'scorpion:shell', chance = 1, min = 20, max = 100},
   },
   water_damage = 20,
   lava_damage = 60,
   light_damage = 0,
   reach = 5,
   view_range = 12,
   fear_height = 9,
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

   custom_attack = function(self)
      local random_number = math.random(0,12)
      if random_number <= 3 then
         local s = self.object:get_pos()
         local pos1 = {x=s.x+math.random(-3,3), y=s.y+1, z=s.z+math.random(-3,3)}
         local node = minetest.get_node(pos1)
         local nodedef = minetest.registered_nodes[node.name] or nil
         if nodedef.buildable_to or nil then
            minetest.add_entity(pos1, 'scorpion:little')
         end
      elseif random_number == 9 then
         local s = self.object:get_pos()
         local pos1 = {x=s.x+math.random(-3,3), y=s.y+1, z=s.z+math.random(-3,3)}
         local node = minetest.get_node(pos1)
         local nodedef = minetest.registered_nodes[node.name] or nil
         if nodedef.buildable_to or nil then
            minetest.add_entity(pos1, 'scorpion:big')
         end
      end
   end,

   on_die = function(self)
      local random_number = math.random(0,2)
      if random_number == 1 then
         local pos = self.object:get_pos()
         local objs = minetest.get_objects_inside_radius(pos, 4)
         for _, obj in pairs(objs) do
            if obj:is_player() then
               local pos1 = {x=pos.x+math.random(-2,2), y=pos.y, z=pos.z+math.random(-2,2)}
               local mob = minetest.add_entity(pos1, 'scorpion:pet')
               local ent2 = mob:get_luaentity()
               mob:set_properties({
                  visual_size = {
                     x = ent2.base_size.x / 2,
                     y = ent2.base_size.y / 2
                  },
                  collisionbox = {
                     ent2.base_colbox[1] / 2,
                     ent2.base_colbox[2] / 2,
                     ent2.base_colbox[3] / 2,
                     ent2.base_colbox[4] / 2,
                     ent2.base_colbox[5] / 2,
                     ent2.base_colbox[6] / 2
                  },
               })
               ent2.child = true
            end
         end
      end
   end,
})

mobs:spawn({
   name = 'scorpion:boss',
   nodes = {'default:desert_stone', 'illuminati:goldblock'},
   max_light = 10,
   min_height = 0,
   max_height = 150,
   interval = 45,
   chance = 10000,
   active_object_count = 1,
})
