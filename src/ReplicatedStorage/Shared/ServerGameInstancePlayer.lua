local SPDict = require(game.ReplicatedStorage.Shared.SPDict)

local ServerGameInstancePlayer = {}

function ServerGameInstancePlayer:new(user_id, name)
	local self = {}

	----- SHARED ------

	self._id = user_id
	self._name = name
	self._requested_song_key = nil

	------ GAME ------

	self._score = 0
	self._chain = 0
	self._power_bar_active = false
	self._finished = false

	-- non-replicated
	self._perfect_count = 0
	self._great_count = 0
	self._okay_count = 0
	self._miss_count = 0

	------ JOIN ------

	self._ready = false
	self._matchmaking_time = 0

	------ VOTEPICK ------

	self._votepick_song_key = nil
	self._timeout = 0

	------ SOUNDLOAD ------

	self._loaded = false

	------------------

	function self:set_requested_song_key(val)
		self._requested_song_key = val
	end


	function self:get_player_info(slot)
		return {
			Name = self._name;
			UserId = self._id;
			Slot = slot;
			RequestedSongKey = self._requested_song_key;

			Score = self._score;
			Chain = self._chain;
			PowerBarActive = self._power_bar_active;
			Finished = self._finished;
		}
	end

	function self:update_from_player_info(player_info)
		self._id = player_info.UserId
		self._name = player_info.Name
		self._requested_song_key = player_info.RequestedSongKey

		if player_info.Score == nil then
			return
		end

		self._score = player_info.Score
		self._chain = player_info.Chain
		self._power_bar_active = player_info.PowerBarActive
		self._finished = player_info.Finished
	end

	function self:get_player_matchmaking_info(slot)
		return {
			Name = self._name;
			UserId = self._id;
			Slot = slot;
			RequestedSongKey = self._requested_song_key;

			Ready = self._ready;
			Timeout = self._timeout;
			Loaded = self._loaded;
			VotePickSongKey = self._votepick_song_key;
		}
	end

	function self:update_from_matchmaking_info(player_info)
		self._id = player_info.UserId
		self._name = player_info.Name
		self._requested_song_key = player_info.RequestedSongKey

		if player_info.Ready == nil then error("ServerGameInstancePlayer:update_from_matchmaking_info missing[Ready]") end

		self._ready = player_info.Ready
		self._timeout = player_info.Timeout
		self._loaded = player_info.Loaded
		self._votepick_song_key = player_info.VotePickSongKey
	end

	return self
end

local function update_dict_shared(dict, player_info, updatefn)
	local updated = false
	for itr_key,itr_player in dict:key_itr() do
		local found = false
		for i=1,4 do
			if player_info[i] ~= nil and player_info[i].Slot == itr_key then
				found = true
			end
		end

		if found == false then
			dict:remove(itr_key)
			updated = true
		end

	end

	for i_player_info=1,4 do
		if player_info[i_player_info] ~= nil then
			local itr_info = player_info[i_player_info]
			if dict:contains(itr_info.Slot) == false then
				dict:add(itr_info.Slot, ServerGameInstancePlayer:new(
					itr_info.UserId,
					itr_info.Name
				))
				updated = true
			end
			updatefn(dict:get(itr_info.Slot), itr_info)
		end
	end
	return updated
end

local function update_from_player_info_updatefn(itr, itr_info)
	itr:update_from_player_info(itr_info)
end

local function update_from_matchmaking_info(itr, itr_info)
	itr:update_from_matchmaking_info(itr_info)
end

function ServerGameInstancePlayer:slot_from_player_info_table_for_id(player_info, player_id)
	for i=1,4 do
		if player_info[i] ~= nil and player_info[i].UserId == player_id then
			return player_info[i].Slot
		end
	end
	return -1
end

function ServerGameInstancePlayer:update_dict_from_player_info_table(dict, player_info)
	return update_dict_shared(dict, player_info, update_from_player_info_updatefn)
end

function ServerGameInstancePlayer:update_dict_from_matchmaking_info_table(dict, player_info)
	return update_dict_shared(dict, player_info, update_from_matchmaking_info)
end

function ServerGameInstancePlayer:playerinfo_to_str(player_info)
	local rtv = "["
	for i_player_info=1,4 do
		if player_info[i_player_info] ~= nil then
			rtv = rtv .. string.format(
				"[%d] = {%s (%d) ready(%s)};",
				i_player_info,
				player_info[i_player_info].Name,
				player_info[i_player_info].UserId,
				tostring(player_info[i_player_info].Ready)
			)
		end
	end
	return rtv
end

return ServerGameInstancePlayer
