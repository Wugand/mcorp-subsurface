function place_resources(surface, pos_arr)
	local resources = {}
	local properties = {}
	for proto,_ in pairs(surface.map_gen_settings.autoplace_controls or {}) do
		if proto ~= "enemy-base" and proto ~= "trees" then
			table.insert(resources, proto)
			table.insert(properties, "entity:"..proto..":richness")
			table.insert(properties, "entity:"..proto..":probability")
		end
	end
	
	local calcresult = surface.calculate_tile_properties(properties, pos_arr)
	for _,proto in ipairs(resources) do
		for i,pos in ipairs(pos_arr) do
			if calcresult["entity:"..proto..":richness"] and calcresult["entity:"..proto..":richness"][i] > 0 and calcresult["entity:"..proto..":probability"][i] > 0 and surface.count_entities_filtered{type="resource", position={pos[1]+0.5, pos[2]+0.5}} == 0 then
				surface.create_entity{name=proto, position=pos, force=game.forces.neutral, amount=math.ceil(calcresult["entity:"..proto..":richness"][i])}
			end
		end
	end
end



function prospect_resources(prospector)
	local surface = prospector.surface
	
	log(surface.name)
	log(surface.index)

	--local resources = {}
	--local res = {}
	--for k,v in pairs(subsurface.map_gen_settings.autoplace_controls or {}) do
--		resources["entity:"..k..":richness"] = k
--		table.insert(res, "entity:"..k..":richness")
--	end
	
	local pos = prospector.position
	local pos_arr = {}
	for x, y in iarea(get_area(pos, 200)) do
		if (x-pos.x)^2 + (y-pos.y)^2 < 40000 then table.insert(pos_arr, {x, y}) end
	end
	
	--local calcresult = subsurface.calculate_tile_properties(res, pos_arr)
	--for r,arr in pairs(calcresult) do
	--	for i,v in ipairs(arr) do
	--		if v > 0 then
	--			rendering.draw_circle{color={0.5, 0.5, 0.5, 0.1}, target=pos_arr[i], radius=0.3, surface=prospector.surface, time_to_live=36000, forces={prospector.force}, draw_on_ground=true}
	--		end
	--	end
	--end



	local resources = {}
	local properties = {}
	for proto,_ in pairs(surface.map_gen_settings.autoplace_controls or {}) do
		if proto ~= "enemy-base" and proto ~= "trees" then
			table.insert(resources, proto)
			table.insert(properties, "entity:"..proto..":richness")
			table.insert(properties, "entity:"..proto..":probability")
		end
	end
	
	local calcresult = surface.calculate_tile_properties(properties, pos_arr)
	for _,proto in ipairs(resources) do
		for i,pos in ipairs(pos_arr) do
			if calcresult["entity:"..proto..":richness"] and calcresult["entity:"..proto..":richness"][i] > 0 and calcresult["entity:"..proto..":probability"][i] > 0 then
				rendering.draw_circle{color={0.5, 0.5, 0.5, 0.1}, target=pos, radius=0.3, surface=prospector.surface, time_to_live=36000, forces={prospector.force}, draw_on_ground=true}
				--surface.create_entity{name=proto, position=pos, force=game.forces.neutral, amount=math.ceil(calcresult["entity:"..proto..":richness"][i])}
			end
		end
	end

end
