if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
playtime = {}

local storage = minetest.get_mod_storage()

function playtime.get_current_playtime(name)
  return os.time() - storage:get_int(name.."-join")
end

--  Function to get playtime
function playtime.get_total_playtime(name)
  return storage:get_int(name.."-total") + playtime.get_current_playtime(name)
end

minetest.register_on_leaveplayer(function(player)
  local name = player:get_player_name()
  storage:set_int(name.."-total", playtime.get_total_playtime(name))
end)

minetest.register_on_shutdown(function()
	for _, player in pairs(minetest.get_connected_players()) do
	local name = player:get_player_name()
	storage:set_int(name.."-total", playtime.get_total_playtime(name))
	end
end)


minetest.register_on_joinplayer(function(player)
  local name = player:get_player_name()
  storage:set_int(name.."-join", os.time())
end)

local function SecondsToClock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
    return "00:00:00";
  else
    local hours = string.format("%02.f", math.floor(seconds/3600));
    local mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
    local secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
    return hours..":"..mins..":"..secs
  end
end

minetest.register_chatcommand("played", {
  params = "",
  description = "Use it to get your own playtime!",
  func = function(name)
    minetest.chat_send_player(name, "Total: "..SecondsToClock(playtime.get_total_playtime(name)).." Current: "..SecondsToClock(playtime.get_current_playtime(name)))
  end,
})
