if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end

-- mobs_humans
-- based on the following

--[[
	Mobs Humans - Adds human mobs.
	Copyright © 2018-2019 Hamlet <hamlatmesehub@riseup.net>

	Licensed under the EUPL, Version 1.2 or – as soon they will be
	approved by the European Commission – subsequent versions of the
	EUPL (the "Licence");
	You may not use this work except in compliance with the Licence.
	You may obtain a copy of the Licence at:

	https://joinup.ec.europa.eu/software/page/eupl
	https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:32017D0863

	Unless required by applicable law or agreed to in writing,
	software distributed under the Licence is distributed on an
	"AS IS" basis,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
	implied.
	See the Licence for the specific language governing permissions
	and limitations under the Licence.

--]]

-- Used for localization

local S = minetest.get_translator("mobs_humans")


--
-- General variables
--

local mob_difficulty = tonumber(minetest.settings:get("mob_difficulty"))
if (mob_difficulty == nil) then
	 mob_difficulty = 1
end

local show_nametags = minetest.settings:get_bool("mobs_humans_use_nametags")
if (show_nametags == nil) then
	show_nametags = true
end

local function upper(str)
    return str:gsub("^%l", string.upper)
end

--
-- Custom bones node
--

minetest.register_node("mobs_humans:human_bones", {
	description = S("Human Bones"),
	drawtype = "mesh",
	mesh = "mobs_humans_bones_model.obj",
	tiles = {"mobs_humans_bones.png"},
	use_texture_alpha = "clip",
	inventory_image = "mobs_humans_bones_inv.png",
	wield_image = "mobs_humans_bones_inv.png",
	selection_box =  {
		type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.0, 0.5}
			},
	},
	walkable = false,
	pointable = true,
	diggable = true,
	buildable_to = true,
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate = 2, falling_node = 1},
	sounds = default.node_sound_gravel_defaults(),

	on_construct = function(pos)
		minetest.check_single_for_falling(pos)
		minetest.get_node_timer(pos):start(math.random(300, 600))
	end,

	on_timer = function(pos, elapsed)
		minetest.get_node_timer(pos):stop()
		minetest.swap_node(pos, {name = "air"})
	end
})


--
-- Chat messages
--

local MESSAGE_1 = S("Saluton ")
local MESSAGE_2 = S(", my name is ")
local addenda = {"Tin and copper start at -64.",
					"Iron starts at -128.",
					"Gold starts at -256.",
					"You can find Mese below -512.",
					"There are diamonds below -1024.",
					"There are Mese Blocks below -2048.",
					"Nickel is all over up to 100 elevation.",
					"Platinum starts at -85.",
					"Palladium starts at -250.",
					"Cobalt starts at -600.",
					"Thorium starts at -1250.",
					"Anthracite starts at -2000.",
					"Osmium starts at -3500.",
					"Rhenium starts at -5750.",
					"Vanadium starts at -8000.",
					"Rarium starts at -10000.",
					"Orichalcum starts at -12500.",
					"Titanium starts at -15000.",
					"Iridium starts at -15000.",
					"Neutronium starts at -18000.",
					"Silver starts at -2.",
					"Mithril starts at -512.",
					"Uranium is only between -80 and -300.",
					"Chromium starts at -100.",
					"Zinc can be found at elevation 2 and below.",
					"Lead starts at 16 and goes down from there.",
					"There's Ancient Portalstone in the nether.",
		}
--
-- Functions
--

local function flip_coin()
	return math.random(0, 1)
end

local function boolean()
	if (flip_coin() == 0) then
		return false
	else
		return true
	end
end


local function attack_type()
	local attack_name = {"dogfight", "shoot", "dogshoot"}
--[[
	local number = 
	local attack_name = nil
	if (number == 1) then
		attack_name = "dogfight"
	elseif (number == 2) then
		attack_name = "shoot"
	else
		attack_name = "dogshoot"
	end
	return attack_name
--]]
	return attack_name[math.random(1, 3)]
end


local function dps(self, element)
	local damage_speed = nil
	local hit_points = nil
	local time_speed = nil
	local in_game_day_length = nil
	local five_in_game_minutes = nil
	local damage_per_second = nil

	hit_points = self.health
	time_speed = tonumber(minetest.settings:get("time_speed"))

	if (time_speed == nil) then
		time_speed = 72

	elseif (time_speed == 0) then
		time_speed = 1
	end

	if (element == "water") then
		damage_speed = 300

	elseif (element == "lava") then
		damage_speed = 100
	end

	in_game_day_length = 86400 / time_speed
	five_in_game_minutes = (in_game_day_length * damage_speed) / 86400
	damage_per_second = hit_points / five_in_game_minutes

	return damage_per_second
end


local function experience(self)
	if (self.attack == nil) and (self.engaged ~= true) then
		return

	elseif (self.attack ~= nil) and (self.engaged ~= true) then
		self.engaged = true

		self.object:set_properties({engaged = self.engaged})

	elseif (self.attack == nil) and (self.engaged == true) then
		self.engaged = false

		self.object:set_properties({engaged = self.engaged})

		if (self.damage < (8 * mob_difficulty)) then
			self.damage = self.damage + 1
			self.object:set_properties({damage = self.damage})
		end

		if (self.armor > 10) then
			self.armor = self.armor - 1
			self.object:set_properties({armor = self.armor})
		end
	end
end


local function heal_over_time(self, dtime)
	-- For backward compatibility
	if (self.heal_counter == nil)
	or (self.initial_hp == nil)
	or (self.injured == nil)
	then
		self.heal_counter = 4.0
		-- used for health recovery

		self.initial_hp = math.random(self.hp_min, self.hp_max)
		-- used as reference when recovering health

		-- used to determine whether if in need of healing
		if (self.health == self.initial_hp) then
			self.injured = false

		else
			self.injured = true

		end

		self.object:set_properties({
			heal_counter = self.heal_counter,
			initial_hp = self.initial_hp,
			injured = self.injured
		})
	end

	if (self.injured == true) then
		if (self.state ~= "attack") and (self.state ~= "runaway") then
			-- recover 1HP every 4 seconds
			if (self.health < self.initial_hp) then
				if (self.heal_counter > 0) then
					self.heal_counter = self.heal_counter - dtime

					self.object:set_properties({
						heal_counter = self.heal_counter
					})

				else
					self.heal_counter = 4.0
					self.health = self.health + 1
					self.object:set_hp(self.health)

					self.object:set_properties({
						heal_counter = self.heal_counter
					})

				end

			elseif (self.health == self.initial_hp) then
				self.injured = false

				self.object:set_properties({injured = self.injured})
			end
		end
	end
end


local function random_name()

	local length = math.random(3, 6)
	local first_letter = true
	local next_letter = flip_coin()
	local string = ""

	local vowels = {"a", "e", "i", "o", "u", "ya",
		"a", "e", "i", "o", "u",  -- repeat to increase chance of use
		"a", "e", "i", "o", "u",
		"a", "e", "i", "o", "u",
		"aa", "ae", "ai", "ao", "au", "ay",
		"ea", "ee", "ei", "eo", "eu", "ey",
		"ia", "ie", "io", "iu",
		"oa", "oe", "oi", "oo", "ou", "oy",
		"ua", "ue", "ui", "uo", "uy",
		"y", "ye", "yi", "yo", "yu",
	}

	local consonants = {
		"b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "x", "z",
		"b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w",
		"bl", "br", "dr", "gl", "gr", "kl", "pl", "pr", "sp", "st", "tr", "vl",  -- end of first_letter choices
		"dd", "dh", "dl", "dz","bb", "gg", "kk", "kr", "ks",
		"ll", "lm", "ln", "lb", "lp", "ld", "lt", "lg", "lk", "ls",
		"ln", "lv", "lf", "lħ", "mm", "mb", "mp", "mr", "ms", "mf",
		"nn", "nd", "nt", "ng", "nk", "nr", "ns", "nh", "pp", "ps",
		"rr", "rm", "rn", "rb", "rp", "rd", "rt", "rg", "rk", "rs",
		"rn", "rv", "rf", "rħ", "ss", "sk", "sf",
		"tt", "tl", "ts", "vr",
	}

	for initial_value = 1, length do
		if next_letter == 0 then
			if first_letter then
				string = string..(vowels[math.random(1, 20)])
			else
				string = string..(vowels[math.random(1, #vowels)])
			end
		else
			if first_letter then
				string = string..(consonants[math.random(1, 48)])
			else
				string = string..(consonants[math.random(1, #consonants)])
			end
		end
		first_letter = false
		next_letter = 1 - next_letter
	end
	-- capitalize the first letter of the name

	return upper(string)
end


local function random_type()
	local type = "npc"
	local number = math.random(1, 20)

	if (number <= 5) then
		type = "monster"

	elseif (number >= 16) then
		type = "animal"
	end

	return type
end


--
-- Entity definition
--

mobs:register_mob("mobs_humans:human", {
	nametag = "",
	given_name = nil,
	type = nil,
	hp_min = 15,
	hp_max = 20,
	initial_hp = nil,
	armor = nil,
	passive = nil,
	walk_velocity = 4,
	run_velocity = 4,
	walk_chance = nil,
	jump = false,
	runaway = nil,
	view_range = nil,
	damage = nil,
	fall_damage = true,
	water_damage = nil,
	lava_damage = nil,
	suffocation = true,
	floats = nil,
	reach = 4,
	docile_by_day = nil,
	attacks_monsters = nil,
	attack_animals = nil,
	group_attack = nil,
	attack_type = "dogfight",
	arrow = "mobs_humans:stone",
	shoot_interval = 2,
	shoot_offset = 1.5,
	runaway_from = {
		"mobs_banshee:banshee",
		"mobs_ghost_redo:ghost",
		"mobs_others:snow_walker"
	},
	makes_footstep_sound = nil,
	sounds = {
		attack = "default_punch",
		shoot_attack = "mobs_swing"
	},
	visual = "mesh",
	visual_size = {x = 1, y = 1},
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.7, 0.3},
	textures = {
		{"mobs_humans_female_01.png"},
		{"mobs_humans_female_02.png"},
		{"mobs_humans_male_01.png"},
		{"mobs_humans_male_02.png"}
	},
	mesh = "character.b3d",
	animation = {
		stand_start = 0,
		stand_end = 79,
		stand_speed = 30,
		walk_start = 168,
		walk_end = 187,
		walk_speed = 30,
		run_start = 168,
		run_end = 187,
		run_speed = 30,
		punch_start = 189,
		punch_end = 198,
		punch_speed = 30,
		die_start = 162,
		die_end = 166,
		die_speed = 0.8
	},

	on_spawn = function(self, pos)

		-- Random values chosen for any human type
		self.given_name = random_name()
		self.type = random_type()
		self.initial_hp = math.random(self.hp_min, self.hp_max)
		self.heal_counter = 4.0
		self.injured = false
		self.armor = math.random(10, 100)
		self.walk_chance = math.random(10, 33)
		self.view_range = math.random(7, 15)
		self.damage = (math.random(1, 8) * mob_difficulty)
		self.water_damage = dps(self, "water")
		self.lava_damage = dps(self, "lava")
		self.floats = boolean()
		self.makes_footstep_sound = boolean()
		if (show_nametags == true) then
			if (self.type == "monster") then
				self.nametag = minetest.colorize("magenta", self.given_name ..
					" (" .. S("NPC") .. ")")
			else
				self.nametag = minetest.colorize("white", self.given_name ..
					" (" .. S("NPC") .. ")")
			end
		else
			self.nametag = ""
		end

		-- Random values chosen for specific human types
		if (self.type == "animal") then
			self.passive = boolean()
			self.runaway = boolean()

		elseif (self.type == "npc") then
			self.passive = boolean()
			self.attacks_monsters = boolean()
			self.group_attack = boolean()
			self.attack_type = attack_type()

		elseif (self.type == "monster") then
			self.docile_by_day = boolean()
			self.attack_animals = boolean()
			self.group_attack = boolean()
			self.attack_type = attack_type()

		end

		-- Values applied to any human type
		self.object:set_properties({
			given_name = self.given_name,
			type = self.type,
			heal_counter = self.heal_counter,
			initial_hp = self.initial_hp,
			injured = self.injured,
			walk_chance = self.walk_chance,
			view_range = self.view_range,
			damage = self.damage,
			water_damage = self.water_damage,
			lava_damage = self.lava_damage,
			floats = self.floats,
			makes_footstep_sound = self.makes_footstep_sound,
			nametag = self.nametag
		})

		self.object:set_armor_groups({
			immortal = 1,
			fleshy = self.armor
		})

		self.object:set_hp(self.initial_hp)

		-- Values applied to specific human types
		if (self.type == "animal") then
			self.object:set_properties({
				passive = self.passive,
				runaway = self.runaway
			})

		elseif (self.type == "npc") then
			self.object:set_properties({
				passive = self.passive,
				attacks_monsters = self.attacks_monsters,
				group_attack = self.group_attack,
				attack_type = self.attack_type
			})

		elseif (self.type == "monster") then
			self.object:set_properties({
				docile_by_day = self.docile_by_day,
				attack_animals = self.attack_animals,
				group_attack = self.group_attack,
				attack_type = self.attack_type
			})

		end
		return true
	end,

	do_punch = function(self)
		if (self.health < self.initial_hp) and (self.injured == false) then
			self.injured = true

			self.object:set_properties({injured = self.injured})
		end
	end,

	-- Health recover and experience gain
	do_custom = function(self, dtime)
		heal_over_time(self, dtime)

		if (self.type ~= "animal") then
			experience(self)
		end
	end,

	on_rightclick = function(self, clicker)
		if (self.health > 0)
		and (self.state ~= "attack")
		and (self.state ~= "runaway")
		then
			local player_name = clicker:get_player_name()

			local msg = MESSAGE_1 .. player_name .. MESSAGE_2
				.. self.given_name .. ".\n"
			minetest.chat_send_player(player_name, msg)
			if (math.random(1, 10) > 3) then
				local msg = addenda[(math.random(1 , #addenda))]
				minetest.chat_send_player(player_name, msg)
				if (math.random(1, 10) > 3) then
					local msg = addenda[(math.random(1 , #addenda))]
					minetest.chat_send_player(player_name, msg)
				end
			end
		end
	end,

	-- Bones' random spawner
	on_die = function(self, pos)
		local drop_bones = math.random(1, 12)

		if (drop_bones <= 8) then
			local pos = {x = pos.x, y = (pos.y -1), z = pos.z}
			local node_name = minetest.get_node(pos).name

			if (node_name == "air") then
				minetest.set_node(pos, {name="mobs_humans:human_bones"})
			end
		end
	end
})

--
-- Arrow entity
--

mobs:register_arrow("mobs_humans:stone", {
	visual = "sprite",
	visual_size = {x = 0.1, y = 0.1},
	textures = {"default_stone.png"},
	velocity = 9,
	hit_player = function(self, player)
		player:punch(self.object, 1,
			{
				full_punch_interval = 0.1,
				damage_groups = {fleshy = 6},
			}
		)
	end,

	hit_node = function(self, pos, node)
		self.object:remove()
	end
})

--
-- Entity spawner
--

mobs:spawn({
	name = "mobs_humans:human",
	nodes = {"group:crumbly"},
	neighbors = {"air"},
	max_light = 15,
	min_light = 0,
	interval = 60,
	chance = 7500,
	active_object_count = 2,
	min_height = 1,
	max_height = 240,
	day_toggle = nil
})

-- Spawn Egg

mobs:register_egg("mobs_humans:human", S("Spawn Human"), "mobs_humans_icon.png")


--
-- Alias
--

mobs:alias_mob("mobs:human", "mobs_humans:human")


--
-- Minetest engine debug logging
--
--[[
if (minetest.settings:get("debug_log_level") == nil)
or (minetest.settings:get("debug_log_level") == "action")
or (minetest.settings:get("debug_log_level") == "info")
or (minetest.settings:get("debug_log_level") == "verbose")
then
	minetest.log("action", "[Mod] Mobs Humans [v0.3.0] loaded.")
end
--]]