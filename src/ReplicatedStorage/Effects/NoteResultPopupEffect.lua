local EffectSystem = require(game.ReplicatedStorage.Effects.EffectSystem)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local NoteResult = require(game.ReplicatedStorage.Shared.NoteResult)

local NoteResultPopupEffect = {}


function NoteResultPopupEffect:new(_game, position, result)
	local self = EffectSystem:EffectBase()
	self.Type = "NoteResultPopupEffect"
	
	self._effect_obj = nil
	self._anim_t = 0
	self._result = result
	
	self._initial_pos = position
	self._final_pos = position + Vector3.new(0,1.25,0)
	
	local function update_visual()
		self._effect_obj:SetPrimaryPartCFrame(
			CFrame.new(
				SPUtil:vec3_lerp(self._initial_pos,self._final_pos,self._anim_t), 
				workspace.CurrentCamera.CFrame.p
			)
		)
		self._effect_obj.Panel.Decal.Transparency = CurveUtil:YForPointOf2PtLine(
			Vector2.new(0,0.05), 
			Vector2.new(1,1), 
			self._anim_t
		)
	end
	
	local function pool_str()
		return string.format("%s_%d",self.Type,self._result)
	end
	
	function self:cons(_game, position, result)
		self._effect_obj = _game._object_pool:depool(pool_str())
		if self._effect_obj == nil then
			if self._result == NoteResult.Miss then
				self._effect_obj = _game:get_game_protos().PopupMissEffect:Clone()
			elseif self._result == NoteResult.Okay then
				self._effect_obj =  _game:get_game_protos().PopupOkayEffect:Clone()
			elseif self._result == NoteResult.Good then
				self._effect_obj =  _game:get_game_protos().PopupGoodEffect:Clone()
			elseif self._result == NoteResult.Great then
				self._effect_obj =  _game:get_game_protos().PopupGreatEffect:Clone()
			elseif self._result == NoteResult.Perfect then
				self._effect_obj =  _game:get_game_protos().PopupPerfectEffect:Clone()
			else
				self._effect_obj =  _game:get_game_protos().PopupMarvelousEffect:Clone()
			end
		end
		
		self._effect_obj:SetPrimaryPartCFrame(
			CFrame.new(position, workspace.CurrentCamera.CFrame.p)
		)
		
		self._anim_t = 0
	end
	
	--[[Override--]] function self:add_to_parent(parent, _game)
		self._effect_obj.Parent = parent
	end
	
	--[[Override--]] function self:update(dt_scale, _game)
		self._anim_t = self._anim_t + CurveUtil:SecondsToTick(0.55) * dt_scale
		update_visual()	
	end	
	--[[Override--]] function self:should_remove(_game)
		return self._anim_t >= 1
	end	
	--[[Override--]] function self:do_remove(_game)
		_game._object_pool:repool(pool_str(),self._effect_obj)
		self._effect_obj = nil
	end	
	
	self:cons(_game, position, result)
	return self
end

return NoteResultPopupEffect
