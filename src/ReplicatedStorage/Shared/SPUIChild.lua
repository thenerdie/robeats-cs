local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPUISystem = require(game.ReplicatedStorage.Shared.SPUISystem)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local SPUIChild = {}

function SPUIChild:new(
	_parent_ui_obj,
	_parent_part,
	_child_part)

	local self = SPUISystem:SPUIObjectBase()

	self._localscale_x = 1
	self._localscale_y = 1
	self._localrotation = Vector3.new(0,0,0)
	self._child_native_basis_offset = Vector2.new(0,0)
	self._child_native_size = nil

	function self:cons()
		self._child_native_size = _child_part.Size
		self:update_basis_offset()
	end

	--[[Override--]] function self:get_native_size() return self._child_native_size end
	--[[Override--]] function self:get_size() return _child_part.Size end
	--[[Override--]] function self:set_size(size) DebugOut:errf("SPUIChild Cannot set size") end
	--[[Override--]] function self:get_pos() return _child_part.Position end

	function self:get_child_part()
		return _child_part
	end

	function self:update_basis_offset()
		local x_basis, y_basis = SPUISystem:part_get_front_xy_basis(_parent_part)
		local w_pos_delta = (_child_part.Position - _parent_part.Position)

		self._child_native_basis_offset = Vector2.new(
			w_pos_delta:Dot(x_basis),
			w_pos_delta:Dot(y_basis)
		)
	end

	function self:set_position(pos)
		_child_part.Position = pos
		self:update_basis_offset()
	end

	function self:get_position()
		return _child_part.Position
	end

	function self:set_scale(val)
		self._localscale_x = val
		self._localscale_y = val
		return self
	end
	function self:set_scale_x(val) self._localscale_x = val end
	function self:set_scale_y(val) self._localscale_y = val end

	function self:get_scale()
		return self._localscale_x
	end

	function self:get_rotation()
		return self._localrotation
	end
	function self:set_rotation_x(val)
		self._localrotation = Vector3.new(val,self._localrotation.Y,self._localrotation.Z)
	end
	function self:set_rotation_z(val)
		self._localrotation = Vector3.new(self._localrotation.X,self._localrotation.Y,val)
	end
	function self:set_rotation(val)
		self._localrotation = Vector3.new(val)
	end

	function self:set_child_relative_xy(x,y)
		self._child_native_basis_offset = Vector2.new(
			x,
			y
		)
		return self
	end
	function self:get_child_relative_xy()
		return self._child_native_basis_offset
	end

	local _do_scale = true
	function self:set_do_scale(val)
		_do_scale = val
		return self
	end

	function self:layout()
		local scale = Vector2.new(
			_parent_ui_obj:get_size().X / _parent_ui_obj:get_native_size().X,
			_parent_ui_obj:get_size().Y / _parent_ui_obj:get_native_size().Y
		)

		if _do_scale then
			_child_part.Size = Vector3.new(
				self._child_native_size.X * scale.X * self._localscale_x,
				self._child_native_size.Y * scale.Y * self._localscale_y,
				0.2
			)
		end

		local x_basis, y_basis = SPUISystem:part_get_front_xy_basis(_parent_part)

		local x_basis_comp = x_basis * self._child_native_basis_offset.X * scale.X
		local y_basis_comp = y_basis * self._child_native_basis_offset.Y * scale.Y

		_child_part.CFrame = CFrame.new(_parent_part.Position + x_basis_comp + y_basis_comp) *
			SPUtil:angles_vec3(_parent_part.Rotation)	*
			SPUtil:angles_vec3(self._localrotation)

		return self
	end

	self:cons()
	return self
end

return SPUIChild
