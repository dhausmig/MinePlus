if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
screwdriver = screwdriver or {}
local S = minetest.get_translator("enchanting")
local FS = function(...) return minetest.formspec_escape(S(...)) end
local ceil, abs, random = math.ceil, math.abs, math.random
local reg_tools = minetest.registered_tools

-- Cost in Mese crystal(s) for enchanting.
local mese_cost = 1

-- Force of the enchantments.
local enchanting = {
	uses     = 1.2,  -- Durability
	times    = 0.1,  -- Efficiency
	damages  = 1,    -- Sharpness
}

local function cap(str) return
	str:gsub("^%l", string.upper)
end

local function to_percent(orig_value, final_value)
	return abs(ceil(((final_value - orig_value) / orig_value) * 100))
end

function enchanting:get_tooltip(enchant, orig_caps, fleshy)
	local bonus = {durable = 0, efficiency = 0, damages = 0}

	if orig_caps then
		bonus.durable = to_percent(orig_caps.uses, orig_caps.uses * enchanting.uses)
		local sum_caps_times = 0
		for i=1, #orig_caps.times do
			sum_caps_times = sum_caps_times + orig_caps.times[i]
		end
		local average_caps_time = sum_caps_times / #orig_caps.times
		bonus.efficiency = to_percent(average_caps_time, average_caps_time -
					      enchanting.times)
	end

	if fleshy then
		bonus.damages = to_percent(fleshy, fleshy + enchanting.damages)
	end

	local specs = { -- not finished, to complete
		durable = {"#00baff", " (+" .. bonus.durable .. "%)"},
		fast    = {"#74ff49", " (+" .. bonus.efficiency .. "%)"},
		sharp   = {"#ffff00", " (+" .. bonus.damages .. "%)"},
	}

	local enchant_loc = {
		fast = S("Efficiency"),
		durable = S("Durability"),
		sharp = S("Sharpness"),
	}

	return minetest.colorize and minetest.colorize(specs[enchant][1],
			"\n" .. enchant_loc[enchant] .. specs[enchant][2]) or
			"\n" .. enchant_loc[enchant] .. specs[enchant][2]
end

local enchant_buttons = {
	"image_button[3.9,0.85;4,0.92;bg_btn.png;fast;"..FS("Efficiency").."]" ..
	"image_button[3.9,1.77;4,1.12;bg_btn.png;durable;"..FS("Durability").."]",
	"image_button[3.9,2.9;4,0.92;bg_btn.png;sharp;"..FS("Sharpness").."]",
}

function enchanting.formspec(pos, num)
	local meta = minetest.get_meta(pos)
	local formspec = [[ size[9,9;]
			bgcolor[#080808BB;true]
			background[0,0;9,9;ench_ui.png]
			list[context;tool;0.9,2.9;1,1;]
			list[context;mese;2,2.9;1,1;]
			list[current_player;main;0.5,4.5;8,4;]
			listring[current_player;main]
			listring[context;tool]
			listring[current_player;main]
			listring[context;mese]
			image[2,2.9;1,1;mese_layout.png]
			]]
			.."tooltip[sharp;"..FS("Your weapon inflicts more damages").."]"
			.."tooltip[durable;"..FS("Your tool last longer").."]"
			.."tooltip[fast;"..FS("Your tool digs faster").."]"
			..default.gui_slots .. default.get_hotbar_bg(0.5,4.5)

	formspec = formspec .. (enchant_buttons[num] or "")
	meta:set_string("formspec", formspec)
end

function enchanting.on_put(pos, listname, _, stack)
	if listname == "tool" then
		local stackname = stack:get_name()
		local tool_groups = {
			"axe, pick, shovel, pickaxe",
			"sword, shortsword, spear",
		}

		for idx, tools in ipairs(tool_groups) do
			if tools:find(stackname:match(":(%w+)")) then
				enchanting.formspec(pos, idx)
			end
		end
	end
end

function enchanting.fields(pos, _, fields, sender)
	if not next(fields) or fields.quit then return end
	local inv = minetest.get_meta(pos):get_inventory()
	local tool = inv:get_stack("tool", 1)
	local mese = inv:get_stack("mese", 1)
	local orig_wear = tool:get_wear()
	local mod, name = tool:get_name():match("(.*):(.*)")
	local enchanted_tool = (mod or "") .. ":enchanted_" .. (name or "") .. "_" .. next(fields)
	if (orig_wear > 1) then
		our_mese_cost = mese_cost + 1
	else
		our_mese_cost = mese_cost
	end
	if mese:get_count() >= our_mese_cost and reg_tools[enchanted_tool] then
		minetest.sound_play("enchanting_enchanting", {
			to_player = sender:get_player_name(),
			gain = 0.8
		})

		tool:replace(enchanted_tool)
--		tool:add_wear(orig_wear)
		mese:take_item(our_mese_cost)
		inv:set_stack("mese", 1, mese)
		inv:set_stack("tool", 1, tool)
	end
end

function enchanting.dig(pos)
	local inv = minetest.get_meta(pos):get_inventory()
	return inv:is_empty("tool") and inv:is_empty("mese")
end

local function allowed(tool)
	if not tool then return end

	for item in pairs(reg_tools) do
		if item:find("enchanted_" .. tool) then
			return true
		end
	end
end

function enchanting.put(_, listname, _, stack)
	local stackname = stack:get_name()
	if listname == "mese" and (stackname == "default:mese_crystal" or
			stackname == "imese:industrial_mese_crystal") then
		return stack:get_count()
	elseif listname == "tool" and allowed(stackname:match("[^:]+$")) then
		return 1
	end

	return 0
end

function enchanting.on_take(pos, listname)
	if listname == "tool" then
		enchanting.formspec(pos)
	end
end

function enchanting.construct(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("infotext", S("Enchantment Table"))
	enchanting.formspec(pos)

	local inv = meta:get_inventory()
	inv:set_size("tool", 1)
	inv:set_size("mese", 1)

	minetest.add_entity({x = pos.x, y = pos.y + 0.85, z = pos.z}, "enchanting:book_open")
	local timer = minetest.get_node_timer(pos)
	timer:start(0.5)
end

function enchanting.destruct(pos)
	for _, obj in pairs(minetest.get_objects_inside_radius(pos, 0.9)) do
		if obj and obj:get_luaentity() and
				obj:get_luaentity().name == "enchanting:book_open" then
			obj:remove()
			break
		end
	end
end

function enchanting.timer(pos)
	local num = #minetest.get_objects_inside_radius(pos, 0.9)
	if num == 0 then
		minetest.add_entity({x = pos.x, y = pos.y + 0.85, z = pos.z}, "enchanting:book_open")
	end

	local minp = {x = pos.x - 2, y = pos.y,     z = pos.z - 2}
	local maxp = {x = pos.x + 2, y = pos.y + 1, z = pos.z + 2}

	local bookshelves = minetest.find_nodes_in_area(minp, maxp, "group:bookshelf")
	if #bookshelves == 0 then
		return true
	end

	local bookshelf_pos = bookshelves[random(1, #bookshelves)]
	local x = pos.x - bookshelf_pos.x
	local y = bookshelf_pos.y - pos.y
	local z = pos.z - bookshelf_pos.z

	if tostring(x .. z):find(2) then
		minetest.add_particle({
			pos = bookshelf_pos,
			velocity = {x = x, y = 2 - y, z = z},
			acceleration = {x = 0, y = -2.2, z = 0},
			expirationtime = 1,
			size = 1.5,
			glow = 5,
			texture = "enchanting_glyph" .. random(1,18) .. ".png"
		})
	end

	return true
end

minetest.register_node("enchanting:enchantment_table", {
	description = S("Enchantment Table"),
	tiles = {
		"enchanting_table_top.png",  "enchanting_table_bottom.png",
		"enchanting_table_side.png", "enchanting_table_side.png",
		"enchanting_table_side.png", "enchanting_table_side.png"
	},
	groups = {cracky = 1, level = 1},
	light_source = 6,
	sounds = default.node_sound_stone_defaults(),
	on_rotate = screwdriver.rotate_simple,
	can_dig = enchanting.dig,
	on_timer = enchanting.timer,
	on_construct = enchanting.construct,
	on_destruct = enchanting.destruct,
	on_receive_fields = enchanting.fields,
	on_metadata_inventory_put = enchanting.on_put,
	on_metadata_inventory_take = enchanting.on_take,
	allow_metadata_inventory_put = enchanting.put,
	allow_metadata_inventory_move = function()
		return 0
	end,
})

minetest.register_entity("enchanting:book_open", {
	visual = "sprite",
	visual_size = {x=0.75, y=0.75},
	collisionbox = {0},
	physical = false,
	textures = {"enchanting_book_open.png"},
	on_activate = function(self)
		local pos = self.object:get_pos()
		local pos_under = {x = pos.x, y = pos.y - 1, z = pos.z}

		if minetest.get_node(pos_under).name ~= "enchanting:enchantment_table" then
			self.object:remove()
		end
	end
})

function enchanting:register_tools(mod, def)
	for tool in pairs(def.tools) do
	for material in def.materials:gmatch("[%w_]+") do
	for enchant in def.tools[tool].enchants:gmatch("[%w_]+") do
		local original_tool = reg_tools[mod .. ":" .. tool .. "_" .. material]
		if not original_tool then break end
		local original_toolcaps = original_tool.tool_capabilities

		if original_toolcaps then
			local original_damage_groups = original_toolcaps.damage_groups
			local original_groupcaps = original_toolcaps.groupcaps
			local groupcaps = table.copy(original_groupcaps)
			local fleshy = original_damage_groups.fleshy
			local full_punch_interval = original_toolcaps.full_punch_interval
			local max_drop_level = original_toolcaps.max_drop_level
			local group = next(original_groupcaps)
			local original_desc = original_tool.description

			if enchant == "durable" then
				groupcaps[group].uses = ceil(original_groupcaps[group].uses *
							     enchanting.uses)
			elseif enchant == "fast" then
				for i, time in pairs(original_groupcaps[group].times) do
					groupcaps[group].times[i] = time - enchanting.times
				end
			elseif enchant == "sharp" then
				fleshy = fleshy + enchanting.damages
			end
			minetest.register_tool(":" .. mod .. ":enchanted_" .. tool .. "_" .. material .. "_" .. enchant, {
				description = "".. core.colorize("#ffff00", "Enchanted ")..original_desc..
					self:get_tooltip(enchant, original_groupcaps[group], fleshy),
				inventory_image = original_tool.inventory_image,
				wield_image = original_tool.wield_image,
				groups = {not_in_creative_inventory = 1},
				light_source = 8,
				tool_capabilities = {
					groupcaps = groupcaps, damage_groups = {fleshy = fleshy},
					full_punch_interval = full_punch_interval,
					max_drop_level = max_drop_level
				}
			})
		end
	end
	end
	end
end

enchanting:register_tools("default", {
	materials = "steel, bronze, mese, diamond",
	tools = {
		axe    = {enchants = "durable, fast", desc = S("Axe")},
		pick   = {enchants = "durable, fast", desc = S("Pickaxe")},
		shovel = {enchants = "durable, fast", desc = S("Shovel")},
		sword  = {enchants = "sharp", desc = S("Sword")}
	},
})

if (minetest.get_modpath("moreores") ~= nil) then
enchanting:register_tools("moreores", {
	materials = "silver, mithril",
	tools = {
		axe    = {enchants = "durable, fast", desc = S("Axe")},
		pick   = {enchants = "durable, fast", desc = S("Pickaxe")},
		shovel = {enchants = "durable, fast", desc = S("Shovel")},
		sword  = {enchants = "sharp", desc = S("Sword")}
	},
})
end

if (minetest.get_modpath("xtraores") ~= nil) then
enchanting:register_tools("xtraores", {
	materials = "nickel, platinum, palladium, cobalt, thorium, osmium, rhenium, vanadium, rarium, orichalcum,titanium, neutronium, radioactive",
	tools = {
		axe    = {enchants = "durable, fast", desc = S("Axe")},
		pickaxe   = {enchants = "durable, fast", desc = S("Pickaxe")},
		shovel = {enchants = "durable, fast", desc = S("Shovel")},
		sword  = {enchants = "sharp", desc = S("Sword")},
		shortsword = {enchants = "sharp", desc = "Shortsword"},
		spear = {enchants = "sharp", desc = "Spear"}
	},
})
end

 -- Recipes

minetest.register_craft({
	output = "enchanting:enchantment_table",
	recipe = {
		{"", "default:book", ""},
		{"default:diamond", "default:obsidian", "default:diamond"},
		{"default:obsidian", "default:obsidian", "default:obsidian"}
	}
})
