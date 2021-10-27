if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
dofile(minetest.get_modpath('scorpion')..'/little.lua')
dofile(minetest.get_modpath('scorpion')..'/big.lua')
dofile(minetest.get_modpath('scorpion')..'/boss.lua')
dofile(minetest.get_modpath('scorpion')..'/pet.lua')

minetest.register_craftitem('scorpion:shell', {
   description = 'Piece of insect shell',
   inventory_image = 'scorpion_shell_piece.png',
})
