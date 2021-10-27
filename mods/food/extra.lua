-- extra food mod
-- by dhausmig

---------------------------------------------------------------

S = function ( s ) return s end

local path = minetest.get_modpath("food")
local grinder_recipes = {}

-- Load new settings if found
local input = io.open(path.."/settings.conf", "r")
if input then
	dofile(path .. "/settings.conf")
	input:close()
	input = nil
end

-- meat_raw
minetest.register_craftitem("food:meat_raw", {
   description = S("Raw Meat"),
   inventory_image = "food_raw_meat.png",
   on_use = minetest.item_eat(2),
   groups = {food_meat = 1,food_meat_raw = 1 }
})
minetest.register_craft({
   output = "food:meat_raw",
   type = "shapeless",
   recipe = {"food:tofu","food:tofu","food:tofu",
             'food:flour', 'default:apple', "farming:wheat"},
})
-- meat_cooked
minetest.register_craftitem("food:meat_cooked", {
   description = S("Cooked Meat"),
   inventory_image = "food_cooked_meat.png",
   on_use = minetest.item_eat(6),
   groups = {food_meat = 1, }
})
minetest.register_craft({
   type = "cooking",
   output = "food:meat_cooked",
   recipe = "food:meat_raw",
   cooktime = 4,
})

-- ground_meat
minetest.register_craftitem("food:ground_meat", {
   description = S("Ground Meat"),
   inventory_image = "food_ground_meat.png",
   on_use = minetest.item_eat(4),
   groups = {food_meat = 1, }
})

table.insert(grinder_recipes, {"mobs:meat_raw", "food:ground_meat 2"})
table.insert(grinder_recipes, {"food:meat_raw", "food:ground_meat 2"})

minetest.register_craft({
   type = "shapeless",
   output = "food:ground_meat 4",
   recipe = {"mobs:meat_raw", "mobs:meat_raw", "mobs:meat_raw", "mobs:meat_raw"}
})

-- meat_patty
-- grilled_patty
minetest.register_craftitem("food:meat_patty", {
   description = S("Ground Meat Patty"),
   inventory_image = "food_meat_patty.png",
   on_use = minetest.item_eat(1),
   groups = {food_meat = 1, }
})

minetest.register_craftitem("food:grilled_patty", {
   description = S("Grilled Meat Patty"),
   inventory_image = "food_grilled_patty.png",
   on_use = minetest.item_eat(2),
   groups = {food_meat = 1, }
})

minetest.register_craft({
   type = "shapeless",
   output = "food:meat_patty 2",
   recipe = {"food:ground_meat"},
})

minetest.register_craft({
   type = "cooking",
   output = "food:grilled_patty",
   recipe = "food:meat_patty",
})

-- PEPPERONI
minetest.register_craftitem("food:pepperoni", {
   description = S("Pepperoni"),
   inventory_image = "food_pepperoni.png",
   on_use = minetest.item_eat(8),
})

minetest.register_craft({
   type = "shapeless",
   output = 'food:pepperoni',
   recipe = {"mobs:meat_raw", 'farming:chili_pepper'},
})

-- tomato_slice
minetest.register_craftitem("food:tomato_slice", {
   description = S("Tomato Slice"),
   inventory_image = "food_tomato_slice.png",
   on_use = minetest.item_eat(1),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:tomato_slice 8",
   recipe = {"farming:tomato"},
})

-- onion_slice
minetest.register_craftitem("food:onion_slice", {
   description = S("Onion Slice"),
   inventory_image = "food_onion_slice.png",
   on_use = minetest.item_eat(1),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:onion_slice 8",
   recipe = {"farming:onion"},
})

-- potato_slice
minetest.register_craftitem("food:potato_slice", {
   description = S("Potato Slice"),
   inventory_image = "food_potato_slice.png",
   on_use = minetest.item_eat(1),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:potato_slice 8",
   recipe = {"farming:potato"},
})

-- meatloaf_raw
-- meatloaf
minetest.register_craftitem("food:meatloaf_raw", {
   description = S("Raw Meatloaf"),
   inventory_image = "food_meatloaf_raw.png",
   on_use = minetest.item_eat(6),
})

minetest.register_craftitem("food:meatloaf", {
   description = S("Meatloaf"),
   inventory_image = "food_meatloaf.png",
   on_use = minetest.item_eat(10),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:meatloaf_raw",
   recipe = {"food:ground_meat", "food:ground_meat", "food:bread",
             "farming:onion"},
})

minetest.register_craft({
   type = "cooking",
   output = "food:meatloaf 6",
   recipe = "food:meatloaf_raw",
})

-- corn_dog_raw
-- corn_dog
minetest.register_craftitem("food:corn_dog_raw", {
   description = S("Raw Corn Dog"),
   inventory_image = "food_corn_dog_raw.png",
})

minetest.register_craftitem("food:corn_dog", {
   description = S("Corn_dog"),
   inventory_image = "food_corn_dog.png",
   on_use = minetest.item_eat(3, "default:stick"),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:corn_dog_raw 3",
   recipe = {"food:ground_meat", "food:cornmeal", "default:stick",
      "default:stick", "default:stick"},
})

minetest.register_craft({
   type = "cooking",
   output = "food:corn_dog",
   recipe = "food:corn_dog_raw",
})

-- hamburger
-- cheeseburger
minetest.register_craftitem("food:hamburger", {
   description = S("Hamburger"),
   inventory_image = "food_hamburger.png",
   on_use = minetest.item_eat(6),
})

minetest.register_craftitem("food:cheeseburger", {
   description = S("Double Cheeseburger"),
   inventory_image = "food_cheeseburger.png",
   on_use = minetest.item_eat(8),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:hamburger",
   recipe = {"food:bread", "food:grilled_patty", "food:tomato_slice",
             "food:onion_slice"},
})

minetest.register_craft({
   type = "shapeless",
   output = "food:cheeseburger",
   recipe = {"food:bread", "food:grilled_patty", "food:cheese",
             "food:grilled_patty", "food:cheese"},
})

-- MARINARA
minetest.register_craftitem("food:marinara", {
   description = S("Jar of Marinara Sauce"),
   inventory_image = "food_marinara.png",
   groups = {vessel = 1},
   on_use = minetest.item_eat(6),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:marinara",
   recipe = {"farming:tomato", "farming:tomato", "farming:onion", "farming:garlic_clove"}
})

-- spaghetti, lasagna, pizza
minetest.register_craftitem("food:spaghetti", {
   description = S("Spaghetti"),
   inventory_image = "food_spaghetti.png",
   on_use = minetest.item_eat(3),
})

minetest.register_craftitem("food:lasagna", {
   description = S("Lasagna"),
   inventory_image = "food_lasagna.png",
   on_use = minetest.item_eat(4),
})

-- SPAGHETTI AND LASAGNA

minetest.register_craft({
   type = "shapeless",
   output = 'food:spaghetti 5',
   recipe = {"food:marinara", "food:pasta", "food:pasta",
             "food:pasta", "food:pasta", "food:pasta"},
})


minetest.register_craft({
   type = "shapeless",
   output = 'food:lasagna 5',
   recipe = {"food:marinara", "food:pasta", "food:pasta",
             "food:pasta", "food:pasta", "food:pasta", "food:cheese"},
})

-- PIZZA
minetest.register_craftitem("food:cheese_pizza", {
   description = S("Cheese Pizza"),
   inventory_image = "food_cheese_pizza.png",
   on_use = minetest.item_eat(3),
})

minetest.register_craft({
   type = "shapeless",
   output = 'food:cheese_pizza 8',
   recipe = {"food:flour", "food:marinara", "food:cheese"},
})

minetest.register_craftitem("food:pepperoni_pizza", {
   description = S("Pepperoni Pizza"),
   inventory_image = "food_pepperoni_pizza.png",
   on_use = minetest.item_eat(5),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:pepperoni_pizza 8",
   recipe = {"food:flour", "food:marinara", "food:cheese",
             "food:pepperoni"},
})

minetest.register_craftitem("food:deluxe_pizza", {
   description = S("Deluxe Pizza"),
   inventory_image = "food_deluxe_pizza.png",
   on_use = minetest.item_eat(8),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:deluxe_pizza 8",
   recipe = {"food:flour", "food:marinara", "food:cheese",
             "food:pepperoni", "food:onion_slice",
            "food:tomato_slice", "flowers:mushroom_brown"}
})

minetest.register_craftitem("food:pineapple_pizza", {
   description = S("Pineapple Pizza"),
   inventory_image = "food_pineapple_pizza.png",
   on_use = minetest.item_eat(5),
})
minetest.register_craft({
   type = "shapeless",
   output = "food:pineapple_pizza 8",
   recipe = {"food:flour", "food:marinara", "food:cheese",
             "food:ground_meat", "farming:pineapple_ring"},
})

minetest.register_craft({
   type = "shapeless",
   output = "food:salsa",
   recipe = {"farming:chili_pepper", "farming:onion", "farming:tomato"},
})

-- COTTONSEED OIL
minetest.register_craftitem("food:cottonseed_oil", {
   description = S("Cottonseed Oil"),
   inventory_image = "food_cottonseed_oil.png",
   groups = {vessel = 1, food_oil = 1}
})

minetest.register_craft({
   output = 'food:cottonseed_oil',
   recipe = {
      {'farming:seed_cotton', 'farming:seed_cotton', 'farming:seed_cotton'},
      {'farming:seed_cotton', 'farming:seed_cotton', 'farming:seed_cotton'},
      {'farming:seed_cotton', 'farming:seed_cotton', 'farming:seed_cotton'},
   }
})


technic.register_extractor_recipe({input = {"farming:seed_cotton 4"},
	output = "food:cottonseed_oil"})


minetest.register_craft({
   type = "fuel",
   recipe = "food:cottonseed_oil",
   burntime = 40,
})

-- SALSA
minetest.register_craftitem("food:salsa", {
   description = S("Jar of Salsa"),
   inventory_image = "food_salsa.png",
   groups = {vessel = 1},
   on_use = minetest.item_eat(6),
})

-- TORTILLA, TACOS AND QUESADILLA
minetest.register_craftitem("food:flour_tortilla", {
   description = S("Flour Tortilla"),
   inventory_image = "food_flour_tortilla.png",
   on_use = minetest.item_eat(1),
})

minetest.register_craft({
   type = "shapeless",
   output = 'food:flour_tortilla 10',
   recipe = {'food:flour', 'group:food_oil'},
})

minetest.register_craftitem("food:taco", {
   description = S("Taco"),
   inventory_image = "food_taco.png",
   on_use = minetest.item_eat(4),
})

minetest.register_craft({
   type = "shapeless",
   output = 'food:taco 5',
   recipe = {'food:ground_meat', "food:cheese", 'food:flour_tortilla',
         'food:flour_tortilla', 'food:flour_tortilla',
         'food:flour_tortilla', 'food:flour_tortilla'},
})

minetest.register_craftitem("food:super_taco", {
   description = S("Super Taco"),
   inventory_image = "food_taco.png",
   on_use = minetest.item_eat(6),
})

minetest.register_craft({
   type = "shapeless",
   output = "food:super_taco 5",
   recipe = {"food:salsa", "food:taco", "food:taco",
             "food:taco", "food:taco","food:taco"},
 })

minetest.register_craftitem("food:quesadilla", {
   description = S("Quesadilla"),
   inventory_image = "food_flour_tortilla.png",
   on_use = minetest.item_eat(6),
})

minetest.register_craft({
   output = "food:quesadilla 3",
   recipe = {
      {'food:flour_tortilla', 'food:flour_tortilla', 'food:flour_tortilla'},
      {"food:salsa", "food:cheese",""},
      {'food:flour_tortilla', 'food:flour_tortilla', 'food:flour_tortilla'},
   },
})

-- ONION RINGS, POTATO CRISPS, FRENCH FRIES, BLOOMING ONION, and FISH STICKS
minetest.register_craftitem("food:onion_rings", {
   description = S("Onion Rings"),
   inventory_image = "food_onion_rings.png",
   on_use = minetest.item_eat(3),
})

minetest.register_craftitem("food:potato_crisps", {
   description = S("Potato Crisps"),
   inventory_image = "food_potato_crisps.png",
   on_use = minetest.item_eat(2),
})

minetest.register_craftitem("food:french_fries", {
   description = S("French Fries"),
   inventory_image = "food_french_fries.png",
   on_use = minetest.item_eat(2),
})

minetest.register_craftitem("food:blooming_onion", {
   description = S("Blooming Onion"),
   inventory_image = "food_blooming_onion.png",
   on_use = minetest.item_eat(10),
})

minetest.register_craftitem("food:fish_sticks", {
   description = S("Fish Sticks"),
   inventory_image = "food_fish_sticks.png",
   on_use = minetest.item_eat(3),
})

local alloy_recipes = {
   {"food:onion_slice 4",  "group:food_oil", "food:onion_rings 4"},
   {"food:potato_slice 8", "group:food_oil", "food:potato_crisps 8"},
	{"farming:potato", "group:food_oil", "food:french_fries 4"},
	{"farming:onion", "group:food_oil", "food:blooming_onion"},
	{"mobs:fish_raw", "group:food_oil", "food:fish_sticks 4"},
      }

for _, data in pairs(alloy_recipes) do
   technic.register_alloy_recipe(
      {input = {data[1], data[2]},
       output = data[3], time = data[4]})
end

-- CORNMEAL AND CORNBREAD

minetest.register_craftitem("food:cornmeal", {
   description = S("Corn Meal"),
   inventory_image = "food_cornmeal.png",
})

minetest.register_craftitem("food:cornbread", {
   description = S("Cornbread"),
   inventory_image = "food_cornbread.png",
   on_use = minetest.item_eat(10),
})
minetest.register_craft({
   type = "shapeless",
   output = 'food:cornmeal 4',
   recipe = {"farming:corn", "farming:corn","farming:corn", "farming:corn"},
})

table.insert(grinder_recipes, {"farming:corn",   "food:cornmeal 2"})

for _, data in pairs(grinder_recipes) do
   technic.register_grinder_recipe({input = {data[1]}, output = data[2]})
end
		 
minetest.register_craft({
   type = "cooking",
   cooktime = 10,
   output = "food:cornbread",
   recipe = "food:cornmeal"
})


