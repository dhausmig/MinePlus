local S = minetest.get_translator("default")

	minetest.register_craftitem("default:oil_extract", {
		    description = "Oil extract",
		    inventory_image = "default_oil_extract.png",
	})

	minetest.register_craftitem("default:paraffin", {
		    description = "Unprocessed paraffin",
		    inventory_image = "default_paraffin.png",
	})


	minetest.register_craftitem("default:plastic_sheet", {
		    description = "Plastic sheet",
		    inventory_image = "default_plastic_sheet.png",
	})

minetest.register_craftitem("default:plastic_strip", {
	description = S("Plastic strips"),
	groups = { strip = 1 },
	inventory_image = "default_plastic_strip.png",
})

	minetest.register_craft({
		type = "shapeless",
		output = "default:oil_extract 4",
		recipe = {
			"group:leaves",
			"group:leaves",
			"group:leaves",
			"group:leaves",
			"group:leaves",
			"group:leaves"
		}
	})

	minetest.register_craft({
		    type = "cooking",
		    output = "default:paraffin",
		    recipe = "default:oil_extract",
	})

	minetest.register_craft({
		    type = "cooking",
		    output = "default:plastic_sheet",
		    recipe = "default:paraffin",
	})

	minetest.register_craft({
		    type = "fuel",
		    recipe = "default:oil_extract",
		    burntime = 30,
	})

	minetest.register_craft({
		    type = "fuel",
		    recipe = "default:paraffin",
		    burntime = 30,
	})

	minetest.register_craft({
		    type = "fuel",
		    recipe = "default:plastic_sheet",
		    burntime = 30,
	})

minetest.register_craft( {
    output = "default:plastic_strip 9",
    recipe = {
		{ "default:plastic_sheet", "default:plastic_sheet", "default:plastic_sheet" }
    },
})
