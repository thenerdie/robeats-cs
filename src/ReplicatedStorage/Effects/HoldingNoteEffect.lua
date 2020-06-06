local EffectSystem = require(game.ReplicatedStorage.Effects.EffectSystem)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local NoteResult = require(game.ReplicatedStorage.Shared.NoteResult)

local HoldingNoteEffect = {}

function HoldingNoteEffect:new(
	_game,
	position,
	note_result
	)
	local self = EffectSystem:EffectBase()
	self.Type = "HoldingNoteEffect"
	
	self._effect_obj = nil;
	self._anim_t = 0
	
	local function update_visual()
		self._effect_obj.Body.Transparency = CurveUtil:YForPointOf2PtLine(
			Vector2.new(0,0.4), 
			Vector2.new(1,1), 
			self._anim_t
		)
		
		local size_val = CurveUtil:YForPointOf2PtLine(
			Vector2.new(0,2),
			Vector2.new(1,3.4),
			self._anim_t
		)
		self._effect_obj.Body.Size = Vector3.new(size_val,size_val,size_val)
	end	
	
	function self:cons()
		self._effect_obj = _game._object_pool:depool(self.Type)
		if self._effect_obj == nil then
			self._effect_obj = _game:get_game_protos().HoldingNoteEffectProto:Clone()
		end
		
		self._effect_obj.PrimaryPart.Position = position
		if note_result == NoteResult.Okay then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(243,0,255)
		elseif note_result == NoteResult.Good then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(0,165,255)
		elseif note_result == NoteResult.Great then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(0,255,0)
		elseif note_result == NoteResult.Perfect then
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(255,255,0)
		else
			self._effect_obj.PrimaryPart.BrickColor = BrickColor.new(255,255,255)
		end	
		
		self._anim_t = 0
		update_visual()
	end	
	
	--[[Override--]] function self:add_to_parent(parent, _game)
		self._effect_obj.Parent = parent
	end
	
	--[[Override--]] function self:update(dt_scale, _game)
		self._anim_t = self._anim_t + CurveUtil:SecondsToTick(0.35) * dt_scale
		update_visual()	
	end	
	--[[Override--]] function self:should_remove(_game)
		return self._anim_t >= 1
	end	
	--[[Override--]] function self:do_remove(_game)
		_game._object_pool:repool(self.Type,self._effect_obj)
		self._effect_obj = nil
	end		
	
	self:cons()
	return self
end

return HoldingNoteEffect
