local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local SFXManager = require(game.ReplicatedStorage.Local.SFXManager)
local Note = require(game.ReplicatedStorage.Local.Note)
local HeldNote = require(game.ReplicatedStorage.Local.HeldNote)
local NoteResult = require(game.ReplicatedStorage.Shared.NoteResult)
local RandomLua = require(game.ReplicatedStorage.Shared.RandomLua)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)
local Constants = require(game.ReplicatedStorage.Shared.Constants)
local HitSFXGroup = require(game.ReplicatedStorage.Local.HitSFXGroup)
local SongDatabase = require(game.ReplicatedStorage.AudioData.SongDatabase)
local Modchart = require(game.Players.LocalPlayer.PlayerGui.Utils.Modchart)

local FastSpawn = require(game.ReplicatedStorage.FastSpawn)

local ModManager = require(game.ReplicatedStorage.ModManager)
--local Spectating = game.ReplicatedStorage.Spectating

local AudioManager = {}
AudioManager.Mode = {
	NotLoaded = 0;
	Loading = 1;
	PreStart = 3;
	Playing = 4;
	PostPlaying = 5;
	Finished = 6;
}

function AudioManager:new(game_element, specOffset, amods)
	if specOffset == nil then
		specOffset = 0
	end
	if amods == nil then
		amods = {}
	end
	
	local self = {}
	--STEPMANIA J4
	self.NOTE_PREBUFFER_TIME = 500
	self.NOTE_OKAY_MAX = 180
	self.NOTE_GOOD_MAX = 135
	self.NOTE_GREAT_MAX = 90
	self.NOTE_PERFECT_MAX = 52
	self.NOTE_MARVELOUS_MAX = 22
	self.NOTE_MARVELOUS_MIN = -22
	self.NOTE_PERFECT_MIN = -52
	self.NOTE_GREAT_MIN = -90
	self.NOTE_GOOD_MIN = -135
	self.NOTE_OKAY_MIN = -180
	self.NOTE_REMOVE_TIME = -300
	
	self.NOTE_COLORS = {}
	self.NOTE_COLORS[1] = Color3.new(1.0,0.2,0.2) -- SNAPS
	self.NOTE_COLORS[2] = Color3.new(0.1,0.3,1.0)
	self.NOTE_COLORS[3] = Color3.new(0.5,0.2,1.0)
	self.NOTE_COLORS[4] = Color3.new(1.0,1.0,0.2)
	self.NOTE_COLORS[5] = Color3.new(1.0,0.2,1.0)
	self.NOTE_COLORS[6] = Color3.new(1.0,0.5,0.2)
	self.NOTE_COLORS[7] = Color3.new(0.2,1.0,1.0)
	self.NOTE_COLORS[8] = Color3.new(0.2,1.0,0.2)
	self.NOTE_COLORS[9] = Color3.new(0.2,1.0,0.2)
	self.NOTE_COLORS[10] = Color3.new(1.0,1.0,0.0) -- DEFAULT
	self.NOTE_COLORS[11] = Color3.new(0,0.5,1.0) -- CUSTOMIZABLE
	self.NOTE_COLORS[12] = Color3.new(0,1.0,1.0)
	self.NOTE_COLORS[13] = Color3.new(0.6,1.0,0.6) 
	self.NOTE_COLORS[14] = Color3.new(0.3,1,0.3)
	self.NOTE_COLORS[15] = Color3.new(1,1,0.3)
	self.NOTE_COLORS[16] = Color3.new(1,0.5,0.3)
	self.NOTE_COLORS[17] = Color3.new(1,0.3,0.3)
	self.NOTE_COLORS[18] = Color3.new(1,0.3,0.7)
	self.NOTE_COLORS[19] = Color3.new(1,0.6,1)
	self.NOTE_COLORS[20] = Color3.new(1,1,1)
	self.NOTE_COLORS[21] = Color3.new(0.1,0.1,0.1)
	
	self.BEAT_SNAPS = { }
	self.BEAT_SNAPS[1] = 48
	self.BEAT_SNAPS[2] = 24
	self.BEAT_SNAPS[3] = 16
	self.BEAT_SNAPS[4] = 12
	self.BEAT_SNAPS[5] = 8
	self.BEAT_SNAPS[6] = 6
	self.BEAT_SNAPS[7] = 4
	self.BEAT_SNAPS[8] = 3
	self.BEAT_SNAPS[9] = 2

	local PRE_START_TIME_MS_MAX = Constants.PRE_START_TIME_MS_MAX
	local POST_TIME_PLAYING_MS_MAX = Constants.POST_TIME_PLAYING_MS_MAX
	local _song_rate = 1.0

	local modchart_index = 1

	self._audio_time_offset = 0

	self._bgm = Instance.new("Sound", game_element)
	self._bgm.Name = "BGM"
	self._bgm.PlaybackSpeed = _song_rate
	self._bgm_time_position = 0
	self._current_audio_data = nil
	self.note_color = nil
	self._song_colors = nil
	self._audio_data_index = 1
	self._hit_sfx_group = nil

	local _current_mode = AudioManager.Mode.NotLoaded
	function self:get_current_mode() return _current_mode end
	function self:Mode() return AudioManager.Mode end

	local _is_playing = false
	local _pre_start_time_ms = 0
	local _post_playing_time_ms = 0
	local _audio_volume = 0.5

	local _song_key = 0
	function self:get_song_key() return _song_key end

	self._note_gen_rand = RandomLua.mwc(0)
	self.snap_enabled = false

	local _last_held_note_hit_time = 0
	function self:notify_held_note_begin(hit_time)
		_last_held_note_hit_time = hit_time
	end

	local _last_note_time = 1
	
	function self:get_snap_color(time_start, beat_length, note_pos)
		local cur_time = note_pos - time_start + 1
		
		while cur_time > beat_length * 65536 do 
			cur_time = cur_time - beat_length * 65536 
		end
		while cur_time > beat_length * 4096 do 
			cur_time = cur_time - beat_length * 4096 
		end
		while cur_time > beat_length * 256 do 
			cur_time = cur_time - beat_length * 256 
		end
		while cur_time > beat_length * 16 do 
			cur_time = cur_time - beat_length * 16 
		end
		while cur_time > beat_length do 
			cur_time = cur_time - beat_length 
		end
		
		local index = math.floor(48 * cur_time / beat_length)
		local returned = false
		
		for i=1, 9 do
			if index % self.BEAT_SNAPS[i] == 0 then
				returned = true
				return i
			end
		end
		
		if returned == false then
			return 9
		end
	end

	function self:load_song(_game,song_,song_rate,scroll_speed, note_colors, audio_offset, note_color)
		self.note_color = note_color or Color3.new(1,1,1)
		for z, mod in pairs(amods) do
			if mod.Init then
				mod:Init()
			end
		end
		_song_rate = song_rate
		_song_key = 0
		_current_mode = AudioManager.Mode.Loading
		self._audio_data_index = 1
		self._current_audio_data = song_:GetData()
		self.mod_points = self._current_audio_data.ModPoints or {}
		if note_colors == 2 then
			self.snap_enabled = true
		end
		
		-- SONG COLORS
		self._song_colors = { }
		local bpm_pos = 1
		for i=1,#self._current_audio_data.HitObjects do
			-- DEFAULT COLORS
			if note_colors == 1 then
				table.insert(self._song_colors, 10)
			-- SNAP COLORS
			elseif note_colors == 2 then
				if bpm_pos + 1 < #self._current_audio_data.TimingPoints and self._current_audio_data.HitObjects[i].Time > self._current_audio_data.TimingPoints[bpm_pos + 1].Time then
					while bpm_pos + 1 < #self._current_audio_data.TimingPoints and self._current_audio_data.HitObjects[i].Time > self._current_audio_data.TimingPoints[bpm_pos + 1].Time do
						bpm_pos = bpm_pos + 1
					end
				end
				table.insert(self._song_colors, self:get_snap_color(
					self._current_audio_data.TimingPoints[bpm_pos].Time, 
					self._current_audio_data.TimingPoints[bpm_pos].BeatLength, 
					self._current_audio_data.HitObjects[i].Time)
				)
			-- RANDOM COLORS
			elseif note_colors == 3 then
				table.insert(self._song_colors, math.random(1,19))
			-- TIER 4
			elseif note_colors == 4 then
				table.insert(self._song_colors, 11)
			-- TIER 5
			elseif note_colors == 5 then
				table.insert(self._song_colors, 12)
			-- TIER 6
			elseif note_colors == 6 then
				table.insert(self._song_colors, 13)
			-- TIER 7
			elseif note_colors == 7 then
				table.insert(self._song_colors, 14)
			-- TIER 8
			elseif note_colors == 8 then
				table.insert(self._song_colors, 15)
			-- TIER 9
			elseif note_colors == 9 then
				table.insert(self._song_colors, 16)
			-- TIER 10
			elseif note_colors == 10 then
				table.insert(self._song_colors, 17)
			-- TIER 11
			elseif note_colors == 11 then
				table.insert(self._song_colors, 18)
				
			elseif note_colors == 12 then
				table.insert(self._song_colors, 19)
				
			elseif note_colors == 13 then
				table.insert(self._song_colors, 20)
				
			elseif note_colors == 14 then
				table.insert(self._song_colors, 21)
			end
		end

		local last_hit_object = self._current_audio_data.HitObjects[#self._current_audio_data.HitObjects]
		if last_hit_object.Type == 2 then
			_last_note_time = last_hit_object.Time + last_hit_object.Duration
		else
			_last_note_time = last_hit_object.Time
		end

		local sfxg_id = self._current_audio_data.AudioHitSFXGroup
		if sfxg_id == nil then
			sfxg_id = 0
		end
		self._hit_sfx_group = HitSFXGroup:new(_game,sfxg_id)
		self._hit_sfx_group:preload()

		self._audio_time_offset = self._current_audio_data.AudioTimeOffset + audio_offset --/ song_rate

		self._bgm.SoundId = self._current_audio_data.AudioAssetId
		self._bgm.Playing = true
		self._bgm.Volume = 0
		self._bgm.PlaybackSpeed = song_rate
		self._bgm_time_position = specOffset/1000
		self._bgm.TimePosition = specOffset/1000

		if self._current_audio_data.AudioVolume ~= nil then
			_audio_volume = self._current_audio_data.AudioVolume
		end

		self.NOTE_PREBUFFER_TIME = 1000 * CurveUtil:YForPointOf2PtLine(Vector2.new(0,1), Vector2.new(40,0.2), scroll_speed) * _song_rate

		if self._current_audio_data.RandomSeed == nil then
			self._note_gen_rand = RandomLua.mwc(0)
		else
			self._note_gen_rand = RandomLua.mwc(self._current_audio_data.RandomSeed)
		end

		_last_held_note_hit_time = self._current_audio_data.HitObjects[1].Time
	end

	function self:teardown()
		self._bgm:Destroy()
		self._bgm = nil
		self._current_audio_data = nil
		self._note_gen_rand = nil
		self = nil
	end

	function self:is_ready_to_play()
		return self._current_audio_data ~= nil and self._bgm.IsLoaded == true
	end

	function self:is_prestart() return _current_mode == AudioManager.Mode.PreStart end
	function self:is_playing() return _current_mode == AudioManager.Mode.Playing end
	function self:is_finished() return _current_mode == AudioManager.Mode.Finished end

	function self:get_note_prebuffer_time_ms()
		return self.NOTE_PREBUFFER_TIME
	end

	local _gen_rand_note_last = 0
	local _hit_time_last = 0
	local function gen_rand_note(i,hit_time)
		local rtv = self._note_gen_rand:rand_rangei(1,5)

		if rtv == _gen_rand_note_last and math.abs(hit_time - _hit_time_last) < 10 then
			while rtv == _gen_rand_note_last do
				rtv = self._note_gen_rand:rand_rangei(1,5)
			end
		end

		_gen_rand_note_last = rtv
		_hit_time_last = hit_time

		return rtv
	end

	local function push_back_note(
		i,
		_game,
		itr_hitobj,
		current_time_ms,
		hit_time,
		note_color)

		local track_number = 1
		if itr_hitobj.Track ~= nil then
			track_number = itr_hitobj.Track
		else
			track_number = gen_rand_note(i,hit_time)
		end
		
		for z, mod in pairs(amods) do
			if mod.PushBackNote then
				local p = mod:PushBackNote({
					Track=track_number;
					Time=hit_time;
					CurrentTime=current_time_ms;
					Color=note_color;
					Id=i
				})
				if p ~= nil then
					track_number = p.track or track_number
				end
			end
		end

		for slot_id,tracksystem in _game:tracksystems_itr() do
			tracksystem._notes:push_back(
				Note:new(
					_game,
					track_number,
					tracksystem:get_game_slot(),
					current_time_ms,
					hit_time,
					note_color,
					i,
					amods
				)
			)
		end
	end

	local function push_back_heldnote(
		i,
		_game,
		itr_hitobj,
		current_time_ms,
		hit_time,
		duration,
		note_color)
		
		

		local track_number = 1
		if itr_hitobj.Track ~= nil then
			track_number = itr_hitobj.Track
		else
			track_number = gen_rand_note(i,hit_time)
		end
		
		for z, mod in pairs(amods) do
			print(z, mod)
			if mod.PushBackHold then
				local p = mod:PushBackHold({
					Track=track_number;
					Time=hit_time;
					EndTime=hit_time+duration;
					Duration=duration;
					CurrentTime=current_time_ms;
					Color=note_color;
					Id=i
				})
				track_number = p.track or track_number
			end
		end

		for slot_id,tracksystem in _game:tracksystems_itr() do
			tracksystem._notes:push_back(
				HeldNote:new(
					_game,
					track_number,
					tracksystem:get_game_slot(),
					current_time_ms,
					hit_time,
					duration,
					note_color,
					self.snap_enabled,
					i,
					amods
				)
			)
		end
	end

	function self:start_play()
		_current_mode = AudioManager.Mode.PreStart
		_pre_start_time = 0
		Modchart:Init()
	end

	local _raise_pre_start_trigger = false
	local _raise_pre_start_trigger_val = 0
	local _raise_pre_start_trigger_duration = 0
	function self:raise_pre_start_trigger()
		local rtv = _raise_pre_start_trigger
		_raise_pre_start_trigger = false
		return rtv, _raise_pre_start_trigger_val, _raise_pre_start_trigger_duration
	end

	local _raise_ended_trigger = false
	local _raise_just_finished = false
	local _ended_connection = nil

	function self:update(dt_scale,_game)
		dt_scale = dt_scale * _song_rate
		if _current_mode == AudioManager.Mode.PreStart then
			local pre_start_time_pre = _pre_start_time
			local pre_start_time_post = _pre_start_time + CurveUtil:TimescaleToDeltaTime(dt_scale) * 1000
			_pre_start_time = pre_start_time_post

			local PCT_3 = PRE_START_TIME_MS_MAX * 0.2
			local PCT_2 = PRE_START_TIME_MS_MAX * 0.4
			local PCT_1 = PRE_START_TIME_MS_MAX * 0.6
			local PCT_START = PRE_START_TIME_MS_MAX * 0.8

			if pre_start_time_pre < PCT_3 and pre_start_time_post > PCT_3 then
				_raise_pre_start_trigger = true
				_raise_pre_start_trigger_val = 1
				_raise_pre_start_trigger_duration = PCT_2 - PCT_3

			elseif pre_start_time_pre < PCT_2 and pre_start_time_post > PCT_2 then
				_raise_pre_start_trigger = true
				_raise_pre_start_trigger_val = 2
				_raise_pre_start_trigger_duration = PCT_1 - PCT_2

			elseif pre_start_time_pre < PCT_1 and pre_start_time_post > PCT_1 then
				_raise_pre_start_trigger = true
				_raise_pre_start_trigger_val = 3
				_raise_pre_start_trigger_duration = PCT_START - PCT_1

			elseif pre_start_time_pre < PCT_START and pre_start_time_post > PCT_START then
				_raise_pre_start_trigger = true
				_raise_pre_start_trigger_val = 4
				_raise_pre_start_trigger_duration = PRE_START_TIME_MS_MAX - PCT_START

			end

			if _pre_start_time >= PRE_START_TIME_MS_MAX then
				self._bgm.TimePosition = specOffset/1000
				self._bgm.Volume = _audio_volume
				self._bgm.PlaybackSpeed = _song_rate
				self._bgm_time_position = specOffset/1000
				_ended_connection = self._bgm.Ended:Connect(function()
					_raise_ended_trigger = true
					_ended_connection:Disconnect()
					_ended_connection = nil
				end)

				_current_mode = AudioManager.Mode.Playing
			end

			self:update_spawn_notes(dt_scale,_game)

		elseif _current_mode == AudioManager.Mode.Playing then
			self:update_spawn_notes(dt_scale,_game)
			self._bgm_time_position = math.min(
				self._bgm_time_position + CurveUtil:TimescaleToDeltaTime(dt_scale),
				self._bgm.TimeLength
			)

			if _raise_ended_trigger == true then
				_current_mode = AudioManager.Mode.PostPlaying
			end
			
			for i = modchart_index, #self.mod_points, 1 do
				local curPoint = self.mod_points[i]
				if self:get_current_time_ms() >= curPoint.Time then
					modchart_index = modchart_index + 1
					if curPoint.Callback then
						FastSpawn(curPoint.Callback)
					end
					break
				end
			end

			--[[Spectating.UpdateGame:FireServer({
				bgmTime = self._bgm_time_position*1000
			})]]--

		elseif _current_mode == AudioManager.Mode.PostPlaying then
			_post_playing_time_ms = _post_playing_time_ms + CurveUtil:TimescaleToDeltaTime(dt_scale) * 1000
			if _post_playing_time_ms > POST_TIME_PLAYING_MS_MAX then
				_current_mode = AudioManager.Mode.Finished
				_raise_just_finished = true
			end
		end
	end
	
	function self:get_song_rate()
		return _song_rate
	end

	function self:get_just_finished()
		local rtv = _raise_just_finished
		_raise_just_finished = false
		return rtv
	end

	function self:update_spawn_notes(dt_scale,_game)
		local current_time_ms = self:get_current_time_ms()
		local note_prebuffer_time_ms = self:get_note_prebuffer_time_ms()

		local test_time = current_time_ms + note_prebuffer_time_ms - PRE_START_TIME_MS_MAX

		self:update_beat(dt_scale,_game)

		for i=self._audio_data_index,#self._current_audio_data.HitObjects do
			local itr_hitobj = self._current_audio_data.HitObjects[i]
			if test_time >= itr_hitobj.Time then
				if itr_hitobj.Time >= specOffset then
					if itr_hitobj.Type == 1 then
						push_back_note(
							i,
							_game,
							itr_hitobj,
							current_time_ms,
							itr_hitobj.Time + PRE_START_TIME_MS_MAX,
							self.note_color
						)
	
					elseif itr_hitobj.Type == 2 then
						push_back_heldnote(
							i,
							_game,
							itr_hitobj,
							current_time_ms,
							itr_hitobj.Time + PRE_START_TIME_MS_MAX,
							itr_hitobj.Duration,
							self.note_color
						)
	
					end
				end

				self._audio_data_index = self._audio_data_index + 1
			else
				break
			end
		end
	end

	local _i_beat_data = 1
	function self:get_beat_duration()
		local beat_duration = self._current_audio_data.TimingPoints[1].BeatLength
		local current_time = self:get_current_time_ms()
		for i=_i_beat_data,#self._current_audio_data.TimingPoints do
			local itr = self._current_audio_data.TimingPoints[i]
			if current_time >= itr.Time then
				beat_duration = itr.BeatLength
				_i_beat_data = i
			else
				break
			end

		end
		return beat_duration
	end

	local _frame_is_beat = false
	local _last_frame_time = 0
	function self:update_beat(dt_scale,_game)
		local cur_beat_duration = self:get_beat_duration()
		local current_time = self:get_current_time_ms()

		local i_cur_frame_beat = math.floor((current_time - _last_held_note_hit_time)/(cur_beat_duration*_song_rate))
		local i_last_frame_beat = math.floor((_last_frame_time  - _last_held_note_hit_time)/(cur_beat_duration*_song_rate))

		if i_cur_frame_beat > i_last_frame_beat then
		  _frame_is_beat = true
		else
		  _frame_is_beat = false
		end

		_last_frame_time = current_time
	end
	function self:is_beat()
		return _frame_is_beat
	end

	function self:get_current_time_ms()
		return (self._bgm_time_position * 1000 + self._audio_time_offset) + _pre_start_time
	end

	function self:get_current_time_bgm_ms()
		-- Does not update at 60fps
		return (self._bgm.TimePosition * 1000 + self._audio_time_offset ) + _pre_start_time
	end

	function self:get_song_length_ms()
		return self._bgm.TimeLength * 1000 + PRE_START_TIME_MS_MAX
	end

	function self:get_last_note_time()
		return _last_note_time
	end

	function self:get_audio_data()
		return self._current_audio_data
	end

	return self
end


return AudioManager
