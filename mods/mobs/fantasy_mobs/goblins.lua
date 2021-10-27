local search_replace2 = function(
   self,
   search_rate,
   search_rate_above,
   search_rate_below,
   search_offset,
   search_offset_above,
   search_offset_below,
   replace_rate,
   replace_what,
   replace_with)

   if math.random(1, search_rate) == 1 then
      local pos  = self.object:get_pos() --
      local pos1 = self.object:get_pos()
      local pos2 = self.object:get_pos()

      -- if we are looking, will we look below and by how much?
      if math.random(1, search_rate_below) == 1 then
         pos1.y = pos1.y - search_offset_below
      end

      -- if we are looking, will we look above and by how much?
      if math.random(1, search_rate_above) == 1 then
         pos2.y = pos2.y + search_offset_above
      end

      pos1.x = pos1.x - search_offset
      pos1.z = pos1.z - search_offset
      pos2.x = pos2.x + search_offset
      pos2.z = pos2.z + search_offset

      local nodelist = minetest.find_nodes_in_area(pos1, pos2, replace_what)
      if #nodelist > 0 then
         for key,value in pairs(nodelist) do
            -- ok we see some nodes around us, are we going to replace them?
            if math.random(1, replace_rate) == 1 then
               minetest.set_node(value, {name = replace_with})
            end
            minetest.sound_play(self.sounds.replace, {
               object = self.object,
               max_hear_distance = self.sounds.distance
            })
         end
      end
   end
end

local goblin_sounds = {
   random = "goblins_goblin_ambient",
   warcry = "goblins_goblin_attack",
   attack = "goblins_goblin_attack",
   damage = "goblins_goblin_damage",
   death = "goblins_goblin_death",
   distance = 7,
}

mobs:register_mob('fantasy_mobs:goblin', {
   description = 'Goblin',
   type = 'monster',
   passive = false,
   damage = 8,
   damage_max = 12,
   damage_chance = 95,
   attack_type = 'dogfight',
   hp_min = 20,
   hp_max = 50,
   armor = 100,
   collisionbox = {-0.35,-1,-0.35, 0.35,-.1,0.35},
   visual = 'mesh',
   mesh = 'fantasy_goblin.b3d',
      textures = {
         {'fantasy_goblin_1.png'},
         {'fantasy_goblin_2.png'},
         {'fantasy_goblin_3.png'},
         {'fantasy_goblin_4.png'},
         {'fantasy_goblin_5.png'},
         {'fantasy_goblin_6.png'},
         {'fantasy_goblin_7.png'},
         {'fantasy_goblin_8.png'},
         {'fantasy_goblin_9.png'},
         {'fantasy_goblin_10.png'},
         {'fantasy_goblin_11.png'},
         {'fantasy_goblin_12.png'},
      },
   makes_footstep_sound = true,
   sounds = goblin_sounds,
   walk_velocity = 2,
   run_velocity = 3,
   jump = true,
   drops = {
      {name = 'default:mossycobble', chance = 1, min = 1, max = 3},
      {name = 'default:apple', chance = 2, min = 1, max = 2},
      {name = 'default:torch', chance = 3, min = 1, max = 10},
      {name = 'default:coal_lump', chance = 10, min = 1, max = 15},
      {name = 'currency:minegeld_10', chance = 30, min = 1, max = 10},
--      {name = 'stations:scroll_sulfur_dust', chance = 30, min = 1, max = 1},
--      {name = 'stations:scroll_gunpowder', chance = 30, min = 1, max = 1},
      {name = 'default:diamond', chance = 500, min = 0, max = 20},
      {name = 'farming:coffee_beans', chance = 300, min = 0, max = 5},
--      {name = 'stations:scroll_ash', chance = 1, min = 0, max = 1},
--      {name = 'epic:reaver', chance = 150, min = 0, max = 1},
--      {name = 'illuminati:cone_off', chance = 150, min = 0, max = 1},
--      {name = 'illuminati:core_off', chance = 150, min = 0, max = 1},
   },
   water_damage = 0,
   lava_damage = 2,
   light_damage = 0,
   follow = {'default:diamond', 'default:apple', 'food:bread'},
   view_range = 10,
   animation = {
      speed_normal = 30,
      speed_run = 30,
      stand_start = 0,
      stand_end = 79,
      walk_start = 168,
      walk_end = 187,
      run_start = 168,
      run_end = 187,
      punch_start = 200,
      punch_end = 219,
   },
   replace_what = {'default:torch', 'default:torch_wall', 'default:torch_ceiling'},
   do_custom = function(self)
      search_replace2(
      self,
      10, --search_rate
      1, --search_rate_above
      1, --search_rate_below
      1, --search_offset
      2, --search_offset_above
      1, --search_offset_below
      5, --replace_rate
      {'default:torch', 'default:torch_wall', 'default:torch_ceiling'}, --replace_what
      'air') --replace_with
   end,
})

mobs:spawn({
   name = 'fantasy_mobs:goblin',
   nodes = {'default:mossycobble'},
   max_light = 13,
   min_height = -31000,
   max_height = -10,
   interval = 30,
   chance = 250,
   active_object_count = 10,
})
