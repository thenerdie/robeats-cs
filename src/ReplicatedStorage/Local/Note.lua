local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local NoteBase = require(game.ReplicatedStorage.Local.NoteBase)
local NoteResult = require(game.ReplicatedStorage.Shared.NoteResult)
local SFXManager = require(game.ReplicatedStorage.Local.SFXManager)
local HoldingNoteEffect = require(game.ReplicatedStorage.Effects.HoldingNoteEffect)
local ModManager = require(game.ReplicatedStorage.ModManager)
local test = nil
local test1 = 0.25
local test2 = 0.925

local TriggerNoteEffect = require(game.ReplicatedStorage.Effects.TriggerNoteEffect)

local NoteSize = 2


local leftID = nil
local upID = nil
local downID = nil
local rightID = nil

local _left = "rbxassetid://"
local _up = "rbxassetid://"
local _down = "rbxassetid://"
local _right = "rbxassetid://"


local NOTE_HEIGHT = 1.5

local Note = {}
Note.Type = "Note"

Note.State = {
	Pre = 0;
	DoRemove = 1;
}


local _outline_top_position_offset = Vector3.new()
local _outline_bottom_position_offset = Vector3.new()

function Note:new(_game, track_index, slot_index, creation_time_ms, hit_time_ms, new_color, id, amods)
	
	if not amods then
		amods = {}
	end
	
	--local amods = ModManager:GetActivatedMods()
	
	local scrollmode = {Value=2}

	local self = NoteBase:NoteBase()
	self.Type = Note.Type
	self.id = id
	self._state = Note.State.Pre

	local _note_obj = nil
	local _body = nil
	local _outline_top = nil
	local _outline_bottom = nil
	local _outline_top_initial_size = nil
	local _outline_bottom_initial_size = nil
	local _note_decal = nil
	local _t = 0
	local _track_index = track_index
	local _position = Vector3.new()
	local cur_color = new_color

	local _body_adorn, _outline_top_adorn, _outline_bottom_adorn

	local function is_local_slot()
		return slot_index == _game:get_local_game_slot()
	end

	local function get_start_position()
		return _game:get_tracksystem(slot_index):get_track(track_index):get_start_position()
	end
	local function get_end_position()
		return _game:get_tracksystem(slot_index):get_track(track_index):get_end_position()
	end

	local function update_visual_for_t(t)
		
		if scrollmode.Value == 1 then
			test = test2
		else
			test = test1	
		end
	
		SPUtil:profilebegin("Note:update_visual_for_t")

		_position = SPUtil:vec3_lerp(
			get_start_position(),
			get_end_position(),
			t
		)
		_position = Vector3.new(
			_position.X,
			0.25 + _game:get_game_environment_center().Y,
			_position.Z
		)

		local size = CurveUtil:YForPointOf2PtLine(
			Vector2.new(0,test),
			Vector2.new(1,0.925),
			SPUtil:clamp(t,0,1)
		)
		
		for i, mod in pairs(amods) do
			if mod.UpdateNote then
				local p = mod:UpdateNote({
					Alpha=t;
					Track=_track_index;
					OriginalColor=new_color;
					CurrentColor=cur_color;
					Position=_position;
					Size=size;
					Id=id
				})
				if p ~= nil then
					if p.color then
						cur_color=p.color
					end
					if p.visible ~= nil then
						if p.visible == false then
							_body_adorn.Transparency = 1	
						end
					end
					if p.transparency then
						_body.Decal.Transparency = p.transparency 
						_body_adorn.Transparency = p.transparency
						--_outline_bottom_adorn.Transparency = p.transparency
						--_outline_top_adorn.Transparency = p.transparency
					end
				end
			end
		end
		
		if 2 == 1 then
			_body.CFrame = CFrame.new(_position) * CFrame.Angles(math.rad(90),0,math.rad(-135)) --CFrame.Angles(math.rad(90), 0, math.rad(-135))
			_outline_bottom_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(_position + _outline_bottom_position_offset * size))
			_outline_bottom_adorn.Height = 0
			_outline_bottom_adorn.Radius = 0
			_outline_top_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(_position + _outline_top_position_offset * size))
			_outline_top_adorn.Height = 0
			_outline_top_adorn.Radius = 0
			local power_bar_active = _game._players._slots:get(slot_index)._power_bar_active
		else
			_body_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(_position))
			_body_adorn.Height = size * 1.5
			_body_adorn.Radius = size * 1.5
	
			_outline_bottom_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(
				_position + (_outline_bottom_position_offset * size)
			))
		end
		if scrollmode.Value ~= 1 then
			_body_adorn.Color3 = cur_color
		else
			_note_decal.Color3 = cur_color
		end
		
		_body_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(_position))
		_body_adorn.Height = size * 1.5
		_body_adorn.Radius = size * 1.5

		_outline_bottom_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(
			_position + (_outline_bottom_position_offset * size)
		))
	if scrollmode.Value == 1 then
		_outline_bottom_adorn.Height = size * 0
		_outline_bottom_adorn.Radius = size * 0
	else
		_outline_bottom_adorn.Height = size * 0.5
		_outline_bottom_adorn.Radius = size * 1.6
	end

		_outline_top_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(
			_position + (_outline_top_position_offset * size)
		))
	if scrollmode.Value == 1 then
		_outline_top_adorn.Height = 0
		_outline_top_adorn.Radius = 0
	else
		_outline_top_adorn.Height = size * 0.25
		_outline_top_adorn.Radius = size * 1.6
	end
		

		SPUtil:profileend()
	end

	function self:cons(_game)
		_note_obj = _game._object_pool:depool(self.Type)
		if _note_obj == nil then
			_note_obj = _game:get_game_protos().NoteAdornProto:Clone()
			_outline_top_position_offset = _note_obj.OutlineTop.Position - _note_obj.PrimaryPart.Position
			_outline_bottom_position_offset = _note_obj.OutlineBottom.Position - _note_obj.PrimaryPart.Position

			_note_obj.Body.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Body))
			_note_obj.OutlineTop.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.OutlineTop))
			_note_obj.OutlineBottom.CFrame = (CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.OutlineBottom))
			_note_obj.Body.Decal.Color3 = Color3.new(1,1,1)
		end
		

		

		

		_body = _note_obj.Body
		_outline_top = _note_obj.OutlineTop
		_outline_bottom = _note_obj.OutlineBottom
		_body_adorn = _body.Adorn
		_outline_top_adorn = _outline_top.Adorn
		_outline_bottom_adorn = _outline_bottom.Adorn
		
		if scrollmode.Value == 1 then
			
			
				
			_note_decal = _body.Decal
			_body_adorn.Transparency = 1
			_outline_top_adorn.Transparency = 1
			_outline_bottom_adorn.Transparency = 1
			
		if _track_index == 1 then
			_body.Size = Vector3.new(NoteSize.Value / 100 ,NoteSize.Value / 100 ,0.05)
			_left = "rbxassetid://" .. leftID.Value
			_note_decal.Texture = _left
			_note_decal.Transparency = 0
			
			
		elseif _track_index == 2 then
			_body.Size = Vector3.new(NoteSize.Value / 100 ,NoteSize.Value / 100 ,0.05)
			_up = "rbxassetid://" .. upID.Value
			_note_decal.Texture = _up
			_note_decal.Transparency = 0
			
			
		elseif _track_index == 3 then
			_body.Size = Vector3.new(NoteSize.Value / 100 ,NoteSize.Value / 100 ,0.05)
			_down = "rbxassetid://" .. downID.Value
			_note_decal.Texture = _down
			_note_decal.Transparency = 0
			
			
		elseif _track_index == 4 then
			_body.Size = Vector3.new(NoteSize.Value / 100 ,NoteSize.Value / 100 ,0.05)
			_right = "rbxassetid://" .. rightID.Value
			_note_decal.Texture = _right
			_note_decal.Transparency = 0
			
			
	end
end
		
		_outline_bottom_adorn.Color3 = Color3.new(0,0,0)
		_outline_top_adorn.Color3 = Color3.new(0,0,0)

		_outline_top_initial_size = _outline_top.Size
		_outline_bottom_initial_size = _outline_bottom.Size

		_t = 0
		update_visual_for_t(_t)

		_note_obj.Parent = _game:get_game_element().Parent
	end

	local _dt_scale_sum = 0
	--[[Override--]] function self:update(dt_scale, _game)
		SPUtil:profilebegin("Note:update")

		if self._state == Note.State.Pre then
			_t = (_game._audio_manager:get_current_time_ms() - creation_time_ms) / (hit_time_ms - creation_time_ms)

			if slot_index == _game:get_local_game_slot() then
				update_visual_for_t(_t)
			else
				_dt_scale_sum = _dt_scale_sum + dt_scale
				if _game:get_frame_count() % 4 == (slot_index - 1) % 4 then
					update_visual_for_t(_t)
					_dt_scale_sum = 0
				end
			end

			if self:should_remove(_game) then
				if NoteResult.Miss ~= 1 then
					NoteResult.Miss = 1
				end
				if NoteResult.Okay ~= 2 then
					NoteResult.Okay = 2
				end
				if NoteResult.Good ~= 3 then
					NoteResult.Good = 3
				end
				if NoteResult.Great ~= 4 then
					NoteResult.Great = 4
				end
				if NoteResult.Perfect ~= 5 then
					NoteResult.Perfect = 5
				end
				if NoteResult.Marvelous ~= 6 then
					NoteResult.Marvelous = 6
				end
				
				local ln = require(game:GetService'ReplicatedStorage'.Local.HeldNote);
				if ln.State.Pre ~= 0 then
					ln.State.Pre = 0
				end
				if ln.State.Holding ~= 1 then
					ln.State.Holding = 1
				end
				if ln.State.HoldMissedActive ~= 2 then
					ln.State.HoldMissedActive = 2
				end
				if ln.State.Passed ~= 3 then
					ln.State.Passed = 3
				end
				if ln.State.DoRemove ~= 4 then
					ln.State.DoRemove = 4
				end	
				_game._score_manager:register_hit(
					_game,
					NoteResult.Miss,
					slot_index,
					track_index,
					{ PlaySFX = false; PlayHoldEffect = false; TimeMiss = true; },
					-10000
				)
			end
		end

		SPUtil:profileend()
	end

	--[[Override--]] function self:should_remove(_game)
		if NoteResult.Miss ~= 1 then
			NoteResult.Miss = 1
		end
		if NoteResult.Okay ~= 2 then
			NoteResult.Okay = 2
		end
		if NoteResult.Good ~= 3 then
			NoteResult.Good = 3
		end
		if NoteResult.Great ~= 4 then
			NoteResult.Great = 4
		end
		if NoteResult.Perfect ~= 5 then
			NoteResult.Perfect = 5
		end
		if NoteResult.Marvelous ~= 6 then
			NoteResult.Marvelous = 6
		end
		
		local ln = require(game:GetService'ReplicatedStorage'.Local.HeldNote);
		if ln.State.Pre ~= 0 then
			ln.State.Pre = 0
		end
		if ln.State.Holding ~= 1 then
			ln.State.Holding = 1
		end
		if ln.State.HoldMissedActive ~= 2 then
			ln.State.HoldMissedActive = 2
		end
		if ln.State.Passed ~= 3 then
			ln.State.Passed = 3
		end
		if ln.State.DoRemove ~= 4 then
			ln.State.DoRemove = 4
		end	
		return self._state == Note.State.DoRemove or self:get_time_to_end() < _game._audio_manager.NOTE_REMOVE_TIME
	end

	--[[Override--]] function self:do_remove(_game)
		if is_local_slot() then
			_game._effects:add_effect(HoldingNoteEffect:new(
				_game,
				_note_obj.PrimaryPart.Position,
				NoteResult.Okay
			))
		end
		_game._object_pool:repool(self.Type,_note_obj)
		_note_obj = nil
	end

	--[[Override--]] function self:test_hit(_game)
		local time_to_end = self:get_time_to_end()
		if NoteResult.Miss ~= 1 then
			NoteResult.Miss = 1
		end
		if NoteResult.Okay ~= 2 then
			NoteResult.Okay = 2
		end
		if NoteResult.Good ~= 3 then
			NoteResult.Good = 3
		end
		if NoteResult.Great ~= 4 then
			NoteResult.Great = 4
		end
		if NoteResult.Perfect ~= 5 then
			NoteResult.Perfect = 5
		end
		if NoteResult.Marvelous ~= 6 then
			NoteResult.Marvelous = 6
		end
		
		local ln = require(game:GetService'ReplicatedStorage'.Local.HeldNote);
		if ln.State.Pre ~= 0 then
			ln.State.Pre = 0
		end
		if ln.State.Holding ~= 1 then
			ln.State.Holding = 1
		end
		if ln.State.HoldMissedActive ~= 2 then
			ln.State.HoldMissedActive = 2
		end
		if ln.State.Passed ~= 3 then
			ln.State.Passed = 3
		end
		if ln.State.DoRemove ~= 4 then
			ln.State.DoRemove = 4
		end	
		local did_hit, note_result = NoteResult:timedelta_to_result(time_to_end, _game)
		
		if did_hit then
			return did_hit, note_result
		end

		return false, NoteResult.Miss
	end

	--[[Override--]] function self:on_hit(_game,note_result,i_notes)
		--[[_game._effects:add_effect(TriggerNoteEffect:new(
			_game,
			self:get_position(),
			note_result,
			is_local_slot()
		))]]--
		if not _game.is_spectating then
--			print("Adding note hit to local cache...")
			_game._hit_cache:addToCache(
				_game._hit_cache:genNewHit(_game._audio_manager:get_current_time_ms(), track_index, "Press", note_result, self.id)
			)
		end

		_game._score_manager:register_hit(
			_game,
			note_result,
			slot_index,
			track_index,
			{ PlaySFX = true; PlayHoldEffect = true; HoldEffectPosition = self:get_position(); },
			self:get_time_to_end()
		)

		self._state = Note.State.DoRemove
	end

	--[[Override--]] function self:test_release(_game)
		return false, NoteResult.Miss
	end
	--[[Override--]] function self:on_release(_game,note_result,i_notes)
	end
	--[[Override--]] function self:get_track_index()
		return _track_index
	end

	function self:get_time_to_end()
		return (hit_time_ms - creation_time_ms) * (1 - _t)
	end

	function self:get_position()
		return _position
	end

	self:cons(_game)
	return self
end

return Note
