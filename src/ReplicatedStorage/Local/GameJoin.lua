local InputUtil = require(game.ReplicatedStorage.Shared.InputUtil)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)
local GameLocal = require(game.ReplicatedStorage.Local.GameLocal)
local SongDatabase = require(game.ReplicatedStorage.AudioData.SongDatabase)
local EnvironmentSetup = require(game.ReplicatedStorage.LocalShared.EnvironmentSetup)
local score = require(game.ReplicatedStorage.Local.ScoreManager)

local GameJoin = {}

function GameJoin:new(combo)
	local self = {}

	local _game_environment_center = nil

	function self:cons()
	end

	local _game = nil
	local _sputil = nil
	local _local_services = nil
	local _do_game_update = false
	local ispec = false
	
	function self:game_init(local_services, game_environment, is_spectating)
		ispec = not not is_spectating
		EnvironmentSetup:set_mode(EnvironmentSetup.Mode.Game)
		_game_environment_center = game_environment.GameEnvironmentCenter
		_local_services = local_services
	end

	function self:load_game(local_services,song,song_rate, scroll_speed, game_environment, game_protos, game_element, note_color, audio_offset, hit_position, popups, specOffset, amods,combo)
		_game = GameLocal:new(_local_services, _game_environment_center, self, game_environment, game_protos, game_element, note_color, hit_position, popups, specOffset, amods,combo)
		_game.is_spectating = ispec
		_game._audio_manager:load_song(_game,song, song_rate, scroll_speed, nil, audio_offset, note_color)
		_game:setup_world()
		return _game
	end

	function self:is_game_audio_loaded()
		return _game._audio_manager:is_ready_to_play()
	end

	function self:start_game()
		_game:start_game()
		_do_game_update = true
	end

	function self:update(dt_scale)
		if _do_game_update then
			_game:update(dt_scale)
		end
	end
	
	function self:get_data()
		return _game:get_data()
	end
	
	function self:getAcc()
		return _game:getAcc()
	end
	
	function self:GetMsDeviance()
		return _game:getMsDeviance()
	end
	
	local jj = 0
	local prev = 0
	local ita = 0
	function self:check_songDone()
		local song_length = _game._audio_manager:get_song_length_ms()
		local song_time = _game._audio_manager:get_current_time_ms()
		local ms_remaining = song_length - song_time
		
		if (ms_remaining == prev) then ita = ita + 1 
		else ita = 0 end
			
		prev = ms_remaining
		if ita >= 10 then return true 
		else return false end
	end
	
	function self:get_songTime()
		return _game._audio_manager:get_current_time_ms()
	end
	
	function self:get_songLength()
		return _game._audio_manager:get_song_length_ms()
	end
	
	function self:finishGame()
		_game:finishGame()
	end

	self:cons()
	return self
end

return GameJoin
