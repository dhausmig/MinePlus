if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
maxhp = {}
maxhp.storage = minetest.get_mod_storage()

dofile(minetest.get_modpath('maxhp')..'/functions.lua')
dofile(minetest.get_modpath('maxhp')..'/potions.lua')

minetest.register_on_joinplayer(function(player)
   local name = player:get_player_name()
   local max_hp = tonumber(maxhp.storage:get_string(name..'_max_hp'))
   if max_hp == nil then
      maxhp.storage:set_string(name..'_max_hp', 20)
      player:set_properties({hp_max = 20})
   else
      player:set_properties({hp_max = max_hp})
   end
end)

minetest.register_on_dieplayer(function(player)
   local name = player:get_player_name()
   local max_hp = tonumber(maxhp.storage:get_string(name..'_max_hp'))
   local new_max_hp = max_hp - 1
   if new_max_hp >= 25 then
      player:set_properties({hp_max = new_max_hp})
      maxhp.storage:set_string(name..'_max_hp', new_max_hp)
   end
end)
