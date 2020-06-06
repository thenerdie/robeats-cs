local GameSlot = {
	SLOT_1 = 1;
	SLOT_2 = 2;
	SLOT_3 = 3;
	SLOT_4 = 4;	
}

GameSlot._world_center_position = Vector3.new()

function GameSlot:set_world_center_position(pos)
	GameSlot._world_center_position = pos
end

function GameSlot:slot_to_world_position(slot)
	local DIST = 50
	if slot == GameSlot.SLOT_1 then
		return Vector3.new(-DIST,0,DIST) + GameSlot._world_center_position	
		
	elseif slot == GameSlot.SLOT_2 then
		return Vector3.new(-DIST,0,-DIST) + GameSlot._world_center_position	
		
	elseif slot == GameSlot.SLOT_3 then
		return Vector3.new(DIST,0,-DIST) + GameSlot._world_center_position		
		
	else
		return Vector3.new(DIST,0,DIST) + GameSlot._world_center_position	
		
	end
end

function GameSlot:slot_to_camera_cframe(slot)
	if slot == GameSlot.SLOT_1 then	
		if false then
			return CFrame.new(Vector3.new(-18.5, 20, 21) + GameSlot._world_center_position) * CFrame.Angles(-math.pi / 2, 0, -math.pi / 4)
		else
			return CFrame.new(
				Vector3.new(-36.5, 14, 36.5) + GameSlot._world_center_position,
				Vector3.new(-17.5, 0, 17.5) + GameSlot._world_center_position	
			)
			end

			
	elseif slot == GameSlot.SLOT_3 then
		return 	CFrame.new(
			Vector3.new(36.5, 14, -36.5) + GameSlot._world_center_position,
			Vector3.new(17.5, 0, -17.5) + GameSlot._world_center_position
		)			
		
	else
		return 	CFrame.new(
			Vector3.new(36.5, 14, 36.5) + GameSlot._world_center_position,
			Vector3.new(17.5, 0, 17.5) + GameSlot._world_center_position
		)			
		
	end
end

function GameSlot:slot_to_color_and_transparency(slot, power_bar_active)
	if power_bar_active == true then
		return BrickColor.new(1024), 0.8
	end
	
	--[[
	if slot == GameSlot.SLOT_1 then
		return BrickColor.new(6), 0.5
	elseif slot == GameSlot.SLOT_2 then
		return BrickColor.new(226), 0.55
	elseif slot == GameSlot.SLOT_3 then
		return BrickColor.new(125), 0.5				
	else
		return BrickColor.new(343), 0.5		
	end
	]]--
	return BrickColor.new(226), 0.9
end

function GameSlot:perp_view_slot(slot, view_slot)
	if slot == GameSlot.SLOT_1 then
		return view_slot == GameSlot.SLOT_2 or view_slot == GameSlot.SLOT_4
	elseif slot == GameSlot.SLOT_2 then
		return view_slot == GameSlot.SLOT_1 or view_slot == GameSlot.SLOT_3
	elseif slot == GameSlot.SLOT_3 then
		return view_slot == GameSlot.SLOT_2 or view_slot == GameSlot.SLOT_4
	else
		return view_slot == GameSlot.SLOT_1 or view_slot == GameSlot.SLOT_3
	end
end

function GameSlot:slot_to_character_cframe(slot)
	local Y_OFFSET = 2.45
	if slot == GameSlot.SLOT_1 then
		return 	CFrame.new(
			Vector3.new(-19.147, Y_OFFSET, 29.279) + GameSlot._world_center_position,			
			Vector3.new(-100,0,100) + GameSlot._world_center_position
		)		
		
	elseif slot == GameSlot.SLOT_2 then
		return 	CFrame.new(
			Vector3.new(-30, Y_OFFSET, -16.5) + GameSlot._world_center_position,			
			Vector3.new(-100,0,-100) + GameSlot._world_center_position
		)		
		
	elseif slot == GameSlot.SLOT_3 then
		return 	CFrame.new(
			Vector3.new(19.147, Y_OFFSET, -29.279) + GameSlot._world_center_position,			
			Vector3.new(100,0,-100) + GameSlot._world_center_position
		)				
		
	else
		return 	CFrame.new(
			Vector3.new(30.5, Y_OFFSET, 16.6) + GameSlot._world_center_position,			
			Vector3.new(100,0,100) + GameSlot._world_center_position
		)				
		
	end
end

return GameSlot
