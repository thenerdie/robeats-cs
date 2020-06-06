local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPUISystem = require(game.ReplicatedStorage.Shared.SPUISystem)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local CycleElementBase = require(game.ReplicatedStorage.Menu.CycleElementBase)
local SPVector = require(game.ReplicatedStorage.Shared.SPVector)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local SPUIDisplay = {}

function SPUIDisplay:new(_obj,_spui)
	local self = SPUISystem:SPUIObjectBase()
	
	function self:get_part() return _obj.PrimaryPart end	
	
	local _scale = Vector3.new(1,1,1)
	function self:set_scale(x,y)
		_scale = Vector3.new(x,y,1)
		return self
	end	
	
	local _rotation = 0
	
	local _position_nxy = SPVector:new(0.5,0.5)
	local _anchor_rnxy = SPVector:new(0.5,0.5)
	function self:set_position_nxy(pnx,pny)
		_position_nxy:set(pnx,pny)
		return self
	end
	function self:get_position_nxy() return _position_nxy end	
	
	function self:set_anchor_rnxy(ornx,orny)
		_anchor_rnxy:set(ornx,orny)
		return self	
	end
	
	local _position_offset_xy = SPVector:new(0,0)
	function self:set_position_offset_xy(pox,poy)
		_position_offset_xy:set(pox,poy)
		return self
	end
	function self:get_position_offset_xy() return _position_offset_xy end
	
	function self:cons()
		self._native_size = self:get_part().Size
		self._size = self:get_part().Size
		self:layout()
	end
	
	local _do_autosize_calc = false
	function self:do_autosize_calc(val)
		_do_autosize_calc = val
		return self
	end
	
	function self:layout()
		if _do_autosize_calc == true then
			self:get_part().Size = self._native_size * _scale
		end		
		
		_obj:SetPrimaryPartCFrame(_spui:get_cframe({
			PositionNXY = Vector2.new(_position_nxy._x,_position_nxy._y);
			OffsetXYZ = self:anchored_offset(_anchor_rnxy._x,_anchor_rnxy._y) + Vector3.new(_position_offset_xy._x,_position_offset_xy._y,0);
			LocalRotationOffset = Vector3.new(0,0,_rotation);
		}))
		
		if _do_autosize_calc == true then
			self._size = self:get_part().Size
		end
	end
	
	--[[Override--]] function self:get_native_size()
		return self._native_size
	end
	--[[Override--]] function self:get_size()
		return self._size
	end
	--[[Override--]] function self:set_size(size) 
		self._size = size
		self:get_part().Size = Vector3.new(size.X,size.Y,0.2)
	end	
	--[[Override--]] function self:get_pos()
		return self:get_part().Position
	end	
	--[[Override--]] function self:get_sgui()
		DebugOut:errf("SPUIButton get_sgui not implemented")
		return nil
	end
	
		
	self:cons()
	return self
end

return SPUIDisplay
