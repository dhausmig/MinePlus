--larva.lua (fantasy_mobs)

mobs:register_mob('fantasy_mobs:larva', {
   description = 'Larva',
   type = 'monster',
   damage = 30,
   damage_max = 36,
   damage_chance = 100,
   attack_type = 'dogfight',
   hp_min = 40,
   hp_max = 100,
   armor = 75,
   collisionbox = {-.35,-.05,-.35,.35,.3,.35},
   visual = 'mesh',
   mesh = 'fantasy_larva.b3d',
      textures = {
         {'fantasy_larva.png'},
      },
   visual_size = {x = 10, y = 10},
   walk_velocity = 1,
   run_velocity = 3,
   water_damage = 0,
   lava_damage = 10,
   view_range = 5,
   reach = 2,
   replace_rate = 1,
   replace_what = {
      {'default:obsidian', 'fantasy_mobs:larva_egg', 0},
   },
   drops = {
      {name = 'fantasy_mobs:larva_egg', chance = 100, min = 0, max = 1},
      {name = 'maxhp:lifeforce1', chance = 10, min = 0, max = 3},
      {name = 'maxhp:lifeforce5', chance = 150, min = 0, max = 1},
   },
   runaway_from = {'fantasy_mobs:larva_pet'},
   animation = {
      walk_start = 1,
      walk_end = 59,
      punch_start = 61,
      punch_end = 100,
   },
})

mobs:register_mob('fantasy_mobs:larva_pet', {
   description = 'Larva pet',
   type = 'npc',
   passive = false,
   attack_type = 'dogfight',
   owner_loyal = true,
   pathfinding = true,
   damage = 7,
   hp_min = 20,
   hp_max = 60,
   armor = 75,
   collisionbox = {-.35,-.05,-.35,.35,.3,.35},
   visual = 'mesh',
   mesh = 'fantasy_larva.b3d',
      textures = {
         {'fantasy_larva.png'},
      },
   visual_size = {x = 10, y = 10},
   walk_velocity = 1,
   run_velocity = 3,
   water_damage = 0,
   lava_damage = 10,
   light_damage = 1,
   view_range = 5,
   fear_height = 2,
   follow = 'default:obsidian_shard',
   owner = '',
   order = 'follow',
   reach = 2,
   animation = {
      walk_start = 1,
      walk_end = 59,
      punch_start = 61,
      punch_end = 100,
   },
   on_spawn = function(self)
      local pos = self.object:get_pos()
      local objs = minetest.get_objects_inside_radius(pos, 4)
      for _, obj in pairs(objs) do
         if obj:is_player() then
            local owner = obj:get_player_name()
            self.owner = owner
            minetest.chat_send_player(owner, "Eww, a nether larva think you're its parent, gross.")
         end
      end
      return true
   end,

   on_rightclick = function(self, clicker)
      local name = clicker:get_player_name()
      if mobs:feed_tame(self, clicker, 10, false, true) then
         return
      end
      if mobs:protect(self, clicker) then return end
      if self.owner and self.owner == name then
         if self.order == 'follow' then
            self.order = 'stand'
            minetest.chat_send_player(name, ('Larva holding ground.'))
         else
            self.order = 'follow'
            minetest.chat_send_player(name, ('Larva following you.'))
         end
         mobs:capture_mob(self, clicker, 20, 0, 100, false, nil)
      end
   end,
})

mobs:spawn({
   name = 'fantasy_mobs:larva',
   nodes = {'nether:rack'},
   min_height = -31000,
   max_height = -5000,
   interval = 31,
   chance = 2000,
   active_object_count = 15,
})

minetest.register_node('fantasy_mobs:larva_egg', {
   description = 'Larva egg',
   drawtype = 'mesh',
   mesh = 'fantasy_mobs_larva_egg.obj',
   tiles = {'fantasy_larva.png'},
	use_texture_alpha = "clip",
   paramtype = 'light',
   groups = {oddly_breakable_by_hand=1},
   selection_box = {
      type = 'fixed',
      fixed = {-.2, -.5, -.2, .2, -.1, .2}, -- Right, Bottom, Back, Left, Top, Front
      },
   collision_box = {
      type = 'fixed',
      fixed = {-.2, -.5, -.2, .2, -.1, .2}, -- Right, Bottom, Back, Left, Top, Front
      },
   on_construct = function(pos)
      local fpos, num = minetest.find_nodes_in_area(
      {x = pos.x+2, y = pos.y, z = pos.z+2},
      {x = pos.x-2, y = pos.y-1, z = pos.z-2},
      'nether:sand')
      if #fpos >= 9 then
         if pos.y > 0 then
            local timer = minetest.get_node_timer(pos)
            timer:start(300)
         end
      end
   end,
   on_timer = function(pos)
      minetest.add_entity(pos, 'fantasy_mobs:larva_pet')
      minetest.remove_node(pos)
   end,
})

mobs:register_egg('fantasy_mobs:larva_pet', 'Nether Larva', 'fantasy_mobs_larva_pet.png', 0, true)
