local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPUISystem = require(game.ReplicatedStorage.Shared.SPUISystem)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local CycleElementBase = require(game.ReplicatedStorage.Menu.CycleElementBase)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local SPUIChildButton = {}

function SPUIChildButton:new(_uichild,_spui,_callback)
	local self = CycleElementBase:new()

	local _part = _uichild:get_child_part()
	function self:get_part() return _part end
	local _selected = false

	local _selected_anim_t = SPUtil:rand_rangef(0,3.14*2)
	local _trigger_scale_offset = 0

	local _raise_trigger_element = false

	local _enabled_anim_updatefn = nil
	local _enabled_anim_t = 1
	local _enabled = true

	function self:cons()
		self:layout()
	end

	function self:layout()
		_uichild:layout()
		self._native_size = _part.Size
		self._size = self._native_size
	end

	function self:set_enabled_anim_updatefn(enabled_anim_updatefn)
		_enabled_anim_updatefn = enabled_anim_updatefn
		return self
	end

	function self:set_enabled(val,imm)
		if val == false then
			_selected = false
			if imm == true then
				_enabled_anim_t = 0
			end
		end
		_enabled = val
		return self
	end

	function self:set_visible(val)
		if val == true then
			_part.SurfaceGui.Enabled = true
		else
			_part.SurfaceGui.Enabled = false
		end
		self:set_enabled(val)
		return self
	end

	local _rotation_amplitude = 2.5
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

	local _scale = 1
	function self:set_scale(val)
		_scale = val
		return self
	end

	local __last_enabled_anim_t = -1
	--[[Override--]] function self:update(dt_scale, _local_services)
		local tar_scale = _scale
		local tar_rotation = 0
		if _selected == true then
			tar_scale = tar_scale * _tar_scale
			tar_rotation = math.sin(_selected_anim_t) * _rotation_amplitude
			_selected_anim_t = CurveUtil:IncrementWrap(_selected_anim_t, 0.05 * dt_scale, math.pi * 2)

		elseif _has_passive_anim == true then
			tar_rotation = math.sin(_selected_anim_t) * _rotation_amplitude * 0.5
			_selected_anim_t = CurveUtil:IncrementWrap(_selected_anim_t, 0.05 * dt_scale, math.pi * 2)
		end
		tar_scale = tar_scale + _trigger_scale_offset

		_trigger_scale_offset = CurveUtil:Expt(
			_trigger_scale_offset,
			0,
			CurveUtil:NormalizedDefaultExptValueInSeconds(0.5),
			dt_scale
		)

		_uichild:set_scale(CurveUtil:Expt(
			_uichild:get_scale(),
			tar_scale,
			CurveUtil:NormalizedDefaultExptValueInSeconds(0.5),
			dt_scale
		))
		_uichild:set_rotation_z(CurveUtil:Expt(
			_uichild:get_rotation().Z,
			tar_rotation,
			CurveUtil:NormalizedDefaultExptValueInSeconds(0.5),
			dt_scale
		))

		if _enabled == true then
			_enabled_anim_t = CurveUtil:Expt(_enabled_anim_t,1,CurveUtil:exptvsec(0.5),dt_scale)
		else
			_enabled_anim_t = CurveUtil:Expt(_enabled_anim_t,0,CurveUtil:exptvsec(0.5),dt_scale)
		end

		if __last_enabled_anim_t ~= _enabled_anim_t and _enabled_anim_updatefn ~= nil then
			_enabled_anim_updatefn(_enabled, _enabled_anim_t)
		end

		__last_enabled_anim_t = _enabled_anim_t

		self:layout()
	end

	--[[Override--]] function self:get_selected()
		return _selected
	end

	--[[Override--]] function self:trigger_element(_local_services)
		_local_services._input:clear_just_pressed_keys()
		_callback()
		_trigger_scale_offset = _trigger_scale_offset + 1
		_raise_trigger_element = true
	end

	function self:did_raise_trigger_element()
		local rtv = _raise_trigger_element
		_raise_trigger_element = false
		return rtv
	end

	--[[Override--]] function self:is_selectable()
		return _enabled
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
		_part.Size = Vector3.new(size.X,size.Y,0.2)
	end
	--[[Override--]] function self:get_pos()
		return _part.Position
	end
	--[[Override--]] function self:get_sgui()
		DebugOut:errf("SPUIButton get_sgui not implemented")
		return nil
	end

	local _alpha = 1
	function self:set_alpha(val)
		_alpha = val
		return self
	end
	function self:get_alpha() return _alpha end

	self:cons()
	return self
end

return SPUIChildButton
