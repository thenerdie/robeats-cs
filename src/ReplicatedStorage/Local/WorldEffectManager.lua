local GameSlot = require(game.ReplicatedStorage.Shared.GameSlot)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local NoteResult = require(game.ReplicatedStorage.Shared.NoteResult)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPList = require(game.ReplicatedStorage.Shared.SPList)
local SFXManager = require(game.ReplicatedStorage.Local.SFXManager)

local WorldEffectManager = {}

function WorldEffectManager:new(local_services, game_environment, game_protos, game_element)
	local self = {}

	local _character_shines = SPList:new()
	local _center_emitter = nil
	local _frame_has_played_tick = false

	local _frame_is_hold = false

	function self:cons(game_environment, game_protos)
		_center_emitter = game_protos.CenterEmitterProto:Clone()

		local game_center = game_environment.GameEnvironmentCenter.Position
		_center_emitter:SetPrimaryPartCFrame(
			SPUtil:part_cframe_rotation(_center_emitter.PrimaryPart) +
			(game_center + Vector3.new(0,1.05,0))
		)
		_center_emitter.Parent = game_element
	end
	function self:teardown(_game)
		_center_emitter:Destroy()
		_center_emitter = nil
		for i=1,_character_shines:count() do
			_character_shines:get(i):do_remove(_game)
		end
		_character_shines:clear()
		_character_shines = nil
		self = nil
	end

	function self:setup_world(_game)
	end

	function self:update(dt_scale, _game)
		self:update_character_shines(dt_scale, _game)
		_frame_has_played_tick = false
		_frame_is_hold = false
	end

	function self:post_update(dt_scale, _game)
	end

	function self:update_character_shines(dt_scale, _game)
		for i=1,_character_shines:count() do
			local show = false
			if _game._players._slots:contains(i) then
				local itr_player = _game._players._slots:get(i)
				if itr_player._power_bar_active then
					show = true
				end
			end
			_character_shines:get(i):set_enabled(show)
		end
	end

	function self:notify_hit(_game, note_result, slot_index, track_index)
		if slot_index ~= _game._local_game_slot then return end
		if not _game._score_manager:is_powerbar_active() then return end
		if note_result == NoteResult.Miss then return end
	end

	function self:notify_hold_tick(_game, slot_index, track_index)
		if slot_index ~= _game._local_game_slot then return end

		if _frame_has_played_tick == false then
			--_game._sfx_manager:play_sfx(SFXManager.SFX_TICK)
		end
		_frame_has_played_tick = true

		if not _game._score_manager:is_powerbar_active() then return end
	end

	function self:notify_frame_hold(_game, slot_index, track_index)
		if slot_index ~= _game._local_game_slot then return end

		_frame_is_hold = true
	end

	self:cons(game_environment, game_protos)
	return self
end

return WorldEffectManager
