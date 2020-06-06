local EffectSystem = require(game.ReplicatedStorage.Effects.EffectSystem)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local SPRange = require(game.ReplicatedStorage.Shared.SPRange)
local SPVector = require(game.ReplicatedStorage.Shared.SPVector)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local ConfigAnimEffect = {}
ConfigAnimEffect.EffectObject = {}

function ConfigAnimEffect.EffectObject:new()
	local self = {}	
	
	function self:set_position(x,y,z) end
	function self:set_alpha(alpha) end
	function self:set_rotation(rotation) end
	function self:set_scale(scale) end	
	
	function self:add_to_parent(parent, _game) end
	function self:do_remove(_game) end
	
	return self
end

function ConfigAnimEffect:new(effect_obj)
	local self = EffectSystem:EffectBase()
	
	self._effect_obj = effect_obj
	self._anim_t = 0
	self._position = SPVector.new(0,0,0)	
	self._r = 0
	self._vr = 0
	self._scale = SPRange:new(1,1)
	self._alpha = SPRange:new(1,1)
	self._velocity = SPVector:new(0,0,0)
	self._acceleration = SPVector:new(0,0,0)	
	self._tick_incr = CurveUtil:SecondsToTick(0.5)
	
	function self:cons()
		self:update_visual()
	end
	
	function self:set_duration_seconds(sec)
		self._tick_incr = CurveUtil:SecondsToTick(sec)
		return self
	end
	function self:set_position(x,y,z)
		self._position:set(x,y,z)
		return self
	end
	function self:set_rotation(rotation)
		self._r = rotation
		return self
	end
	function self:set_vrotation(vrotation)
		self._vr = vrotation		
		return self
	end
	function self:set_scale(smin,smax)
		self._scale:set_min_max(smin,smax)
		return self
	end
	function self:set_alpha(amin,amax)
		self._alpha:set_min_max(amin,amax)
		return self
	end
	function self:set_velocity(vx,vy,vz)
		self._velocity:set(vx,vy,vz)
		return self
	end
	function self:set_acceleration(ax,ay,az)
		self._acceleration:set(ax,ay,az)
		return self
	end	
	
	--[[Override--]] function self:update(dt_scale, _game)
		self._anim_t = self._anim_t + self._tick_incr * dt_scale
		self._position:add_scaled(self._velocity, dt_scale)
		self._velocity:add_scaled(self._acceleration, dt_scale)
		self._r = self._r + self._vr * dt_scale
		
		self:update_visual()	
	end
	
	function self:update_visual()
		self._effect_obj:set_position(
			self._position._x,
			self._position._y,
			self._position._z
		)		
		
		self._effect_obj:set_alpha(
			CurveUtil:Lerp(
				self._alpha._min, 
				self._alpha._max, 
				self._anim_t
			)
		)
		self._effect_obj:set_rotation(
			self._r
		)
		self._effect_obj:set_scale(
			CurveUtil:Lerp(
				self._scale._min, 
				self._scale._max, 
				self._anim_t
			)
		)
	end	
	
	--[[Override--]] function self:add_to_parent(parent, _game)
		self._effect_obj:add_to_parent(parent, _game)
	end
	--[[Override--]] function self:should_remove(_game)
		return self._anim_t >= 1
	end	
	--[[Override--]] function self:do_remove(_game)
		self._effect_obj:do_remove(_game)
		self._effect_obj = nil
	end		
	
	self:cons()
	return self
end

return ConfigAnimEffect
