local EffectSystem = require(game.ReplicatedStorage.Effects.EffectSystem)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local GameSlot = require(game.ReplicatedStorage.Shared.GameSlot)

local CharacterShineEffect = {}

function CharacterShineEffect:new(_game,game_slot)
	local self = {}	
	self.Type = "CharacterShineEffect"	
	
	local _anim_t = 0
	local _do_kill = false
	local _effect_obj = nil
	
	function self:cons()
		_effect_obj = _game._object_pool:depool(self.Type)
		if _effect_obj == nil then
			_effect_obj = game.ReplicatedStorage.ElementProtos.CharacterShineEffectProto:Clone()
		end
		
		_effect_obj.PrimaryPart.Position = GameSlot:slot_to_character_cframe(game_slot).p + Vector3.new(0,-2,0)
		_effect_obj.PrimaryPart.ParticleEmitter.Enabled = true	
	end
	
	function self:set_enabled(val)
		_effect_obj.PrimaryPart.ParticleEmitter.Enabled = val
	end
	
	function self:kill()
		_do_kill = true
	end
	
	--[[Override--]] function self:add_to_parent(parent, _game)
		_effect_obj.Parent = parent
	end
	
	--[[Override--]] function self:update(dt_scale, _game)
		--_anim_t = _anim_t + CurveUtil:SecondsToTick(0.5) * dt_scale
	end	
	--[[Override--]] function self:should_remove(_game)
		return _do_kill
	end	
	--[[Override--]] function self:do_remove(_game)
		_game._object_pool:repool(self.Type,_effect_obj)
		self._effect_obj = nil
	end		
	
	self:cons()
	return self
end

return CharacterShineEffect
