local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local TriggerButton = require(game.ReplicatedStorage.Local.TriggerButton)
local GameSlot = require(game.ReplicatedStorage.Shared.GameSlot)

local Track = {}

function Track:new(track_system, offset_angle, name, _game, track_index, note_offset, scorllmode)
	local self = {}
	
	local offset_multiplier = CurveUtil:YForPointOf2PtLine(Vector2.new(0,1), Vector2.new(40,0.1), -note_offset*2)
	local _offset_angle = offset_angle
	local _track_obj = nil
	local _trigger_button = nil
	local _parent_track_system = track_system
		
	local _rotation = 0
	local function get_rotation()
		return _rotation
	end
	local function set_rotation(rotation)
		_rotation = rotation		
		_track_obj.PrimaryPart.Rotation = Vector3.new(0,-rotation-0,90) --lol
	end
	local function set_position(x,z)
		_track_obj.PrimaryPart.Position = Vector3.new(x,0.5 + _game:get_game_environment_center().Y,z)
	end
	
	local scrollmode = {Value=2}
	function self:cons()
		local world_center = track_system:get_player_world_center()
		local player_position = track_system:get_player_world_position()		
		
		_track_obj =  _game:get_game_protos().PlayerTrackProto:Clone()
		
		self:update_brick_color(1,_game)

		local world_to_player_dir = player_position-world_center
		local world_to_player_rotation = SPUtil:dir_ang_deg(
			world_to_player_dir.X,
			world_to_player_dir.Z
		)
		
		if scrollmode.Value == 1 then
			_track_obj.PrimaryPart.Size = Vector3.new(0.1,world_to_player_dir.Magnitude,0.1)	
			workspace.CurrentCamera.GameEnvironment.Background.Stage.Union.Transparency = 1
			workspace.CurrentCamera.GameEnvironment.Background.Stage.Union2.Transparency = 0
		else
			_track_obj.PrimaryPart.Size = Vector3.new(0.2,world_to_player_dir.Magnitude,0.1)	
			workspace.CurrentCamera.GameEnvironment.Background.Stage.Union.Transparency = 0
			workspace.CurrentCamera.GameEnvironment.Background.Stage.Union2.Transparency = 1		
		end
				
		
		do
			local offset_rotation = world_to_player_rotation + offset_angle
			local offset_dir = 0
			do
				local xy_dir = SPUtil:ang_deg_dir(offset_rotation)
				offset_dir = Vector3.new(
				  xy_dir.X,
				  0,					
				  xy_dir.Y
				) * world_to_player_dir.Magnitude
			end			
			
			local offset_mid = offset_dir * 0.5 + world_center

			set_position(offset_mid.X,offset_mid.Z)			
			set_rotation(offset_rotation)		
		end	
		
	if scrollmode.Value == 1 then	
		set_rotation(get_rotation() - offset_angle)
	else 
		set_rotation(get_rotation() - offset_angle * 0.25)
	end

		_track_obj.Name = name
		_track_obj.Parent = _game:get_game_element().Parent	
		
		_trigger_button = TriggerButton:new(
			_game,
			self:get_end_position(true), 
			_parent_track_system,
			track_index
		)
	end
	
	function self:teardown()
		_track_obj:Destroy()
		_parent_track_system = nil
		_trigger_button:teardown()
		_trigger_button = nil
		self = nil
		_game = nil
		track_system = nil
		
	end
	
	local _beat_flash_offset = 0
	function self:update_brick_color(dt_scale, _game)
		if _game._players._slots:contains(_parent_track_system._game_slot) == false then
			return
		end
		
		local target_transparency = 1
		if scrollmode.Value ~= 1 then
			_track_obj.PlayerTrackProto.BrickColor, target_transparency =
				GameSlot:slot_to_color_and_transparency(
					_parent_track_system._game_slot, 
					_game._players._slots:get(_parent_track_system._game_slot)._power_bar_active
				)
		else
			target_transparency = 1
			_track_obj.PlayerTrackProto.Transparency = 1
			_track_obj.PlayerTrackProto.BrickColor = BrickColor.new("Really black")
		end
		if GameSlot:perp_view_slot(_game:get_local_game_slot(), _parent_track_system._game_slot) then
			target_transparency = 0
		end
		--[[
		if _game:get_local_game_slot() == 2 and _parent_track_system._game_slot == 2 then
			target_transparency = 0.65		
		elseif GameSlot:perp_view_slot(_game:get_local_game_slot(), _parent_track_system._game_slot) then
			target_transparency = target_transparency * 1.5
		end
		]]--
			
		if _game._players._slots:get(_parent_track_system._game_slot)._power_bar_active then
			if _game._audio_manager:is_beat() then
				_beat_flash_offset = 0
			end
		end
		
		if scrollmode ~= 1 then
			_track_obj.PlayerTrackProto.Transparency = target_transparency + _beat_flash_offset
		end
			
		
	--	_beat_flash_offset = CurveUtil:Expt(
	--		_beat_flash_offset,
	--		0,
	--		CurveUtil:NormalizedDefaultExptValueInSeconds(0.75),
	--		dt_scale
	--	)
	end
	
	function self:update(dt_scale,_game)
		_trigger_button:update(dt_scale,_game)
		self:update_brick_color(dt_scale, _game)
	end
	
	function self:get_start_position()
		local dir_xy = SPUtil:ang_deg_dir(get_rotation()).unit
		local dir = Vector3.new(dir_xy.x, 0, dir_xy.y)
		return _track_obj.PrimaryPart.Position + (dir * -1 * _track_obj.PrimaryPart.Size.Y * 0.5)
	end
	
	function self:get_end_position(isTrigger)
		--local END_PCT = 0.55		
		local END_PCT = 0.1
		local dir_xy = SPUtil:ang_deg_dir(get_rotation()).unit
		local dir = Vector3.new(dir_xy.x, 0, dir_xy.y)
		if isTrigger == true then
			return _track_obj.PrimaryPart.Position + (dir * 1 * _track_obj.PrimaryPart.Size.Y * 0.5 * END_PCT)
		else
			return _track_obj.PrimaryPart.Position + (dir * 1 * _track_obj.PrimaryPart.Size.Y * 0.5 * END_PCT * offset_multiplier)
		end
	end
	
	function self:press()
		_trigger_button:press()
	end
	function self:release()
		_trigger_button:release()
	end
	

	self:cons()
	return self
end

return Track
