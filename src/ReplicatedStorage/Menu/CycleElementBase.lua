local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPMultiDict = require(game.ReplicatedStorage.Shared.SPMultiDict)
local SPList = require(game.ReplicatedStorage.Shared.SPList)
local SPUISystem = require(game.ReplicatedStorage.Shared.SPUISystem)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local CycleElementBase = {}
function CycleElementBase:new()
	local self = SPUISystem:SPUIObjectBase()
	
	function self:set_selected(_local_services, val) end
	function self:trigger_element(_local_services) end
	function self:update(dt_scale, _local_services) end
	function self:get_selected() return false end
	function self:trigger_element(_local_services) end
	
	function self:is_selectable() return true end
	
	--From SPUISystem:SPUIObjectBase
	function self:get_native_size() end
	function self:get_size() end
	function self:set_size(size) end	
	function self:get_pos() end	
	function self:get_sgui() end
	
	return self	
end

return CycleElementBase