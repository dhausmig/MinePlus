local cavefreak_sounds = {
--   random = 'goblins_goblin_ambient',
--   warcry = 'goblins_goblin_attack',
   attack = 'fantasy_cavefreak_punch',
--   damage = 'goblins_goblin_damage',
   death = 'fantasy_cavefreak_die',
   distance = 7,
}

function fire_splash(pos)
   minetest.sound_play('fantasy_fire_start',{pos = pos, max_hear_distance = 10, gain = 0.5})
   for z = -1,1 do
      for y = -1,0 do
         for x = -1,1 do
            local p = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
            local nn = minetest.get_node(p).name
            if nn == 'air' then
               minetest.set_node(p, {name='fire:basic_flame'})
            end
         end
      end
   end
end

mobs:register_mob('fantasy_mobs:cavefreak_fire', {
   description = 'Cavefreak',
   type = 'monster',
   damage = 15,
   damage_max = 20,
   damage_chance = 100,
   attack_type = 'shoot',
   shoot_interval = 2,
   arrow = 'fantasy_mobs:cavefreak_fire_arrow',
   shoot_offset = 1,
   hp_min = 100,
   hp_max = 200,
   armor = 75,
   collisionbox = {-0.4, -0.5, -0.4, 0.4, .5, 0.4},
   visual = 'mesh',
   mesh = 'fantasy_cavefreak.b3d',
      textures = {
         {'fantasy_cavefreak1.png^fantasy_cavefreak_fire.png'},
         {'fantasy_cavefreak2.png^fantasy_cavefreak_fire.png'},
         {'fantasy_cavefreak3.png^fantasy_cavefreak_fire.png'},
      },
   rotate = 180,
   visual_size = {x = 9, y = 9},
   sounds = cavefreak_sounds,
   walk_velocity = 2,
   run_velocity = 4,
   immune_to = {{'castle_weapons:crossbow_bolt_entity', 30},},
   jump = true,
   water_damage = 5,
   lava_damage = -5,
   light_damage = 1,
   reach = 2,
   view_range = 8,
   drops = {
      {name = 'scorpion:shell', chance = 2, min = 1, max = 6},
      {name = 'currency:minegeld_50', chance = 10, min = 0, max = 15},
      {name = 'tnt:gunpowder', chance = 3, min = 4, max = 20},
      {name = 'maxhp:lifeforce4', chance = 20, min = 0, max = 2}
   },
   animation = {
      die_start = 140,
      die_end = 180,
      die_loop = false,
      stand_start = 0,
      stand_end = 60,
      walk_start = 65,
      walk_end = 135,
      punch_start = 185,
      punch_end = 240,
      shoot_start = 245,
      shoot_end = 290,
   },
   makes_footstep_sound = true,
})

mobs:register_mob('fantasy_mobs:cavefreak_slash', {
   description = 'Cavefreak',
   type = 'monster',
   damage = 20,
   damage_max = 25,
   damage_chance = 150,
   attack_type = 'dogfight',
   hp_min = 100,
   hp_max = 200,
   armor = 75,
   collisionbox = {-0.4, -0.5, -0.4, 0.4, .5, 0.4},
   visual = 'mesh',
   mesh = 'fantasy_cavefreak.b3d',
      textures = {
         {'fantasy_cavefreak1.png'},
         {'fantasy_cavefreak2.png'},
         {'fantasy_cavefreak3.png'},
      },
   rotate = 180,
   visual_size = {x = 9, y = 9},
   sounds = cavefreak_sounds,
   walk_velocity = 2,
   run_velocity = 4,
   immune_to = {{'castle_weapons:crossbow_bolt_entity', 30},},
   jump = true,
   water_damage = 5,
   lava_damage = -5,
   light_damage = 1,
   reach = 3,
   view_range = 8,
   drops = {
      {name = 'scorpion:shell', chance = 2, min = 1, max = 6},
--      {name = 'epic:huntite', chance = 2, min = 0 , max = 1},
      {name = 'maxhp:lifeforce4', chance = 20, min = 0, max = 2}
   },
   animation = {
      die_start = 140,
      die_end = 180,
      die_loop = false,
      stand_start = 0,
      stand_end = 60,
      walk_start = 65,
      walk_end = 135,
      punch_start = 185,
      punch_end = 240,
      shoot_start = 245,
      shoot_end = 290,
   },
   makes_footstep_sound = true,
})

mobs:register_arrow('fantasy_mobs:cavefreak_fire_arrow', {
   visual = 'sprite',
   visual_size = {x = .5, y = .5},
   textures = {'fantasy_goblins_blood.png'},
   collisionbox = {-0.1, -0.1, -0.1, 0.1, 0.1, 0.1},
   velocity = 7,
   on_activate = function(self, staticdata, dtime_s)
      self.object:set_armor_groups({immortal = 1, fleshy = 100})
   end,
   hit_player = function(self, player)
      local pos = player:get_pos()
      local current_player_pos = {
         x = math.floor(pos.x + 0.5),
         y = math.floor(pos.y + 1.2),
         z = math.floor(pos.z + 0.5)
      }
      fire_splash(current_player_pos)
   end,
   hit_mob = function(self, player)
      local pos = player:get_pos()
      local current_player_pos = {
         x = math.floor(pos.x + 0.5),
         y = math.floor(pos.y + 1.2),
         z = math.floor(pos.z + 0.5)
      }
      fire_splash(current_player_pos)
   end,
   hit_node = function(self, pos, node)
      fire_splash(pos)
   end
})

mobs:spawn({
   name = 'fantasy_mobs:cavefreak_fire',
   nodes = {'caverealms:stone_with_lichen', 'caverealms:stone_with_moss', 'caverealms:stone_with_algae'},
   max_light = 10,
   min_height = -21900,
   max_height = -500,
   interval = 213,
   chance = 3200,
   active_object_count = 1,
})

mobs:spawn({
   name = 'fantasy_mobs:cavefreak_slash',
   nodes = {'caverealms:stone_with_lichen', 'caverealms:stone_with_moss', 'caverealms:stone_with_algae'},
   max_light = 10,
   min_height = -21900,
   max_height = -500,
   interval = 132,
   chance = 1000,
   active_object_count = 4,
})
