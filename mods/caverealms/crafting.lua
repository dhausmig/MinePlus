--CaveRealms crafting.lua

--CRAFT ITEMS--

--mycena powder
minetest.register_craftitem("caverealms:mycena_powder", {
	description = "Mycena Powder",
	inventory_image = "caverealms_mycena_powder.png",
})

--CRAFT RECIPES--

--mycena powder
minetest.register_craft({
	output = "caverealms:mycena_powder",
	type = "shapeless",
	recipe = {"caverealms:mycena"}
})


--glow mese block
minetest.register_craft({
	output = "caverealms:glow_mese",
	recipe = {
		{"default:mese_crystal_fragment","default:mese_crystal_fragment","default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment","caverealms:mycena_powder","default:mese_crystal_fragment"},
		{"default:mese_crystal_fragment","default:mese_crystal_fragment","default:mese_crystal_fragment"}
	}
})

--reverse craft for glow mese
minetest.register_craft({
	output = "default:mese_crystal_fragment 8",
	type = "shapeless",
	recipe = {"caverealms:glow_mese"}
})

--thin ice to water
minetest.register_craft({
	output = "default:water_source",
	type = "shapeless",
	recipe = {"caverealms:thin_ice"}
})

--use for coal dust
minetest.register_craft({
	output = "default:coalblock",
	recipe = {
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"},
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"},
		{"caverealms:coal_dust","caverealms:coal_dust","caverealms:coal_dust"}
	}
})

-- lava from Glow Obsidian
minetest.register_craft({
   output = "bucket:bucket_lava",
	recipe = {{"caverealms:glow_obsidian_2", "caverealms:glow_obsidian_2", "caverealms:glow_obsidian_2"},
		{"caverealms:glow_obsidian_2", "bucket:bucket_empty", "caverealms:glow_obsidian_2"},
		{"caverealms:glow_obsidian_2", "caverealms:glow_obsidian_2", "caverealms:glow_obsidian_2"}
	},
	replacements = {
		{ "caverealms:glow_obsidian_2", "caverealms:glow_obsidian" },
		{ "caverealms:glow_obsidian_2", "caverealms:glow_obsidian" },
		{ "caverealms:glow_obsidian_2", "caverealms:glow_obsidian" },
		{ "caverealms:glow_obsidian_2", "caverealms:glow_obsidian" },
		{ "caverealms:glow_obsidian_2", "caverealms:glow_obsidian" },
		{ "caverealms:glow_obsidian_2", "caverealms:glow_obsidian" },
		{ "caverealms:glow_obsidian_2", "caverealms:glow_obsidian" },
		{ "caverealms:glow_obsidian_2", "caverealms:glow_obsidian" }
	}
})

minetest.register_craft({
   output = "bucket:bucket_lava",
	recipe = {{"caverealms:glow_obsidian", "caverealms:glow_obsidian", "caverealms:glow_obsidian"},
		{"caverealms:glow_obsidian", "bucket:bucket_empty", "caverealms:glow_obsidian"},
		{"caverealms:glow_obsidian", "caverealms:glow_obsidian", "caverealms:glow_obsidian"}
	},
	replacements = {
		{ "caverealms:glow_obsidian", "default:obsidian" },
		{ "caverealms:glow_obsidian", "default:obsidian" },
		{ "caverealms:glow_obsidian", "default:obsidian" },
		{ "caverealms:glow_obsidian", "default:obsidian" },
		{ "caverealms:glow_obsidian", "default:obsidian" },
		{ "caverealms:glow_obsidian", "default:obsidian" },
		{ "caverealms:glow_obsidian", "default:obsidian" },
		{ "caverealms:glow_obsidian", "default:obsidian" }
	}
})

minetest.register_craft({
	output = "caverealms:glow_obsidian_2 8",
	recipe = {{"caverealms:glow_obsidian", "caverealms:glow_obsidian", "caverealms:glow_obsidian"},
		{"caverealms:glow_obsidian", "bucket:bucket_lava", "caverealms:glow_obsidian"},
		{"caverealms:glow_obsidian", "caverealms:glow_obsidian", "caverealms:glow_obsidian"}
	},
	replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}}
})

minetest.register_craft({
	output = "caverealms:glow_obsidian 8",
	recipe = {{"default:obsidian", "default:obsidian", "default:obsidian"},
		{"default:obsidian", "bucket:bucket_lava", "default:obsidian"},
		{"default:obsidian", "default:obsidian", "default:obsidian"}
	},
	replacements = {{"bucket:bucket_lava", "bucket:bucket_empty"}}
})

