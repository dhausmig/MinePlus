handle_schematics.get_content_id_replaced = function( node_name, replacements )
	if( not( node_name )) then
		return minetest.get_content_id( 'ignore' );
	end
	local new_name = node_name
	if( replacements and replacements.table and replacements.table[ node_name ]) then
		new_name = replacements.table[ node_name ];
	end
	if(minetest.registered_aliases[ new_name ]) then
		new_name = minetest.registered_aliases[ new_name ]
	end
	-- try the original name if the new one doesn't exist
	if(not(minetest.registered_nodes[ new_name ])
	   and minetest.registered_nodes[ node_name ]) then
		new_name = node_name
	end
	if(minetest.registered_aliases[ new_name ]) then
		new_name = minetest.registered_aliases[ new_name ];
	end
	-- apply global replacements
	if(handle_schematics.global_replacement_table[ new_name ]) then
		new_name = handle_schematics.global_replacement_table[ new_name ]
	end
	if(not(minetest.registered_nodes[ new_name ])) then
		new_name = 'air';
	end
	return minetest.get_content_id( new_name );
end

-- shortcut (we need this function often)
local GCIR = handle_schematics.get_content_id_replaced

-- either uses get_node_or_nil(..) or the data from voxelmanip
-- the function might as well be local (only used by *.mg_drop_moresnow)
handle_schematics.get_node_somehow = function( x, y, z, a, data, param2_data )
	if( a and data and param2_data ) then
		return { content = data[a:index(x, y, z)], param2 = param2_data[a:index(x, y, z)] };
	end
	-- no voxelmanip; get the node the normal way
	local node = minetest.get_node_or_nil( {x=x, y=y, z=z} );
	if( not( node ) ) then
		return { content = moresnow.c_ignore, param2 = 0 };
	end
	return { content = minetest.get_content_id( node.name ), param2 = node.param2, name = node.name };
end


-- "drop" moresnow snow on diffrent shapes; works for voxelmanip and node-based setting
handle_schematics.mg_drop_moresnow = function( x, z, y_top, y_bottom, a, data, param2_data, cid)

	-- this only works if moresnow is installed
	if( not( handle_schematics.moresnow_installed )) then
		return;
	end

	local y = y_top;
	local node_above = handle_schematics.get_node_somehow( x, y+1, z, a, data, param2_data );
	local node_below = nil;
	while( y >= y_bottom ) do

		node_below = handle_schematics.get_node_somehow( x, y, z, a, data, param2_data );
		if(     node_above.content == moresnow.c_air
		    and node_below.content
		    and node_below.content ~= moresnow.c_ignore
		    and node_below.content ~= moresnow.c_air ) then

			-- turn water into ice, but don't drop snow on it
			if( node_below.content == cid.c_water_source
			 or node_below.content == cid.c_river_water_source) then
				return { height = y, suggested = {new_id = cid.c_ice, param2 = 0 }};
			end

			-- if the node below drops snow when digged (i.e. is either snow or a moresnow node), we're finished
			local get_drop = minetest.get_name_from_content_id( node_below.content );
			if( get_drop ) then
				get_drop = handle_schematics.node_defined( get_drop );
				if( get_drop and get_drop.drop and type( get_drop.drop )=='string' and get_drop.drop == 'default:snow') then
					return;
				end
			end
			if( not(node_below.content)
			    or  node_below.content == moresnow.c_snow ) then
				return;
			end

			local suggested = moresnow.suggest_snow_type( node_below.content, node_below.param2 );

			-- c_snow_top and c_snow_fence can only exist when the node 2 below is a solid one
			if(    suggested.new_id == moresnow.c_snow_top
			    or suggested.new_id == moresnow.c_snow_fence) then
				local node_below2 = handle_schematics.get_node_somehow( x, y-1, z, a, data, param2_data);
				if(     node_below2.content ~= moresnow.c_ignore
				    and node_below2.content ~= moresnow.c_air ) then
					local suggested2 = moresnow.suggest_snow_type( node_below2.content, node_below2.param2 );

					if( suggested2.new_id == moresnow.c_snow ) then
						return { height = y+1, suggested = suggested };
					end
				end
			-- it is possible that this is not the right shape; if so, the snow will continue to fall down
			elseif( suggested.new_id ~= moresnow.c_ignore ) then

				return { height = y+1, suggested = suggested };
			end
			-- TODO return; -- abort; there is no fitting moresnow shape for the node below
		end
		y = y-1;
		node_above = node_below;
	end
end


-- helper function for generate_building
-- places a marker that allows players to buy plots with houses on them (in order to modify the buildings)
local function generate_building_plotmarker( pos, minp, maxp, data, param2_data, a, cid, building_nr_in_bpos, village_id, filename)
	-- position the plot marker so that players can later buy this plot + building in order to modify it
	-- pos.o contains the original orientation (determined by the road and the side the building is
	local p = {x=pos.x, y=pos.y+1, z=pos.z};
	-- vector for placing mg_villages:mob_spawner
	local v = {x=0,z=0};
	if(     pos.o == 0 ) then
		p.x = p.x - 1;
		p.z = p.z + pos.bsizez - 1;
		v.z = -1;
		p.yaw = 90;
	elseif( pos.o == 2 ) then
		p.x = p.x + pos.bsizex;
		v.z = 1;
		p.yaw = 270;
	elseif( pos.o == 1 ) then
		p.z = p.z + pos.bsizez;
		p.x = p.x + pos.bsizex - 1;
		v.x = -1;
		p.yaw = 0;
	elseif( pos.o == 3 ) then
		p.z = p.z - 1;
		v.x = 1;
		p.yaw = 180;
	end
	-- actually position the marker
	if(   p.x >= minp.x and p.x <= maxp.x and p.z >= minp.z and p.z <= maxp.z and p.y >= minp.y and p.y <= maxp.y) then
		if( handle_schematics.moresnow_installed
		   and data[ a:index(p.x, p.y, p.z)] == cid.c_snow
		   and p.y<maxp.y
		   and moresnow and moresnow.c_snow_top and cid.c_snow_top ~= cid.c_ignore) then
			data[ a:index(p.x, p.y+1, p.z)] = moresnow.c_snow_top;
		end
		data[       a:index(p.x, p.y, p.z)] = cid.c_plotmarker;
		param2_data[a:index(p.x, p.y, p.z)] = pos.brotate;
		-- store the necessary information in the marker so that it knows for which building it is responsible
		local meta = minetest.get_meta( p );
		meta:set_string('village_id', village_id );
		meta:set_int(   'plot_nr',    building_nr_in_bpos );
		meta:set_string('infotext',   'Plot No. '..tostring( building_nr_in_bpos ).. ' with '..tostring( filename ));
		-- information about the direction the mob ought to look at
		meta:set_int('yaw', p.yaw );
	end

	-- place a mob spawner in front of the house for each bed
	-- we do it here so that the roads will not overwrite it
	local binfo = mg_villages.BUILDINGS[pos.btype];
	if( not( binfo ) or not( binfo.bed_count ) or binfo.bed_count<1 or not( minetest.registered_nodes["mg_villages:mob_spawner"])) then
		return;
	end
	cid.c_mob_spawner = minetest.get_content_id("mg_villages:mob_spawner");
	p.y = p.y - 2; -- hide the spawner from view
	for i=1,binfo.bed_count do
		p.x = p.x + v.x;
		p.z = p.z + v.z;
		if(   p.x >= minp.x and p.x <= maxp.x and p.z >= minp.z
		  and p.z <= maxp.z and p.y >= minp.y and p.y <= maxp.y) then
			-- place the mob spawner
			data[       a:index(p.x, p.y, p.z)] = cid.c_mob_spawner;
			-- not really necessary but can't hurt
			param2_data[a:index(p.x, p.y, p.z)] = pos.brotate;
			-- store where to find information about the mob this spawner is responsible for
			local meta = minetest.get_meta( p );
			meta:set_string('village_id', village_id );
			meta:set_int(   'plot_nr',    building_nr_in_bpos );
			meta:set_int(   'bed_nr',     i );
			meta:set_string('infotext',   'MOB SPAWNER for bed nr '..tostring(i)..' on plot nr '..tostring( building_nr_in_bpos )..' in village '..tostring( village_id ));
		end
	end
end



-- pos has to contain information about the building - o (orientation), bsizex and bsizez
-- this function returns a position in front of the building, with the building stretching equally to the right and left
-- (useful for mobs who want to leave/enter the plot)
-- bed_nr can be used to assign diffrent spawn points to mobs in diffrent beds
handle_schematics.get_pos_in_front_of_house = function( pos, bed_nr )
	if( not( bed_nr )) then
		bed_nr = 0;
	end
	local p = {x=pos.x, y=pos.y+1, z=pos.z, yaw = 0};
	if(     pos.o == 0 ) then
		p.x = p.x - 1;
		p.z = p.z + pos.bsizez - 1 - bed_nr;
--		p.z = p.z - math.floor(pos.bsizex/2+0.5) - bed_nr;
		p.yaw = 90;
	elseif( pos.o == 2 ) then
		p.x = p.x + pos.bsizex;
--		p.z = p.z + math.floor(pos.bsizex/2+0.5) + bed_nr;
		p.z = p.z + bed_nr;
		p.yaw = 270;
	elseif( pos.o == 1 ) then
		p.z = p.z + pos.bsizez;
		p.x = p.x + pos.bsizex - 1 - bed_nr;
--		p.x = p.x - math.floor(pos.bsizez/2+0.5) - bed_nr;
		p.yaw = 0;
	elseif( pos.o == 3 ) then
		p.z = p.z - 1;
--		p.x = p.x + math.floor(pos.bsizez/2+0.5) + bed_nr;
		p.x = p.x + bed_nr;
		p.yaw = 180;
	end
	return p;
end


-- we do have a list of all nodenames the building contains (the .mts file provided it);
-- we can thus apply all replacements to these nodenames;
-- this also checks param2 and sets some other variables to indicate that it's i.e. a tree or a chest
-- (which both need special handling later on)
local function generate_building_translate_nodenames( nodenames, replacements, cid, binfo_scm, mirror_x, mirror_z )

	if( not( nodenames )) then
		return;
	end
	local i;
	local v;
	local new_nodes   = {};
	for i,node_name in ipairs( nodenames ) do

		new_nodes[ i ] = {}; -- array for collecting information about the new content id for nodes with number "i" in their .mts savefile

		-- some nodes may be called differently when mirrored; needed for doors
		local new_node_name = node_name;
		if( new_node_name and ( mirror_x or mirror_z ) and handle_schematics.mirrored_node[ new_node_name ] ) then
			new_node_name = handle_schematics.mirrored_node[ node_name ];
			new_nodes[ i ].is_mirrored = 1; -- currently unused
		end

		-- apply the replacements
		if( new_node_name and replacements.table[ new_node_name ] ) then
			new_node_name = replacements.table[ new_node_name ];
			new_nodes[ i ].is_replaced = 1; -- currently unused
		end

		-- those chests do not exist as regular nodes; they're just placeholders
		if(        node_name == 'cottages:chest_private'
		   or      node_name == 'cottages:chest_work'
		   or      node_name == 'cottages:chest_storage' ) then

			new_nodes[ i ].is_replaced   = 1; -- currently unused
			new_nodes[ i ].special_chest = node_name;
			-- TODO: perhaps use a locked chest owned by the mob living there?
			-- place a normal chest here
			new_nodes[ i ].new_content   = cid.c_chest;
			new_nodes[ i ].special_chest = node_name;
			new_node_name = 'default:chest';

		elseif(new_node_name == 'cottages:chest_private'
		   or  new_node_name == 'cottages:chest_work'
		   or  new_node_name == 'cottages:chest_storage' ) then

			new_nodes[ i ].is_replaced   = 1; -- currently unused
			new_nodes[ i ].special_chest = new_node_name;
			-- TODO: perhaps use a locked chest owned by the mob living there?
			-- place a normal chest here
			new_nodes[ i ].new_content   = cid.c_chest;

		elseif(     node_name == 'default:chest'
		   or   new_node_name == 'default:chest' ) then
			new_nodes[ i ].is_replaced   = 1; -- currently unused
			new_nodes[ i ].special_chest = 'default:chest';
			new_nodes[ i ].new_content   = cid.c_chest;

		elseif(     node_name == 'default:bookshelf'
		    or  new_node_name == 'default:bookshelf' ) then
			new_nodes[ i ].is_replaced   = 1; -- currently unused
			new_nodes[ i ].special_chest = 'default:bookshelf';
			new_nodes[ i ].new_content   = cid.c_bookshelf;

		-- recognize beds
		elseif(     handle_schematics.bed_node_names[ node_name ]
			or  handle_schematics.bed_node_names[ new_node_name ]) then
			new_nodes[ i ].is_bed = 1;

		elseif(     node_name == "mg_villages:mob_workplace_marker"
		    or  new_node_name == "mg_villages:mob_workplace_marker" ) then
			new_nodes[ i ].is_workplace_marker = 1;
		end

		-- only existing nodes can be placed
		local regnode = handle_schematics.node_defined( new_node_name );
		if( new_node_name and regnode) then

			-- apply global replacements
			if( handle_schematics.global_replacement_table[ new_node_name ]) then
				new_node_name = handle_schematics.global_replacement_table[ new_node_name ];
			end

			new_nodes[ i ].new_node_name = new_node_name;
			new_nodes[ i ].new_content   = minetest.get_content_id( new_node_name );
			if( regnode.on_construct ) then
				new_nodes[ i ].on_construct = 1;
			end

			local new_content = new_nodes[ i ].new_content;
			if(     new_content == cid.c_dirt_with_grass ) then
				new_nodes[ i ].is_grass     = 1;
			-- dirt acts as a general placeholder
			elseif( new_content == cid.c_dirt ) then
				new_nodes[ i ].is_dirt      = 1;

			elseif( handle_schematics.is_sapling[ new_content ]) then
				-- store that a tree is to be grown there
				new_nodes[ i ].is_tree      = 1;

			elseif( new_content == cid.c_chest
			   or   new_content == cid.c_bookshelf
			   or   new_content == cid.c_chest_locked
			   or   new_content == cid.c_chest_shelf
			   or   new_content == cid.c_chest_ash
			   or   new_content == cid.c_chest_aspen
			   or   new_content == cid.c_chest_birch
			   or   new_content == cid.c_chest_maple
			   or   new_content == cid.c_chest_chestnut
			   or   new_content == cid.c_chest_pine
			   or   new_content == cid.c_chest_spruce) then
				-- we're dealing with a chest that might need filling
				new_nodes[ i ].is_chestlike = 1;

			elseif( new_content == cid.c_sign ) then
				-- the sign may require some text to be written on it
				new_nodes[ i ].is_sign      = 1;

			-- doors need special treatment as they changed from 2 to 1 node
			elseif( string.sub( node_name,     1, 6)=="doors:"
			    and string.sub( new_node_name, 1, 6)=="doors:" ) then
				if(     string.sub( new_node_name, -2 ) =="_a") then
					new_nodes[ i ].is_door_a    = 1;
				elseif( string.sub( new_node_name, -2 ) =="_b") then
					new_nodes[ i ].is_door_b    = 1;
				end

			-- if we are placing a glass node, param2 needs to be set to 0
			elseif( regnode and regnode.drawtype
			    and (regnode.drawtype=="glasslike" or regnode.drawtype=="glasslike_framed" or regnode.drawtype=="glasslike_framed_optional")) then
				new_nodes[ i ].set_param2_to_0  = 1;

			-- torches can be 3d now; for that, they use diffrent nodes
			elseif( new_node_name == 'mg_villages:torch' or new_node_name == 'default:torch' ) then
				new_nodes[ i ].is_torch        = 1;
			end


			-- handle_schematics.get_param2_rotated( 'facedir', param2 ) needs to be called for nodes
			-- which use either facedir or wallmounted;
			-- realtest rotates some nodes diffrently and does not come with default:ladder
			if(    node_name == 'default:ladder' and handle_schematics.is_realtest) then
				new_nodes[ i ].change_param2 = {}; --{ 2->1, 5->2, 3->3, 4->0 }
				new_nodes[ i ].change_param2[2] = 1;
				new_nodes[ i ].change_param2[5] = 2;
				new_nodes[ i ].change_param2[3] = 3;
				new_nodes[ i ].change_param2[4] = 0;
				new_nodes[ i ].paramtype2 = 'facedir';
			-- ..except if they are stairs or ladders
			elseif( string.sub( node_name, 1, 7 ) == 'stairs:' or string.sub( node_name, 1, 6 ) == 'doors:') then
				new_nodes[ i ].paramtype2 = 'facedir';
			-- normal nodes
			elseif( regnode and regnode.paramtype2 and (regnode.paramtype2=='facedir' or regnode.paramtype2=='wallmounted')) then
				new_nodes[ i ].paramtype2 = regnode.paramtype2;
			end

		-- we tried our best, but the replacement node is not defined
		elseif( new_node_name ~= 'mg:ignore' ) then
			local msg = 'ERROR: Did not find a suitable replacement for '..tostring( node_name )..' (suggested but inexistant: '..
					tostring( new_node_name )..'). Building: '..tostring( binfo_scm )..'.';
			if( mg_villages and mg_villages.print ) then
				mg_villages.print( mg_villages.DEBUG_LEVEL_WARNING, msg );
			else
				print( msg );
			end
			msg = nil;
			new_nodes[ i ].ignore = 1; -- keep the old content
		else -- handle mg:ignore
			new_nodes[ i ].ignore = 1;
		end


	end
	return new_nodes;
end


local function generate_building_what_to_place_here_and_how(t, node_content, new_nodes, cid, keep_ground, ground_type, mirror_x, mirror_z, pos  )

	local new_content = node_content;

	if( not( t )) then
		if( node_content ~= cid.c_plotmarker
		   and (not(handle_schematics.moresnow_installed) or not(moresnow) or node_content ~= moresnow.c_snow_top )) then
			-- place nothing/air
			return { new_content = cid.c_air, new_param2 = 0, n = {} };
		end
	end

	-- TODO: there ought to be no error here....
	if( not( t) or not( t[1] ) or not( new_nodes[ t[1]])
	 -- set air only if the new node is not of type ignore
	 or (not( new_nodes[ t[1]].new_content) and not(new_nodes[ t[1] ].ignore))) then
		return { new_content = cid.c_air, new_param2 = 0, n = {} };
	end

	-- take care of replacements
	local n = new_nodes[ t[1] ]; -- t[1]: id of the old node
	if( not( n.ignore )) then
		new_content = n.new_content;
	else
		new_content = node_content;
	end

	-- replace all dirt and dirt with grass at that x,z coordinate with the stored ground grass node;
	if( n.is_grass and keep_ground and ground_type) then
		new_content = ground_type;
	elseif( n.is_dirt and node_content ~= cid.c_air ) then
		new_content = node_content;
	end

	-- do not overwrite plotmarkers
	if( node_content ~= cid.c_ignore and node_content ~= cid.c_air and (node_content == cid.c_plotmarker or node_content == cid.c_mob_spawner)) then
		-- keep the old content
		new_content = node_content;
	end

	-- remove misplaced scaffolding nodes
	if( new_content == cid.c_air and (node_content == cid.c_scaffolding or node_content == cid.c_scaffolding_empty)) then
		new_content = cid.c_air;
	end

	-- quite often we just need some kind of floor/ground - and do not depend on a particular node
	if(   handle_schematics.also_acceptable
	  and new_content ~= cid.c_ignore and node_content ~= cid.c_ignore
	  and handle_schematics.also_acceptable[ new_content ]
	  and handle_schematics.also_acceptable[ new_content ].is_ok
	  and handle_schematics.also_acceptable[ new_content ].is_ok[ node_content ]) then
		new_content = node_content;
	end

	-- the old torch is split up into three new types
	if( n.is_torch ) then
		if( t[2]==0 ) then
			new_content = cid.c_torch_ceiling;
		elseif( t[2]==1 ) then
			new_content = cid.c_torch;
		else
			new_content = cid.c_torch_wall;
		end
	end

	local param2 = t[2];
	-- handle rotation
	if(     n.paramtype2 ) then
		if( n.change_param2 and  n.change_param2[ t[2] ]) then
			param2 = n.change_param2[ param2 ];
		end

		if(     mirror_x and param2<24) then
			param2 = handle_schematics.rotation_table[ n.paramtype2 ][ param2+1 ][ pos.brotate+1 ][ 2 ];
		elseif( mirror_z and param2<24) then
			param2 = handle_schematics.rotation_table[ n.paramtype2 ][ param2+1 ][ pos.brotate+1 ][ 3 ];
		elseif( param2 < 24) then
			param2 = handle_schematics.rotation_table[ n.paramtype2 ][ param2+1 ][ pos.brotate+1 ][ 1 ];
		end
	end

	-- glasslike nodes need to have param2 set to 0 (else they get a strange fill state)
	if( n.set_param2_to_0 ) then
		param2 = 0;
	end

	return { new_content = new_content, new_param2 = param2, n = n };
end



-- if scaffolding_only is set, a statistic of missing_nodes will be returned
handle_schematics.generate_building = function(pos, minp, maxp, data, param2_data, a, extranodes, replacements, cid, extra_calls, building_nr_in_bpos, village_id, binfo_extra, road_node, keep_ground, scaffolding_only)
	local binfo = binfo_extra;
	if( not( binfo ) and mg_villages) then
		binfo = mg_villages.BUILDINGS[pos.btype]
	end
	local scm

	-- the building got removed from mg_villages.BUILDINGS in the meantime
	if( not( binfo )) then
		return;
	end

	-- schematics of .mts type are not handled here; they need to be placed using place_schematics
	if( binfo.is_mts and binfo.is_mts == 1 ) then
		return;
	end


	-- roads are very simple structures that are not stored as schematics
	if( pos.btype == 'road' ) then
		handle_schematics.place_road( minp, maxp, data, param2_data, a, road_node, pos, cid.c_air );
		return;
	end


	if( not( pos.no_plotmarker )) then
		generate_building_plotmarker( pos, minp, maxp, data, param2_data, a, cid, building_nr_in_bpos, village_id, binfo.scm );
	end

	-- skip building if it is not located at least partly in the area that is currently beeing generated
	if(   pos.x > maxp.x or pos.x + pos.bsizex < minp.x
	   or pos.z > maxp.z or pos.z + pos.bsizez < minp.z ) then
		return;
	end


	if( pos.btype and
	  ((     binfo.sizex ~= pos.bsizex and binfo.sizex ~= pos.bsizez )
	    or ( binfo.sizez ~= pos.bsizex and binfo.sizez ~= pos.bsizez )
	    or not( binfo.scm_data_cache ))) then
		if( mg_villages and mg_villages.print ) then
			mg_villages.print( mg_villages.DEBUG_LEVEL_WARNING,
				'ERROR: This village was created using diffrent buildings than those known know. Cannot place unknown building.');
		else
			print( 'ERROR: Size information about this building differs. Cannot place building.');
		end
		return;
	end

	if( binfo.scm_data_cache )then
		scm = binfo.scm_data_cache;
	else
		scm = binfo.scm
	end

	-- the fruit is set per building, not per village as the other replacements
	if( binfo.farming_plus and binfo.farming_plus == 1 and pos.fruit and mg_villages) then
		local plant = handle_schematics.replace_material( replacements.list, 'farming', nil, nil)
	end

	-- statistic containing information about nodes that still need to be placed (only of intrest if scaffolding_only is set)
	local missing_nodes = {};

	local c_ignore               = minetest.get_content_id("ignore")
	local c_air                  = minetest.get_content_id("air")
	local c_snow                 = GCIR( "default:snow", replacements);
	local c_dirt                 = GCIR( "default:dirt", replacements );
	local c_dirt_with_grass      = GCIR( "default:dirt_with_grass", replacements );
	local c_dirt_with_snow       = GCIR( "default:dirt_with_snow", replacements );

	local c_scaffolding_empty    = GCIR( "handle_schematics:support", replacements );
	local c_scaffolding          = GCIR( "handle_schematics:support_setup", replacements );
	local c_dig_here             = GCIR( "handle_schematics:dig_here", replacements );

	-- freeze water if there is moresnow on top
	cid.c_water_source           = GCIR( "default:water_source", replacements);
	cid.c_river_water_source     = GCIR( "default:river_water_source", replacements);
	cid.c_ice                    = GCIR( "default:ice", replacements);

	local scm_x = 0;
	local scm_z = 0;
	local step_x = 1;
	local step_z = 1;
	local scm_z_start = 0;

	if(     pos.brotate == 2 ) then
		scm_x  = pos.bsizex+1;
		step_x = -1;
	end
	if(     pos.brotate == 1 ) then
		scm_z  = pos.bsizez+1;
		step_z = -1;
		scm_z_start = scm_z;
	end

	local mirror_x = false;
	local mirror_z = false;
	if( pos.mirror ) then
		if( binfo.axis and binfo.axis == 1 ) then
			mirror_x = true;
			mirror_z = false;
		-- used for "restore original landscape"
		elseif( binfo.axis and binfo.axis == 3 ) then
			mirror_z = true;
			mirror_x = true;
		else
			mirror_x = false;
			mirror_z = true;
		end
	end

	-- translate all nodenames and apply the replacements
	local new_nodes = generate_building_translate_nodenames( binfo.nodenames, replacements, cid, binfo.scm, mirror_x, mirror_z );

	for x = 0, pos.bsizex-1 do
	scm_x = scm_x + step_x;
	scm_z = scm_z_start;
	for z = 0, pos.bsizez-1 do
		scm_z = scm_z + step_z;

		local xoff = scm_x;
		local zoff = scm_z;
		if(     pos.brotate == 2 ) then
			if( mirror_x ) then
				xoff = pos.bsizex - scm_x + 1;
			end
			if( mirror_z ) then
				zoff = scm_z;
			else
				zoff = pos.bsizez - scm_z + 1;
			end
		elseif( pos.brotate == 1 ) then
			if( mirror_x ) then
				xoff = pos.bsizez - scm_z + 1;
			else
				xoff = scm_z;
			end
			if( mirror_z ) then
				zoff = pos.bsizex - scm_x + 1;
			else
				zoff = scm_x;
			end
		elseif( pos.brotate == 3 ) then
			if( mirror_x ) then
				xoff = pos.bsizez - scm_z + 1;
			else
				xoff = scm_z;
			end
			if( mirror_z ) then
				zoff = scm_x;
			else
				zoff = pos.bsizex - scm_x + 1;
			end
		elseif( pos.brotate == 0 ) then
			if( mirror_x ) then
				xoff = pos.bsizex - scm_x + 1;
			end
			if( mirror_z ) then
				zoff = pos.bsizez - scm_z + 1;
			end
		end

		local has_snow    = false;
		local ground_type = c_dirt_with_grass;

		-- remove all dig_here-indicators
		if( scaffolding_only ) then
			local ax = pos.x+x;
			local az = pos.z+z;
			for y = 0, binfo.ysize-1 do
				local ay = pos.y+y+binfo.yoff;
				if (ax >= minp.x and ax <= maxp.x) and (ay >= minp.y and ay <= maxp.y) and (az >= minp.z and az <= maxp.z) then
					if( data[a:index(ax, ay, az)] == c_dig_here ) then
						data[a:index(ax, ay, az)] = cid.c_air;
						-- remove old and obsolete metadata
						table.insert( extra_calls.clear_meta, {x=ax, y=ay, z=az});
					end
				end
			end
		end

		for y = 0, binfo.ysize-1 do
			local ax = pos.x+x;
			local ay = pos.y+y+binfo.yoff;
			local az = pos.z+z;
			if (ax >= minp.x and ax <= maxp.x) and (ay >= minp.y and ay <= maxp.y) and (az >= minp.z and az <= maxp.z) then

				local new_content = c_air;
				local t = cid.c_ignore;
				if( scm and scm[y+1] and scm[y+1][xoff] ) then
					t = scm[y+1][xoff][zoff];
				end
				local node_content = data[a:index(ax, ay, az)];

				if( binfo.yoff+y == 0 ) then
					-- no snow on the gravel roads
					if( node_content == c_dirt_with_snow or data[a:index(ax, ay+1, az)]==c_snow) then
						has_snow    = true;
					end

					ground_type = node_content;
				end

--					-- we have the wrong node there
--					elseif( ((not(t) and current_content ~= cid.c_air)
--						 or (t and new_nodes[t[1]] and not(new_nodes[t[1]].ignore) and current_content ~= new_nodes[ t[1]].new_content))
--						-- TODO: detect wrong rotation (param2)
--
--						and current_content ~= c_scaffolding
--						and current_content ~= c_dig_here
--						and ay<maxp.y) then
--						-- there is air above; we can place a digging indicator
--						if( data[a:index(ax, ay+1, az)] == cid.c_air or data[a:index(ax, ay+1, az)]==c_scaffolding) then
--							data[ a:index(ax, ay+1, az)] = c_dig_here;
--						end
--					end

				-- which node (and which rotation) do we need here?
				local res = generate_building_what_to_place_here_and_how(t, node_content, new_nodes, cid, keep_ground, ground_type, mirror_x, mirror_z, pos  )
				local new_content = res.new_content;
				local param2      = res.new_param2;
				local n           = res.n;

				-- scaffolding nodes are only placed when there is air now and there ought to be a node from the building
				if( scaffolding_only ) then
					-- new_content is adjusted later on, so store here what might be missing so that we can create the missing_nodes statistic
					local new_content_wanted = new_content;
					-- a node is to be placed here AND it is diffrent from the existing one AND
					-- the existing node is not air, scaffolding, special scaffolding or a dig-here-indicator
					-- -> the existing node needs to be digged
					if(new_content and new_content ~= node_content
					   and node_content ~= cid.c_air and node_content ~= c_scaffolding and node_content ~= c_scaffolding_empty
					   -- if this is just a plant in a diffrent growth stage: ignore it
					   and not( handle_schematics.player_can_provide[new_content] and
					            handle_schematics.player_can_provide[new_content] ==
						    handle_schematics.player_can_provide[node_content])) then
						local h;
						-- search upward for the first empty (air) node or dig-here-indicator and place a dig_here-indicator
						for h=ay, maxp.y do
							local node_here = data[ a:index(ax, h, az)];
							if( node_here == cid.c_air or node_here == c_dig_here or node_here == c_scaffolding or node_here == c_scaffolding_empty ) then
								if( data[ a:index(ax, h, az)] ~= c_dig_here ) then
									table.insert( extra_calls.scaffolding, {x=ax, y=h, z=az, dig_down = h-ay, what_where = {{ ay, new_content, param2}}});
								else
									-- store which node needs to be placed at which height
									for i,v in ipairs( extra_calls.scaffolding ) do
										if( v.x==ax and v.y==h and v.z==az ) then
											table.insert( v.what_where, { ay, new_content, param2});
										end
									end
								end
								data[ a:index(ax, h, az)] = c_dig_here;
								-- how much is to be digged is counted later on (when evaluating extra_calls.scaffolding)
								break;
							end
						end
						-- keep the old content
						new_content = node_content;
						param2      = param2_data[a:index(ax, ay, az)];
						n           = {};

					-- a new node is to be placed here AND it is not air or ignore AND
					-- the existing node is either air, scaffolding or special scaffolding
					-- -> place special scaffolding to indicate which node is wanted here
					elseif(new_content and new_content ~= cid.c_air and new_content ~= cid.c_ignore
					  and (node_content == cid.c_air or node_content == c_scaffolding or node_content == c_scaffolding_empty)) then
						-- store what we expect/want at this place
						table.insert( extra_calls.scaffolding, {x=ax, y=ay, z=az, node_wanted=new_content, param2_wanted=param2});

						-- place scaffolding instead of the wanted node
						-- TODO: count how many scaffolding nodes where placed
						new_content = c_scaffolding;
						param2      = 0;
						n           = {};

					-- a new node is to be placed here AND it is air AND
					-- there is a scaffolding node already
					-- -> remove this misplaced scaffolding node
					elseif( new_content and new_content == cid.c_air
					  and (node_content == c_scaffolding or node_content == c_scaffolding_empty)) then

						-- we need to remove metadata at this position
						table.insert( extra_calls.clear_meta, {x=ax, y=ay, z=az});

						new_content = cid.c_air;
						param2      = 0;
						n           = {};

					-- let the old node continue to exist
					else
						new_content = node_content;
						param2      = param2_data[a:index(ax, ay, az)];
						n           = {};
					end

					-- create a statistic of all missing nodes
					if( node_content ~= new_content_wanted and node_content and new_content_wanted
					   and new_content_wanted ~= cid.c_air and new_content_wanted ~= cid.c_ignore
					   and not( handle_schematics.player_can_provide[new_content] and
					            handle_schematics.player_can_provide[new_content] ==
						    handle_schematics.player_can_provide[node_content])) then
						if( not( missing_nodes[ new_content_wanted ])) then
							missing_nodes[ new_content_wanted ] = 1;
						else
							missing_nodes[ new_content_wanted ] = missing_nodes[ new_content_wanted ] + 1;
						end
					end
				end

				-- actually change the node
				data[       a:index(ax, ay, az)] = new_content;
				param2_data[a:index(ax, ay, az)] = param2;

				-- some nodes need on_construct to be called in order to be set up properly
				if( n.on_construct ) then
					if( not( extra_calls.on_constr[ new_content ] )) then
						extra_calls.on_constr[ new_content ] = { {x=ax, y=ay, z=az}};
					else
						table.insert( extra_calls.on_constr[ new_content ], {x=ax, y=ay, z=az});
					end
				end

				-- store that a tree is to be grown there
				if(     n.is_tree ) then
					table.insert( extra_calls.trees,  {x=ax, y=ay, z=az, typ=new_content, snow=has_snow});

				-- we're dealing with a chest that might need filling
				elseif( n.is_chestlike ) then
					table.insert( extra_calls.chests, {x=ax, y=ay, z=az, typ=new_content, bpos_i=building_nr_in_bpos, typ_name=n.special_chest});

				-- the sign may require some text to be written on it
				elseif( n.is_sign ) then
					table.insert( extra_calls.signs,  {x=ax, y=ay, z=az, typ=new_content, bpos_i=building_nr_in_bpos});

				-- doors need the state param to be set (which depends on param2)
				elseif( n.is_door_a ) then
					table.insert( extra_calls.door_a, {x=ax, y=ay, z=az, typ=new_content, p2=param2_data[a:index(ax, ay, az)]});
				elseif( n.is_door_b ) then
					table.insert( extra_calls.door_b, {x=ax, y=ay, z=az, typ=new_content, p2=param2_data[a:index(ax, ay, az)]});

				-- beds are of special intrest to npc
				elseif( n.is_bed ) then
					local found = false;
					for i,bed in ipairs(extra_calls.beds ) do
						if( bed and bed.x == ax and bed.y == ay and bed.z == az ) then
							found = true;
						end
					end
					if( not( found)) then
						table.insert( extra_calls.beds,   {x=ax, y=ay, z=az, typ=new_content, p2=param2_data[a:index(ax, ay, az)]});
					end

				-- workplace markers need to know their village_id, plot_nr etc. as well
				elseif( n.is_workplace_marker ) then
					local found = false;
					for i,w in ipairs(extra_calls.workplaces ) do
						if( w and w.x == ax and w.y == ay and w.z == az ) then
							found = true;
						end
					end
					if( not( found)) then
						table.insert( extra_calls.workplaces,   {x=ax, y=ay, z=az, typ=new_content, p2=param2_data[a:index(ax, ay, az)]});
					end
				end
			end
		end

		local ax = pos.x + x;
		local az = pos.z + z;
		local y_top    = pos.y+binfo.yoff+binfo.ysize;
		if( y_top+1 > maxp.y ) then
			y_top = maxp.y-1;
		end
		local y_bottom = pos.y+binfo.yoff;
		if( y_bottom < minp.y ) then
			y_bottom = minp.y;
		end
		if( has_snow and ax >= minp.x and ax <= maxp.x and az >= minp.z and az <= maxp.z ) then
			local res = handle_schematics.mg_drop_moresnow( ax, az, y_top, y_bottom-1, a, data, param2_data, cid);
			if( res and (data[ a:index(ax, res.height, az)]==cid.c_air
			          or data[ a:index(ax, res.height, az)]==cid.c_water )) then
				data[       a:index(ax, res.height, az)] = res.suggested.new_id;
				param2_data[a:index(ax, res.height, az)] = res.suggested.param2;
				has_snow = false;
			end
		end
	end
	end
	if( scaffolding_only ) then
		return missing_nodes;
	end
end



-- actually place the buildings (at least those which came as .we files; .mts files are handled later on)
-- this code was also responsible for tree placement;
-- place_buildings is used by mg_villages exclusively. It calls the local function generate_building and
-- therefore resides in this file.
handle_schematics.place_buildings = function(village, minp, maxp, data, param2_data, a, cid, village_id)
	-- this function is only relevant for mg_villages
	if( not( mg_villages )) then
		return;
	end
	local vx, vz, vs, vh = village.vx, village.vz, village.vs, village.vh
	local village_type = village.village_type;

	local bpos             = village.to_add_data.bpos;

	local replacements = mg_villages.get_replacement_table( village.village_type, nil, village.to_add_data.replacements );

	cid.c_chest            = GCIR( 'default:chest',          replacements );
	cid.c_bookshelf        = GCIR( 'default:bookshelf',      replacements );
	cid.c_chest_locked     = GCIR( 'default:chest_locked',   replacements );
	cid.c_chest_shelf      = GCIR( 'cottages:shelf',         replacements );
	cid.c_chest_ash        = GCIR( 'trees:chest_ash',        replacements );
	cid.c_chest_aspen      = GCIR( 'trees:chest_aspen',      replacements );
	cid.c_chest_birch      = GCIR( 'trees:chest_birch',      replacements );
	cid.c_chest_maple      = GCIR( 'trees:chest_maple',      replacements );
	cid.c_chest_chestnut   = GCIR( 'trees:chest_chestnut',   replacements );
	cid.c_chest_pine       = GCIR( 'trees:chest_pine',       replacements );
	cid.c_chest_spruce     = GCIR( 'trees:chest_spruce',     replacements );
	cid.c_sign             = GCIR( 'default:sign_wall',      replacements );

	cid.c_torch            = GCIR( 'default:torch',          replacements );
	cid.c_torch_ceiling    = GCIR( 'default:torch_ceiling',  replacements );
	cid.c_torch_wall       = GCIR( 'default:torch_wall',     replacements );
--print('REPLACEMENTS: '..minetest.serialize( replacements.table )..' CHEST: '..tostring( minetest.get_name_from_content_id( cid.c_chest ))); -- TODO

	local extranodes = {}
	local extra_calls = { on_constr = {}, trees = {}, chests = {}, signs = {}, traders = {}, door_a = {}, door_b = {}, scaffolding = {}, clear_meta = {}, beds = {}, workplaces = {} };

	for i, pos in ipairs(bpos) do
		-- roads are only placed if there are at least mg_villages.MINIMAL_BUILDUNGS_FOR_ROAD_PLACEMENT buildings in the village
		if( not(pos.btype) or pos.btype ~= 'road' or village.anz_buildings > mg_villages.MINIMAL_BUILDUNGS_FOR_ROAD_PLACEMENT )then
			-- replacements are in table format for mapgen-based building spawning
			local road_material = mg_villages.road_node;
			if( pos.road_material ) then
				road_material = pos.road_material;
			end
			-- we need to collect the positions of all beds...even if they are placed in diffrent mapchunks
			if( not( pos.beds )) then
				pos.beds = {};
			end
			extra_calls.beds = pos.beds;
			if( not( pos.workplaces )) then
				pos.workplaces = {};
			end
			extra_calls.workplaces = pos.workplaces;
			-- do not use scaffolding here; place the building directly
			handle_schematics.generate_building(pos, minp, maxp, data, param2_data, a, extranodes, replacements, cid, extra_calls, i, village_id, nil, road_material, true, false )
			-- the bed positions are of intrest later on
			pos.beds = extra_calls.beds;
			pos.workplaces = extra_calls.workplaces;
		end
	end

	-- we store the beds per building; not per village
	extra_calls.beds = nil;
	extra_calls.workplaces = nil;
	-- replacements are in list format for minetest.place_schematic(..) type spawning
	return { extranodes = extranodes, bpos = bpos, replacements = replacements.list, dirt_roads = village.to_add_data.dirt_roads,
			plantlist = village.to_add_data.plantlist, extra_calls = extra_calls };
end



-- get content ids replaced
handle_schematics.get_cid_table = function( replacements )
	-- only very few nodes are actually used from the cid table (content ids)
	local cid = {};
	cid.c_air              = minetest.get_content_id( 'air' );
	cid.c_dirt             = GCIR( 'default:dirt',           replacements );
	cid.c_dirt_with_grass  = GCIR( 'default:dirt_with_grass',replacements );

	cid.c_plotmarker       = GCIR( 'mg_villages:plotmarker', replacements );
	cid.c_mob_spawner      = GCIR( 'mg_villages:mob_spawner',replacements );

	cid.c_chest            = GCIR( 'default:chest',          replacements );
	cid.c_chest_locked     = GCIR( 'default:chest_locked',   replacements );
	cid.c_chest_shelf      = GCIR( 'cottages:shelf',         replacements );
	cid.c_chest_ash        = GCIR( 'trees:chest_ash',        replacements );
	cid.c_chest_aspen      = GCIR( 'trees:chest_aspen',      replacements );
	cid.c_chest_birch      = GCIR( 'trees:chest_birch',      replacements );
	cid.c_chest_maple      = GCIR( 'trees:chest_maple',      replacements );
	cid.c_chest_chestnut   = GCIR( 'trees:chest_chestnut',   replacements );
	cid.c_chest_pine       = GCIR( 'trees:chest_pine',       replacements );
	cid.c_chest_spruce     = GCIR( 'trees:chest_spruce',     replacements );
	cid.c_sign             = GCIR( 'default:sign_wall',      replacements );

	cid.c_torch            = GCIR( 'default:torch',          replacements );
	cid.c_torch_ceiling    = GCIR( 'default:torch_ceiling',  replacements );
	cid.c_torch_wall       = GCIR( 'default:torch_wall',     replacements );

	-- for roads
	cid.c_sign             = GCIR( 'default:gravel',         replacements );

	-- additional entries from mg_villages
	cid.c_ignore           = minetest.get_content_id( 'ignore' );
	cid.c_stone            = GCIR( 'default:stone', replacements);
	cid.c_snow             = GCIR( 'default:snow', replacements);
	cid.c_snowblock        = GCIR( 'default:snowblock', replacements);
	cid.c_dirt_with_snow   = GCIR( 'default:dirt_with_snow', replacements );
	cid.c_desert_sand      = GCIR( 'default:desert_sand', replacements ); -- PM v
	cid.c_desert_stone     = GCIR( 'default:desert_stone', replacements);
	cid.c_silver_sand      = GCIR( 'default:silver_sand', replacements ); -- PM v
	cid.c_silver_sandstone = GCIR( 'default:silver_sandstone', replacements);
	cid.c_sand             = GCIR( 'default:sand', replacements );
	cid.c_tree             = GCIR( 'default:tree', replacements);
	cid.c_jtree            = GCIR( 'default:jungletree', replacements);
	cid.c_ptree            = GCIR( 'default:pine_tree', replacements);
	cid.c_atree            = GCIR( 'default:acacia_tree', replacements);
	cid.c_asptree          = GCIR( 'default:aspen_tree', replacements);
	cid.c_water            = GCIR( 'default:water_source', replacements); -- PM ^
	cid.c_coal_ore         = GCIR( 'default:coal_ore', replacements);
	cid.c_sandstone        = GCIR( 'default:sandstone', replacements);

	cid.c_msnow_1          = GCIR( 'moresnow:snow_top', replacements );
	cid.c_msnow_2          = GCIR( 'moresnow:snow_fence_top', replacements);
	cid.c_msnow_3          = GCIR( 'moresnow:snow_stair_top', replacements);
	cid.c_msnow_4          = GCIR( 'moresnow:snow_slab_top', replacements);
	cid.c_msnow_5          = GCIR( 'moresnow:snow_panel_top', replacements);
	cid.c_msnow_6          = GCIR( 'moresnow:snow_micro_top', replacements);
	cid.c_msnow_7          = GCIR( 'moresnow:snow_outer_stair_top', replacements);
	cid.c_msnow_8          = GCIR( 'moresnow:snow_inner_stair_top', replacements);
	cid.c_msnow_9          = GCIR( 'moresnow:snow_ramp_top', replacements);
	cid.c_msnow_10         = GCIR( 'moresnow:snow_ramp_outer_top', replacements);
	cid.c_msnow_11         = GCIR( 'moresnow:snow_ramp_inner_top', replacements);
	cid.c_msnow_soil       = GCIR( 'moresnow:snow_soil', replacements );

	cid.c_ice              = GCIR( 'default:ice', replacements );

	if( minetest.get_modpath('ethereal')) then
		cid.c_ethereal_clay_red    = GCIR( 'bakedclay:red', replacements );
		cid.c_ethereal_clay_orange = GCIR( 'bakedclay:orange', replacements );
	end

	return cid;
end

-- place a schematic manually
--
-- pos needs to contain information about how to place the building:
-- 	pos.x, pos.y, pos.z	where the building is to be placed
-- 	pos.btype		determines which building will be placed; if not set, binfo_extra needs to be provided
-- 	pos.brotate		contains a value of 0-3, which determines the rotation of the building
--	pos.bsizex		size of the building in x direction
--	pos.bsizez		size of the building in z direction
--	pos.mirror		if set, the building will be mirrored
-- 	pos.no_plotmarker	optional; needs to be set in order to avoid the generation of a plotmarker
-- 	building_nr		optional; used for plotmarker
-- 	village_id		optional; used for plotmarker
-- 	pos.fruit		optional; determines the fruit a farm is going to grow (if binfo.farming_plus is set)

-- binfo contains general information about a building:
-- 	binfo.sizex		size of the building in x direction
-- 	binfo.sizez
-- 	binfo.ysize
-- 	binfo.yoff		how deep is the building burried?
-- 	binfo.nodenames		list of the node names beeing used by the building
-- 	binfo.scm		name of the file containing the schematic; only needed for an error message
-- 	binfo.scm_data_cache	contains actual information about the nodes beeing used (the data)
-- 	binfo.is_mts		optional; if set to 1, the function will abort
-- 	binfo.farming_plus	optional; if set, pos.fruit needs to be set as well
-- 	binfo.axis		optional; relevant for some mirroring operations
--
-- replacement_list		contains replacements in the same list format as place_schematic uses
-- keep_ground                  keep biome-specific ground nodes
-- scaffolding_only             when true: place a scaffolding node where there is air; place nothing if there is a solid node
--
handle_schematics.place_building_using_voxelmanip = function( pos, binfo, replacement_list, keep_ground, scaffolding_only)

	if( not( replacement_list ) or type( replacement_list ) ~= 'table' ) then
		return;
	end

	-- if not defined, the building needs to start at pos.x,pos.y,pos.z - without offset
	if( not( binfo.yoff )) then
		binfo.yoff = 0;
	end

-- TODO: calculate the end position from the given data
	-- get a suitable voxelmanip object
	-- (taken from minetest_game/mods/default/trees.lua)
	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = pos.x, y = pos.y, z = pos.z},
		-- add one in height in case we need to add a dig_here-indicator
		{x = pos.x+pos.bsizex, y = pos.y+binfo.ysize+1, z = pos.z+pos.bsizez} -- TODO
        )
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data        = vm:get_data()
	local param2_data = vm:get_param2_data();


	-- translate the replacement_list into replacements.ids and replacements.table format
	-- the first two parameters are nil because we do not want a new replacement list to be generated
	local replacements = handle_schematics.get_replacement_table( nil, nil, replacement_list );

	-- get content id table
	local cid = handle_schematics.get_cid_table( replacements );

	local extranodes = {}
	local extra_calls = { on_constr = {}, trees = {}, chests = {}, signs = {}, traders = {}, door_a = {}, door_b = {}, scaffolding = {}, clear_meta = {}, beds = {}, workplaces = {} };

	-- last parameter false -> place dirt nodes instead of trying to keep the ground nodes
	local missing_nodes = handle_schematics.generate_building(pos, minp, maxp, data, param2_data, a, extranodes, replacements, cid, extra_calls, pos.building_nr, pos.village_id, binfo, cid.c_gravel, keep_ground, scaffolding_only);

	-- store the changed map data
	vm:set_data(data);
	vm:set_param2_data(param2_data);
	vm:write_to_map();
	vm:update_liquids();
	vm:update_map();

-- TODO: do the calls for the extranodes as well
	-- replacements are in list format for minetest.place_schematic(..) type spawning
	return { extranodes = extranodes, replacements = replacements.list, extra_calls = extra_calls, missing_nodes = missing_nodes };
end



-- helper function for handle_schematics.place_building_from_file; also used
-- when digging below a dig_here indicator
handle_schematics.setup_scaffolding = function( v )

	local node_name = minetest.get_name_from_content_id(v.node_wanted);
	local descr = tostring(node_name);
	local node_def = handle_schematics.node_defined( node_name );
	if(     node_def and node_def.drop
	    -- the drop can be a craftitem
	    and minetest.registered_items[ node_def.drop ]
	    and not( handle_schematics.direct_instead_of_drop[ node_name ])) then
		descr =  minetest.registered_items[ node_def.drop ].description;
	elseif( node_def and node_def.description ) then
		descr =  node_def.description;
	else
		descr = "- ? -";
	end

	local meta = minetest.get_meta( v );
	meta:set_string( "node_wanted", node_name );
	meta:set_int(  "param2_wanted", v.param2_wanted );
	meta:set_string( "infotext", "Needed: "..descr );
end


-- places a building read from file "building_name" on the map between start_pos and end_pos using luavoxelmanip
-- returns error message on failure and nil on success
handle_schematics.place_building_from_file_or_cache = function( start_pos, end_pos, building_name, replacement_list, rotate, axis, mirror, no_plotmarker, keep_ground, scaffolding_only, plotmarker_pos, binfo )
	--print ("scaffolding place_building_from_file: "..minetest.serialize( scaffolding_only ));
	if( not( building_name )) then
		return "No file name given. Cannot find the schematic.";
	end

	if(not(binfo)) then
		binfo = handle_schematics.analyze_file( building_name, nil, nil );
	end
	if( not( binfo )) then
		return "Failed to import schematic. Only .mts and .we are supported!";
	end

	-- this value has already been taken care of when determining start_pos
	binfo.yoff  = 0;
	-- file name of the scm; only used for error messages
	binfo.scm   = building_name;
	-- this is relevant for mirroring operations
	binfo.axis  = axis;


	if( not( rotate ) or rotate=="0" ) then
		start_pos.brotate = 0;
	elseif( rotate=="90" ) then
		start_pos.brotate = 1;
	elseif( rotate=="180" ) then
		start_pos.brotate = 2;
	elseif( rotate=="270" ) then
		start_pos.brotate = 3;
	end

	if( start_pos.brotate > 3 ) then
		start_pos.brotate = start_pos.brotate % 4;
	end


	-- determine the size of the bulding from the place we assigned to it...
	start_pos.bsizex  = math.abs(end_pos.x - start_pos.x)+1;
	start_pos.bsizez  = math.abs(end_pos.z - start_pos.z)+1;

	-- otpional; if set, the building will be mirrored
	start_pos.mirror = mirror;
	-- do not generate a plot marker as this is not part of a village;
	-- otherwise, building_nr and village_id would have to be provided
	start_pos.no_plotmarker = no_plotmarker;

	-- all those calls to on_construct need to be done now
	local res = handle_schematics.place_building_using_voxelmanip( start_pos, binfo, replacement_list, keep_ground, scaffolding_only);
	if( not(res) or not( res.extra_calls )) then
		return;
	end

	-- clear metadata where needed
	for k, v in pairs( res.extra_calls.clear_meta ) do
		local meta = minetest.get_meta( v );
		-- clear metadata at this position
		meta:from_table( {inventory = {}, fields = {}});
		v = nil;
	end

	-- do the necessary on_construct calls that mostly affect metadata
	handle_schematics.call_on_construct( res.extra_calls.on_constr );
	-- set up doors properly (to whatever minetest_game currently demands)
	handle_schematics.call_door_setup( res.extra_calls.door_b );


	if( scaffolding_only ) then
		-- metadata is not restored
	elseif( binfo.metadata ) then
		-- if it is a .we/.wem file, metadata was included directly
		handle_schematics.restore_meta( nil, binfo.metadata, start_pos, end_pos, start_pos.brotate, mirror);
	elseif( binfo.all_meta) then
		handle_schematics.restore_meta( nil, binfo.all_meta, start_pos, end_pos, start_pos.brotate, mirror);
	else
		handle_schematics.restore_meta( binfo.scm..'.meta', nil, start_pos, end_pos, start_pos.brotate, mirror);
	end

	local nodes_to_dig = 0;
	for k, v in pairs( res.extra_calls.scaffolding ) do

		if( v.node_wanted) then
			handle_schematics.setup_scaffolding( v );

		elseif( v.dig_down ) then
			local meta = minetest.get_meta( v );
			if( v.dig_down > 1 ) then
				meta:set_string( "infotext", "Dig "..v.dig_down.." blocks down here.");
			else
				meta:set_string( "infotext", "Dig the block below.");
			end
			meta:set_string( "dig_down", v.dig_down );
			-- structure of what_where = { pos_y, new_content, param2}}
			meta:set_string( "node_wanted_down_there", minetest.serialize( v.what_where ));
			-- store the position of the build chest so that npc can locate it more easily
			if( plotmarker_pos ) then
				meta:set_string( "chest_pos", minetest.pos_to_string( plotmarker_pos, 0 ));
			end
			-- count them
			nodes_to_dig = nodes_to_dig + v.dig_down;
		end
	end

	-- we need to store additional information at the plotmarkers position
	if( plotmarker_pos ) then
		local meta = minetest.get_meta( plotmarker_pos );
		-- how many nodes need to be digged here?
		meta:set_int( "nodes_to_dig", nodes_to_dig );

		local nodes_to_place = 0;
		if( not( res.missing_nodes )) then
			res.missing_nodes = {};
		end
		local missing = {};
		local inv = meta:get_inventory();
		inv:set_size("needed", 48 );
		for k,v in pairs( res.missing_nodes ) do
			local node_wanted = minetest.get_name_from_content_id( k );
			-- some nodes - like i.e. dirt_with_grass - cannot be obtained by the player directly
			node_wanted = handle_schematics.get_what_player_can_provide( node_wanted );
			-- store how many are needed
			if( missing[ node_wanted ]) then
				missing[ node_wanted ] = missing[ node_wanted ] + v;
			elseif( node_wanted ~= "" ) then -- "" may happen with the top of doors etc.
				missing[ node_wanted ] = v;
			end
		end
		local i = 1;
		-- now turn that information into actual stacks
		for k,v in pairs( missing ) do
			if( i<48 ) then
				local stack = inv:get_stack("needed", i);
				stack:set_name( k );
				stack:set_count( v );
				inv:set_stack( "needed", i, stack );
				nodes_to_place = nodes_to_place + v;
				i = i+1;
			end
		end
		-- clear the rest of the inventory
		while( i< 48 ) do
			local stack = inv:get_stack("needed", i);
			stack:set_name( "" );
			stack:set_count( 0);
			inv:set_stack( "needed", i, stack );
			i = i+1;
		end
		meta:set_int( "nodes_to_place", nodes_to_place );
	end
end



-- add the dirt roads
handle_schematics.place_dirt_roads = function(village, minp, maxp, data, param2_data, a, c_road_node)
	local c_air = minetest.get_content_id( 'air' );
	for _, pos in ipairs(village.to_add_data.dirt_roads) do
		handle_schematics.place_road( minp, maxp, data, param2_data, a, c_road_node, pos, c_air );
	end
end

handle_schematics.place_road = function(minp, maxp, data, param2_data, a, c_road_node, pos, c_air )
	local param2 = 0;
	if( pos.bsizex > 2 and pos.bsizex > pos.bsizez) then
		param2 = 1;
	end

--[[
	local is_main_road  = false;
	local c_road_node   = minetest.get_content_id('default:coalblock');
	local c_middle_wool = minetest.get_content_id('default:clay');
	local slab_stone    = minetest.get_content_id('stairs:slab_stone');
	if( pos.bsizex > 2 and pos.bsizez > 2 ) then
		is_main_road = true;
	end
--]]

	if( not(pos.y >= minp.y and pos.y <= maxp.y-2)) then
		return;
	end
	for x = math.max( pos.x, minp.x ), math.min( pos.x+pos.bsizex-1, maxp.x ) do
		for z = math.max( pos.z, minp.z ), math.min( pos.z+pos.bsizez-1, maxp.z ) do
			-- roads have a height of 1 block
			data[        a:index( x, pos.y, z)] = c_road_node;
			param2_data[ a:index( x, pos.y, z)] = param2;
			-- ...with air above
			data[ a:index( x, pos.y+1, z)] = c_air;
			data[ a:index( x, pos.y+2, z)] = c_air;

--[[
			if(    (param2==0 and (x==pos.x or x==pos.x+8) and is_main_road)
			    or (param2==1 and (z==pos.z or z==pos.z+8) and is_main_road)) then
				data[ a:index( x, pos.y+1, z )] = slab_stone;
			elseif((param2==0 and (x==pos.x+4 ) and is_main_road)
			    or (param2==1 and (z==pos.z+4 ) and is_main_road)) then
				data[ a:index( x, pos.y,   z )] = c_middle_wool;
			end
--]]
		end
	end
end



-- the node layer at height "ground_level" is not touched; thus
-- dirt/sand/whatever can remain there (=biome dependant); this
-- also means that the foundations for the ex-building's walls
-- will keep standing
handle_schematics.clear_area = function( start_pos, end_pos, ground_level, replacements)

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = start_pos.x, y = start_pos.y, z = start_pos.z},
		{x = end_pos.x,   y = end_pos.y,   z = end_pos.z}
        )
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data        = vm:get_data()

	if( ground_level < start_pos.y or ground_level > end_pos.y ) then
		ground_level = start_pos.y;
	end

	local cid_air = minetest.get_content_id("air");
	for y=ground_level+1, end_pos.y do
	for x=start_pos.x, end_pos.x do
	for z=start_pos.z, end_pos.z do
		data[ a:index( x, y, z ) ] = cid_air;
	end
	end
	end

	local cid_dirt = GCIR("default:dirt", replacements);
	for y=start_pos.y, ground_level-1 do
	for x=start_pos.x, end_pos.x do
	for z=start_pos.z, end_pos.z do
		data[ a:index( x, y, z ) ] = cid_dirt;
	end
	end
	end

	-- store the changed map data
	vm:set_data(data);
	vm:write_to_map();
	vm:update_liquids();
	vm:update_map();
end



-- call on_construct where needed;
-- trees, chests and signs receive no special treatment here
--
-- the function generate_building(..) returns a table that includes the
-- table extra_calls.on_constr; that one is needed as input here and
-- on_construct is called for all the nodes (indices of the table) and
-- positions (stored in an array)
handle_schematics.call_on_construct = function( extra_calls_on_constr )
	if( not( extra_calls_on_constr )) then
		return;
	end
	for k, v in pairs( extra_calls_on_constr ) do
		local node_name = minetest.get_name_from_content_id( k );
		local node_def = handle_schematics.node_defined( node_name );
		if( node_def and node_def.on_construct ) then
			for _, pos in ipairs(v) do
				node_def.on_construct( pos );
			end
		end
	end
end

-- the function generate_building(..) returns a table that includes the
-- table extra_calls.door_b; that table includes node names and positions
-- of doors that need further setup regarding metadata and changes in
-- minetest_game over time
handle_schematics.call_door_setup = function( extra_calls_door_b )
	if( not( extra_calls_door_b )) then
		return;
	end
	for k, v in pairs( extra_calls_door_b ) do
		local meta = minetest.get_meta( v );

		-- taken from the doors mod in minetest_game
		local l = 2 -- b
		local h = meta:get_int("right") + 1

		local replace = {
			{ { type = "a", state = 0 }, { type = "a", state = 3 } },
			{ { type = "b", state = 1 }, { type = "b", state = 2 } }
		}
		local new = replace[l][h]
		meta:set_int("state", new.state)
		-- wipe meta on top node as it's unused
		minetest.set_node({x = v.x, y = v.y + 1, z = v.z}, { name = "doors:hidden" })
	end
end


if( minetest.get_modpath('moresnow' )) then
	handle_schematics.moresnow_installed = true;
end
