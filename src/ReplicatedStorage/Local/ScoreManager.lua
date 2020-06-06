local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local NoteBase = require(game.ReplicatedStorage.Local.NoteBase)
local NoteResult = require(game.ReplicatedStorage.Shared.NoteResult)
local SFXManager = require(game.ReplicatedStorage.Local.SFXManager)
local PowerBarState = require(game.ReplicatedStorage.Shared.PowerBarState)
local InputUtil = require(game.ReplicatedStorage.Shared.InputUtil)
local NoteResultPopupEffect = require(game.ReplicatedStorage.Effects.NoteResultPopupEffect)
local HoldingNoteEffect = require(game.ReplicatedStorage.Effects.HoldingNoteEffect)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)
local DebugConfig = require(game.ReplicatedStorage.Shared.DebugConfig)

local ScoreManager = {}

function ScoreManager:new(popups)
	local self = {}

	self._score = 0
	self._chain = 0

	self._power_bar_pct = 0
	self._power_bar_state = PowerBarState.Charging

	local _powerbar_notes_count = 0

	local _marv_count = 0
	local _perfect_count = 0
	local _great_count = 0
	local _good_count = 0
	local _ok_count = 0
	local _total_count = 0
	local _miss_count = 0
	local _max_chain = 0
	local _ms_deviance = {}	
	
	function self:get_data() return {_marv_count,_perfect_count,_great_count,_good_count,_ok_count,_miss_count,_total_count,self:get_acc(),self._score,self._chain,_max_chain} end
	
	function self:get_marv() return _marv_count end
	function self:get_perf() return _perfect_count end
	function self:get_great() return _great_count end
	function self:get_perf() return _good_count end
	function self:get_good() return _ok_count end
	function self:get_miss() return _miss_count end
	function self:get_maxcombo() return _max_chain end
	function self:getMsDeviance() return _ms_deviance end
	function self:get_acc() 
		if _total_count == 0 then 
			return 0 
		else
			return 100*(_marv_count+_perfect_count+_great_count*0.66+_good_count*0.33+_ok_count*0.166) / _total_count
		end
	end

	function self:teardown()
	end

	local function get_chain_multiplier()
		if self._chain > 200 then
			return 1.4
		elseif self._chain > 150 then
			return 1.3
		elseif self._chain > 100 then
			return 1.2
		elseif self._chain > 50 then
			return 1.1
		else
			return 1
		end
	end

	function self:is_powerbar_active()
		return self._power_bar_state == PowerBarState.Active
	end

	local function get_powerbar_multiplier()
		if self:is_powerbar_active() then
			return 1
		else
			return 1
		end
	end

	local function result_to_point_total(note_result)
		if note_result == NoteResult.Marvelous then
			return 400
		elseif note_result == NoteResult.Perfect then
			return 300
		elseif note_result == NoteResult.Great then
			return 200
		elseif note_result == NoteResult.Good then
			return 100
		elseif note_result == NoteResult.Okay then
			return 50
		else
			return 0
		end
	end

	local _raise_chain_broken = false
	local _raise_chain_broken_at = 0
	local _last_created_note_result_popup_info = {
		Slot = 0;
		Track = 0;
	}
	local _last_created_note_result_popup_effect = nil

	local _local_note_count = 0
	function self:get_local_note_count() return _local_note_count end

	local _frame_has_played_sfx = false

	function self:register_hit(
		_game,
		note_result,
		slot_index,
		track_index,
		params,
		offset
	)
		offset = offset or _game._audio_manager.NOTE_REMOVE_TIME
		if params == nil then
			params = { }
		end
		if params.PlaySFX == nil then params.PlaySFX = true; end
		if params.PlayHoldEffect == nil then params.PlayHoldEffect = true; end
		if params.HoldEffectPosition == nil then params.HoldEffectPosition = _game:get_tracksystem(slot_index):get_track(track_index):get_end_position(); end
		if params.NotifyServer == nil then params.NotifyServer = true end

		--if params.TimeMiss then
		--	_game:get_tracksystem(slot_index):notify_time_miss()
		--end
		
		if params.WhiffMiss then
		end

		_game._world_effect_manager:notify_hit(_game, note_result, slot_index, track_index)

		if _last_created_note_result_popup_effect ~= nil then
			if slot_index == _last_created_note_result_popup_info.Slot and
				track_index == _last_created_note_result_popup_info.Track and
				note_result == NoteResult.Miss then

				_last_created_note_result_popup_effect._anim_t = 1
				_last_created_note_result_popup_effect = nil
			end
		end

		if not params.WhiffMiss then
			_local_note_count = _local_note_count + 1
		end

		self:apply_hit_to_power_bar(note_result)

		if popups[note_result] == true then
			_last_created_note_result_popup_effect = _game._effects:add_effect(NoteResultPopupEffect:new(
				_game,
				_game:get_tracksystem(slot_index):get_track(track_index):get_end_position() + Vector3.new(0,2.5,0),
				note_result
			))
			_last_created_note_result_popup_info.Slot = slot_index
			_last_created_note_result_popup_info.Track = track_index
		end

		if params.PlaySFX == true then
			if _frame_has_played_sfx == false then
				if note_result == NoteResult.Perfect then
					if params.IsHeldNoteBegin == true then
						_game._audio_manager._hit_sfx_group:play_first()
					else
						_game._audio_manager._hit_sfx_group:play_alternating()
					end

				elseif note_result == NoteResult.Great then
					_game._audio_manager._hit_sfx_group:play_first()
				elseif note_result == NoteResult.Okay then
					_game._sfx_manager:play_sfx(SFXManager.SFX_DRUM_OKAY)
				else
					_game._sfx_manager:play_sfx(SFXManager.SFX_MISS)
				end
				_frame_has_played_sfx = true
			end

			if params.PlayHoldEffect then
				if note_result ~= NoteResult.Miss then
					_game._effects:add_effect(HoldingNoteEffect:new(
						_game,
						params.HoldEffectPosition,
						note_result
					))
				end
			end
		end

		_max_chain = math.max(self._chain,_max_chain)

		if note_result == NoteResult.Marvelous then
			self._chain = self._chain + 1
			_marv_count = _marv_count + 1
			_total_count = _total_count + 1
			table.insert(_ms_deviance,{_game._audio_manager:get_current_time_ms()/_game._audio_manager:get_song_length_ms(),offset,1})
			
		elseif note_result == NoteResult.Perfect then
			self._chain = self._chain + 1
			_perfect_count = _perfect_count + 1
			_total_count = _total_count + 1
			table.insert(_ms_deviance,{_game._audio_manager:get_current_time_ms()/_game._audio_manager:get_song_length_ms(),offset,2})

		elseif note_result == NoteResult.Great then
			self._chain = self._chain + 1
			_great_count = _great_count + 1
			_total_count = _total_count + 1
			table.insert(_ms_deviance,{_game._audio_manager:get_current_time_ms()/_game._audio_manager:get_song_length_ms(),offset,3})
			
		elseif note_result == NoteResult.Good then
			self._chain = self._chain + 1
			_good_count = _good_count + 1
			_total_count = _total_count + 1
			table.insert(_ms_deviance,{_game._audio_manager:get_current_time_ms()/_game._audio_manager:get_song_length_ms(),offset,4})

		elseif note_result == NoteResult.Okay then
			self._chain = self._chain + 1
			_ok_count = _ok_count + 1
			_total_count = _total_count + 1
			table.insert(_ms_deviance,{_game._audio_manager:get_current_time_ms()/_game._audio_manager:get_song_length_ms(),offset,5})

		else
			if self._chain > 0 then
				if self._chain >= 20 then
					_game._sfx_manager:play_sfx(SFXManager.SFX_BOO_1)
				end
				_raise_chain_broken = true
				_raise_chain_broken_at = self._chain
				self._chain = 0
				_total_count = _total_count + 1
				_miss_count = _miss_count + 1
				table.insert(_ms_deviance,{_game._audio_manager:get_current_time_ms()/_game._audio_manager:get_song_length_ms(),offset,6})

			elseif params.TimeMiss == true then
				_total_count = _total_count + 1
				_miss_count = _miss_count + 1
				table.insert(_ms_deviance,{_game._audio_manager:get_current_time_ms()/_game._audio_manager:get_song_length_ms(),offset,6})

			else
				params.NotifyServer = false
			end
		end

		self._score = self._score + result_to_point_total(note_result) * get_chain_multiplier() * get_powerbar_multiplier() * _game._audio_manager:get_song_rate()

		if note_result ~= NoteResult.Miss then
			_powerbar_notes_count = _powerbar_notes_count + 1
		end

		if params.NotifyServer then
		end
	end

	function self:notify_local_finished(_game)
	end

	function self:get_score()
		return self._score
	end

	function self:get_chain()
		return self._chain
	end

	function self:post_update()
		_raise_chain_broken = false
		_frame_has_played_sfx = false
	end

	function self:get_chain_broken()
		return _raise_chain_broken, _raise_chain_broken_at
	end

	function self:update(dt_scale, _game)
		if _last_created_note_result_popup_effect ~= nil then
			if _last_created_note_result_popup_effect._anim_t > 0.25 then
				_last_created_note_result_popup_effect = nil
			end
		end

		self:update_power_bar(dt_scale, _game)
	end

	function self:get_power_bar_state() return self._power_bar_state end
	function self:get_power_bar_pct() return self._power_bar_pct end

	local _powerbar_time = 0
	function self:apply_hit_to_power_bar(note_result)
		if self:is_powerbar_active() then

			local MULT_MAX = 50
			local pct_add_mult = CurveUtil:YForPointOf2PtLine(
				Vector2.new(0,1),
				Vector2.new(MULT_MAX,0),
				SPUtil:clamp(_powerbar_notes_count,0,MULT_MAX)
			)

			if note_result == NoteResult.Perfect then
				self._power_bar_pct = self._power_bar_pct + CurveUtil:SecondsToTick(0.25) * pct_add_mult
			elseif note_result == NoteResult.Great then
				self._power_bar_pct = self._power_bar_pct + CurveUtil:SecondsToTick(0.5) * pct_add_mult
			elseif note_result == NoteResult.Miss then
				self._power_bar_pct = self._power_bar_pct - CurveUtil:SecondsToTick(1.0)
			end
		else
			if note_result == NoteResult.Perfect then
				self._power_bar_pct = self._power_bar_pct + 0.025 * 1
			elseif note_result == NoteResult.Great then
				self._power_bar_pct = self._power_bar_pct + 0.01 * 1
			end
		end
		self._power_bar_pct = SPUtil:clamp(self._power_bar_pct,0,1)
	end

	function self:update_power_bar(dt_scale, _game)
		if self:is_powerbar_active() then
			self._power_bar_pct = self._power_bar_pct - CurveUtil:SecondsToTick(6.5) * dt_scale
			if self._power_bar_pct <= 0 then
				self._power_bar_state = PowerBarState.Charging

				if _game._players._slots:contains(_game:get_local_game_slot()) == true then
					_game._players._slots:get(_game:get_local_game_slot())._power_bar_active = false
				end
			end

		else
			_powerbar_notes_count = 0
			if self._power_bar_pct >= 1 then

				_game._sfx_manager:play_sfx(SFXManager.SFX_FEVERCHEER_1)
				_game._sfx_manager:play_sfx(SFXManager.SFX_WOOSH)

				self._power_bar_state = PowerBarState.Active
				_powerbar_notes_count = 1
				if _game._players._slots:contains(_game:get_local_game_slot()) == true then
					_game._players._slots:get(_game:get_local_game_slot())._power_bar_active = true
				end
			end
		end
		self._power_bar_pct = SPUtil:clamp(self._power_bar_pct,0,1)
	end

	function self:get_powerbar_notes_count()
		return _powerbar_notes_count
	end

	return self
end

return ScoreManager
