minetest.register_craftitem('maxhp:lifeforce1', { --Dropped by Zombies, Nether Larva,
   _doc_items_longdesc = "Increases max HP by 5 up to 50.",
   description = 'Low-tier Life Force\n+5, Max 50',
   inventory_image = 'maxhp_lifeforce1.png',
   groups = {not_in_creative_inventory = 1},
   on_use = function(itemstack, user, pointed_thing)
      if maxhp.max_hp_change(user, 5, 50) then
         itemstack:take_item(1); return itemstack
      end
   end
})

minetest.register_craftitem('maxhp:lifeforce2', { --Dropped by Oerkki, Dungeon Master
   _doc_items_longdesc = "Increases max HP by 5 up to 65.",
   description = 'Low-tier Life Force\n+5, Max 65',
   inventory_image = 'maxhp_lifeforce2.png',
   groups = {not_in_creative_inventory = 1},
   on_use = function(itemstack, user, pointed_thing)
      if maxhp.max_hp_change(user, 5, 65) then
         itemstack:take_item(1); return itemstack
      end
   end
})

minetest.register_craftitem('maxhp:lifeforce3', { --Dropped by big Scorpion
   _doc_items_longdesc = "Increases max HP by 5 up to 80.",
   description = 'Mid-tier Life Force\n+5, Max 80',
   inventory_image = 'maxhp_lifeforce3.png',
   groups = {not_in_creative_inventory = 1},
   on_use = function(itemstack, user, pointed_thing)
      if maxhp.max_hp_change(user, 5, 80) then
         itemstack:take_item(1); return itemstack
      end
   end
})

minetest.register_craftitem('maxhp:lifeforce4', { --Cavefreaks
   _doc_items_longdesc = "Increases max HP by 5 up to 95.",
   description = 'Mid-tier Life Force\n+5, Max 95',
   inventory_image = 'maxhp_lifeforce4.png',
   groups = {not_in_creative_inventory = 1},
   on_use = function(itemstack, user, pointed_thing)
      if maxhp.max_hp_change(user, 5, 95) then
         itemstack:take_item(1); return itemstack
      end
   end
})

minetest.register_craftitem('maxhp:lifeforce5', { --Nether Larva, Lava Titan
   _doc_items_longdesc = "Increases max HP by 5 up to 110.",
   description = 'Mid-tier Life Force\n+5, Max 110',
   inventory_image = 'maxhp_lifeforce5.png',
   groups = {not_in_creative_inventory = 1},
   on_use = function(itemstack, user, pointed_thing)
      if maxhp.max_hp_change(user, 5, 110) then
         itemstack:take_item(1); return itemstack
      end
   end
})

minetest.register_craftitem('maxhp:lifeforce6', { --Viron
   _doc_items_longdesc = "Increases max HP by 5 up to 125.",
   description = 'Hi-tier Life Force\n+5, Max 125',
   inventory_image = 'maxhp_lifeforce6.png',
   groups = {not_in_creative_inventory = 1},
   on_use = function(itemstack, user, pointed_thing)
      if maxhp.max_hp_change(user, 5, 125) then
         itemstack:take_item(1); return itemstack
      end
   end
})
