function maxhp.get_maxhp(player)
   local name = player:get_player_name()
	return tonumber(maxhp.storage:get_string(name..'_max_hp'))
end

function maxhp.max_hp_change(player, change, cap)
   local cap = cap or 500
   local name = player:get_player_name()
   local max_hp = maxhp.get_maxhp(player)
   local new_max_hp = max_hp + change
   if new_max_hp <= cap then
      player:set_properties({hp_max = new_max_hp})
      maxhp.storage:set_string(name..'_max_hp', new_max_hp)
      return true
   else
      return false
   end
end
