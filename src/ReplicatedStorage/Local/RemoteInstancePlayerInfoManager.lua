local SPList = require(game.ReplicatedStorage.Shared.SPList)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local ServerGameInstancePlayer = require(game.ReplicatedStorage.Shared.ServerGameInstancePlayer)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local RemoteInstancePlayerInfoManager = {}

function RemoteInstancePlayerInfoManager:new()
	local self = {
		_slots = SPDict:new();
	}

	function self:teardown()
		self._slots:clear()
		self = nil
	end

	function self:contains_player_of_id(id)
		for slot,player in self._slots:key_itr() do
			if player._id == id then
				return true
			end
		end
		return false
	end

	function self:get_slot_place(_game,slot)
		if _game._ui_manager._place_slots == nil then
			return 0
		end
		return _game._ui_manager._place_slots:slot_place(slot)
	end

	function self:update_from_player_info_data(_game, player_info)
		----[{ Slot = i; Score = itr._score; Chain = itr._chain; Name = itr._name; UserId = itr._id; }]

		for itr_key,itr_player in self._slots:key_itr() do
			local found = false
			for i=1,4 do
				if player_info[i] ~= nil then
					if player_info[i].Slot == itr_key then
						found = true
					end
				end
			end

			if found == false then

				DebugOut:puts("Player(%s) slot(%d) disconnected",itr_player._name,itr_key)
				self._slots:remove(itr_key)
			end

		end

		for i_player_info=1,4 do
			if player_info[i_player_info] ~= nil then
				local itr_info = player_info[i_player_info]
				if self._slots:contains(itr_info.Slot) == false then
					DebugOut:puts("Player(%s) slot(%d) joined",itr_info.Name,itr_info.Slot)

					self._slots:add(itr_info.Slot, ServerGameInstancePlayer:new(
						itr_info.UserId,
						itr_info.Name
					))
				end

				self._slots:get(itr_info.Slot):update_from_player_info(itr_info)

				if itr_info.Slot == _game:get_local_game_slot() then
					self._slots:get(itr_info.Slot)._power_bar_active = _game._score_manager:is_powerbar_active()
					self._slots:get(itr_info.Slot)._score = _game._score_manager:get_score()
					self._slots:get(itr_info.Slot)._chain = _game._score_manager:get_chain()
				end
			end
		end

	end

	return self
end

return RemoteInstancePlayerInfoManager
