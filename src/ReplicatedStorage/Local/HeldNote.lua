local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local NoteBase = require(game.ReplicatedStorage.Local.NoteBase)
local NoteResult = require(game.ReplicatedStorage.Shared.NoteResult)
local SFXManager = require(game.ReplicatedStorage.Local.SFXManager)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local TriggerNoteEffect = require(game.ReplicatedStorage.Effects.TriggerNoteEffect)
local HoldingNoteEffect = require(game.ReplicatedStorage.Effects.HoldingNoteEffect)
local FlashEvery = require(game.ReplicatedStorage.Shared.FlashEvery)

local SPList = require(game.ReplicatedStorage.Shared.SPList)
local test = nil
local teest = nil
local test1 = 0.25
local test2 = 0.65
local test3 = 1.5

local NoteSize = 2

local leftID = nil
local upID = nil
local downID = nil
local rightID = nil

local ModManager = require(game.ReplicatedStorage.ModManager)

local _left = "rbxassetid://"
local _up = "rbxassetid://"
local _down = "rbxassetid://"
local _right = "rbxassetid://"
-- local BODY_WIDTH = 1.5
-- local BODY_LENGTH = 50
-- local HEAD_SIZE = 3

local HeldNote = {}
HeldNote.Type = "HeldNote"

HeldNote.State = {
	Pre = 0;
	Holding = 1;
	HoldMissedActive = 2;
	Passed = 3;
	DoRemove = 4;
}

function HeldNote:new(
	_game,
	track_index,
	slot_index,
	creation_time_ms,
	hit_time_ms,
	duration_time_ms,
	new_color,
	snap_enabled,
	id,
	amods
)

	if not amods then
		amods = {}
	end
	
	--local amods = ModManager:GetActivatedMods()

	local scrollmode = {Value=2}
	local self = NoteBase:NoteBase()
	
	self.id = id
	
	self.Type = HeldNote.Type

	local _note_obj = nil

	local cur_color = new_color
	local _body = nil
	local _head = nil
	local _tail = nil
	local _head_outline = nil
	local _head_decal = nil
	local _tail_decal = nil
	local _tail_outline = nil
	local _body_outline_left = nil
	local _body_outline_right = nil
	
	local t_override = false
	
	local _body_adorn, _head_adorn, _tail_adorn, _head_outline_adorn, _tail_outline_adorn, _body_outline_left_adorn, _body_outline_right_adorn, _body_2D_part
	local snapped = snap_enabled

	local _game_audio_manager_get_current_time_ms = 0

	local _track_index = track_index

	local _state = HeldNote.State.Pre
	local _did_trigger_head = false
	local _did_trigger_tail = false

	local function is_local_slot()
		return slot_index == _game:get_local_game_slot()
	end

	local __get_start_position = nil
	local function get_start_position()
		if __get_start_position == nil then
			__get_start_position = _game:get_tracksystem(slot_index):get_track(track_index):get_start_position()
		end
		return __get_start_position
	end
	local __get_end_position = nil
	local function get_end_position()
		if __get_end_position == nil then
			__get_end_position = _game:get_tracksystem(slot_index):get_track(track_index):get_end_position()
		end
		return __get_end_position
	end
	local function get_head_position()
		return SPUtil:vec3_lerp(
			get_start_position(),
			get_end_position(),
			(_game_audio_manager_get_current_time_ms - creation_time_ms) / (hit_time_ms - creation_time_ms)
		)
	end
	local function get_tail_hit_time()
		return hit_time_ms + duration_time_ms
	end
	local function tail_visible()
		return not (get_tail_hit_time() > _game_audio_manager_get_current_time_ms + _game._audio_manager:get_note_prebuffer_time_ms())
	end
	local function get_tail_t()
		local tail_show_time = _game_audio_manager_get_current_time_ms - get_tail_hit_time() + _game._audio_manager:get_note_prebuffer_time_ms()
		return tail_show_time / _game._audio_manager:get_note_prebuffer_time_ms()
	end
	local function get_tail_position()
		if not tail_visible() then
			return get_start_position()
		else
			local tail_t = get_tail_t()
			return SPUtil:vec3_lerp(
				get_start_position(),
				get_end_position(),
				tail_t
			)
		end
	end

	local _i_update_visual = -1
	local function update_visual(dt_scale)
		
		if 2 == 1 then
			test = test3
			teest = test3
		else
			test = test1
			teest = test2	
		end
		
		local power_bar_active = _game._players._slots:get(slot_index)._power_bar_active

		local head_pos = get_head_position()
		local tail_pos = get_tail_position()
		_head.CFrame = CFrame.new(head_pos) * CFrame.Angles(0, math.rad(90), 0)
		_tail.CFrame = CFrame.new(tail_pos) * CFrame.Angles(0, math.rad(90), 0)
		--_head_adorn.CFrame = CFrame.new(_head.CFrame:vectorToObjectSpace(head_pos)) + Vector3.new(0,-0.35,0)
		--_tail_adorn.CFrame = CFrame.new(_tail.CFrame:vectorToObjectSpace(tail_pos)) + Vector3.new(0,-0.35,0)

		_head_outline_adorn.CFrame = CFrame.new(_head_outline.CFrame:vectorToObjectSpace(head_pos + Vector3.new(0,-0.65)))
		_tail_outline_adorn.CFrame = CFrame.new(_tail_outline.CFrame:vectorToObjectSpace(tail_pos + Vector3.new(0,-0.65)))

		if _did_trigger_head then
			if _game_audio_manager_get_current_time_ms > hit_time_ms then
				head_pos = get_end_position()
			end
		end

		local tail_to_head = head_pos - tail_pos

		if _state == HeldNote.State.Pre then
			_head_adorn.Transparency = 0
			_head_outline_adorn.Transparency = 0
		else
			_head_adorn.Transparency = 1
			_head_outline_adorn.Transparency = 1
		end

		if _state == HeldNote.State.Passed and _did_trigger_tail then
			_tail_adorn.Transparency = 1
			_tail_outline_adorn.Transparency = 1
			_body_2D_part.Transparency = 1
		else
			if tail_visible() then
				_tail_adorn.Transparency = 0
				_tail_outline_adorn.Transparency = 0
			else
				_tail_adorn.Transparency = 1
				_body_2D_part.Transparency = 1
				_tail_outline_adorn.Transparency = 1
			end
		end

		local head_t = (_game_audio_manager_get_current_time_ms - creation_time_ms) / (hit_time_ms - creation_time_ms)

		for i, mod in pairs(amods) do
			if mod.UpdateHeldNote then
				local p = mod:UpdateHeldNote({
					HeadAlpha=head_t;
					TailAlpha=get_tail_t();
					Track=_track_index;
					OriginalColor=new_color;
					CurrentColor=cur_color;
					HeadPosition=head_pos;
					HeadSize=_head.Size;
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
						t_override = true
						_body_outline_left_adorn.Transparency = p.transparency
						_body_outline_right_adorn.Transparency = p.transparency
						_body_2D_part.Transparency = p.transparency
						_body_adorn.Transparency = p.transparency
						_head_adorn.Transparency = p.transparency
						if _head_decal then
							_head_decal.Transparency = p.transparency
						end
						_head_outline.Transparency = p.transparency
						if _tail_decal then
							_tail_decal.Transparency = p.transparency
						end
						_tail_adorn.Transparency = p.transparency
						_tail_outline.Transparency = p.transparency
						_tail_outline_adorn.Transparency = p.transparency
					end
					if p.h_transparency then
						t_override = true
						_head_adorn.Transparency = p.h_transparency
						if _head_decal then
							_head_decal.Transparency = p.h_transparency
						end
						_head_outline.Transparency = p.h_transparency
					end
					if p.t_transparency then
						t_override = true
						if _tail_decal then
							_tail_decal.Transparency = p.t_transparency
						end
						_tail_adorn.Transparency = p.t_transparency
						_tail_outline.Transparency = p.t_transparency
						_tail_outline_adorn.Transparency = p.t_transparency
					end
					if p.b_transparency then
						t_override = true
						_body_outline_left_adorn.Transparency = p.b_transparency
						_body_outline_right_adorn.Transparency = p.b_transparency
						_body_2D_part.Transparency = p.b_transparency
						_body_adorn.Transparency = p.b_transparency
					end
				end
			end
		end

		do
			_note_obj.Body:SetPrimaryPartCFrame(
				CFrame.Angles(0, SPUtil:deg_to_rad(SPUtil:dir_ang_deg(tail_to_head.x,-tail_to_head.z) + 90), 0)
			)

			local body_pos = (tail_to_head * 0.5) + tail_pos
			local body_size = CurveUtil:YForPointOf2PtLine(
				Vector2.new(0,test),
				Vector2.new(1,teest),
				SPUtil:clamp(head_t,0,1)
			)
			if scrollmode.Value == 1 then
				if _head_decal then _head_decal.Color3 = cur_color end
				if _body_2D_part then _body_2D_part.Color = Color3.new(cur_color.r/1.75,cur_color.g/1.75,cur_color.b/1.75) end
				if _tail_decal then _tail_decal.Color3 = Color3.new(cur_color.r/1.75,cur_color.g/1.75,cur_color.b/1.75) end
				
				_body_2D_part.CFrame = CFrame.new(body_pos) * CFrame.Angles(0,math.rad(-45),0)
				_body_2D_part.Size = Vector3.new(3.2, 0.05, tail_to_head.magnitude)
				if not t_override then
					_body_2D_part.Transparency = 0
				end
				_body_adorn.Transparency = 1
			else
				_body_adorn.CFrame = CFrame.new(_body.CFrame:vectorToObjectSpace(body_pos) + Vector3.new(0,-0.35,0))
			end
			
			local body_radius = body_size
			_body_adorn.Height = tail_to_head.magnitude
			_body_adorn.Radius = body_radius
			
			_body_adorn.Color3 = Color3.new(cur_color.r/1.75,cur_color.g/1.75,cur_color.b/1.75)
			_tail_adorn.Color3 = Color3.new(cur_color.r/1.75,cur_color.g/1.75,cur_color.b/1.75)
			_head_adorn.Color3 = cur_color
			
			_body_outline_left_adorn.CFrame = CFrame.new(_body_outline_left.CFrame:vectorToObjectSpace(
				body_pos
			) + Vector3.new(-body_radius * 1.15,0,0))
			_body_outline_right_adorn.CFrame = CFrame.new(_body_outline_right.CFrame:vectorToObjectSpace(
				body_pos
			) + Vector3.new(body_radius * 1.15,0,0))

			_body_outline_left_adorn.Height = _body_adorn.Height
			_body_outline_right_adorn.Height = _body_adorn.Height
			_body_outline_left_adorn.Radius = body_size * 0.1
			_body_outline_right_adorn.Radius = body_size * 0.1
		end

		do
			local head_size = CurveUtil:YForPointOf2PtLine(
				Vector2.new(0,1.15 / 3.0),
				Vector2.new(1,2.55 / 3.0),
				SPUtil:clamp(head_t,0,1)
			)
			local tail_size = CurveUtil:YForPointOf2PtLine(
				Vector2.new(0,1.15 / 3.0),
				Vector2.new(1,2.55 / 3.0),
				SPUtil:clamp(get_tail_t(),0,1)
			)
			if scrollmode.Value == 1 then
				_head_adorn.Transparency = 1
				_tail_adorn.Transparency = 1
				_head_outline_adorn.Transparency = 1
				_body_outline_left_adorn.Transparency = 1
				_body_outline_right_adorn.Transparency = 1
				_tail_outline_adorn.Transparency = 1
				_head_outline_adorn.Transparency = 1
			else
				_head_adorn.Radius = 1.450 * head_size
				_tail_adorn.Radius = 1.450 * tail_size
				_head_outline_adorn.Radius = 1.65 * head_size
				_tail_outline_adorn.Radius = 1.65 * tail_size
			end
		end

		_i_update_visual = _i_update_visual + 1
		if _i_update_visual > 3 then
			_i_update_visual = 0
		end

		local target_transparency = 0
		local imm = false
		if _state == HeldNote.State.HoldMissedActive then
			target_transparency = 0
			_body_outline_left_adorn.Transparency = 1
			_body_outline_right_adorn.Transparency = 1
			_head.Decal.Transparency = 1
		elseif _state == HeldNote.State.Passed and _did_trigger_tail then
			target_transparency = 1
			imm = true
			_body_outline_left_adorn.Transparency = 1
			_body_outline_right_adorn.Transparency = 1
			_body_2D_part.Transparency = 1
			_head.Decal.Transparency = 1
		else
			target_transparency = 0.2
			if t_override then
				return
			end
		end
		if imm and scrollmode.Value ~= 1 then
			_body_adorn.Transparency = target_transparency
		elseif scrollmode.Value ~= 1 then
			_body_adorn.Transparency = target_transparency
		end
	end

	local _beat_trigger_index = 1
	local _beat_triggers_at = SPList:new()

	function self:cons()
		_game_audio_manager_get_current_time_ms = _game._audio_manager:get_current_time_ms()
		_note_obj = _game._object_pool:depool(self.Type)
		if _note_obj == nil then
			_note_obj = _game:get_game_protos().HeldNoteAdornProto:Clone()
			_note_obj.Body:SetPrimaryPartCFrame(CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Body.PrimaryPart))
			_note_obj.Body.BodyOutlineLeft.CFrame = _note_obj.Body.PrimaryPart.CFrame
			_note_obj.Body.BodyOutlineRight.CFrame = _note_obj.Body.PrimaryPart.CFrame
			_note_obj.Head:SetPrimaryPartCFrame(CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Head.PrimaryPart))
			_note_obj.Tail:SetPrimaryPartCFrame(CFrame.new(Vector3.new()) * SPUtil:part_cframe_rotation(_note_obj.Tail.PrimaryPart))
			_note_obj.Head.Head.Decal.Color3 = Color3.new(1,1,1)
		end
		_body = _note_obj.Body.Body
		_body_adorn = _body.Adorn
		_head = _note_obj.Head.Head
		_head_adorn = _head.Adorn
		_body_2D_part = _body["2D"]
		_tail = _note_obj.Tail.Tail
		_tail_adorn = _tail.Adorn
		_head_outline = _note_obj.Head.HeadOutline
		_head_outline_adorn = _head_outline.Adorn
		_tail_outline = _note_obj.Tail.TailOutline
		_tail_outline_adorn = _tail_outline.Adorn
		_body_outline_left = _note_obj.Body.BodyOutlineLeft
		_body_outline_left_adorn = _body_outline_left.Adorn
		_body_outline_right = _note_obj.Body.BodyOutlineRight
		_body_outline_right_adorn = _body_outline_right.Adorn

		_head_adorn.Color3 = cur_color
		if snapped then
			_body_adorn.Color3 = Color3.new(0.4,0.4,0.4)
			_tail_adorn.Color3 = Color3.new(0.4,0.4,0.4)
		else
			_body_adorn.Color3 = Color3.new(cur_color.r/1.75,cur_color.g/1.75,cur_color.b/1.75)
			_tail_adorn.Color3 = Color3.new(cur_color.r/1.75,cur_color.g/1.75,cur_color.b/1.75)
		end
		if scrollmode.Value == 1 then
			_tail_outline_adorn.Transparency = 1
			_head_outline_adorn.Transparency = 1
			_body_outline_left_adorn.Transparency = 1
			_body_outline_right_adorn.Transparency = 1
			_body_adorn.Transparency = 1
		else
			_tail_outline_adorn.Color3 = Color3.new(0,0,0)
			_head_outline_adorn.Color3 = Color3.new(0,0,0)
			_body_outline_left_adorn.Color3 = Color3.new(0,0,0)
			_body_outline_right_adorn.Color3 = Color3.new(0,0,0)
		end

		_state = HeldNote.State.Pre
		update_visual(1)
		_note_obj.Parent = _game:get_game_element()	
		
		do
			_beat_trigger_index = 1
			_beat_triggers_at:clear()

			local beat_trigger_incr = _game._audio_manager:get_beat_duration() * 0.5
			for i=beat_trigger_incr,duration_time_ms,beat_trigger_incr do
				if i + beat_trigger_incr <= duration_time_ms then
					_beat_triggers_at:push_back(
						hit_time_ms + i
					)
				end
			end
		end
		if scrollmode.Value == 1 then
			_head_decal = _head.Decal
			_body_adorn.Transparency = 1
			_tail_decal = _tail.Decal
			_head_adorn.Transparency = 1
			_tail_adorn.Transparency = 1
			_head_adorn.Transparency = 1
			if _track_index == 1 then
				_head.Size = Vector3.new(NoteSize.Value / 100 ,0.05, NoteSize.Value / 100)
				_tail.Size = Vector3.new(NoteSize.Value / 100 ,0.05, NoteSize.Value / 100)
				_left = "rbxassetid://" .. leftID.Value
				_head_decal.Texture = _left
				_head_decal.Transparency = 0
				_tail_decal.Texture = _left
				_tail_decal.Transparency = 1
				
			elseif _track_index == 2 then
				_head.Size = Vector3.new(NoteSize.Value / 100 ,0.05, NoteSize.Value / 100)
				_tail.Size = Vector3.new(NoteSize.Value / 100 ,0.05, NoteSize.Value / 100)
				_up = "rbxassetid://" .. upID.Value
				_head_decal.Texture = _up
				_head_decal.Transparency = 0
				_tail_decal.Texture = _up
				_tail_decal.Transparency = 1
				
			elseif _track_index == 3 then
				_head.Size = Vector3.new(NoteSize.Value / 100 ,0.05, NoteSize.Value / 100)
				_tail.Size = Vector3.new(NoteSize.Value / 100 ,0.05, NoteSize.Value / 100)
				_down = "rbxassetid://" .. downID.Value
				_head_decal.Texture = _down
				_head_decal.Transparency = 0
				_tail_decal.Texture = _down
				_tail_decal.Transparency = 1
				
			elseif _track_index == 4 then
				_head.Size = Vector3.new(NoteSize.Value / 100 ,0.05, NoteSize.Value / 100)
				_tail.Size = Vector3.new(NoteSize.Value / 100 ,0.05, NoteSize.Value / 100)
				_right = "rbxassetid://" .. rightID.Value
				_head_decal.Texture = _right
				_head_decal.Transparency = 0
				_tail_decal.Texture = _right
				_tail_decal.Transparency = 1
			end
		end
	end

	local function update_beat(_game)
		if is_local_slot() == false then
			return
		end

		local cur_time = _game_audio_manager_get_current_time_ms
		for i=_beat_trigger_index,_beat_triggers_at:count() do

			local trigger_time = _beat_triggers_at:get(i)

			if cur_time + 5 >= trigger_time  then
				if _state == HeldNote.State.Holding then
					_game._world_effect_manager:notify_hold_tick(_game,slot_index,track_index)
				end
				_beat_trigger_index = _beat_trigger_index + 1
			else
				break
			end
		end
	end


	local _hold_flash = FlashEvery:new(0.15)
	_hold_flash:flash_now()
	local _dt_scale_sum = 0
	local _has_notified_held_note_begin = false

	--[[Override--]] function self:update(dt_scale, _game)
		SPUtil:profilebegin("HeldNote:update")
		_game_audio_manager_get_current_time_ms = _game._audio_manager:get_current_time_ms()

		SPUtil:profilebegin("HeldNote:visual_update")
		if slot_index == _game:get_local_game_slot() then
			update_visual(dt_scale)
		else
			_dt_scale_sum = _dt_scale_sum + dt_scale
			if _game:get_frame_count() % 4 == (slot_index - 1) % 4 then
				update_visual(_dt_scale_sum)
				_dt_scale_sum = 0
			end
		end
		SPUtil:profileend()

		update_beat(_game)

		if _has_notified_held_note_begin == false then
			if hit_time_ms < _game_audio_manager_get_current_time_ms then
				_game._audio_manager:notify_held_note_begin(hit_time_ms)
				_has_notified_held_note_begin = true
			end
		end

		if _state == HeldNote.State.Holding then
			_game._world_effect_manager:notify_frame_hold(_game,slot_index,track_index)
		end

		if _state == HeldNote.State.Pre then
			if _game_audio_manager_get_current_time_ms > (hit_time_ms - _game._audio_manager.NOTE_REMOVE_TIME) then
				_game._score_manager:register_hit(
					_game,
					NoteResult.Miss,
					slot_index,
					_track_index,
					{ PlaySFX = false; PlayHoldEffect = false; TimeMiss = true; }
				)

				if is_local_slot() then
					_game._effects:add_effect(HoldingNoteEffect:new(
						_game,
						get_head_position(),
						NoteResult.Okay
					))
				end

				_state = HeldNote.State.HoldMissedActive

			end

		elseif _state == HeldNote.State.Holding or
			_state == HeldNote.State.HoldMissedActive or
			_state == HeldNote.State.Passed then

			if _state == HeldNote.State.Holding then
				_hold_flash:update(dt_scale)
				if _hold_flash:do_flash() then
					if is_local_slot() then
						_game._effects:add_effect(HoldingNoteEffect:new(
							_game,
							_game:get_tracksystem(slot_index):get_track(track_index):get_end_position(),
							NoteResult.Perfect
						))
					end
				end
			end

			if _game_audio_manager_get_current_time_ms > (get_tail_hit_time() - _game._audio_manager.NOTE_REMOVE_TIME) then

				if _state == HeldNote.State.Holding or
					_state == HeldNote.State.HoldMissedActive then
					if is_local_slot() then
						_game._effects:add_effect(HoldingNoteEffect:new(
							_game,
							get_tail_position(),
							NoteResult.Okay
						))
					end

					_game._score_manager:register_hit(
						_game,
						NoteResult.Miss,
						slot_index,
						_track_index,
						{ PlaySFX = false; PlayHoldEffect = false; TimeMiss = true; }
					)

				end

				_state = HeldNote.State.DoRemove
			end
		end

		SPUtil:profileend()
	end

	--[[Override--]] function self:should_remove(_game)
		return _state == HeldNote.State.DoRemove
	end

	--[[Override--]] function self:do_remove(_game)
		_game._object_pool:repool(self.Type,_note_obj)
		_note_obj = nil
	end

	--[[Override--]] function self:test_hit(_game)
		if _state == HeldNote.State.Pre then
			local time_to_end = _game_audio_manager_get_current_time_ms - hit_time_ms
			local did_hit, note_result = NoteResult:timedelta_to_result(time_to_end, _game)

			if did_hit then
				return did_hit, note_result
			end

			return false, NoteResult.Miss

		elseif _state == HeldNote.State.HoldMissedActive then
			local time_to_end = _game_audio_manager_get_current_time_ms - get_tail_hit_time()
			local did_hit, note_result = NoteResult:timedelta_to_result(time_to_end, _game)

			if did_hit then
				return did_hit, note_result
			end

			return false, NoteResult.Miss

		end

		return false, NoteResult.Miss
	end

	--[[Override--]] function self:on_hit(_game,note_result,i_notes)
		if _state == HeldNote.State.Pre then
			--[[_game._effects:add_effect(TriggerNoteEffect:new(
				_game,
				get_head_position(),
				note_result,
				is_local_slot()
			))]]

			_game._score_manager:register_hit(
				_game, note_result, slot_index, _track_index, { PlaySFX = true; PlayHoldEffect = false; IsHeldNoteBegin = true; },
				_game_audio_manager_get_current_time_ms - hit_time_ms
			)

			_did_trigger_head = true
			_state = HeldNote.State.Holding
			if scrollmode.Value == 1 then
				_head_decal.Transparency = 1
			end
		elseif _state == HeldNote.State.HoldMissedActive then
			--[[_game._effects:add_effect(TriggerNoteEffect:new(
				_game,
				get_tail_position(),
				note_result
			))]]

			_game._score_manager:register_hit(
				_game,
				note_result,
				slot_index,
				_track_index,
				{ PlaySFX = true; PlayHoldEffect = true; HoldEffectPosition = get_tail_position() },
				500
			)

			_did_trigger_tail = true
			if scrollmode.Value == 1 then
				_tail_decal.Transparency = 1
			end
			_state = HeldNote.State.Passed
		end
		
		if not _game.is_spectating then
			_game._hit_cache:addToCache(
				_game._hit_cache:genNewHit(_game._audio_manager:get_current_time_ms(), track_index, "Press", note_result, self.id)
			)
		end
	end

	--[[Override--]] function self:test_release(_game)
		if _state == HeldNote.State.Holding or _state == HeldNote.State.HoldMissedActive then
			local time_to_end = _game_audio_manager_get_current_time_ms - get_tail_hit_time()
			local did_hit, note_result = NoteResult:release_timedelta_to_result(time_to_end, _game)

			if did_hit then
				return did_hit, note_result
			end

			if _state == HeldNote.State.HoldMissedActive then
				return false, NoteResult.Miss
			else
				return true, NoteResult.Miss
			end
		end

		return false, NoteResult.Miss
	end
	--[[Override--]] function self:on_release(_game,note_result,i_notes)
		if _state == HeldNote.State.Holding or _state == HeldNote.State.HoldMissedActive then
			if note_result == NoteResult.Miss then
				_game._score_manager:register_hit(
					_game, note_result, slot_index, _track_index,  { PlaySFX = true; PlayHoldEffect = false; },
					get_tail_hit_time() - _game._audio_manager.NOTE_REMOVE_TIME
				)
				_state = HeldNote.State.HoldMissedActive
			else
				--[[_game._effects:add_effect(TriggerNoteEffect:new(
					_game,
					get_tail_position(),
					note_result,
					is_local_slot()
				))]]
				_game._score_manager:register_hit(
					_game,
					note_result,
					slot_index,
					_track_index,
					{ PlaySFX = true; PlayHoldEffect = true; HoldEffectPosition = get_tail_position(); },
					hit_time_ms - _game._audio_manager.NOTE_REMOVE_TIME
				)
				_did_trigger_tail = true
				_state = HeldNote.State.Passed
			end
			if scrollmode.Value == 1 then
				_tail_decal.Transparency = 1
			end
		end
		if not _game.is_spectating then
			print("Adding hold release to local cache...")
			_game._hit_cache:addToCache(
				_game._hit_cache:genNewHit(_game._audio_manager:get_current_time_ms(), track_index, "Release", note_result, self.id)
			)
		end
	end

	--[[Override--]] function self:get_track_index(_game)
		return _track_index
	end


	self:cons()
	return self
end

return HeldNote
