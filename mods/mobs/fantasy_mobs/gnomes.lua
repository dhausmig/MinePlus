mobs:register_mob('fantasy_mobs:gnome', {
   description = 'Gnome',
   type = 'npc',
   passive = false,
   damage = 2,
   damage_max = 8,
   damage_chance = 85,
   attack_monsters = false,
   attack_type = 'dogfight',
   hp_min = 40,
   hp_max = 50,
   armor = 100,
   light_damage = 3,
   light_damage_min = 0,
   light_damage_max = 8,
   collisionbox = {-.2,-.3,-.2, .2,.6,.2},
   visual = 'mesh',
   mesh = 'fantasy_gnome.b3d',
      textures = {
         {'fantasy_gnome_blue.png'},
         {'fantasy_gnome_green.png'},
         {'fantasy_gnome_orange.png'},
         {'fantasy_gnome_purple.png'},
         {'fantasy_gnome_red.png'},
      },
   visual_size = {x = 5, y = 5},
   stay_near = 'group:flower',
   follow = {'mobs:honey', 'xdecor:honey'},
   replace_rate = 10,
   replace_what = {
--      {'epic:scorched_dirt', 'default:dirt', 0},
      {'group:fruit', 'air', 0},
   },
   walk_velocity = .5,
   run_velocity = 1,
   water_damage = 1,
   lava_damage = 2,
   view_range = 5,
   animation = {
      stand_start = 0,
      stand_end = 1,
      walk_start = 0,
      walk_end = 50,
      punch_start = 0,
      punch_end = 60,
   },
   sounds = {
      random = "gnome_happy",
      attack = "gnome_angry",
      damage = "gnome_confused",
      distance = 5,
   },
   drops = {
      {name = 'bonemeal:bonemeal', chance = 40, min = 1, max = 3},
      {name = 'default:grass_1', chance = 10, min = 1, max = 7},
--      {name = 'stations:scroll_coffee_grounds', chance = 20, min = 1, max = 1},
--      {name = 'illuminati:cone_off', chance = 250, min = 0, max = 1},
--      {name = 'illuminati:core_off', chance = 250, min = 0, max = 1},
   },
   runaway_from = {'mobs_animal:kitten'},
   do_custom = function(self, dtime)
      self.dtime = (self.dtime or 0) + dtime
      if self.dtime < 60 then
         return
      end
      self.dtime = 0
      local gnome_pos = self.object:get_pos()
      local pos = {x=gnome_pos.x, y=gnome_pos.y - 1, z=gnome_pos.z}
      bonemeal:on_use(pos, 1)
      bonemeal:on_use(gnome_pos, 3)
   end,
   on_rightclick = function(self, clicker)
      if mobs:feed_tame(self, clicker, 12, false, false) then return end
      if mobs:capture_mob(self, clicker, 1, 95, 0, false, 'fantasy_mobs:gnome') then return end
   end,
})

mobs:spawn({
   name = 'fantasy_mobs:gnome',
   nodes = {'default:dirt_with_grass'},
   min_height = -3,
   max_height = 150,
   interval = 93,
   chance = 5000,
   active_object_count = 4,
})

mobs:register_egg('fantasy_mobs:gnome', 'Gnome', 'fantasy_gnome_inv.png', 0, true)
