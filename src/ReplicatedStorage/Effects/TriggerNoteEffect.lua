local EffectSystem = require(game.ReplicatedStorage.Effects.EffectSystem)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local NoteResult = require(game.ReplicatedStorage.Shared.NoteResult)

local TriggerNoteEffect = {}

function TriggerNoteEffect:new(_game, position, result, is_local_slot)
	local self = EffectSystem:EffectBase()
	self.Type = "TriggerNoteEffect"

	if is_local_slot ~= true then
		is_local_slot = false
	end

	self._effect_obj = nil
	self._anim_t = 0
	self._result = result

	local _position = Vector3.new()

	local function update_visual()
		self._effect_obj.Body.Transparency = CurveUtil:YForPointOf2PtLine(
			Vector2.new(0,0.85),
			Vector2.new(1,1),
			self._anim_t
		)

		local size_val = CurveUtil:YForPointOf2PtLine(
			Vector2.new(0,2.25),
			Vector2.new(1,4.25),
			self._anim_t
		)

		if self._result == NoteResult.Okay then
			size_val = size_val * 0.2
		elseif self._result == NoteResult.Good then
			size_val = size_val * 0.3
		elseif self._result == NoteResult.Great then
			size_val = size_val * 0.4
		elseif self._result == NoteResult.Perfect then
			size_val = size_val * 0.5
		else
			size_val = size_val * 0.5
		end

		if is_local_slot then
			_position = _position + Vector3.new(0,0.01,0)
			self._effect_obj:SetPrimaryPartCFrame(
					CFrame.new(_position) *
					SPUtil:part_cframe_rotation(self._effect_obj.PrimaryPart)
			)
		end
		self._effect_obj.Body.Size = Vector3.new(70,size_val,size_val)

	end

	function self:cons(_game)
		self._effect_obj = _game._object_pool:depool(self.Type)
		if self._effect_obj == nil then
			self._effect_obj = _game:get_game_protos().TriggerHitEffectProto:Clone()
		end

		if self._result == NoteResult.Okay then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(255,0,255)
		elseif self._result == NoteResult.Good then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(0,165,255)
		elseif self._result == NoteResult.Great then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(0,255,0)
		elseif self._result == NoteResult.Perfect then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(255,255,0)
		else
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(255,255,255)
		end

		_position = Vector3.new(position.X, _game:get_game_environment_center().Y, position.Z)
		self._effect_obj:SetPrimaryPartCFrame(
				CFrame.new(_position) *
				SPUtil:part_cframe_rotation(self._effect_obj.PrimaryPart)
		)

		self._anim_t = 0
		update_visual()
	end

	--[[Override--]] function self:add_to_parent(parent, _game)
		self._effect_obj.Parent = parent
	end

	--[[Override--]] function self:update(dt_scale, _game)
		self._anim_t = self._anim_t + CurveUtil:SecondsToTick(0.25) * dt_scale
		update_visual()
	end
	--[[Override--]] function self:should_remove(_game)
		return self._anim_t >= 1
	end
	--[[Override--]] function self:do_remove(_game)
		if is_local_slot then
			_position = _position + Vector3.new(-999,-999,-999)
			self._effect_obj:SetPrimaryPartCFrame(
					CFrame.new(_position) *
					SPUtil:part_cframe_rotation(self._effect_obj.PrimaryPart)
			)
		end
		_game._object_pool:repool(self.Type,self._effect_obj)
		self._effect_obj = nil
	end

	self:cons(_game)
	return self
end

return TriggerNoteEffect
