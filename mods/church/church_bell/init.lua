if minetest.settings:get_bool("log_mods") then minetest.log("Loading "..minetest.get_current_modname() ) end
-- bell_positions are saved through server restart
-- bells ring every hour
-- they ring as many times as a bell ought to

church_bell = {};

church_bell.RING_INTERVAL = 3600; --60*60; -- ring each hour

church_bell.church_bell_SAVE_FILE = minetest.get_worldpath()..'/church_bell_positions.data';

local church_bell_positions = {};


church_bell.save_church_bell_positions = function( player )

   str = minetest.serialize( ({ church_bell_data = church_bell_positions}) );

   local file, err = io.open( church_bell.church_bell_SAVE_FILE, 'wb');
   if (err ~= nil) then
      if( player ) then
         minetest.chat_send_player(player:get_player_name(), 'Error: Could not save bell data');
      end
      return
   end
   file:write( str );
   file:flush();
   file:close();
   --minetest.chat_send_all('Wrote data to savefile '..tostring( church_bell.church_bell_SAVE_FILE ));
end


church_bell.restore_church_bell_data = function()

   local church_bell_position_table;

   local file, err = io.open(church_bell.church_bell_SAVE_FILE, 'rb');
   if (err ~= nil) then
      print('Error: Could not open bell data savefile (ignore this message on first start)');
      return
   end
   local str = file:read();
   file:close();

   local church_bell_positions_table = minetest.deserialize( str );
   if( church_bell_positions_table and church_bell_positions_table.church_bell_data ) then
     church_bell_positions = church_bell_positions_table.church_bell_data;
     print('[church_bell] Read positions of bells from savefile.');
   end
end


-- actually ring the bell
church_bell.ring_church_bell_once = function()

   for i,v in ipairs( church_bell_positions ) do
-- print('Ringing bell at '..tostring( minetest.pos_to_string( v )));
      minetest.sound_play( 'church_bell',
        { pos = v, gain = 1.5, max_hear_distance = 300,});
   end
end



church_bell.ring_church_bell = function()

   -- figure out if this is the right time to ring
   local sekunde = tonumber( os.date( '%S'));
   local minute  = tonumber( os.date( '%M'));
   local stunde  = tonumber( os.date( '%I')); -- in 12h-format (a bell that rings 24x at once would not survive long...)
   local delay   = church_bell.RING_INTERVAL;

   --print('[church_bells]It is now H:'..tostring( stunde )..' M:'..tostring(minute)..' S:'..tostring( sekunde ));

   --local datum = os.date( 'Stunde:%l Minute:%M Sekunde:%S');
   --print('[church_bells] ringing bells at '..tostring( datum ))

   delay = church_bell.RING_INTERVAL - sekunde - (minute*60);

   -- make sure the bell rings the next hour
   minetest.after( delay, church_bell.ring_church_bell );

   -- if no bells are around then don't ring
   if( church_bell_positions == nil or #church_bell_positions < 1 ) then
      return;
   end

   if( sekunde > 10 ) then
--      print('[church_bells] Too late. Waiting for '..tostring( delay )..' seconds.');
      return;
   end

   -- ring the bell for each hour once
   for i=1,stunde do
     minetest.after( (i-1)*5,  church_bell.ring_church_bell_once );
   end

end

-- first call (after the server has been started)
minetest.after( 10, church_bell.ring_church_bell );
-- read data about bell positions
church_bell.restore_church_bell_data();


minetest.register_node('church_bell:iron', {
	description = 'Iron Bell',
	node_placement_prediction = '',
drawtype = 'mesh',
	mesh = "church_bell.obj",
	tiles = {'church_bell_iron.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.38, -0.31, -0.38, 0.38, 0.5, 0.38},
		}
	},
	paramtype = 'light',
	is_ground_content = true,
	inventory_image = 'church_bell_iron_inv.png',
	wield_image = 'church_bell_iron_inv.png',
	stack_max = 1,
	on_punch = function (pos,node,puncher)
		minetest.sound_play( 'church_bell_punch', { pos = pos, gain = 1.5, max_hear_distance = 300,});
		-- minetest.chat_send_all(puncher:get_player_name()..' has rung the bell!')
	end,

	after_place_node = function(pos, placer)
		if( placer ~= nil ) then
			-- minetest.chat_send_all(placer:get_player_name()..' has placed a new bell at '..tostring( minetest.pos_to_string( pos )));
		end
       -- remember that there is a bell at that position
		table.insert( church_bell_positions, pos );
		church_bell.save_church_bell_positions( placer );
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if( digger ~= nil ) then
			-- minetest.chat_send_all(digger:get_player_name()..' has removed the bell at '..tostring( minetest.pos_to_string( pos )));
		end

		local found = 0;
		-- actually remove the bell from the list
		for i,v in ipairs( church_bell_positions ) do
			if( v ~= nil and v.x == pos.x and v.y == pos.y and v.z == pos.z ) then
				found = i;
			end
		end
		-- actually remove the bell
		if( found > 0 ) then
			table.remove( church_bell_positions, found );
			church_bell.save_church_bell_positions( digger );
		end
	end,

	groups = {cracky=2},
})

minetest.register_node('church_bell:gold', {
	description = 'Gold Bell',
	node_placement_prediction = '',
drawtype = 'mesh',
	mesh = "church_bell.obj",
	tiles = {'church_bell_gold.png'},
	selection_box = {
		type = 'fixed',
		fixed = {
			{-0.38, -0.31, -0.38, 0.38, 0.5, 0.38},
		}
	},
	paramtype = 'light',
	is_ground_content = true,
	inventory_image = 'church_bell_gold_inv.png',
	wield_image = 'church_bell_gold_inv.png',
	stack_max = 1,
	on_punch = function (pos,node,puncher)
		minetest.sound_play( 'church_bell_punch', { pos = pos, gain = 1.5, max_hear_distance = 300,});
		-- minetest.chat_send_all(puncher:get_player_name()..' has rung the bell!')
	end,

	after_place_node = function(pos, placer)
		if( placer ~= nil ) then
			-- minetest.chat_send_all(placer:get_player_name()..' has placed a new bell at '..tostring( minetest.pos_to_string( pos )));
		end
       -- remember that there is a bell at that position
		table.insert( church_bell_positions, pos );
		church_bell.save_church_bell_positions( placer );
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, digger)
		if( digger ~= nil ) then
			-- minetest.chat_send_all(digger:get_player_name()..' has removed the bell at '..tostring( minetest.pos_to_string( pos )));
		end

		local found = 0;
		-- actually remove the bell from the list
		for i,v in ipairs( church_bell_positions ) do
			if( v ~= nil and v.x == pos.x and v.y == pos.y and v.z == pos.z ) then
				found = i;
			end
		end
		-- actually remove the bell
		if( found > 0 ) then
			table.remove( church_bell_positions, found );
			church_bell.save_church_bell_positions( digger );
		end
	end,

	groups = {cracky=2},
})

minetest.register_craft({
	output = 'church_bell:gold',
	recipe = {
		{'', 'default:gold_ingot', ''},
		{'default:gold_ingot', '', 'default:gold_ingot'},
		{'default:gold_ingot', '', 'default:gold_ingot'},
	},
})
minetest.register_craft({
	output = 'church_bell:iron',
	recipe = {
		{'', 'default:steel_ingot', ''},
		{'default:steel_ingot', '', 'default:steel_ingot'},
		{'default:steel_ingot', '', 'default:steel_ingot'},
	},
})
