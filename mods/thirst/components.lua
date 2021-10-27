--[[

Default components for Thirst.

These are nodes and items that "implement" the functionality
from functions.lua

See init.lua for license.

]]


--[[

Drinking containers (Tier 1)

Defines a simple wooden bowl which can be used on water to fill
your hydration.

Optionally also augments the nodes from vessels to enable drinking
on use.

]]

if minetest.get_modpath("vessels") and thirst.config.register_vessels then
    -- add "drinking" to vessels
    thirst.augment_item_for_drinking('vessels:drinking_glass', 22)
    thirst.augment_item_for_drinking('vessels:glass_bottle', 24)
    thirst.augment_item_for_drinking('vessels:steel_bottle', 26)
end

if minetest.get_modpath("default") and thirst.config.register_bowl then
	if (minetest.registered_items["default:bowl"]) then
		minetest.override_item("default:bowl",{
			liquids_pointable = true,
			on_use = thirst.on_use(nil),
		})
	else
		-- our own simple wooden bowl
		minetest.register_craftitem('thirst:wooden_bowl', {
			description = "Wooden bowl",
			inventory_image = "thirst_bowl_16.png",
			liquids_pointable = true,
			on_use = thirst.on_use(nil),
		})

		minetest.register_craft({
        output = "thirst:wooden_bowl",
        recipe = {
            {"group:wood", "", "group:wood"},
            {"", "group:wood", ""}
        }
		})
	 end
end

--[[

Hydro containers (Tier 2)

Defines canteens (currently two types, with different capacities),
tools which store hydro. They use wear to show their content
level in their durability bar; they do not disappear when used up.

Wear corresponds to hydro level as follows:
- a wear of 0     shows no durability bar       -> empty (initial state)
- a wear of 1     shows a full durability bar   -> full
- a wear of 65535 shows an empty durability bar -> empty

]]

if minetest.get_modpath("default") and thirst.config.register_canteens then

    minetest.register_tool('thirst:steel_canteen', {
        description = 'Steel canteen',
        inventory_image = "thirst_steel_canteen_16.png",
        liquids_pointable = true,
        stack_max = 1,
        on_use = thirst.on_use(nil),
    })

    minetest.register_tool('thirst:bronze_canteen', {
        description = 'Bronze canteen',
        inventory_image = "thirst_bronze_canteen_16.png",
        liquids_pointable = true,
        stack_max = 1,
        on_use = thirst.on_use(nil),
    })

    minetest.register_craft({
        output = "thirst:steel_canteen",
        recipe = {
            { "group:wood", ""},
            { "default:steel_ingot", "default:steel_ingot"},
            { "default:steel_ingot", "default:steel_ingot"}
        }
    })
    minetest.register_craft({
        output = "thirst:bronze_canteen",
        recipe = {
            { "group:wood", ""},
            { "default:bronze_ingot", "default:bronze_ingot"},
            { "default:bronze_ingot", "default:bronze_ingot"}
        }
    })

end

--[[

Tier 3

]]

if minetest.get_modpath("default") and minetest.get_modpath("bucket") and thirst.config.register_drinking_fountain then

    minetest.register_node('thirst:drinking_fountain', {
        description = 'Drinking fountain',
        drawtype = 'nodebox',
        tiles = {
            -- top, bottom, right, left, front, back
            'thirst_drinkfount_top.png',
            'thirst_drinkfount_bottom.png',
            'thirst_drinkfount_side.png',
            'thirst_drinkfount_side.png',
            'thirst_drinkfount_side.png',
            'thirst_drinkfount_side.png',
        },
        paramtype = 'light',
        groups = { cracky = 2 },
        node_box = {
            type = "fixed",
            fixed = {
                { -3/16, -8/16, -3/16, 3/16, 3/16, 3/16 },
                { -8/16, 3/16, -8/16, 8/16, 6/16, 8/16 },
                { -8/16, 6/16, -8/16, 8/16, 8/16, -6/16 },
                { -8/16, 6/16, 6/16, 8/16, 8/16, 8/16 },
                { -8/16, 6/16, -6/16, -6/16, 8/16, 6/16 },
                { 6/16, 6/16, -6/16, 8/16, 8/16, 6/16 },
            },
        },
        selection_box = {
            type = "regular",
        },
        collision_box = {
            type = "regular",
        },
        on_rightclick = thirst.on_rightclick(nil),
    })

    minetest.register_craft({
        output = "thirst:drinking_fountain",
        recipe = {
            { "default:stone", "bucket:bucket_water", "default:stone"},
            { "", "default:stone", ""},
            { "", "default:stone", ""}
        }
    })

end

--[[

Tier 4+: the water fountains, plus extenders

]]

if minetest.get_modpath("default") and minetest.get_modpath("bucket") and thirst.config.register_fountains then

    minetest.register_node('thirst:water_fountain', {
        description = 'Water fountain',
        tiles = {
            -- top, bottom, right, left, front, back
            'thirst_waterfountain_top.png',
            'thirst_waterfountain_top.png',
            'thirst_waterfountain_side.png',
            'thirst_waterfountain_side.png',
            'thirst_waterfountain_side.png',
            'thirst_waterfountain_side.png',
        },
        paramtype = 'light',
        groups = { cracky = 2 },
    })

    minetest.register_node('thirst:water_extender', {
        description = 'Water fountain extender',
        tiles = {
            'thirst_waterextender_top.png',
            'thirst_waterextender_top.png',
            'thirst_waterextender_side.png',
            'thirst_waterextender_side.png',
            'thirst_waterextender_side.png',
            'thirst_waterextender_side.png',
        },
        paramtype = 'light',
        groups = { cracky = 2 },
    })

    minetest.register_craft({
        output = "thirst:water_fountain",
        recipe = {
            { "default:copper_ingot", "bucket:bucket_water", "default:copper_ingot"},
            { "", "default:copper_ingot", ""},
            { "default:copper_ingot", "default:mese_crystal", "default:copper_ingot"}
        }
    })
    minetest.register_craft({
        output = "thirst:water_extender",
        recipe = {
            { "", "bucket:bucket_water", ""},
            { "", "default:copper_ingot", ""},
            { "default:copper_ingot", "default:mese_crystal", "default:copper_ingot"}
        }
    })


    minetest.register_abm({
        nodenames = {'thirst:water_fountain'},
        interval = 2,
        chance = 5,
        action = thirst.fountain_abm,
    })

end

--[[

Tier 5

These amulets don't do much; the actual code is above, where
they are searched for in player's inventories

]]

if minetest.get_modpath("default") and minetest.get_modpath("bucket") and thirst.config.register_amulets then

    minetest.register_craftitem('thirst:injector', {
        description = 'Water injector',
        inventory_image = 'thirst_injector.png',
    })
    minetest.register_craft({
        output = "thirst:injector",
        recipe = {
            { "default:diamond", "default:mese_crystal", "default:diamond"},
            { "default:mese_crystal", "bucket:bucket_water", "default:mese_crystal"},
            { "default:diamond", "default:mese_crystal", "default:diamond"}
        }
    })

    minetest.register_craftitem('thirst:extractor', {
        description = 'Water extractor',
        inventory_image = 'thirst_extractor.png',
    })
    minetest.register_craft({
        output = "thirst:extractor",
        recipe = {
            { "default:mese_crystal", "default:diamond", "default:mese_crystal"},
            { "default:diamond", "bucket:bucket_water", "default:diamond"},
            { "default:mese_crystal", "default:diamond", "default:mese_crystal"}
        }
    })

end
