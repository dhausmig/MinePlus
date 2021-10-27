if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- Screwdrivers
-- Additional screwdrivers using other materials
-- by dhausmig

screwdrivers = {}
-- Stainless Steel Screwdriver
if (minetest.registered_items["technic:stainless_steel_ingot"] ~= nil) then
   minetest.register_tool("screwdrivers:screwdriver_stainless", {
	   description = "Stainless Steel Screwdriver\n(left-click rotates face, right-click rotates axis)",
   	inventory_image = "screwdrivers_stainless.png",
	   on_use = function(itemstack, user, pointed_thing)
		   screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, 400)
   		return itemstack
	   end,
   	on_place = function(itemstack, user, pointed_thing)
	   	screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, 400)
		   return itemstack
   	end,
   })

   minetest.register_craft({
	   output = "screwdrivers:screwdriver_stainless",
   	recipe = {
	   	{"technic:stainless_steel_ingot"},
		   {"group:stick"}
   	}
   })
end

-- Mese Screwdriver
minetest.register_tool("screwdrivers:screwdriver_mese", {
	description = "Mese Screwdriver\n(left-click rotates face, right-click rotates axis)",
	inventory_image = "screwdrivers_mese.png",
	on_use = function(itemstack, user, pointed_thing)
		screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, 800)
		return itemstack
	end,
	on_place = function(itemstack, user, pointed_thing)
		screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, 800)
		return itemstack
	end,
})

minetest.register_craft({
	output = "screwdrivers:screwdriver_mese",
	recipe = {
		{"default:mese_crystal"},
		{"group:stick"}
	}
})


-- Mithril Screwdriver
if (minetest.registered_items["moreores:mithril_ingot"] ~= nil) then
   minetest.register_tool("screwdrivers:screwdriver_mithril", {
	   description = "Mithril Screwdriver\n(left-click rotates face, right-click rotates axis)",
   	inventory_image = "screwdrivers_mithril.png",
	   on_use = function(itemstack, user, pointed_thing)
		   screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, 1600)
   		return itemstack
	   end,
   	on_place = function(itemstack, user, pointed_thing)
	   	screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, 1600)
		   return itemstack
   	end,
   })

   minetest.register_craft({
	   output = "screwdrivers:screwdriver_mithril",
   	recipe = {
	   	{"moreores:mithril_ingot"},
		   {"group:stick"}
   	}
   })
end


-- Crystal Screwdriver
if (minetest.registered_items["ethereal:crystal_ingot"] ~= nil) then
   minetest.register_tool("screwdrivers:screwdriver_crystal", {
	   description = "Crystal Screwdriver\n(left-click rotates face, right-click rotates axis)",
   	inventory_image = "screwdrivers_crystal.png",
	   on_use = function(itemstack, user, pointed_thing)
		   screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, 3200)
   		return itemstack
	   end,
   	on_place = function(itemstack, user, pointed_thing)
	   	screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, 3200)
		   return itemstack
   	end,
   })

   minetest.register_craft({
	   output = "screwdrivers:screwdriver_crystal",
   	recipe = {
	   	{"ethereal:crystal_ingot"},
		   {"default:steel_ingot"}
   	}
   })
end


-- Cobalt Screwdriver - same durability as Crystal
if (minetest.registered_items["xtraores:cobalt_bar"] ~= nil) then
   minetest.register_tool("screwdrivers:screwdriver_cobalt", {
	  description = "" ..core.colorize("#68fff6", "Cobalt Screwdriver\n")..core.colorize("#FFFFFF", "(left-click rotates face, right-click rotates axis)"),
      inventory_image = "screwdrivers_cobalt.png",
	   on_use = function(itemstack, user, pointed_thing)
		   screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, 3200)
   		   return itemstack
	       end,
   	   on_place = function(itemstack, user, pointed_thing)
	   	  screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, 3200)
		   return itemstack
        end,
   })

   minetest.register_craft({
	   output = "screwdrivers:screwdriver_cobalt",
   	recipe = {
	   	{"xtraores:cobalt_bar"},
		   {"xtraores:duraglass_handle"}
   	}
   })
end


-- Vanadium Screwdriver
if (minetest.registered_items["xtraores:vanadium_bar"] ~= nil) then
   minetest.register_tool("screwdrivers:screwdriver_vanadium", {
	  description = "" ..core.colorize("#68fff6", "Vanadium Screwdriver\n")..core.colorize("#FFFFFF", "(left-click rotates face, right-click rotates axis)"),
      inventory_image = "screwdrivers_vanadium.png",
	   on_use = function(itemstack, user, pointed_thing)
		   screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, 6400)
   		   return itemstack
	       end,
   	   on_place = function(itemstack, user, pointed_thing)
	   	  screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, 6400)
		   return itemstack
        end,
   })

   minetest.register_craft({
	   output = "screwdrivers:screwdriver_vanadium",
   	recipe = {
	   	{"xtraores:vanadium_bar"},
		   {"xtraores:duraglass_handle"}
   	}
   })
end


-- Titanium Screwdriver
if (minetest.registered_items["xtraores:titanium_bar"] ~= nil) then
   minetest.register_tool("screwdrivers:screwdriver_titanium", {
	  description = "" ..core.colorize("#68fff6", "Titanium Screwdriver\n")..core.colorize("#FFFFFF", "(left-click rotates face, right-click rotates axis)"),
      inventory_image = "screwdrivers_titanium.png",
	   on_use = function(itemstack, user, pointed_thing)
		   screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_FACE, 12800)
   		   return itemstack
	       end,
   	   on_place = function(itemstack, user, pointed_thing)
	   	  screwdriver.handler(itemstack, user, pointed_thing, screwdriver.ROTATE_AXIS, 12800)
		   return itemstack
        end,
   })

   minetest.register_craft({
	   output = "screwdrivers:screwdriver_titanium",
   	recipe = {
	   	{"xtraores:titanium_bar"},
		   {"xtraores:duraglass_handle"}
   	}
   })
end


