local SPList = require(game.ReplicatedStorage.Shared.SPList)
local Track = require(game.ReplicatedStorage.Local.Track)
local GameSlot = require(game.ReplicatedStorage.Shared.GameSlot)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)
local NoteResult = require(game.ReplicatedStorage.Shared.NoteResult)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local DebugConfig = require(game.ReplicatedStorage.Shared.DebugConfig)

local TrackSystem = {}

function TrackSystem:new(_game, slot_id, hit_position)
	local scrollmode = {Value=2}
	local note_offset = hit_position
	local self = {
		_notes = SPList:new();
		_tracks = SPList:new();

		_game_slot = slot_id;
	}

	function self:cons()
		if scrollmode.Value == 1 then
			self._tracks:push_back(Track:new(self,12,"Track1",_game,1,note_offset))
			self._tracks:push_back(Track:new(self,4,"Track2",_game,2,note_offset))
			self._tracks:push_back(Track:new(self,-4,"Track3",_game,3,note_offset))
			self._tracks:push_back(Track:new(self,-12,"Track4",_game,4,note_offset))
		else
			self._tracks:push_back(Track:new(self,7.5,"Track1",_game,1,note_offset))
			self._tracks:push_back(Track:new(self,2.5,"Track2",_game,2,note_offset))
			self._tracks:push_back(Track:new(self,-2.5,"Track3",_game,3,note_offset))
			self._tracks:push_back(Track:new(self,-7.5,"Track4",_game,4,note_offset))
		
		end	
	end

	function self:teardown()
		for i=1,self._notes:count() do
			self._notes:get(i):do_remove(_game)
		end
		self._notes:clear()
		for i=1,self._tracks:count() do
			self._tracks:get(i):teardown()
		end
		self._tracks:clear()
		_game = nil
		self = nil
	end

	function self:update(dt_scale,_game)
		--SPUtil:profilebegin("TrackSystem:update")
		--SPUtil:profileend()

		SPUtil:profilebegin("_tracks:update")
		for i=1, self._tracks:count() do
			local itr_track = self._tracks:get(i)
			itr_track:update(dt_scale, _game)
		end
		SPUtil:profileend()

		SPUtil:profilebegin("_notes:update")
		for i=self._notes:count(),1,-1  do
			local itr_note = self._notes:get(i)

			itr_note:update(dt_scale, _game)

			if itr_note:should_remove(_game) then
				itr_note:do_remove(_game)
				self._notes:remove_at(i)
			end
		end
		--SPUtil:profileend()

		SPUtil:profileend()
	end

	function self:get_player_world_center()
		return _game:get_game_environment_center()
	end
	function self:get_player_world_position()
		return GameSlot:slot_to_world_position(self._game_slot)
	end
	function self:get_game_slot()
		return self._game_slot
	end
	function self:get_track(index)
		return self._tracks:get(index)
	end

	function self:remote_replicate_hit_result(note_result)
		if _game:get_local_game_slot() == self._game_slot then
			DebugOut:warnf("remote_replicate_hit_result on local track(!!)")
		end
	end

	function self:press_track_index(_game, track_index)
		self:get_track(track_index):press()
		local hit_found = false

		for i=1,self._notes:count() do
			local itr_note = self._notes:get(i)
			if itr_note:get_track_index() == track_index then
				local did_hit, note_result = itr_note:test_hit(_game)
				if did_hit then
					itr_note:on_hit(_game,note_result,i)
					hit_found = true
					break
				end
			end
		end

		if hit_found == false then
--			_game._score_manager:register_hit(
--				_game,
--				NoteResult.Miss,
--				slot_id,
--				track_index,
--				{ PlaySFX = true; PlayHoldEffect = false; WhiffMiss = true; }
--			)
		end
	end
	
	function self:spectate_press_track_index(_game, track_index, note_result, id)
		local hit_found = false

		for i=1,self._notes:count() do
			local itr_note = self._notes:get(i)
			if itr_note.id == id then
				itr_note:on_hit(_game,note_result,i)
				hit_found = true
				break
			end
		end

		if hit_found == false then
--			_game._score_manager:register_hit(
--				_game,
--				NoteResult.Miss,
--				slot_id,
--				track_index,
--				{ PlaySFX = true; PlayHoldEffect = false; WhiffMiss = true; }
--			)
		end
	end

	function self:release_track_index(_game, track_index)
		self:get_track(track_index):release()

		for i=1,self._notes:count() do
			local itr_note = self._notes:get(i)
			if itr_note:get_track_index() == track_index then
				local did_release, note_result = itr_note:test_release(_game)
				if did_release then
					itr_note:on_release(_game,note_result,i)
					break
				end
			end
		end
	end
	
	function self:spectate_release_track_index(_game, track_index, note_result, id)
		local hit_found = false

		for i=1,self._notes:count() do
			local itr_note = self._notes:get(i)
			if itr_note.id == id then
				itr_note:on_release(_game,note_result,i)
				hit_found = true
				break
			end
		end

		if hit_found == false then
--			_game._score_manager:register_hit(
--				_game,
--				NoteResult.Miss,
--				slot_id,
--				track_index,
--				{ PlaySFX = true; PlayHoldEffect = false; WhiffMiss = true; }
--			)
		end
	end

	self:cons()
	return self
end

return TrackSystem
