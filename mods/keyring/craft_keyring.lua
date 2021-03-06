-- Translation support
local S = minetest.get_translator("keyring")

keyring.form.register_allowed("keyring:keyring", {
	remove_key = true,
	rename_key = true,
	set_owner = false,
	share = false,
	title_tab = false,
})

minetest.register_craftitem("keyring:keyring", {
	description = S("Keyring"),
	inventory_image = "keyring_keyring.png",
	-- mimic a key
	groups = {key = 1, key_container = 1},
	stack_max = 1,
	on_place = keyring.craft_common.keyring_on_place,

	-- on left click
	on_use = function(itemstack, placer, pointed_thing)
		local pos = pointed_thing.under
		if pos then
			itemstack = keyring.craft_common.select_key(
				itemstack, placer, minetest.get_meta(pos))
		else -- no node pointed
			itemstack = keyring.form.formspec(itemstack, placer)
		end
		return itemstack
	end,
	on_secondary_use = function(itemstack, placer, pointed_thing)
		return keyring.form.formspec(itemstack, placer)
	end,
	-- mod doc
	_doc_items_longdesc = S("A keyring to store your keys."),
	_doc_items_usagehelp = S("Left-click on a locked node to select a key, "
		.."then works as a regular key. "
		.."Some nodes support right-clicking to select key and open at once.\n"
		.."Click pointing no node to access key-management interface "
		.."(keys can be renamed or taken off).\n"
		.."Some crafts let you add keys to the keyring."),
})


-- craft with wire
minetest.register_craft({
	output = "keyring:keyring",
	recipe = {
		{ "",           "group:wire", ""           },
		{ "group:wire", "group:key",  "group:wire" },
		{ "",           "group:wire", ""           },
	},
})
-- craft with 4 group:key
-- to make the adding of keys in keyring easier (but at a cost)
minetest.register_craft({
	output = "keyring:keyring",
	recipe = {
		{ "group:key",  "group:wire", "group:key"  },
		{ "group:wire", "",           "group:wire" },
		{ "group:key",  "group:wire", "group:key"  },
	},
})


-- craft to add a key
minetest.register_craft({
	output = "keyring:keyring",
	recipe = { "keyring:keyring", "group:key" },
	type = "shapeless",
})
minetest.register_craft({
	output = "keyring:keyring",
	recipe = { "keyring:keyring", "group:key_container" },
	type = "shapeless",
})
