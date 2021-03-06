-- CANNED FOOD
-- Merged into food mod for MinePlus.
-- Introduces new food types to add some variety. All of them rely on glass bottles
-- from the default vessels mod, which otherwise sees very little use. In vanilla game,
-- at least 4 new types will be available, two of which will also turn inedible items
-- into edible food. With farming (redo) and ethereal, pretty much anything that can
-- be harvested can also be canned.

--[[
    Definition scheme
	internal_name_of_the_product = {
		proper_name = Human-readable name,
		found_in = mod name where the source object is introduced
		obj_name = name of source object
		orig_nutritional_value = self-explanatory
		amount = how many objects are needed to fill a bottle /not implemented/
		sugar = boolean, set if needs sugar (jams) or not
		transforms = name of the product it turns into if left on a shelf
	}
	image files for items must follow the scheme "internal_name_of_the_product.png"
]]

local canned_food_definitions = {
	apple_jam = {
		proper_name = "Apple jam",
		found_in = "default",
		obj_name = "default:apple",
		orig_nutritional_value = 2,
		amount = 3,
		sugar = false -- must not use sugar to be available in vanilla
	},
	dandelion_jam = {
		proper_name = "Dandelion jam",
		found_in = "flowers",
		obj_name = "flowers:dandelion_yellow",
		orig_nutritional_value = 1,
		amount = 5,
		sugar = false -- must not use sugar to be available in vanilla
	},
	rose_jam = {
		proper_name = "Rose petal jam",
		found_in = "flowers",
		obj_name = "flowers:rose",
		orig_nutritional_value = 1,
		amount = 5,
		sugar = false -- must not use sugar to be available in vanilla
	},
	canned_mushrooms = {
		proper_name = "Canned mushrooms",
		found_in = "flowers",
		obj_name = "flowers:mushroom_brown",
		orig_nutritional_value = 1,
		amount = 5,
		sugar = false,
		transforms = "Salted mushrooms"
	},
	orange_jam = {
		proper_name = "Orange jam",
		found_in = "orange_tree",
		obj_name = "orange_tree:orange",
		orig_nutritional_value = 2,
		amount = 3,
		sugar = true
	},
	banana_jam = {
		proper_name = "Banana jam",
		found_in = "banana_tree",
		obj_name = "banana_tree:banana",
		orig_nutritional_value = 1,
		amount = 5,
		sugar = true
	},
	strawberry_jam = {
		proper_name = "Strawberry jam",
		found_in = "farming",
		obj_name = "farming:strawberry",
		orig_nutritional_value = 1,
		amount = 5,
		sugar = true
	},
	canned_wild_onion = {
		proper_name = "Canned wild onions",
		found_in = "ethereal",
		obj_name = "ethereal:wild_onion_plant",
		orig_nutritional_value = 2,
		amount = 4,
		sugar = false,
		transforms = "Pickled wild onions"
	},
	blueberry_jam = {
		proper_name = "Blueberry jam",
		found_in = "farming",
		obj_name = "farming:blueberries",
		orig_nutritional_value = 1,
		amount = 6,
		sugar = true
	},
	raspberry_jam = {
		proper_name = "Raspberry jam",
		found_in = "farming",
		obj_name = "farming:raspberries",
		orig_nutritional_value = 1,
		amount = 6,
		sugar = true
	},
	grape_jam = {
		proper_name = "Grape jam",
		found_in = "farming",
		obj_name = "farming:grapes",
		orig_nutritional_value = 2,
		amount = 4,
		sugar = true
	},
	rhubarb_jam = {
		proper_name = "Rhubarb jam",
		found_in = "farming",
		obj_name = "farming:rhubarb",
		orig_nutritional_value = 1,
		amount = 6,
		sugar = true
	},
	melon_jam = {
		proper_name = "Melon jam",
		found_in = "farming",
		obj_name = "farming:melon_slice",
		orig_nutritional_value = 2,
		amount = 3,
		sugar = true
	},
	canned_carrot = {
		proper_name = "Canned carrots",
		found_in = "farming",
		obj_name = "farming:carrot",
		orig_nutritional_value = 4,
		amount = 3,
		sugar = false,
		transforms = "Pickled carrot sticks"
	},
	canned_potato = {
		proper_name = "Canned potatoes",
		found_in = "farming",
		obj_name = "farming:potato",
		orig_nutritional_value = 1,
		amount = 5,
		sugar = false,
		-- a rare thing, apparently
		transforms = "Mexican pickled potatoes"
	},
	canned_cucumber = {
		proper_name = "Canned cucumbers",
		found_in = "farming",
		obj_name = "farming:cucumber",
		orig_nutritional_value = 4,
		amount = 3,
		sugar = false,
		-- one just cannot simply make the pickles
		transforms = "Pickles"
	},
	canned_tomato = {
		proper_name = "Canned tomatoes",
		found_in = "farming",
		obj_name = "farming:tomato",
		orig_nutritional_value = 4,
		amount = 3,
		sugar = false,
		transforms = "Marinated tomatoes"
	},
	canned_corn = {
		proper_name = "Canned corn",
		found_in = "farming",
		obj_name = "farming:corn",
		orig_nutritional_value = 3,
		amount = 3,
		sugar = false
	},
	canned_beans = {
		proper_name = "Canned beans",
		found_in = "farming",
		obj_name = "farming:beans",
		orig_nutritional_value = 1,
		amount = 6,
		sugar = false
	},
	canned_chili_pepper = {
		proper_name = "Canned chili pepper",
		found_in = "farming",
		obj_name = "farming:chili_pepper",
		orig_nutritional_value = 1,
		amount = 6,
		sugar = false,
		transforms = "Pickled chili pepper"
	},
	canned_coconut = {
		proper_name = "Canned coconut",
		found_in = "ethereal",
		obj_name = "ethereal:coconut_slice",
		orig_nutritional_value = 1,
		amount = 5,
		sugar = false
	},
	pine_nuts_jar = {
		proper_name = "A Jar of pine nuts",
		found_in = "ethereal",
		obj_name = "ethereal:pine_nuts",
		orig_nutritional_value = 1,
		amount = 8,
		sugar = false
	},
	canned_pumpkin = {
		proper_name = "Canned pumpkin puree",
		found_in = "farming",
		obj_name = "farming:pumpkin_slice",
		orig_nutritional_value = 2,
		amount = 3,
		sugar = false
	},
	honey_jar = {
		proper_name = "A jar of honey",
		found_in = "mobs_animal",
		obj_name = "mobs:honey",
		orig_nutritional_value = 4,
		amount = 4,
		sugar = false
	},
	canned_pineapple = {
		proper_name = "Canned pineapple rings",
		found_in = "farming",
		obj_name = "farming:pineapple_ring",
		orig_nutritional_value = 1,
		amount = 5,
		sugar = false
	},
	canned_onion = {
		proper_name = "Canned onions",
		found_in = "farming",
		obj_name = "farming:onion",
		orig_nutritional_value = 1,
		amount = 4,
		sugar = false,
		transforms = "Pickled onions"
	},
	canned_garlic_cloves = {
		proper_name = "Canned garlic cloves",
		found_in = "farming",
		obj_name = "farming:garlic_clove",
		orig_nutritional_value = 0.5,
		amount = 8,
		sugar = false,
		transforms = "Pickled garlic cloves"
	},
	canned_peas = {
		proper_name = "Canned peas",
		found_in = "farming",
		obj_name = "farming:peas",
		orig_nutritional_value = 1,
		amount = 8,
		sugar = false,
	},
}


-- creating all objects with one universal scheme
for product, def in pairs(canned_food_definitions) do
	if minetest.get_modpath(def.found_in) then
	--if minetest.global_exists(def.found_in) then
		if def.sugar and minetest.get_modpath("farming") or not def.sugar then
			
			-- introducing a new item, a bit more nutricious than the source 
			-- material when sugar is used.
			minetest.register_node("food:" .. product, {
				description = def.proper_name,
				drawtype = "plantlike",
				tiles = {product .. ".png"},
				inventory_image = product .. ".png",
				wield_image = product .. ".png",
				paramtype = "light",
				is_ground_content = false,
				walkable = false,
				selection_box = {
					type = "fixed",
					fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
				},
				groups = { food = 1,
							canned_food = 1, 
			                 vessel = 1, 
			                 dig_immediate = 3, 
			                 attached_node = 1 },
				-- canned food prolongs shelf life IRL, but in minetest food never
				-- goes bad. Here, we increase the nutritional value instead.
				on_use = minetest.item_eat(
						math.floor (def.orig_nutritional_value * def.amount * 1.33)
						+ (def.sugar and 1 or 0), "vessels:glass_bottle"),
				-- the empty bottle stays, of course
				sounds = default.node_sound_glass_defaults(),
			})
			
			-- Some products involve marinating or salting, however there is no salt
			-- or vingerar in minetest; instead we imitate this more complex process
			-- by putting the jar on a wooden shelf in a dark room for a long while.
			-- The effort is rewarded accordingly.
			if (def.transforms) then
				
				minetest.register_node("food:" .. product .."_plus", {
					description = def.transforms,
					drawtype = "plantlike",
					tiles = {product .. ".png^paper_lid_cover.png"},
					inventory_image = product .. ".png^paper_lid_cover.png",
					wield_image = product .. ".png^paper_lid_cover.png",
					paramtype = "light",
					is_ground_content = false,
					walkable = false,
					selection_box = {
						type = "fixed",
						fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
					},
					groups = { food = 1,
						canned_food = 1, 
						vessel = 1, 
						dig_immediate = 3, 
						attached_node = 1,
						not_in_creative_inventory = 1 },
					-- the reward for putting the food in a cellar is even greater 
					-- than for merely canning it.
					on_use = minetest.item_eat(
							(math.floor(def.orig_nutritional_value * def.amount * 1.33)
							+ (def.sugar and 1 or 0))*2, "vessels:glass_bottle"),
					-- the empty bottle stays, of course
					sounds = default.node_sound_glass_defaults(),
				})
				
				minetest.register_abm ({
					label = def.proper_name .. " transformation",
					nodenames = {"food:" .. product},
					neighbors = {"group:wood"},
					-- chances might need tweaking though
					interval = 180,
					chance = 10,
					action = function(pos)
						if minetest.get_node_light(pos) < 11 then
							minetest.set_node(pos, {name = "food:" .. product .."_plus"})
						end
					end,
				})
				
			end
			
			-- a family of shapeless recipes, with sugar for jams
			-- except for apple: there should be at least 1 jam guaranteed
			-- to be available in vanilla game (and mushrooms are the guaranteed
			-- regular - not sweet - canned food)
			local ingredients = {"vessels:glass_bottle"}
			local max = 8
			if def.sugar then
				table.insert(ingredients, "group:food_sugar")
				max = 7
			end
			-- prevent creation of a recipe with more items than there are slots
			-- left in the 9-tile craft grid
			if def.amount > max then 
				def.amount = max 
			end
			for i=1,def.amount do
				table.insert(ingredients, def.obj_name)
			end
			minetest.register_craft({
				type = "shapeless",
				output = "food:" .. product,
				recipe = ingredients
			})
		end
	end
end


-- The Moor has done his duty, the Moor can go
canned_food_definitions = nil
