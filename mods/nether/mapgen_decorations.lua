--[[

  Register decorations for Nether mapgen

  Copyright (C) 2020 Treer

  Permission to use, copy, modify, and/or distribute this software for
  any purpose with or without fee is hereby granted, provided that the
  above copyright notice and this permission notice appear in all copies.

  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
  WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR
  BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES
  OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
  WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
  ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
  SOFTWARE.

]]--

-- Lava is unreliable in the old Nether mapgen because it removes lava
-- from the overdraw areas, so any decorations involving lava will often
-- have the lava missing depending on whether nearby chunks were already
-- emerged or not before the decoration was placed.
local allow_lava_decorations = nether.useBiomes

local _  = {name = "air",                     prob = 0}
local A  = {name = "air",                     prob = 255, force_place = true}
local G  = {name = "nether:glowstone",        prob = 255, force_place = true}
local N  = {name = "nether:rack",             prob = 255}
local B  = {name = "nether:basalt",           prob = 255}
local S  = {name = "nether:sand",             prob = 255, force_place = true}
local L  = {name = "default:lava_source",     prob = 255, force_place = true}
local F  = {name = "nether:fumarole",         prob = 255, force_place = true}
local FS = {name = "nether:fumarole_slab",    prob = 255, force_place = true}
local F1 = {name = "nether:fumarole_corner",  prob = 255, force_place = true, param2 = 0}
local F2 = {name = "nether:fumarole_corner",  prob = 255, force_place = true, param2 = 1}
local F3 = {name = "nether:fumarole_corner",  prob = 255, force_place = true, param2 = 2}
local F4 = {name = "nether:fumarole_corner",  prob = 255, force_place = true, param2 = 3}
local S1 = {name = "stairs:stair_netherrack", prob = 255, force_place = true, param2 = 5}
local S2 = {name = "stairs:stair_netherrack", prob = 255, force_place = true, param2 = 7}
local S3 = {name = "stairs:stair_netherrack", prob = 255, force_place = true, param2 = 12}
local S4 = {name = "stairs:stair_netherrack", prob = 255, force_place = true, param2 = 16}


-- =================
--    Stalactites
-- =================

local schematic_GlowstoneStalactite = {
    size = {x = 5, y = 10, z = 5},
    data = { -- note that data is upside down
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, N, G, N, _,
        _, N, N, N, _,

        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, G, _, _,
        _, _, G, _, _,
        _, G, G, G, _,
        N, G, G, G, N,
        N, N, G, N, N,

        _, _, N, _, _,   -- ypos 0, prob 25% (64/256)
        _, _, G, _, _,   -- ypos 1, prob 37% (96/256)
        _, _, G, _, _,   -- ypos 2, prob 100%
        _, _, G, _, _,   -- ypos 3, prob 100%
        _, _, G, G, _,   -- ypos 4, prob 50% (128/256) to make half of stalactites asymmetric
        _, G, G, G, _,   -- ypos 5, prob 75% (192/256)
        _, G, G, G, _,   -- ypos 6, prob 75% (192/256)
        _, G, G, G, _,   -- ypos 7, prob 100%
        G, G, G, G, G,   -- ypos 8, prob 100%
        N, G, G, G, N,   -- ypos 9, prob 75% (192/256)

        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, G, _, _,
        _, _, G, _, _,
        _, _, G, _, _,
        _, G, G, G, _,
        N, G, G, G, N,
        N, N, G, N, N,

        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, _, _, _, _,
        _, N, G, N, _,
        _, N, N, N, _
    },
    -- Y-slice probabilities do not function correctly for ceiling schematic
    -- decorations because they are inverted, so ypos numbers have been inverted
    -- to match, and a larger offset in place_offset_y should be used (e.g. -3).
    yslice_prob = {
        {ypos = 9, prob = 192},
        {ypos = 6, prob = 192},
        {ypos = 5, prob = 192},
        {ypos = 4, prob = 128},
        {ypos = 1, prob = 96},
        {ypos = 0, prob = 64}
    }
}

minetest.register_decoration({
    name = "Glowstone stalactite",
    deco_type = "schematic",
    place_on = "nether:rack",
    sidelen = 80,
    fill_ratio = 0.0004,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH_CEILING, -- keep compatibility with mapgen_nobiomes.lua
    y_min = nether.DEPTH_FLOOR,
    schematic = schematic_GlowstoneStalactite,
    flags = "place_center_x,place_center_z,force_placement,all_ceilings",
    place_offset_y=-3
})

minetest.register_decoration({
    name = "Netherrack stalactite",
    deco_type = "schematic",
    place_on = "nether:rack",
    sidelen = 80,
    fill_ratio = 0.0008,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH_CEILING, -- keep compatibility with mapgen_nobiomes.lua
    y_min = nether.DEPTH_FLOOR,
    schematic = schematic_GlowstoneStalactite,
    replacements = {["nether:glowstone"] = "nether:rack"},
    flags = "place_center_x,place_center_z,all_ceilings",
    place_offset_y=-3
})

local schematic_BasaltStalactite = {
    size = {x = 3, y = 20, z = 3},
    data = { -- note that data is upside down

        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, B, _,
        _, B, _,
        _, B, _,
        B, B, B,
        B, B, B,
        B, B, B,
        B, B, B,

        _, B, _,  -- ypos 0, prob 85% (218/255)
        _, B, _,  -- ypos 1, prob 85% (218/255)
        _, B, _,  -- ypos 2, prob 85% (218/255)
        _, B, _,  -- ypos 3, prob 85% (218/255)
        _, B, _,  -- ypos 4, prob 85% (218/255)
        _, B, _,  -- ypos 5, prob 85% (218/255)
        _, B, _,  -- ypos 6, prob 85% (218/255)
        _, B, _,  -- ypos 7, prob 85% (218/255)
        _, B, _,  -- ypos 8, prob 85% (218/255)
        _, B, B,  -- ypos 9, prob 50% (128/256) to make half of stalactites asymmetric
        _, B, B,  -- ypos 10, prob 50% (128/256) to make half of stalactites asymmetric
        _, B, B,  -- ypos 11, prob 50% (128/256) to make half of stalactites asymmetric
        _, B, B,  -- ypos 12, prob 50% (128/256) to make half of stalactites asymmetric
        B, B, B,  -- ypos 13, prob 75% (192/256)
        B, B, B,  -- ypos 14, prob 75% (192/256)
        B, B, B,  -- ypos 15, prob 100%
        B, B, B,  -- ypos 16, prob 100%
        B, B, B,  -- ypos 17, prob 100%
        B, B, B,  -- ypos 18, prob 100%
        B, B, B,  -- ypos 19, prob 75% (192/256)

        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, _, _,
        _, B, _,
        _, B, _,
        _, B, _,
        _, B, _,
        B, B, B,
        B, B, B,
        B, B, B,
        B, B, B,

    },
    -- Y-slice probabilities do not function correctly for ceiling schematic
    -- decorations because they are inverted, so ypos numbers have been inverted
    -- to match, and a larger offset in place_offset_y should be used (e.g. -3).
    yslice_prob = {
        {ypos = 19, prob = 192},
        {ypos = 14, prob = 192},
        {ypos = 13, prob = 192},
        {ypos = 12, prob = 128},
        {ypos = 11, prob = 128},
        {ypos = 10, prob = 128},
        {ypos =  9, prob = 128},
        {ypos =  8, prob = 218},
        {ypos =  7, prob = 218},
        {ypos =  6, prob = 218},
        {ypos =  5, prob = 218},
        {ypos =  4, prob = 218},
        {ypos =  3, prob = 218},
        {ypos =  2, prob = 218},
        {ypos =  1, prob = 218},
        {ypos =  0, prob = 218}
    }
}



-- a stalagmite is an upsidedown stalactite
local schematic_BasaltStalagmite = {
    size = schematic_BasaltStalactite.size,
    data = {},
    yslice_prob = {}
}
local array_length = #schematic_BasaltStalactite.data + 1
for i, node in ipairs(schematic_BasaltStalactite.data) do
    schematic_BasaltStalagmite.data[array_length - i] = node
end
array_length = #schematic_BasaltStalactite.yslice_prob + 1
y_size = schematic_BasaltStalactite.size.y
for i, node in ipairs(schematic_BasaltStalactite.yslice_prob) do
    schematic_BasaltStalagmite.yslice_prob[i] = {
        -- we can safely lower the prob. to gain more variance because floor based schematics
        -- don't have the bug where missing lines moves them away from the surface
        prob = schematic_BasaltStalactite.yslice_prob[i].prob - 20,
        ypos = y_size - 1 - schematic_BasaltStalactite.yslice_prob[i].ypos
    }
end

minetest.register_decoration({
    name = "Basalt glowstone stalactite",
    deco_type = "schematic",
    place_on = "nether:basalt",
    sidelen = 80,
    fill_ratio = 0.0003,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH_CEILING, -- keep compatibility with mapgen_nobiomes.lua
    y_min = nether.DEPTH_FLOOR,
    schematic = schematic_GlowstoneStalactite,
    replacements = {["nether:rack"] = "nether:basalt"},
    flags = "place_center_x,place_center_z,force_placement,all_ceilings",
    place_offset_y=-3
})

minetest.register_decoration({
    name = "Basalt fat stalactite",
    deco_type = "schematic",
    place_on = "nether:basalt",
    sidelen = 80,
    fill_ratio = 0.0003,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH_CEILING, -- keep compatibility with mapgen_nobiomes.lua
    y_min = nether.DEPTH_FLOOR,
    schematic = schematic_GlowstoneStalactite,
    replacements = {["nether:rack"] = "nether:basalt", ["nether:glowstone"] = "nether:basalt"},
    flags = "place_center_x,place_center_z,force_placement,all_ceilings",
    place_offset_y=-3
})

--[[

minetest.register_decoration({
    name = "Basalt stalactite",
    deco_type = "schematic",
    place_on = "nether:basalt",
    sidelen = 80,
    fill_ratio = 0.001,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH_CEILING, -- keep compatibility with mapgen_nobiomes.lua
    y_min = nether.DEPTH_FLOOR,
    schematic = schematic_BasaltStalactite,
    flags = "place_center_x,place_center_z,force_placement,all_ceilings",
    place_offset_y=-6
})]]


minetest.register_decoration({
    name = "Basalt stalagmite",
    deco_type = "schematic",
    place_on = "nether:basalt",
    sidelen = 80,
    fill_ratio = 0.001,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH_CEILING, -- keep compatibility with mapgen_nobiomes.lua
    y_min = nether.DEPTH_FLOOR,
    schematic = schematic_BasaltStalagmite,
    flags = "place_center_x,place_center_z,force_placement,all_floors",
    --place_offset_y=-6
})

minetest.register_decoration({
    name = "Fire Vines",
    deco_type = "simple",
    decoration = "caverealms:fire_vine",
    height = 1,
    height_max = 6,
    place_on = "nether:lava_crust",
    sidelen = 80,
    fill_ratio = 0.01,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH_CEILING,
    y_min = nether.DEPTH_FLOOR,
})

-- =======================================
--    Concealed crevice / Lava sinkhole
-- =======================================
-- if player places a torch/block on this sand or digs it while standing on it, it sinks into lava

if allow_lava_decorations then
    minetest.register_decoration({
        name = "Weak trap",
        deco_type = "schematic",
        place_on = "nether:rack",
        sidelen = 80,
        fill_ratio = 0.002,
        biomes = {"nether_caverns"},
        y_max = nether.DEPTH, -- keep compatibility with mapgen_nobiomes.lua
        y_min = nether.DEPTH_FLOOR,
        schematic = {
            size = {x = 4, y = 7, z = 4},
            data = { -- note that data is upside down
                _, _, _, _,
                _, _, _, _,
                _, N, _, _,
                _, N, N, _,
                _, N, N, _,
                _, N, N, _,
                _, _, _, _,

                _, N, _, _, -- make it look like a stalactite if it protrudes out the bottom of a landform
                _, N, _, _,
                N, L, N, _,
                N, L, L, N,
                N, L, L, N,
                N, A, A, N,
                _, S, S, _,

                _, _, _, _,
                _, _, _, _,
                _, N, N, _,
                N, L, L, N,
                N, L, L, N,
                N, A, A, N,
                _, S, S, _,

                _, _, _, _,
                _, _, _, _,
                _, _, _, _,
                _, N, N, _,
                _, N, N, _,
                _, N, N, _,
                _, _, _, _,
            }
        },
        replacements = {["nether:glowstone"] = "nether:rack"},
        flags = "place_center_x,place_center_z,force_placement, all_floors",
        place_offset_y=-6,
        rotation = "random"
    })
end


-- ==========================
--    Fumaroles (Chimneys)
-- ==========================


local replacements_slab = {}
local replacements_full = {["nether:fumarole_slab"] = "nether:fumarole"}

if allow_lava_decorations then
    -- Minetest engine limitations mean any mesh or nodebox node (like nether:fumarole)
    -- will light up if it has lava below it, so replace the air node over the lava with
    -- a node that prevents light propagation.
    -- (Unfortunately this also means if a player digs down to get the lava block it'll
    -- look like the lighting wasn't set in the block above the lava)
    replacements_slab["air"] = "nether:airlike_darkness"
    replacements_full["air"] = "nether:airlike_darkness"
else
    -- Lava is frequently removed by the old mapgen, so put sand at the bottom
    -- of fumaroles.
    replacements_slab["default:lava_source"] = "nether:sand"
    replacements_full["default:lava_source"] = "nether:sand"
end


local schematic_fumarole = {
    size = {x = 3, y = 5, z = 3},
    data = { -- note that data is upside down
        _, _, _,
        _, N, _,
        _, N, _,
        _, _, _,
        _, _, _,

        _, N, _,
        N, L, N,
        N, A, N,
        _, F, _,
        _,FS, _,

        _, _, _,
        _, N, _,
        _, N, _,
        _, _, _,
        _, _, _,
    },
}

-- Common fumarole decoration that's flush with the floor and spawns everywhere

minetest.register_decoration({
    name = "Sunken nether fumarole",
    deco_type = "schematic",
    place_on = {"nether:rack"},
    sidelen = 80,
    fill_ratio = 0.005,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH,
    y_min = nether.DEPTH_FLOOR,
    schematic = schematic_fumarole,
    replacements = replacements_full,
    flags = "place_center_x,place_center_z,all_floors",
    place_offset_y=-4
})


-- Rarer formations of raised fumaroles in clumps

local fumarole_clump_noise_offset = -0.58
local fumarole_clump_noise = {
    offset = fumarole_clump_noise_offset,
    scale = 0.5,
    spread = {x = 40, y = 40, z = 15},
    octaves = 4,
    persist = 0.65,
    lacunarity = 2.0,
}

fumarole_clump_noise.offset = fumarole_clump_noise_offset - 0.035
minetest.register_decoration({
    name = "Raised Nether fumarole",
    deco_type = "schematic",
    place_on = {"nether:rack"},
    sidelen = 8,
    noise_params = fumarole_clump_noise,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH,
    y_min = nether.DEPTH_FLOOR,
    schematic = schematic_fumarole,
    replacements = replacements_full,
    flags = "place_center_x,place_center_z,all_floors",
    place_offset_y=-3
})

fumarole_clump_noise.offset = fumarole_clump_noise_offset
minetest.register_decoration({
    name = "Half-raised Nether fumarole",
    deco_type = "schematic",
    place_on = {"nether:rack"},
    sidelen = 8,
    noise_params = fumarole_clump_noise,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH,
    y_min = nether.DEPTH_FLOOR,
    schematic = schematic_fumarole,
    replacements = replacements_slab,
    flags = "place_center_x,place_center_z,all_floors",
    place_offset_y=-3
})

fumarole_clump_noise.offset = fumarole_clump_noise_offset - 0.035
minetest.register_decoration({
    name = "Nether fumarole mound",
    deco_type = "schematic",
    place_on = {"nether:rack"},
    sidelen = 8,
    noise_params = fumarole_clump_noise,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH,
    y_min = nether.DEPTH_FLOOR,
    schematic = {
        size = {x = 4, y = 4, z = 4},
        data = { -- note that data is upside down
            _, _,  _,  _,
            _, N,  N,  _,
            _, _,  _,  _,
            _, _,  _,  _,

            _, S,  S,  _,
            N, A,  A,  N,
            _, S2, S1, _,
            _, F2, F1, _,

            _, S,  S,  _,
            N, A,  A,  N,
            _, S3, S4, _,
            _, F3, F4, _,

            _, _,  _,  _,
            _, N,  N,  _,
            _, _,  _,  _,
            _, _,  _,  _
        },
        yslice_prob = {{ypos = 3, prob = 192}} -- occasionally leave the fumarole cap off
    },
    flags = "place_center_x,place_center_z,all_floors",
    place_offset_y = -2
})

fumarole_clump_noise.offset = fumarole_clump_noise_offset - 0.01
minetest.register_decoration({
    name = "Double Nether fumarole",
    deco_type = "schematic",
    place_on = {"nether:rack"},
    sidelen = 8,
    noise_params = fumarole_clump_noise,
    biomes = {"nether_caverns"},
    y_max = nether.DEPTH,
    y_min = nether.DEPTH_FLOOR,
    schematic = {
        size = {x = 4, y = 5, z = 4},
        data = { -- note that data is upside down
            _, _,  _,  _,
            _, N,  N,  _,
            _, _,  _,  _,
            _, _,  _,  _,
            _, _,  _,  _,

            _, S,  S,  _,
            N, A,  A,  N,
            _, S2, S1, _,
            _, F2, F,  _,
            _, _,  FS, _,

            _, S,  S,  _,
            F, A,  A,  N, -- the F may add slight variance in landforms where it gets exposed
            _, S3, S4, _,
            _, F3, F4, _,
            _, _,  _,  _,

            _, _,  _,  _,
            _, N,  N,  _,
            _, _,  _,  _,
            _, _,  _,  _,
            _, _,  _,  _
        }
    },
    flags = "place_center_x,place_center_z,all_floors",
    place_offset_y = -2,
    rotation = "random"
})
