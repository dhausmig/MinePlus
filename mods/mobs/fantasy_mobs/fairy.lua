drops = {
--   'stations:scroll_teleport', 'stations:scroll_healing', 'stations:scroll_bloodstone_powder',
--   'stations:scroll_anti_fire', 'stations:scroll_chitin', 'stations:scroll_sulfur_dust',
--   'stations:scroll_gunpowder', 'stations:scroll_poison', 'epic:deed',
		'multidimensions:dimension_disc',
}

mobs:register_mob('fantasy_mobs:fairy', {
   description = 'Fairy',
   type = 'npc',
   passive = false,
   damage = 200,
   damage_max = 800,
   damage_chance = 1000,
   attack_monsters = true,
   attack_type = 'dogfight',
   hp_min = 400,
   hp_max = 500,
   armor = 5,
   collisionbox = {-.2,.7,-.2, .2,1.1,.2},
   visual = 'mesh',
   mesh = 'fantasy_fairy.b3d',
      textures = {
         {'fantasy_fairy.png'},
      },
   visual_size = {x = 4, y = 4},
   glow = 14,
   fly = true,
   fly_in = 'air',
   stand_chance = 0,
   stay_near = 'group:flower',
   replace_rate = 1,
   replace_what = {'group:flower'},
   replace_with = 'fantasy_mobs:fairy_mushroom',
   walk_velocity = .25,
   run_velocity = .5,
   water_damage = 100,
   lava_damage = 200,
   light_damage = 200,
   view_range = 5,
   animation = {
      fly_start = 0,
      fly_end = 60,
      stand_start = 0,
      stand_end = 60,
      punch_start = 0,
      punch_end = 60,
   },
   on_rightclick = function(self, clicker)
      local item = clicker:get_wielded_item()
      local pos = self.object:get_pos()
      local player_name = clicker:get_player_name()
      if item:get_name() == 'fantasy_mobs:fairy_mushroom' then
         minetest.add_item(pos, {name = drops[math.random(1, #drops)]})
         item:take_item(1)
         clicker:set_wielded_item(item)
      else
         minetest.chat_send_player(player_name, 'you fool, die!')
         clicker:set_hp(-50)
      end
   end,
})

mobs:spawn({
   name = 'fantasy_mobs:fairy',
   nodes = {'group:flower'},
   neighbors = 'default:dirt_with_grass',
   max_light = 8,
   min_height = -3,
   max_height = 150,
   interval = 30,
   chance = 200,
   active_object_count = 1,
})

--nodes
minetest.register_node('fantasy_mobs:fairy_mushroom', {
   description = 'Fairy mushroom',
   drawtype = 'plantlike',
   tiles = {'fantasy_mushrooms.png'},
   groups = { snappy=3, flammable=2, flower=1, flora=1, attached_node=1, not_in_creative_inventory=1},
   sunlight_propagates = true,
   waving = 1,
   walkable = false,
   pointable = true,
   diggable = true,
   buildable_to = true,
   paramtype = 'light',
   light_source = 4,
   sounds = default.node_sound_leaves_defaults(),
   selection_box = {
      type = 'fixed',
      fixed = { -0.4, -0.5, -0.4, 0.4, 0.0, 0.4 },
   },
})

minetest.register_abm({
   label = 'fairy mushroom removal',
   nodenames = {'fantasy_mobs:fairy_mushroom'},
   interval = 100,
   chance = 10,
   action = function(pos, node)
      minetest.remove_node(pos)
   end,
})
