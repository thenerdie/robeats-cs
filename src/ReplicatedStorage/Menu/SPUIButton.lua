local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPUISystem = require(game.ReplicatedStorage.Shared.SPUISystem)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local CycleElementBase = require(game.ReplicatedStorage.Menu.CycleElementBase)
local SPVector = require(game.ReplicatedStorage.Shared.SPVector)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local SPUIButton = {}

function SPUIButton:new(_obj,_spui,_callback)
	local self = CycleElementBase:new()

	local _selected = false

	local _selected_anim_t = 0
	local _trigger_scale_offset = 0

	local _scale = 1
	local _rotation = 0

	local _auto_zoffset_behaviour = true
	function self:set_auto_zoffset_behaviour(val)
		_auto_zoffset_behaviour = val
		return self
	end

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
	function self:get_position_offset_xy() return _position_offset_xy end
	function self:set_position_offset_xy(pox,poy)
		_position_offset_xy:set(pox,poy)
		return self
	end

	local _has_max_nxy = false
	local _max_nxy = SPVector:new(0,0)
	function self:set_max_nxy(max_nx,max_ny)
		_has_max_nxy = true
		_max_nxy:set(max_nx,max_ny)
		return self
	end

	local _pre_layout_fn = nil
	function self:get_pre_layout_fn() return _pre_layout_fn end
	function self:set_pre_layout_fn(fn) _pre_layout_fn = fn fn() return self end

	function self:cons()
		self._native_size = _obj.PrimaryPart.Size
		self._size = _obj.PrimaryPart.Size
		self:layout()
	end

	function self:layout()
		if _has_max_nxy == true then
			_spui:uiobj_rescale_to_max_nxy(self, _max_nxy._x, _max_nxy._y, _scale)
		else
			_obj.PrimaryPart.Size = self._native_size * _scale
		end
		self._size = _obj.PrimaryPart.Size

		if _pre_layout_fn ~= nil then
			_pre_layout_fn()
		end

		_obj:SetPrimaryPartCFrame(_spui:get_cframe({
			PositionNXY = Vector2.new(_position_nxy._x,_position_nxy._y);
			OffsetXYZ = self:anchored_offset(_anchor_rnxy._x,_anchor_rnxy._y) + Vector3.new(_position_offset_xy._x,_position_offset_xy._y,0);
			LocalRotationOffset = Vector3.new(0,0,_rotation);
		}))
	end

	local _selectable = true
	function self:set_selectable(val)
		_selectable = val
		return self
	end

	local _rotation_amplitude = 10
	function self:set_selected_rotation_amplitude(val)
		_rotation_amplitude = val
		return self
	end

	local _tar_scale = 1.25
	function self:set_selected_tar_scale(val)
		_tar_scale = val
		return self
	end

	local _has_passive_anim = false
	function self:set_passive_anim()
		_has_passive_anim = true
		return self
	end

	--[[Override--]] function self:update(dt_scale, _local_services)
		local tar_scale = 1
		local tar_rotation = 0
		if _selected == true and _selectable == true then
			tar_scale = _tar_scale
			tar_rotation = math.sin(_selected_anim_t) * _rotation_amplitude
			_selected_anim_t = CurveUtil:IncrementWrap(_selected_anim_t, 0.05 * dt_scale, math.pi * 2)

		elseif _has_passive_anim == true then
			tar_rotation = math.sin(_selected_anim_t) * _rotation_amplitude * 0.5
			_selected_anim_t = CurveUtil:IncrementWrap(_selected_anim_t, 0.025 * dt_scale, math.pi * 2)

		end

		if _auto_zoffset_behaviour == true then
			local surfacegui_child = _obj.PrimaryPart:FindFirstChild("SurfaceGui")
			if surfacegui_child ~= nil then
				if _selected then
					surfacegui_child.ZOffset = 500
				else
					surfacegui_child.ZOffset = 0
				end
			end
		end

		tar_scale = tar_scale + _trigger_scale_offset


		_trigger_scale_offset = CurveUtil:Expt(
			_trigger_scale_offset,
			0,
			CurveUtil:NormalizedDefaultExptValueInSeconds(0.5),
			dt_scale
		)

		_scale = CurveUtil:Expt(
			_scale,
			tar_scale,
			CurveUtil:NormalizedDefaultExptValueInSeconds(0.5),
			dt_scale
		)
		_rotation = CurveUtil:Expt(
			_rotation,
			tar_rotation,
			CurveUtil:NormalizedDefaultExptValueInSeconds(0.5),
			dt_scale
		)

		self:layout()
	end

	--[[Override--]] function self:is_selectable()
		return _selectable
	end

	--[[Override--]] function self:get_selected()
		return _selected
	end

	--[[Override--]] function self:trigger_element(_local_services)
		_callback()
		_trigger_scale_offset = _trigger_scale_offset + 1
	end

	--[[Override--]] function self:set_selected(_local_services, selected)
		_selected = selected
	end

	--[[Override--]] function self:get_native_size()
		return self._native_size
	end
	--[[Override--]] function self:get_size()
		return self._size
	end
	--[[Override--]] function self:set_size(size)
		self._size = size
		_obj.PrimaryPart.Size = Vector3.new(size.X,size.Y,0.2)
	end
	--[[Override--]] function self:get_pos()
		return _obj.PrimaryPart.Position
	end
	--[[Override--]] function self:get_sgui()
		return _obj.PrimaryPart.SurfaceGui
	end


	self:cons()
	return self
end

return SPUIButton
