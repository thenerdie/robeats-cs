local SPList = require(game.ReplicatedStorage.Shared.SPList)

local EffectSystem = {}

function EffectSystem:new(game_element)
	local self = {}	
	
	self._effect_root = Instance.new("Folder",game_element.Parent)
	self._effect_root.Name = "EffectRoot"
	self._effects = SPList:new();	
	
	function self:cons()
	end
	
	function self:teardown(_game)
		for i=self._effects:count(),1,-1 do
			local itr_effect = self._effects:get(i)
			itr_effect:do_remove(_game)
		end
		self._effects:clear()
		self._effect_root:Destroy()
		self = nil
	end
	
	function self:update(dt_scale, _game)
		for i=self._effects:count(),1,-1 do
			local itr_effect = self._effects:get(i)
			itr_effect:update(dt_scale, _game)
			if itr_effect:should_remove(_game) then
				itr_effect:do_remove(_game)
				self._effects:remove_at(i)
			end
		end
	end
		
	function self:add_effect(effect)
		effect:add_to_parent(self._effect_root)
		self._effects:push_back(effect)
		return effect
	end	
	
	self:cons()	
	return self
end

function EffectSystem:EffectBase()
	local self = {}
	
	function self:add_to_parent(parent, _game) error("EffectBase must implement add_to_parent") end
	function self:update(dt_scale, _game) error("EffectBase must implement update") end	
	function self:should_remove(_game) error("EffectBase must implement should_remove") end	
	function self:do_remove(_game) error("EffectBase must implement do_remove") end	
	
	return self
end

return EffectSystem
