table_miner_names = {
	["vehicle-miner"]=1, ["vehicle-miner-mk2"]=1, ["vehicle-miner-mk3"]=1, ["vehicle-miner-mk4"]=1, ["vehicle-miner-mk5"]=1, 
	["vehicle-miner-0"]=1, ["vehicle-miner-mk2-0"]=1, ["vehicle-miner-mk3-0"]=1, ["vehicle-miner-mk4-0"]=1, ["vehicle-miner-mk5-0"]=1
}

function check_miner_placed(entity)
	if table_miner_names[entity.name] then
		global.aai_miners[entity.unit_number] = entity
		script.register_on_entity_destroyed(entity)
	end
end

function handle_miners(tick)
	global.aai_miners = global.aai_miners or {}

	for _,miner in pairs(global.aai_miners) do

		subsurface=miner.surface
		
		if miner.valid and miner.speed > 0 then -- digging part
			local orientation = miner.orientation
			local miner_collision_box = miner.prototype.collision_box
			local center_big_excavation = move_towards_continuous(miner.position, orientation, -miner_collision_box.left_top.y)
			local center_small_excavation = move_towards_continuous(center_big_excavation, orientation, 1.5)
			local speed_test_position = move_towards_continuous(center_small_excavation, orientation, 1.6)
			
			local walls_dug = clear_subsurface(subsurface, center_small_excavation, 1, nil)
			walls_dug = walls_dug + clear_subsurface(subsurface, center_big_excavation, 3, nil)
			
			if walls_dug > 0 then
				local stack = {name = "stone", count = 20 * walls_dug}
				local actually_inserted = miner.insert(stack)
				if actually_inserted ~= stack.count then
					stack.count = stack.count - actually_inserted
					subsurface.spill_item_stack(miner.position, stack)
				end
				subsurface.pollute(center_small_excavation, walls_dug * 0.25)
				subsurface.create_trivial_smoke{name="fire-smoke-without-glow", position=speed_test_position}
				subsurface.create_trivial_smoke{name="fire-smoke-without-glow", position=speed_test_position}
				subsurface.create_trivial_smoke{name="fire-smoke-without-glow", position=speed_test_position}
			end

			if miner.speed > 0 and subsurface.find_entity("subsurface-wall", speed_test_position) then
				miner.friction_modifier = 10
			else
				miner.friction_modifier = 1
			end
		end
	end
end
