
local S = farming.intllib


--= Sugar

minetest.register_craftitem("food:sugar", {
	description = S("Sugar"),
	inventory_image = "food_sugar.png",
	groups = {food_sugar = 1, flammable = 3}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "food:sugar 2",
	recipe = "default:papyrus"
})

--= Salt

minetest.register_node("food:salt", {
	description = S("Salt"),
	inventory_image = "food_salt.png",
	wield_image = "food_salt.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"food_salt.png"},
	groups = {food_salt = 1, vessel = 1, dig_immediate = 3,
			attached_node = 1},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "food:salt",
	recipe = "bucket:bucket_water",
	replacements = {{"bucket:bucket_water","bucket:bucket_empty" }}
})

-- milk

minetest.register_craftitem("food:bottle_milk", {
	description = S("Bottle of Milk"),
	inventory_image = "food_bottle_milk.png",
	on_use = minetest.item_eat(2, 'vessels:glass_bottle' ),
	groups = {food_milk = 1,},
})

minetest.register_craft({
	type = "shapeless",
	output = "food:bottle_milk 4",
	recipe = {"group:milkbucket", "vessels:glass_bottle", "vessels:glass_bottle" ,"vessels:glass_bottle", "vessels:glass_bottle"},
	replacements = {{ "group:milkbucket", "bucket:bucket_empty"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "mobs:bucket_milk",
	recipe = {"bucket:bucket_empty", "food:bottle_milk", "food:bottle_milk", "food:bottle_milk", "food:bottle_milk"},
	replacements = {
		{ "food:bottle_milk", "vessels:glass_bottle"},
		{ "food:bottle_milk", "vessels:glass_bottle"},
		{ "food:bottle_milk", "vessels:glass_bottle"},
		{ "food:bottle_milk", "vessels:glass_bottle"}
	},
})

minetest.register_craftitem(":food:milk_glass", {
	description = S("Glass of Milk"),
	inventory_image = "food_milk_glass.png",
	on_use = minetest.item_eat(1, 'vessels:drinking_glass' ),
	groups = {food_milk = 1, food_milk_glass = 1,},
})

minetest.register_craft({
	type = "shapeless",
	output = "food:milk_glass 2",
	recipe = {"food:bottle_milk", "vessels:drinking_glass", "vessels:drinking_glass" },
	replacements = {{ "food:bottle_milk", "vessels:glass_bottle"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "food:bottle_milk",
	recipe = {"vessels:glass_bottle", "food:milk_glass", "food:milk_glass"},
	replacements = {
		{ "food:milk_glass", "vessels:drinking_glass"},
		{ "food:milk_glass", "vessels:drinking_glass"},
	},
})

-- flour

minetest.register_craftitem("food:flour", {
	description = S("Flour"),
	inventory_image = "food_flour.png",
	groups = {food_flour = 1, flammable = 1}
})

minetest.register_craftitem("food:rice_flour", {
	description = S("Rice Flour"),
	inventory_image = "food_rice_flour.png",
	groups = {food_rice_flour = 1, flammable = 1}
})

-- Multigrain flour

minetest.register_craftitem("food:flour_multigrain", {
	description = S("Multigrain Flour"),
	inventory_image = "food_flour_multigrain.png",
	groups = {food_flour = 1, flammable = 1},
})

if (food.utensils) then

   minetest.register_craft({
      type = "shapeless",
      output = "food:flour",
      recipe = {
         "farming:wheat", "farming:wheat", "farming:wheat",
         "farming:wheat", "food:mortar_pestle"
      },
      replacements = {{"group:food_mortar_pestle", "food:mortar_pestle"}}
   })

   minetest.register_craft({
	   type = "shapeless",
	   output = "food:rice_flour 2",
	   recipe = {
		   "farming:rice", "farming:rice", "farming:rice", "farming:rice",
		   "food:mortar_pestle"
	   },
	   replacements = {{"group:food_mortar_pestle", "food:mortar_pestle"}}
   })

   minetest.register_craft({
	   type = "shapeless",
	   output = "food:flour_multigrain",
	   recipe = {
		   "farming:wheat", "farming:barley", "farming:oat",
		   "farming:rye", "food:mortar_pestle"
	   },
	   replacements = {{"group:food_mortar_pestle", "food:mortar_pestle"}}
   })

else

   minetest.register_craft({
	   type = "shapeless",
	   output = "food:flour",
	   recipe = {
		   "farming:barley", "farming:barley", "farming:barley",
		   "farming:barley"
	   },
   })

   minetest.register_craft({
	   type = "shapeless",
	   output = "food:flour",
	   recipe = {
		   "farming:oat", "farming:oat", "farming:oat", "farming:oat"
	   },
   })

   minetest.register_craft({
	   type = "shapeless",
	   output = "food:flour",
	   recipe = {
		   "farming:rye", "farming:rye", "farming:rye", "food:rye",
	   },
   })

   minetest.register_craft({
      type = "shapeless",
      output = "food:flour",
      recipe = {
         "farming:wheat", "farming:wheat", "farming:wheat",
         "farming:wheat"
      },
   })

   minetest.register_craft({
	   type = "shapeless",
	   output = "food:rice_flour 2",
	   recipe = {
		   "farming:rice", "farming:rice", "farming:rice", "farming:rice",
	   },
   })

   minetest.register_craft({
	   type = "shapeless",
	   output = "food:flour_multigrain",
	   recipe = {
		   "farming:wheat", "farming:barley", "farming:oat",
		   "farming:rye"
	   },
   })

end

-- bread

minetest.register_craftitem("food:bread", {
	description = S("Bread"),
	inventory_image = "food_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_bread = 1, flammable = 2}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "food:bread",
	recipe = "food:flour"
})

-- rice bread

minetest.register_craftitem("food:rice_bread", {
	description = S("Rice Bread"),
	inventory_image = "food_rice_bread.png",
	on_use = minetest.item_eat(5),
	groups = {food_rice_bread = 1, flammable = 2}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "food:rice_bread",
	recipe = "food:rice_flour"
})

minetest.register_craft({
	type = "fuel",
	recipe = "food:rice_bread",
	burntime = 1
})

-- Multigrain bread

minetest.register_craftitem("food:bread_multigrain", {
	description = S("Multigrain Bread"),
	inventory_image = "food_bread_multigrain.png",
	on_use = minetest.item_eat(7),
	groups = {food_bread = 1, flammable = 2}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "food:bread_multigrain",
	recipe = "food:flour_multigrain"
})

minetest.register_craft({
	type = "fuel",
	recipe = "food:bread_multigrain",
	burntime = 1
})

-- sliced bread
minetest.register_craftitem("food:bread_slice", {
	description = S("Sliced Bread"),
	inventory_image = "food_bread_slice.png",
	on_use = minetest.item_eat(1),
	groups = {food_bread_slice = 1, flammable = 2}
})

if (food.utensils) then

minetest.register_craft({
	type = "shapeless",
	output = "food:bread_slice 5",
	recipe = {"food:bread", "group:food_cutting_board"},
	replacements = {{"group:food_cutting_board", "food:cutting_board"}}
})

else

minetest.register_craft({
	type = "shapeless",
	output = "food:bread_slice 5",
	recipe = {"food:bread"},
})

end

-- toast
minetest.register_craftitem("food:toast", {
	description = S("Toast"),
	inventory_image = "food_toast.png",
	on_use = minetest.item_eat(1),
	groups = {food_toast = 1, flammable = 2}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 3,
	output = "food:toast",
	recipe = "food:bread_slice"
})

-- toast sandwich
minetest.register_craftitem("food:toast_sandwich", {
	description = S("Toast Sandwich"),
	inventory_image = "food_toast_sandwich.png",
	on_use = minetest.item_eat(4),
	groups = {flammable = 2}
})

minetest.register_craft({
	output = "food:toast_sandwich",
	recipe = {
		{"food:bread_slice"},
		{"food:toast"},
		{"food:bread_slice"}
	}
})

-- butter

minetest.register_craftitem("food:butter", {
	description = S("Butter"),
	inventory_image = "food_butter.png",
	on_use = minetest.item_eat(2),
	groups = {food_butter = 1, flammable = 2},
})

minetest.register_craft({
	type = "shapeless",
	output = "food:butter 4",
	recipe = {"group:milkbucket", "food:salt"},
	replacements = {{ "group:milkbucket", "bucket:bucket_empty"}},
})

minetest.register_craft({
	type = "shapeless",
	output = "food:butter",
	recipe = {"food:bottle_milk", "food:salt"},
	replacements = {{"food:bottle_milk" , "vessels:glass_bottle"}},
})

--= Cheese
-- cheese wedge

minetest.register_craftitem(":food:cheese", {
	description = S("Cheese"),
	inventory_image = "food_cheese.png",
	on_use = minetest.item_eat(4),
	groups = {food_cheese = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "food:cheese 4",
	recipe = "group:milkbucket",
	cooktime = 5,
	replacements = {{"group:milkbucket", "bucket:bucket_empty"}}
})

minetest.register_craft({
	type = "cooking",
	output = "food:cheese",
	recipe = "food:bottle_milk",
	cooktime = 2,
	replacements = {{"food:bottle_milk", "vessels:glass_bottle"}}
})

-- cheese block

minetest.register_node(":food:cheeseblock", {
	description = S("Cheese Block"),
	tiles = {"food_cheeseblock.png"},
	is_ground_content = false,
	groups = {crumbly = 3},
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_craft({
	output = "food:cheeseblock",
	recipe = {
		{'food:cheese', 'food:cheese', 'food:cheese'},
		{'food:cheese', 'food:cheese', 'food:cheese'},
		{'food:cheese', 'food:cheese', 'food:cheese'},
	}
})

minetest.register_craft({
	output = "food:cheese 9",
	recipe = {
		{'food:cheeseblock'},
	}
})

-- cooked meat
minetest.register_craftitem("food:meat", {
	description = S("Meat"),
	inventory_image = "food_meat.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, flammable = 2}
})

minetest.register_craft({
	type = "cooking",
	output = "food:meat",
	recipe = "mobs:meat_raw",
	cooktime = 5
})

-- cooked porkchop
minetest.register_craftitem("food:pork_cooked", {
	description = S("Cooked Porkchop"),
	inventory_image = "food_pork_cooked.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, food_pork = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "food:pork_cooked",
	recipe = "mobs:pork_raw",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "food:pork_cooked",
	recipe = "animalworld:pork_raw",
	cooktime = 5,
})

-- cooked mutton
minetest.register_craftitem("food:mutton_cooked", {
	description = S("Cooked Mutton"),
	inventory_image = "food_mutton_cooked.png",
	on_use = minetest.item_eat(6),
	groups = {food_meat = 1, food_mutton = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "food:mutton_cooked",
	recipe = "mobs:mutton_raw",
	cooktime = 5,
})

-- cooked rat, yummy!
minetest.register_craftitem("food:rat_cooked", {
	description = S("Cooked Rat"),
	inventory_image = "food_cooked_rat.png",
	on_use = minetest.item_eat(3),
	groups = {food_rat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "food:rat_cooked",
	recipe = "mobs_animal:rat",
	cooktime = 5,
})

-- fried egg
minetest.register_craftitem("food:chicken_egg_fried", {
	description = S("Fried Egg"),
	inventory_image = "food_chicken_egg_fried.png",
	on_use = minetest.item_eat(2),
	groups = {food_egg_fried = 1, flammable = 2},
})

minetest.register_craft({
	type  =  "cooking",
	output = "food:chicken_egg_fried",
	recipe  = "group:food_egg",
})

-- cooked chicken
minetest.register_craftitem("food:chicken_cooked", {
description = S("Cooked Chicken"),
	inventory_image = "food_chicken_cooked.png",
	on_use = minetest.item_eat(6),
	groups = {food_meat = 1, food_chicken = 1, flammable = 2},
})

minetest.register_craft({
	type  =  "cooking",
	output = "food:chicken_cooked",
	recipe  = "mobs:chicken_raw",
})

minetest.register_craft({
	type  =  "cooking",
	output = "food:chicken_cooked",
	recipe  = "animalworld:chicken_raw",
})

-- cooked rabbit
minetest.register_craftitem("food:rabbit_cooked", {
	description = S("Cooked Rabbit"),
	inventory_image = "food_rabbit_cooked.png",
	on_use = minetest.item_eat(5),
	groups = {food_meat = 1, food_rabbit = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "food:rabbit_cooked",
	recipe = "mobs:rabbit_raw",
	cooktime = 5,
})

minetest.register_craft({
	type = "cooking",
	output = "food:rabbit_cooked",
	recipe = "animalworld:rabbit_raw",
	cooktime = 5,
})

-- Cooked Fish
minetest.register_craftitem("food:fish_cooked", {
	description = S("Cooked Fish"),
	inventory_image = "fish_cooked.png",
	wield_image = "fish_cooked.png",
	groups = {food_fish = 1, flammable = 3},
	on_use = minetest.item_eat(5),
})

minetest.register_craft({
	type = "cooking",
	output = "food:fish_cooked",
	recipe = "mobs:fish_raw",
	cooktime = 2,
})

minetest.register_craft({
	type = "cooking",
	output = "food:fish_cooked",
	recipe = "animalworld:rawfish",
	cooktime = 5,
})

-- cooked mollusk
minetest.register_craftitem("food:cookedmollusk", {
	description = ("Fried Mollusk"),
	inventory_image = "food_cookedmollusk.png",
	on_use = minetest.item_eat(5),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "food:cookedmollusk",
	recipe = "animalworld:rawmollusk",
	cooktime = 5,
})

-- escargot
minetest.register_craftitem("food:escargots", {
	description = ("Escargots"),
	inventory_image = "food_escargots.png",
	on_use = minetest.item_eat(5),
	groups = {food_meat_raw = 1, flammable = 2},
})

minetest.register_craft({
	output = "food:escargots",
	type = "shapeless",
	recipe = 
		{"animalworld:snail", "farming:garlic_clove", "food:butter", "food:bread"}
})

-- roasted locust (yum)
minetest.register_craftitem("food:locust_roasted", {
	description = ("Roasted Locust"),
	inventory_image = "food_locust_roasted.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "food:locust_roasted",
	recipe = "animalworld:locust",
	cooktime = 2,
})

--[[
-- Sashimi (Thanks to Natalia Grosner for letting me use the sashimi image)
minetest.register_craftitem("food:sashimi", {
	description = S("Sashimi"),
	inventory_image = "sashimi.png",
	wield_image = "sashimi.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	output = "mobs:sashimi 2",
	recipe = {
		{'group:food_seaweed','group:food_fish_raw','group:food_seaweed'},
	}
})
--]]
-- honey block
minetest.register_node("food:honey_block", {
	description = S("Honey Block"),
	tiles = {"food_honey_block.png"},
	groups = {snappy = 3, flammable = 2},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	output = "food:honey_block",
	recipe = {
		{"mobs:honey", "mobs:honey", "mobs:honey"},
		{"mobs:honey", "mobs:honey", "mobs:honey"},
		{"mobs:honey", "mobs:honey", "mobs:honey"},
	}
})

minetest.register_craft({
	output = "mobs:honey 9",
	recipe = {
		{"food:honey_block"},
	}
})

minetest.register_craftitem("food:acorn_muffin_batter", {
	description = S("Acorn Muffin batter"),
	inventory_image = "food_acorn_muffin_batter.png",
})

minetest.register_craftitem("food:acorn_muffin", {
	description = S("Acorn Muffin"),
	inventory_image = "food_acorn_muffin.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "shapeless",
	output = "food:acorn_muffin_batter",
	recipe = {
		"group:acorn",
		"group:acorn",
		"group:acorn",
		"group:acorn",
		"food:coconut_milk",
	},
	replacements = {
		{ "food:coconut_milk", "vessels:drinking_glass" }
	}
})

minetest.register_craft({
	type = "cooking",
	output = "food:acorn_muffin 4",
	recipe = "food:acorn_muffin_batter",
})

-- blueberry muffin (thanks to sosogirl123 @ deviantart.com for muffin image)
minetest.register_craftitem("food:muffin_blueberry", {
	description = S("Blueberry Muffin"),
	inventory_image = "food_blueberry_muffin.png",
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	output = "food:muffin_blueberry 2",
	recipe = {
		{"group:food_blueberries", "group:food_bread", "group:food_blueberries"}
	}
})

minetest.register_craftitem("food:cedar_nuts", {
	description = S("Roasted Cedar Cone Nuts"),
	inventory_image = "food_cedar_nuts.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	type = "cooking",
	output = "food:cedar_nuts 4",
	recipe = "moretrees:cedar_cone",
})

-- bowl of chili
minetest.register_craftitem("food:chili_bowl", {
	description = S("Bowl of Chili"),
	inventory_image = "food_chili_bowl.png",
	on_use = minetest.item_eat(8, "default:bowl")
})

minetest.register_craft({
	type = "shapeless",
	output = "food:chili_bowl",
	recipe = {
		"group:food_chili_pepper", "group:food_barley",
		"group:food_tomato", "group:food_meat", "group:food_bowl"
	}
})

minetest.register_craftitem("food:coconut_slice", {
	description = S("Coconut Slice"),
	inventory_image = "food_coconut_slice.png",
	wield_image = "food_coconut_slice.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("food:coconut_milk", {
	description = S("Coconut Milk"),
	inventory_image = "food_coconut_milk_inv.png",
	wield_image = "food_coconut_milk.png",
	on_use = minetest.item_eat(2),
})

minetest.register_craftitem("food:raw_coconut", {
	description = S("Raw Coconut"),
	inventory_image = "food_raw_coconut.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "shapeless",
	output = "food:coconut_slice 4",
	recipe = {
		"moretrees:coconut"
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "food:coconut_milk 2",
	recipe = {
		"food:coconut_slice", "vessels:drinking_glass", "vessels:drinking_glass",
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "food:raw_coconut",
	recipe = {
		"food:coconut_slice"
	}
})

-- chocolate cookie
minetest.register_craftitem("food:cookie", {
	description = S("Cookie"),
	inventory_image = "food_cookie.png",
	on_use = minetest.item_eat(2)
})

minetest.register_craft( {
	output = "food:cookie 8",
	recipe = {
		{"group:food_wheat", "group:food_cocoa", "group:food_wheat" }
	}
})

-- bar of dark chocolate
minetest.register_craftitem("food:chocolate_dark", {
	description = S("Bar of Dark Chocolate"),
	inventory_image = "food_chocolate_dark.png",
	on_use = minetest.item_eat(3)
})

minetest.register_craft( {
	output = "food:chocolate_dark",
	recipe = {
		{"group:food_cocoa", "group:food_cocoa", "group:food_cocoa"}
	}
})

-- chocolate block
minetest.register_node("food:chocolate_block", {
	description = S("Chocolate Block"),
	tiles = {"food_chocolate_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_craft({
	output = "food:chocolate_block",
	recipe = {
		{"food:chocolate_dark", "food:chocolate_dark", "food:chocolate_dark"},
		{"food:chocolate_dark", "food:chocolate_dark", "food:chocolate_dark"},
		{"food:chocolate_dark", "food:chocolate_dark", "food:chocolate_dark"}
	}
})

minetest.register_craft({
	output = "food:chocolate_dark 9",
	recipe = {
		{"food:chocolate_block"}
	}
})

-- bar of milk chocolate
minetest.register_craftitem("food:milk_chocolate", {
	description = S("Bar of Milk Chocolate"),
	inventory_image = "food_milk_chocolate.png",
	groups = {food_milk_chocolate=1},
	on_use = minetest.item_eat(3),
})

minetest.register_craft( {
	output = "food:milk_chocolate",
	recipe = {
	    {"","group:food_milk",""},
		{"group:food_cocoa", "group:food_cocoa", "group:food_cocoa"}
	},
	replacements = {
	   {"group:milkbucket", "bucket:bucket_empty"},
	   {"food:bottle_milk", "vessels:glass_bottle"},
	   {"food:milk_glass", "vessels:drinking_glass"},
	},
})

-- milk chocolate block
minetest.register_node("food:milk_chocolate_block", {
	description = S("Milk Chocolate Block"),
	tiles = {"food_milk_chocolate_block.png"},
	is_ground_content = false,
	groups = {cracky = 2, oddly_breakable_by_hand = 2},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_craft({
	output = "food:milk_chocolate_block",
	recipe = {
		{"food:milk_chocolate", "food:milk_chocolate", "food:milk_chocolate"},
		{"food:milk_chocolate", "food:milk_chocolate", "food:milk_chocolate"},
		{"food:milk_chocolate", "food:milk_chocolate", "food:milk_chocolate"}
	}
})

minetest.register_craft({
	output = "food:milk_chocolate 9",
	recipe = {
		{"food:chocolate_block"}
	}
})

-- cup of coffee
minetest.register_node("food:coffee_cup", {
	description = S("Cup of Coffee"),
	drawtype = "torchlike",
	tiles = {"food_coffee_cup.png"},
	inventory_image = "food_coffee_cup.png",
	wield_image = "food_coffee_cup.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.25, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1, drink = 1},
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	sounds = default.node_sound_glass_defaults()
})

minetest.register_alias("food:coffee_cup_hot", "food:coffee_cup")
minetest.register_alias("food:drinking_cup", "vessels:drinking_glass")

if food.utensils then
   minetest.register_craft( {
	  output = "food:coffee_cup",
	  type = "shapeless",
	  recipe = {
		 "vessels:drinking_glass", "group:food_coffee",
		 "group:water_bucket", "group:food_saucepan"},
	  replacements = {
		 {"group:water_bucket", "bucket:bucket_empty"},
		 {"group:food_saucepan", "food:saucepan"}
	  }
   })
else
   minetest.register_craft( {
	  output = "food:coffee_cup",
	  type = "shapeless",
	  recipe = {
		 "vessels:drinking_glass", "group:food_coffee",
		 "group:water_bucket"},
	  replacements = {
		 {"group:water_bucket", "bucket:bucket_empty"},
	  }
   })
end

-- corn on the cob (texture by TenPlus1)
minetest.register_craftitem("food:corn_cob", {
	description = S("Corn on the Cob"),
	inventory_image = "food_corn_cob.png",
	groups = {food_corn_cooked = 1, flammable = 2},
	on_use = minetest.item_eat(5)
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "food:corn_cob",
	recipe = "group:food_corn"
})

-- cornstarch
minetest.register_craftitem("food:cornstarch", {
	description = S("Cornstarch"),
	inventory_image = "food_cornstarch.png",
	groups = {food_cornstarch = 1, flammable = 2}
})

if food.utensils then
   minetest.register_craft({
	  output = "food:cornstarch",
	  recipe = {
		 {"group:food_mortar_pestle", "group:food_corn_cooked", "group:food_baking_tray"},
		 {"", "group:food_bowl", ""},
	  },
	  replacements = {
		 {"group:food_mortar_pestle", "food:mortar_pestle"},
		 {"group:food_baking_tray", "food:baking_tray"},
	  }
   })
else
   minetest.register_craft({
	  output = "food:cornstarch",
	  recipe = {
		 {"group:food_corn_cooked","group:food_bowl"},
	  },
   })
end

minetest.register_craftitem("food:date_nut_snack", {
	description = S("Date & nut snack"),
	inventory_image = "food_date_nut_snack.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craftitem("food:date_nut_batter", {
	description = S("Date-nut cake batter"),
	inventory_image = "food_date_nut_batter.png",
})

minetest.register_craftitem("food:date_nut_cake", {
	description = S("Date-nut cake"),
	inventory_image = "food_date_nut_cake.png",
	on_use = minetest.item_eat(32),
})

minetest.register_craftitem("food:date_nut_bar", {
	description = S("Date-nut energy bar"),
	inventory_image = "food_date_nut_bar.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "shapeless",
	output = "food:date_nut_snack",
	recipe = {
		"moretrees:date",
		"moretrees:date",
		"moretrees:date",
		"food:spruce_nuts",
		"food:cedar_nuts",
		"food:fir_nuts",
	}
})

-- The date-nut cake is an exceptional food item due to its highly
-- concentrated nature (32 food units). Because of that, it requires
-- many different ingredients, and, starting from the base ingredients
-- found or harvested in nature, it requires many steps to prepare.
minetest.register_craft({
	type = "shapeless",
	output = "food:date_nut_batter",
	recipe = {
		"food:date_nut_snack",
		"food:date_nut_snack",
		"food:date_nut_snack",
		"food:coconut_milk",
		"food:date_nut_snack",
		"food:raw_coconut",
		"food:coconut_milk",
		"food:flour",
		"food:raw_coconut",
	},
	replacements = {
		{ "food:coconut_milk", "vessels:drinking_glass 2" }
	}
})

minetest.register_craft({
	type = "cooking",
	output = "food:date_nut_cake",
	recipe = "food:date_nut_batter",
})

minetest.register_craft({
	type = "shapeless",
	output = "food:date_nut_bar 8",
	recipe = {"food:date_nut_cake"},
})

-- ethanol (thanks to JKMurray for this idea)
minetest.register_node("food:bottle_ethanol", {
	description = S("Bottle of Ethanol"),
	drawtype = "plantlike",
	tiles = {"food_bottle_ethanol.png"},
	inventory_image = "food_bottle_ethanol.png",
	wield_image = "food_bottle_ethanol.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_craft( {
	output = "food:bottle_ethanol",
	recipe = {
		{ "vessels:glass_bottle", "group:food_corn", "group:food_corn"},
		{ "group:food_corn", "group:food_corn", "group:food_corn"},
		{ "group:food_corn", "group:food_corn", "group:food_corn"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "food:bottle_ethanol",
	burntime = 80,
	replacements = {{ "food:bottle_ethanol", "vessels:glass_bottle"}}
})

minetest.register_craftitem("food:fir_nuts", {
	description = S("Roasted Fir Cone Nuts"),
	inventory_image = "food_fir_nuts.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	type = "cooking",
	output = "food:fir_nuts 4",
	recipe = "moretrees:fir_cone",
})

-- garlic braid
minetest.register_node("food:garlic_braid", {
	description = S("Garlic Braid"),
	inventory_image = "food_garlic_braid.png",
	wield_image = "food_garlic_braid.png",
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"food_garlic_braid_side.png","food_garlic_braid.png",
		"food_garlic_braid_side.png^[transformFx","food_garlic_braid_side.png",
		"food_garlic_braid.png","food_garlic_braid.png"
	},
	use_texture_alpha = "clip",
	groups = {vessel = 1, dig_immediate = 3, flammable = 3},
	sounds = default.node_sound_leaves_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
				{-0.13, -0.45, 0.5, 0.13, 0.45, 0.24}
		}
	}
})

minetest.register_craft({
	output = "food:garlic_braid",
	recipe = {
		{"farming:garlic", "farming:garlic", "farming:garlic"},
		{"farming:garlic", "farming:garlic", "farming:garlic"},
		{"farming:garlic", "farming:garlic", "farming:garlic"}
	}
})

-- hemp oil
minetest.register_node("food:hemp_oil", {
	description = S("Bottle of Hemp Oil"),
	drawtype = "plantlike",
	tiles = {"food_hemp_oil.png"},
	inventory_image = "food_hemp_oil.png",
	wield_image = "food_hemp_oil.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {food_oil = 1, vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_craft( {
	output = "food:hemp_oil",
	recipe = {
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
		{"farming:hemp_leaf", "farming:hemp_leaf", "farming:hemp_leaf"},
		{"", "vessels:glass_bottle", ""}
	}
})

minetest.register_craft( {
	output = "food:hemp_oil",
	recipe = {
		{"farming:seed_hemp", "farming:seed_hemp", "farming:seed_hemp"},
		{"farming:seed_hemp", "farming:seed_hemp", "farming:seed_hemp"},
		{"farming:seed_hemp", "vessels:glass_bottle", "farming:seed_hemp"}
	}
})

technic.register_extractor_recipe({input = {"farming:seed_hemp 4"},
	output = "food:hemp_oil"})
technic.register_extractor_recipe({input = {"farming:hemp_leaf 3"},
	output = "food:hemp_oil"})

minetest.register_craft({
	type = "fuel",
	recipe = "food:hemp_oil",
	burntime = 20,
	replacements = {{ "food:hemp_oil", "vessels:glass_bottle"}}
})

-- Soups

-- beetroot soup
minetest.register_craftitem("food:beetroot_soup", {
	description = S("Beetroot Soup"),
	inventory_image = "food_beetroot_soup.png",
	groups = {flammable = 2},
	on_use = minetest.item_eat(6, "default:bowl")
})

minetest.register_craft({
	type = "shapeless",
	output = "food:beetroot_soup",
	recipe = {
		"group:food_beetroot", "group:food_beetroot",
		"group:food_beetroot", "group:food_beetroot",
		"group:food_beetroot", "group:food_beetroot","group:food_bowl"
	}
})

-- onion soup
minetest.register_craftitem("food:onion_soup", {
	description = S("Onion Soup"),
	inventory_image = "food_onion_soup.png",
	groups = {flammable = 2},
	on_use = minetest.item_eat(6, "default:bowl")
})

if food.utensils then
   minetest.register_craft({
	  type = "shapeless",
	  output = "food:onion_soup",
	  recipe = {
		 "group:food_onion", "group:food_onion", "group:food_pot",
		 "group:food_onion", "group:food_onion",
		 "group:food_onion", "group:food_onion", "group:food_bowl"
	  },
	  replacements = {{"food:pot", "food:pot"}}
   })
else
   minetest.register_craft({
	  type = "shapeless",
	  output = "food:onion_soup",
	  recipe = {
		 "group:food_onion", "group:food_onion",
		 "group:food_onion", "group:food_onion",
		 "group:food_onion", "group:food_onion", "group:food_bowl"
	  },
   })
end

-- pea soup
minetest.register_craftitem("food:pea_soup", {
	description = S("Pea Soup"),
	inventory_image = "food_pea_soup.png",
	groups = {flammable = 2},
	on_use = minetest.item_eat(4, "default:bowl")
})

minetest.register_craft({
	type = "shapeless",
	output = "food:pea_soup",
	recipe = {"group:food_peas", "group:food_peas", "group:food_bowl"}
})

-- tomato soup
minetest.register_craftitem("food:tomato_soup", {
	description = S("Tomato Soup"),
	inventory_image = "food_soup_tomato.png",
	groups = {flammable = 2},
	on_use = minetest.item_eat(4, "default:bowl")
})

minetest.register_craft({
	type = "shapeless",
	output = "food:tomato_soup",
	recipe = {"group:food_tomato", "group:food_tomato", "group:food_bowl"}
})

-- ground pepper
minetest.register_node("food:pepper_ground", {
	description = S("Ground Pepper"),
	inventory_image = "food_pepper_ground.png",
	wield_image = "food_pepper_ground.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"food_pepper_ground.png"},
	groups = {
		vessel = 1, food_pepper_ground = 1,
		dig_immediate = 3, attached_node = 1
	},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	}
})

if food.utensils then
   minetest.register_craft( {
	  output = "food:pepper_ground",
	  type = "shapeless",
	  recipe = {"group:food_peppercorn", "vessels:glass_bottle", "food:mortar_pestle"},
	  replacements = {{"group:food_mortar_pestle", "food:mortar_pestle"}}
   })
else
   minetest.register_craft( {
	  output = "food:pepper_ground",
	  type = "shapeless",
	  recipe = {"group:food_peppercorn", "vessels:glass_bottle"},
   })
end

-- Pies

-- Apple Pie

minetest.register_craftitem("food:apple_pie", {
	description = S("Apple Pie"),
	inventory_image = "food_apple_pie.png",
	on_use = minetest.item_eat(6)
})

if food.utensils then
   minetest.register_craft({
	  output = "food:apple_pie",
	  type = "shapeless",
	  recipe = {
		 "group:food_flour", "group:food_sugar",
		 "group:food_apple", "group:food_apple", "group:food_apple",
		 "group:food_baking_tray"
	  },
	  replacements = {{"group:food_baking_tray", "food:baking_tray"}}
   })
else
   minetest.register_craft({
	  output = "food:apple_pie",
	  type = "shapeless",
	  recipe = {
		 "group:food_flour", "group:food_sugar",
		 "group:food_apple", "group:food_apple", "group:food_apple",
	  },
   })
end

-- Blackberry Pie
minetest.register_craftitem("food:blackberry_pie", {
	description = S("Blackberry Pie"),
	inventory_image = "food_blueberry_pie.png",
	on_use = minetest.item_eat(6)
})

if food.utensils then
   minetest.register_craft({
		output = "food:blackberry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:food_blackberries", "group:food_blackberries", "group:food_blackberries",
			"group:food_baking_tray"
		},
		replacements = {{"group:food_baking_tray", "food:baking_tray"}}
	})
else
   minetest.register_craft({
		output = "food:blackberry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:food_blackberries", "group:food_blackberries", "group:food_blackberries"
		},
	})
end

-- Blueberry Pie
minetest.register_craftitem("food:blueberry_pie", {
	description = S("Blueberry Pie"),
	inventory_image = "food_blueberry_pie.png",
	on_use = minetest.item_eat(6)
})

if food.utensils then
   minetest.register_craft({
		output = "food:blueberry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:food_blueberries", "group:food_blueberries", "group:food_blueberries",
			"group:food_baking_tray"
		},
		replacements = {{"group:food_baking_tray", "food:baking_tray"}}
	})
else
   minetest.register_craft({
		output = "food:blueberry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:food_blueberries", "group:food_blueberries", "group:food_blueberries"
		},
	})
end

-- Cherry Pie
minetest.register_craftitem("food:cherry_pie", {
	description = S("Cherry Pie"),
	inventory_image = "food_cherry_pie.png",
	on_use = minetest.item_eat(6)
})

if food.utensils then
   minetest.register_craft({
		output = "food:cherry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:cherries", "group:cherries", "group:cherries",
			"group:food_baking_tray"
		},
		replacements = {{"group:food_baking_tray", "food:baking_tray"}}
	})
else
   minetest.register_craft({
		output = "food:cherry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:cherries", "group:cherries", "group:cherries"
		},
	})
end

-- Raspberry Pie
minetest.register_craftitem("food:raspberry_pie", {
	description = S("Raspberry Pie"),
	inventory_image = "food_cherry_pie.png",
	on_use = minetest.item_eat(6)
})

if food.utensils then
   minetest.register_craft({
		output = "food:raspberry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:food_raspberries", "group:food_raspberries", "group:food_raspberries",
			"group:food_baking_tray"
		},
		replacements = {{"group:food_baking_tray", "food:baking_tray"}}
	})
else
   minetest.register_craft({
		output = "food:raspberry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:food_raspberries", "group:food_raspberries", "group:food_raspberries"
		},
	})
end

-- Rhubarb Pie
minetest.register_craftitem("food:rhubarb_pie", {
	description = S("Rhubarb Pie"),
	inventory_image = "food_rhubarb_pie.png",
	on_use = minetest.item_eat(6)
})

if food.utensils then
   minetest.register_craft({
	  output = "food:rhubarb_pie",
		type = "shapeless",
	  recipe = {
		 "group:food_flour", "group:food_sugar",
		 "group:food_rhubarb", "group:food_rhubarb", "group:food_rhubarb",
		 "group:food_baking_tray"
	  },
	  replacements = {{"group:food_baking_tray", "food:baking_tray"}}
   })
else
   minetest.register_craft({
	  output = "food:rhubarb_pie",
		type = "shapeless",
	  recipe = {
		 "group:food_flour", "group:food_sugar",
		 "group:food_rhubarb", "group:food_rhubarb", "group:food_rhubarb"
	  },
   })
end

-- Strawberry Pie
minetest.register_craftitem("food:strawberry_pie", {
	description = S("Strawberry Pie"),
	inventory_image = "food_cherry_pie.png",
	on_use = minetest.item_eat(6)
})

if food.utensils then
   minetest.register_craft({
		output = "food:strawberry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:food_strawberry", "group:food_strawberry", "group:food_strawberry",
			"group:food_baking_tray"
		},
		replacements = {{"group:food_baking_tray", "food:baking_tray"}}
	})
else
   minetest.register_craft({
		output = "food:strawberry_pie",
		type = "shapeless",
		recipe = {
			"group:food_flour", "group:food_sugar",
			"group:food_strawberry", "group:food_strawberry", "group:food_strawberry"
		},
	})
end

-- baked potato
minetest.register_craftitem("food:baked_potato", {
	description = S("Baked Potato"),
	inventory_image = "food_baked_potato.png",
	on_use = minetest.item_eat(6)
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "food:baked_potato",
	recipe = "group:food_potato"
})

-- Potato and cucumber Salad
minetest.register_craftitem("food:potato_salad", {
	description = S("Cucumber and Potato Salad"),
	inventory_image = "food_potato_salad.png",
	on_use = minetest.item_eat(10, "default:bowl")
})

minetest.register_craft({
	output = "food:potato_salad",
	recipe = {
		{"group:food_cucumber"},
		{"food:baked_potato"},
		{"group:food_bowl"}
	}
})

-- pumpkin bread
minetest.register_craftitem("food:pumpkin_bread", {
	description = S("Pumpkin Bread"),
	inventory_image = "food_pumpkin_bread.png",
	on_use = minetest.item_eat(8),
	groups = {food_bread = 1, flammable = 2}
})

minetest.register_craftitem("food:pumpkin_dough", {
	description = S("Pumpkin Dough"),
	inventory_image = "food_pumpkin_dough.png"
})

minetest.register_craft({
	output = "food:pumpkin_dough",
	type = "shapeless",
	recipe = {"group:food_flour", "group:food_pumpkin_slice", "group:food_pumpkin_slice"}
})

minetest.register_craft({
	type = "cooking",
	output = "food:pumpkin_bread",
	recipe = "food:pumpkin_dough",
	cooktime = 10
})

-- raspberry smoothie
minetest.register_craftitem("food:smoothie_raspberry", {
	description = S("Raspberry Smoothie"),
	inventory_image = "food_raspberry_smoothie.png",
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1}
})

minetest.register_craft({
	output = "food:smoothie_raspberry",
	recipe = {
		{"default:snow"},
		{"group:food_raspberries"},
		{"vessels:drinking_glass"}
	}
})

minetest.register_craftitem("food:spruce_nuts", {
	description = S("Roasted Spruce Cone Nuts"),
	inventory_image = "food_spruce_nuts.png",
	on_use = minetest.item_eat(1),
})

minetest.register_craft({
	type = "cooking",
	output = "food:spruce_nuts 4",
	recipe = "moretrees:spruce_cone",
})

-- vanilla extract
minetest.register_node("food:vanilla_extract", {
	description = S("Vanilla Extract"),
	drawtype = "plantlike",
	tiles = {"food_vanilla_extract.png"},
	inventory_image = "food_vanilla_extract.png",
	wield_image = "food_vanilla_extract.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {vessel = 1, dig_immediate = 3, attached_node = 1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft( {
	output = "food:vanilla_extract",
	recipe = {
		{ "group:food_vanilla", "group:food_vanilla", "group:food_vanilla"},
		{ "group:food_vanilla", "food:bottle_ethanol", "bucket:bucket_water"},
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "food:vanilla_extract",
	burntime = 25,
	replacements = {{ "food:vanilla_extract", "vessels:glass_bottle" }}
})

-- soy milk
minetest.register_node("food:soy_milk", {
	description = S("Soy Milk"),
	drawtype = "plantlike",
	tiles = {"food_soy_milk_glass.png"},
	inventory_image = "food_soy_milk_glass.png",
	wield_image = "food_soy_milk_glass.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.3, -0.5, -0.3, 0.3, 0.5, 0.3}
	},
	on_use = minetest.item_eat(2, "vessels:drinking_glass"),
	groups = {
		vessel = 1, food_milk_glass = 1, dig_immediate = 3,
		attached_node = 1, drink = 1
	},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_craft( {
	type = "shapeless",
	output = "food:soy_milk",
	recipe = {
		"group:food_soy", "group:food_soy", "group:food_soy",
		"food:vanilla_extract", "bucket:bucket_water", "vessels:drinking_glass"
	},
	replacements = {
		{"bucket:bucket_water", "bucket:bucket_empty"},
		{"food:vanilla_extract", "vessels:glass_bottle"}
	}
})

-- tofu
minetest.register_craftitem("food:tofu", {
	description = S("Tofu"),
	inventory_image = "food_tofu.png",
	groups = {food_tofu = 1, food_meat_raw = 1, flammable = 2},
	on_use = minetest.item_eat(3)
})

if food.utensils then
   minetest.register_craft({
	  output = "food:tofu",
	  type = "shapeless",
	  recipe = {
		 "food:baking_tray", "group:food_soy", "group:food_soy",
		 "group:food_soy", "group:food_soy", "group:food_soy",
	  },
	  replacements = {{"food:baking_tray", "food:baking_tray"}}
   })
else
   minetest.register_craft({
	  output = "food:tofu",
	  type = "shapeless",
	  recipe = {
		 "group:food_soy", "group:food_soy", "group:food_soy",
		 "group:food_soy", "group:food_soy", "group:food_soy",
	  },
   })
end

-- cooked tofu
minetest.register_craftitem("food:tofu_cooked", {
	description = S("Cooked Tofu"),
	inventory_image = "food_tofu_cooked.png",
	groups = {food_meat = 1, flammable = 2},
	on_use = minetest.item_eat(6)
})

minetest.register_craft({
	type = "cooking",
	output = "food:tofu_cooked",
	recipe = "food:tofu",
	cooktime = 5
})

-- sunflower seeds (toasted)
minetest.register_craftitem("food:sunflower_seeds_toasted", {
	description = S("Toasted Sunflower Seeds"),
	inventory_image = "farming_sunflower_seeds_toasted.png",
	groups = {food_sunflower_seeds_toasted = 1, flammable = 2},
	on_use = minetest.item_eat(1)
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "food:sunflower_seeds_toasted",
	recipe = "farming:seed_sunflower"
})

-- sunflower oil
minetest.register_node("food:sunflower_oil", {
	description = S("Bottle of Sunflower Oil"),
	drawtype = "plantlike",
	tiles = {"farming_sunflower_oil.png"},
	inventory_image = "farming_sunflower_oil.png",
	wield_image = "farming_sunflower_oil.png",
	paramtype = "light",
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {
		food_oil = 1, vessel = 1, dig_immediate = 3, attached_node = 1,
		flammable = 2
	},
	sounds = default.node_sound_glass_defaults()
})

minetest.register_craft( {
	output = "food:sunflower_oil",
	recipe = {
		{"group:food_sunflower_seeds", "group:food_sunflower_seeds", "group:food_sunflower_seeds"},
		{"group:food_sunflower_seeds", "group:food_sunflower_seeds", "group:food_sunflower_seeds"},
		{"group:food_sunflower_seeds", "vessels:glass_bottle", "group:food_sunflower_seeds"}
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "food:sunflower_oil",
	burntime = 30,
	replacements = {{"food:sunflower_oil", "vessels:glass_bottle"}}
})

-- sunflower seed bread
minetest.register_craftitem("food:sunflower_bread", {
	description = S("Sunflower Seed Bread"),
	inventory_image = "farming_sunflower_bread.png",
	on_use = minetest.item_eat(8),
	groups = {food_bread = 1, flammable = 2}
})

minetest.register_craftitem("food:sunflower_bread", {
	description = S("Sunflower Bread"),
	inventory_image = "farming_sunflower_bread.png"
})

minetest.register_craft({
	output = "food:sunflower_bread",
	recipe = {{"group:food_sunflower_seeds_toasted", "group:food_bread", "group:food_sunflower_seeds_toasted"}}
})


--[[ no gelatin
--= Rose Water

minetest.register_node("food:rose_water", {
	description = S("Rose Water"),
	inventory_image = "food_rose_water.png",
	wield_image = "food_rose_water.png",
	drawtype = "plantlike",
	visual_scale = 0.8,
	paramtype = "light",
	tiles = {"food_rose_water.png"},
	groups = {food_rose_water = 1, vessel = 1, dig_immediate = 3,
			attached_node = 1},
	sounds = default.node_sound_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	}
})

if food.utensils then
   minetest.register_craft({
	  output = "food:rose_water",
	  recipe = {
		 {"flowers:rose", "flowers:rose", "flowers:rose"},
		 {"flowers:rose", "flowers:rose", "flowers:rose"},
		 {"group:water_bucket", "group:food_pot", "vessels:glass_bottle"}
	  },
	  replacements = {
		{"group:water_bucket", "bucket:bucket_empty"},
		{"group:food_pot", "food:pot"}
	  }
   })
else
   minetest.register_craft({
	  output = "food:rose_water",
	  recipe = {
		 {"flowers:rose", "flowers:rose", "flowers:rose"},
		 {"flowers:rose", "flowers:rose", "flowers:rose"},
		 {"group:water_bucket", "flowers:rose", "vessels:glass_bottle"}
	  },
	  replacements = {
		{"group:water_bucket", "bucket:bucket_empty"}
	  }
   })
end

--= Turkish Delight

minetest.register_craftitem("food:turkish_delight", {
	description = S("Turkish Delight"),
	inventory_image = "food_turkish_delight.png",
	groups = {flammable = 3},
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	output = "food:turkish_delight 4",
	recipe = {
		{"group:food_gelatin", "group:food_sugar", "group:food_gelatin"},
		{"group:food_sugar", "group:food_rose_water", "group:food_sugar"},
		{"group:food_cornstarch", "group:food_sugar", "dye:pink"}
	},
	replacements = {
		{"group:food_cornstarch", "default:bowl"},
		{"group:food_rose_water", "vessels:glass_bottle"}
	}
})
--]]
-- Garlic Bread

minetest.register_craftitem("food:garlic_dough", {
   description = S("Garlic Bread Dough"),
   inventory_image = "food_garlic_dough.png",
})

minetest.register_craftitem("food:garlic_bread", {
   description = S("Garlic Bread"),
   inventory_image = "food_garlic_bread.png",
   groups = {flammable = 3},
   on_use = minetest.item_eat(6),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:garlic_dough",
   recipe = {"food:flour", "farming:garlic_clove"}
})

minetest.register_craft({
   type = "cooking",
   output = "food:garlic_bread",
   recipe = "food:garlic_dough"
})
--[[
minetest.register_craftitem("food:garlic_bread", {
	description = S("Garlic Bread"),
	inventory_image = "farming_garlic_bread.png",
	groups = {flammable = 3},
	on_use = minetest.item_eat(2)
})

minetest.register_craft({
	type = "shapeless",
	output = "food:garlic_bread",
	recipe = {"group:food_toast", "group:food_garlic_clove", "group:food_garlic_clove"}
})
--]]
--= Donuts (thanks to Bockwurst for making the donut images)

minetest.register_craftitem("food:donut", {
	description = S("Donut"),
	inventory_image = "food_donut.png",
	on_use = minetest.item_eat(4)
})

minetest.register_craft({
	output = "food:donut 3",
	recipe = {
		{"", "group:food_wheat", ""},
		{"group:food_wheat", "group:food_sugar", "group:food_wheat"},
		{"", "group:food_wheat", ""}
	}
})

minetest.register_craftitem("food:donut_chocolate", {
	description = S("Chocolate Donut"),
	inventory_image = "food_donut_chocolate.png",
	on_use = minetest.item_eat(6)
})

minetest.register_craft({
	output = "food:donut_chocolate",
	recipe = {
		{"group:food_cocoa"},
		{"food:donut"}
	}
})

minetest.register_craftitem("food:donut_apple", {
	description = S("Apple Donut"),
	inventory_image = "food_donut_apple.png",
	on_use = minetest.item_eat(6)
})

minetest.register_craft({
	output = "food:donut_apple",
	recipe = {
		{"default:apple"},
		{"food:donut"}
	}
})

--= Porridge Oats

minetest.register_craftitem("food:porridge", {
	description = S("Porridge"),
	inventory_image = "food_porridge.png",
	on_use = minetest.item_eat(6, "default:bowl")
})

minetest.register_craft({
	type = "shapeless",
	output = "food:porridge",
	recipe = {
		"group:food_oats", "group:food_oats", "group:food_oats",
		"group:food_oats", "group:food_bowl", "group:food_milk_glass"
	},
	replacements = {
		{"mobs:glass_milk", "vessels:drinking_glass"},
		{"food:soy_milk", "vessels:drinking_glass"}
	}
})

--= Jaffa Cake

minetest.register_craftitem("food:jaffa_cake", {
	description = S("Jaffa Cake"),
	inventory_image = "food_jaffa_cake.png",
	on_use = minetest.item_eat(6)
})

if food.utensils then
   minetest.register_craft({
	  type = "shapeless",
	  output = "food:jaffa_cake",
	  recipe = {
		 "food:baking_tray", "group:food_egg", "group:food_sugar",
		 "group:food_flour", "group:food_cocoa", "group:food_orange",
		 "group:food_milk"
	  },
	  replacements = {
		 {"food:baking_tray", "food:baking_tray"},
		 {"group:milkbucket", "bucket:bucket_empty"},
		 { "food:bottle_milk", "vessels:glass_bottle"},
	  }
   })
else
   minetest.register_craft({
	  type = "shapeless",
	  output = "food:jaffa_cake",
	  recipe = {
		  "group:food_egg", "group:food_sugar",
		 "group:food_flour", "group:food_cocoa", "group:food_orange",
		 "group:food_milk"
	  },
	  replacements = {
		 {"group:milkbucket", "bucket:bucket_empty"},
		 { "food:bottle_milk", "vessels:glass_bottle"},
	  }
   })
end


-- Pasta

minetest.register_craftitem("food:pasta", {
   description = S("Pasta"),
   inventory_image = "food_pasta.png",
   on_use = minetest.item_eat(1),
	groups = {food_pasta = 1}
})

minetest.register_craft({
   output = 'food:pasta 5',
   type = "shapeless",
   recipe = {'food:flour', 'bucket:bucket_water'},
   replacements = {{ "bucket:bucket_water", "bucket:bucket_empty"}}
})

-- Register pasta bake

minetest.register_craftitem("food:pasta_bake",{
	description = S("Pasta Bake"),
	inventory_image = "food_pasta_bake.png",
	on_use = minetest.item_eat(4, "default:bowl"),
	groups = {food=3}
})

minetest.register_craftitem("food:pasta_bake_raw",{
	description = S("Raw Pasta Bake"),
	inventory_image = "food_pasta_bake_raw.png",
})

minetest.register_craft({
	output = "food:pasta_bake",
	type = "cooking",
	 recipe = "food:pasta_bake_raw"
})

minetest.register_craft({
	output = "food:pasta_bake_raw",
	recipe = {
		{"group:food_cheese"},
		{"group:food_pasta"},
		{"group:food_bowl"}
	}
})

-- Spaghetti

minetest.register_craftitem("food:spaghetti", {
	description = S("Spaghetti"),
	inventory_image = "food_raviolii.png",
	on_use = minetest.item_eat(8)
})

if food.utensils then
   minetest.register_craft({
	  output = "food:spaghetti",
	  type = "shapeless",
	  recipe = {
		 "group:food_pasta", "group:food_saucepan",
		 "group:food_tomato", "group:food_garlic_clove", "group:food_garlic_clove"
	  },
	  replacements = {{"group:food_saucepan", "food:saucepan"}}
   })
else
   minetest.register_craft({
	  output = "food:spaghetti",
	  type = "shapeless",
	  recipe = {
		 "group:food_pasta",
		 "group:food_tomato", "group:food_garlic_clove", "group:food_garlic_clove"
	  },
   })
end

-- Korean Bibimbap
--[[
minetest.register_craftitem("food:bibimbap", {
	description = S("Bibimbap"),
	inventory_image = "food_bibimbap.png",
	on_use = minetest.item_eat(8, "default:bowl")
})

if minetest.get_modpath("mobs_animal") or minetest.get_modpath("xanadu")then
minetest.register_craft({
	output = "food:bibimbap",
	type = "shapeless",
	recipe = {
		"group:food_skillet", "group:food_bowl", "group:food_egg", "group:food_rice",
		"group:food_chicken_raw", "group:food_cabbage", "group:food_carrot",
		"group:food_chili_pepper"
	},
	replacements = {{"group:food_skillet", "food:skillet"}}
})
else
minetest.register_craft({
	output = "food:bibimbap",
	type = "shapeless",
	recipe = {
		"group:food_skillet", "group:food_bowl", "group:food_mushroom",
		"group:food_rice", "group:food_cabbage", "group:food_carrot",
		"group:food_mushroom", "group:food_chili_pepper"
	},
	replacements = {{"group:food_skillet", "food:skillet"}}
})
end
--]]
-- Burger

minetest.register_craftitem("food:burger", {
	description = S("Burger"),
	inventory_image = "food_burger.png",
	on_use = minetest.item_eat(16),
})

minetest.register_craft({
	type = "shapeless",
	output = "food:burger",
	recipe = {
		"food:bread", "group:food_meat", "group:food_cheese",
		"group:food_tomato", "group:food_cucumber", "group:food_onion",
		"group:food_lettuce"
	}
})

-- Salad

minetest.register_craftitem("food:salad", {
	description = S("Salad"),
	inventory_image = "food_salad.png",
	on_use = minetest.item_eat(8, "default:bowl")
})

minetest.register_craft({
	output = "food:salad",
	type = "shapeless",
	recipe = {
		"group:food_bowl", "group:food_tomato", "group:food_cucumber",
		"group:food_lettuce", "group:food_oil"
	},
})

-- Triple Berry Smoothie

minetest.register_craftitem("food:smoothie_berry", {
	description = S("Triple Berry Smoothie"),
	inventory_image = "food_berry_smoothie.png",
	on_use = minetest.item_eat(6, "vessels:drinking_glass"),
	groups = {vessel = 1, drink = 1}
})

minetest.register_craft({
	output = "food:smoothie_berry",
	type = "shapeless",
	recipe = {
		"group:food_raspberries", "group:food_blackberries",
		"group:food_strawberry", "group:food_banana",
		"vessels:drinking_glass"
	}
})

-- cooked whale
minetest.register_craftitem(":food:whalemeat_cooked", {
	description = ("Cooked Whale Meat"),
	inventory_image = "food_whalemeat_cooked.png",
	on_use = minetest.item_eat(8),
	groups = {food_meat = 1, flammable = 2},
})

minetest.register_craft({
	type = "cooking",
	output = "food:whalemeat_cooked",
	recipe = "animalworld:whalemeat_raw",
	cooktime = 2,
})
