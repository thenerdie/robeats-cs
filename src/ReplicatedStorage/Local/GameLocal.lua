local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local InputUtil = require(game.ReplicatedStorage.Shared.InputUtil)
local SPList = require(game.ReplicatedStorage.Shared.SPList)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local Note = require(game.ReplicatedStorage.Local.Note)
local AudioManager = require(game.ReplicatedStorage.Local.AudioManager)
local SFXManager = require(game.ReplicatedStorage.Local.SFXManager)
local ObjectPool = require(game.ReplicatedStorage.Local.ObjectPool)
local ScoreManager = require(game.ReplicatedStorage.Local.ScoreManager)
local TrackSystem = require(game.ReplicatedStorage.Local.TrackSystem)
local EffectSystem = require(game.ReplicatedStorage.Effects.EffectSystem)
local GameSlot = require(game.ReplicatedStorage.Shared.GameSlot)
local WorldEffectManager = require(game.ReplicatedStorage.Local.WorldEffectManager)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)
local RemoteInstancePlayerInfoManager = require(game.ReplicatedStorage.Local.RemoteInstancePlayerInfoManager)
local ServerGameInstancePlayer = require(game.ReplicatedStorage.Shared.ServerGameInstancePlayer)
local PowerBarState = require(game.ReplicatedStorage.Shared.PowerBarState)
local _game_protos = nil
local _game_element = nil

--local Spectating = game.ReplicatedStorage.Spectating

local GameLocal = {}
GameLocal.Mode = {
	Setup = 1;
	Game = 2;
	GameEnded = 3;
	DoRemove = 10;
}

function GameLocal:new(local_services, _game_environment_center_part, _game_join, game_environment, game_protos, game_element, note_colors, hit_offset, popups, specOffset, amods,combo)
	local _game_protos = game_protos
	local _game_element = game_element
	local note_offset = hit_offset
	local note_popups = popups
	
	local spec_keys = nil
	local spec_keys_last = nil
	
	local self = {
		_tracksystems = SPDict:new();
		_audio_manager = AudioManager:new(game_element, specOffset, amods);
		_score_manager = ScoreManager:new(popups, 0, combo);
		_world_effect_manager = WorldEffectManager:new(local_services, game_environment, _game_protos, _game_element);
		_effects = EffectSystem:new(game_element);
		_players = RemoteInstancePlayerInfoManager:new();

		_input = local_services._input;
		_sfx_manager = local_services._sfx_manager;
		_object_pool = local_services._object_pool;
		_evt = local_services._evt;
		_animation_manager = local_services._animation_manager;

		_spui = local_services._spui;
		_menus = local_services._menus;
		
		_hit_cache = local_services.hit_cache;

		_local_game_slot = 0;
		
		is_spectating = false
	}
	local _game = self
	local _current_mode = GameLocal.Mode.Setup

	local function cons_camera()
		workspace.CurrentCamera.CFrame = GameSlot:slot_to_camera_cframe(_game._local_game_slot)
		workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
		workspace.CurrentCamera.CameraSubject = nil
	end

	function self:get_game_environment_center()
		return _game_environment_center_part.Position
	end
	
	function self:get_game_protos()
		return _game_protos
	end
	
	function self:get_game_element()
		return _game_element
	end

	function self:setup_world()
		self._local_game_slot = 1
		GameSlot:set_world_center_position(self:get_game_environment_center())
		cons_camera()

		self._world_effect_manager:setup_world(_game)
	end

	function self:start_game()
		_game._players._slots:add(1, ServerGameInstancePlayer:new(1,"Test"))
		_game._tracksystems:add(1,TrackSystem:new(_game,1, note_offset))

		_game._audio_manager:start_play()
		_current_mode = GameLocal.Mode.Game
	end

	function self:get_local_game_slot()
		return self._local_game_slot
	end
	
	function self:getScore()
		return self._score_manager:getScore()
	end
	
	function self:getAcc()
		return self._score_manager:get_acc()
	end
	
	function self:getMsDeviance()
		return self._score_manager:getMsDeviance()
	end

	function self:get_tracksystem(index)
		return self._tracksystems:get(index)
	end
	function self:get_local_tracksystem()
		return self:get_tracksystem(self._local_game_slot)
	end
	function self:tracksystems_itr()
		return self._tracksystems:key_itr()
	end

	local KEY_TO_TRACK_INDEX = {
		[InputUtil.KEY_TRACK1] = 1;
		[InputUtil.KEY_TRACK2] = 2;
		[InputUtil.KEY_TRACK3] = 3;
		[InputUtil.KEY_TRACK4] = 4;
	}

	local _frame_count = 0
	function self:get_frame_count()
		return _frame_count
	end
	
	function self:is_ready()
		return self._audio_manager:is_ready_to_play()
	end
	
	local _time_since_any_pressed = 9999
	function self:get_time_since_any_pressed()
		return _time_since_any_pressed
	end
	
	function self:finishGame()
		self._world_effect_manager:teardown(_game)
	end

	function self:update(dt_scale)
		_frame_count = _frame_count + 1

		if _current_mode == GameLocal.Mode.DoRemove then return end
		SPUtil:profilebegin("GameLocal:Update")

		for slot,itr in _game._tracksystems:key_itr() do
			if _game._players._slots:contains(slot) == false then
				itr:teardown()
				_game._tracksystems:remove(slot)
			end
		end
		GameSlot:set_world_center_position(self:get_game_environment_center())

		if _current_mode == GameLocal.Mode.Setup then

		elseif _current_mode == GameLocal.Mode.Game then
			_game._audio_manager:update(dt_scale,_game)
			local any_pressed = false
			
			for itr_key,itr_index in pairs(KEY_TO_TRACK_INDEX) do
				if _game._input:control_pressed(itr_key) then
					any_pressed = true
				end
				if _game._input:control_just_pressed(itr_key) then
					self:get_local_tracksystem():press_track_index(_game,itr_index)
				end
				if _game._input:control_just_released(itr_key) then
					self:get_local_tracksystem():release_track_index(_game,itr_index)
				end
			end

			if any_pressed then
				_time_since_any_pressed = 0
			else
				_time_since_any_pressed = _time_since_any_pressed + CurveUtil:TimescaleToDeltaTime(dt_scale)
			end

			_game._world_effect_manager:update(dt_scale,_game)

			SPUtil:profilebegin("_game._tracksystems update")
			for slot,itr in _game._tracksystems:key_itr() do
				itr:update(dt_scale,_game)
			end
			SPUtil:profileend()

			_game._world_effect_manager:post_update(dt_scale,_game)
			_game._score_manager:update(dt_scale,_game)
			_game._score_manager:post_update()

			if _game._audio_manager:get_just_finished() then
				_game._score_manager:notify_local_finished(_game)
			end

		elseif _current_mode == GameLocal.Mode.GameEnded then
			--Transition to GameEnded when receiving SPRemoteEvent.EVT_Game_ServerNotifyDoEnd
			_game._ui_manager:update(dt_scale,_game)

		end

		_game._effects:update(dt_scale,_game)
		SPUtil:profileend()

		pcall(function()
			local debugui_frame = game.Players.LocalPlayer.PlayerGui.DebugUI.Frame
			local ma_frame = game.Players.LocalPlayer.PlayerGui.DebugUI.MA
			--debugui_frame.BarActiveDisplay.Text = tostring(_game._score_manager:get_power_bar_state() == PowerBarState.Active)
			--debugui_frame.BarPercentDisplay.Text = string.format("%.2f",_game._score_manager:get_power_bar_pct())
			debugui_frame.ScoreDisplay.Text = tostring(_game._score_manager:get_score())
			debugui_frame.ChainDisplay.Text = tostring(_game._score_manager:get_chain().."x")
			debugui_frame.ChainMax.Text = tostring("Max: ".._game._score_manager:get_maxcombo().."x")
			ma_frame.score_acc.Text = string.format("%.2f",_game._score_manager:get_acc()).."%"
			ma_frame.score_perf.Text = tostring(_game._score_manager:get_perf())
			ma_frame.score_great.Text = tostring(_game._score_manager:get_great())
			ma_frame.score_good.Text = tostring(_game._score_manager:get_good())
			ma_frame.score_miss.Text = tostring(_game._score_manager:get_miss())
		end)
	end

	function self:get_data()
		return _game._score_manager:get_data()
	end

	return self
end

return GameLocal
