if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

local MP = minetest.get_modpath("keyring")

keyring = {}

-- mod information
keyring.mod = {version = "1.2.5", author = "Louis Royer"}

-- keyring settings
keyring.settings =
	{
		personal_keyring = minetest.settings:get_bool("keyring.personal_keyring", true),
		playerfactions = minetest.settings:get_bool("keyring.playerfactions", true),
		override_default_can_interact_with_node = minetest.settings:get_bool(
			"keyring.override_default_can_interact_with_node", true),
	}

-- disable playerfactions if not loaded
if not minetest.get_modpath("playerfactions") then
	keyring.settings.playerfactions = false
end

-- XXX: when https://github.com/minetest/minetest/pull/7377
--      is merged, we can remove this function and %s/keyring\.log/minetest\.log/g
keyring.log = function(level, text)
	local prefix = "[keyring] "
	if text then
		minetest.log(level, prefix..text)
	else
		minetest.log(prefix..level)
	end
end

if keyring.settings.override_default_can_interact_with_node then
	dofile(MP.."/override_default_can_interact_with_node.lua")
end
dofile(MP.."/privileges.lua")
dofile(MP.."/meta_fields.lua")
dofile(MP.."/formspec.lua")
dofile(MP.."/craft_common.lua")
dofile(MP.."/craft_keyring.lua")
if keyring.settings.personal_keyring then
	dofile(MP.."/craft_personal_keyring.lua")
end
