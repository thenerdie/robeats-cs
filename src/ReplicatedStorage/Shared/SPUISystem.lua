local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPVector = require(game.ReplicatedStorage.Shared.SPVector)
local SPRect = require(game.ReplicatedStorage.Shared.SPRect)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local SPUISystem = {}

function SPUISystem:SPUIObjectBase()
	local self = {}	
	
	function self:get_native_size() DebugOut:errf("NOIMPL") return Vector2.new() end
	function self:get_size() DebugOut:errf("NOIMPL") return Vector2.new() end
	function self:set_size(size) DebugOut:errf("NOIMPL") end
	function self:get_pos() DebugOut:errf("NOIMPL") return Vector3.new() end
	function self:get_sgui() DebugOut:errf("NOIMPL") return nil end	
	
	function self:anchored_offset_from_size(nx,ny,size)
		return Vector3.new(
			-(nx - 0.5) * size.X,
			(ny - 0.5) * size.Y,
			0
		)
	end	
	
	function self:anchored_offset(nx,ny)
		return self:anchored_offset_from_size(nx,ny,self:get_size())
	end
	
	local _get_nbounds = SPRect:new(0,0,0,0)
	function self:get_nrect(spui)
		local center_nxy = spui:get_nxy_from_pos(self:get_pos())
		local size_nxy = spui:uiobj_get_size_nxy(self)	
		_get_nbounds:set_centerxy_wid_hei(
			center_nxy.X,
			center_nxy.Y,
			size_nxy.X,
			size_nxy.Y
		)
		return _get_nbounds
	end
	
	local __calc_offset = SPVector:new()
	local __calc_size = SPVector:new()
	function self:uichild_get_nbounds(spui, uichild)
		local tar_sgui = self:get_sgui()
		local sgui_size = tar_sgui.CanvasSize
		__calc_offset:set(0,0)
		__calc_size:set(uichild.Size.X.Offset,uichild.Size.Y.Offset)
		local itrchild = uichild
		
		__calc_offset._x = __calc_offset._x - itrchild.AnchorPoint.X * itrchild.AbsoluteSize.X
		__calc_offset._y = __calc_offset._y - itrchild.AnchorPoint.Y * itrchild.AbsoluteSize.Y
		
		while itrchild ~= tar_sgui and itrchild ~= nil do
			__calc_offset._x = __calc_offset._x + itrchild.Position.X.Offset		
			__calc_offset._y = __calc_offset._y + itrchild.Position.Y.Offset
			
			local parent = itrchild.Parent			
			local parent_absolute_size = parent.AbsoluteSize
			__calc_offset._x = __calc_offset._x + parent_absolute_size.X * itrchild.Position.X.Scale
			__calc_offset._y = __calc_offset._y + parent_absolute_size.Y * itrchild.Position.Y.Scale
			
			itrchild = parent
		end
		
		local rtv = self:get_nrect(spui)
		
		local npct_x1 = __calc_offset._x / sgui_size.X
		local npct_x2 = (__calc_offset._x + __calc_size._x) / sgui_size.X
		local npct_y1 = __calc_offset._y / sgui_size.Y
		local npct_y2 = (__calc_offset._y + __calc_size._y) / sgui_size.Y
			
		rtv:set(
			CurveUtil:Lerp(rtv._x1,rtv._x2,npct_x1),
			CurveUtil:Lerp(rtv._y1,rtv._y2,npct_y1),
			CurveUtil:Lerp(rtv._x1,rtv._x2,npct_x2),
			CurveUtil:Lerp(rtv._y1,rtv._y2,npct_y2)
		)
		return rtv
	end
	
	return self
end

function SPUISystem:new(distance_from_camera)
	local self = {}	
	
	self._normal_dir = Vector3.new()
	self._screen_tl_pos = Vector3.new()
	self._screen_tr_pos = Vector3.new()
	self._screen_bl_pos = Vector3.new()
	self._screen_br_pos = Vector3.new()
	
	local __nxy_intermediates_dirty = true	
	
	function self:layout(tmp)
		if tmp == true then
			return
		end			
		
		local screencenter_nontopbar_x, screencenter_nontopbar_y = SPUtil:nxy_to_nontopbar_screen_pos(0.5,0.5)
		local screen_center_ray = game.Workspace.Camera:ScreenPointToRay(
			screencenter_nontopbar_x, screencenter_nontopbar_y
		)
		
		self._normal_dir = screen_center_ray.Direction * -1
		
		local center_position = screen_center_ray.Origin + (screen_center_ray.Direction.Unit * distance_from_camera)	
			
		local function get_nxy_position(nx,ny)
			local screen_corner_position = nil	
			
			local nontopbar_x,nontopbar_y = SPUtil:nxy_to_nontopbar_screen_pos(nx,ny)
			local screen_corner_ray = game.Workspace.Camera:ScreenPointToRay(
				nontopbar_x,nontopbar_y
			)			
			
			local intersect, pt = SPUtil:plane_intersect(
				screen_corner_ray.Origin, 
				screen_corner_ray.Direction.Unit, 
				center_position,
				self._normal_dir
			)
			if intersect then 
				return pt
			else
				DebugOut:puts("SPUISystem ERR(update_from_localcamera) no intersect")
				return center_position
			end
		end
		
		self._screen_tl_pos = get_nxy_position(0,0)
		self._screen_tr_pos = get_nxy_position(1,0)
		self._screen_bl_pos = get_nxy_position(0,1)
		self._screen_br_pos = get_nxy_position(1,1)
		
		__nxy_intermediates_dirty = true
	end
	
	function self:get_normal_dir()
		return self._normal_dir
	end
	function self:get_up_dir()
		return (self._screen_br_pos - self._screen_tr_pos).Unit * -1
	end
	
	local __screen_topbar_ui_y_pct = 0
	local __tl_tr = Vector2.new()
	local __bl_br = Vector2.new()
	local __tl_bl = Vector2.new()
	
	function self:get_pos_from_nxy(nx,ny)	
		if __nxy_intermediates_dirty == true then
			__tl_tr = self._screen_tr_pos - self._screen_tl_pos
			__bl_br = self._screen_br_pos - self._screen_bl_pos
			__tl_bl = self._screen_bl_pos - self._screen_tl_pos
			
			__nxy_intermediates_dirty = false
		end
		
		local x_cmp = (__tl_tr * nx * (1-ny)) + (__bl_br * nx * (ny))
		local y_cmp = __tl_bl * ny			
		return x_cmp + 	y_cmp + self._screen_tl_pos	
		
		--[[
		--UNOPTIMIZED VERSION
		--screen_pos is a parallelogram, bilinear interpolate the y coordinate
		--interpolating the x coordinate seems to break stuff, don't know why
		local tl_tr = (self._screen_tr_pos - self._screen_tl_pos) * nx
		local bl_br = (self._screen_br_pos - self._screen_bl_pos) * nx
		local x_cmp = (tl_tr * (1-ny)) + (bl_br * (ny))
		local tl_bl = self._screen_bl_pos - self._screen_tl_pos		
		return x_cmp + 	(tl_bl) * ny + self._screen_tl_pos	
		]]--
	end
	
	function self:get_nxy_from_pos(pos)
		return SPUtil:pos_to_nxy(pos) --Vector2
	end
	
	function self:get_rotation_cframe()
		return CFrame.new(Vector3.new(0,0,0), self._normal_dir)
	end
	
	function self:get_cframe(params)
		if params == nil then params = {} end
		if params.PositionNXY == nil then params.PositionNXY = Vector2.new(0.5,0.5) end
		if params.OffsetXYZ == nil then params.OffsetXYZ = Vector3.new(0,0,0) end
		if params.LocalRotationOffset == nil then params.LocalRotationOffset = Vector3.new() end
		
		params.OffsetXYZ = Vector3.new(-params.OffsetXYZ.X, params.OffsetXYZ.Y, params.OffsetXYZ.Z)
		
		local center = self:get_pos_from_nxy(
			params.PositionNXY.X,
			params.PositionNXY.Y
		)
		return 
			CFrame.new(center, center + self._normal_dir) * 
			CFrame.new(params.OffsetXYZ.X, params.OffsetXYZ.Y, params.OffsetXYZ.Z) *
			CFrame.Angles(
				SPUtil:deg_to_rad(params.LocalRotationOffset.X),
				SPUtil:deg_to_rad(params.LocalRotationOffset.Y),
				SPUtil:deg_to_rad(params.LocalRotationOffset.Z)
			)
	end
	
	function self:get_size_from_nxy(nx,ny)
		return Vector2.new(
			(self:get_pos_from_nxy(1,1) - self:get_pos_from_nxy(0,1)).Magnitude * nx,
			(self:get_pos_from_nxy(1,1) - self:get_pos_from_nxy(1,0)).Magnitude * ny
		)
	end	
	
	function self:uiobj_rescale_to_max_nxy(uiobj, max_nx, max_ny, scale_mult)
		if scale_mult == nil then scale_mult = 1 end		
		
		local uiobj_size = uiobj:get_native_size()
		local screen_size = self:get_size_from_nxy(1,1)
		
		local xover_ratio = uiobj_size.X / (screen_size.X * max_nx)
		local yover_ratio = uiobj_size.Y / (screen_size.Y * max_ny)
		
		if xover_ratio < 1 and yover_ratio < 1 then
			uiobj:set_size(uiobj:get_native_size() * scale_mult)
			return
		end
		
		local tarover_ratio = math.max(xover_ratio,yover_ratio)
		
		uiobj:set_size(uiobj:get_native_size() * (1.0 / tarover_ratio) * scale_mult)
	end	
	
	function self:get_xy_basis()
		local x_basis = self:get_up_dir():Cross(
			self:get_normal_dir()
		).Unit
		local y_basis = self:get_normal_dir():Cross(x_basis).Unit
		return x_basis, y_basis	
	end
	
	function self:uiobj_get_size_nxy(uiobj)
		local uiobj_size = uiobj:get_size()
		local screen_size = self:get_size_from_nxy(1,1)
		return Vector2.new(
			uiobj_size.X / screen_size.X,
			uiobj_size.Y / screen_size.Y
		)
	end
	
	function self:get_cursor_nxy()
		local mouse = game.Players.LocalPlayer:GetMouse()
		local nx,ny = SPUtil:nontopbar_screen_pos_to_nxy(mouse.X,mouse.Y)		
		return Vector2.new(nx,ny)
	end
	
	self:layout()
	return self
end

function SPUISystem:part_get_front_xy_basis(part)
	return part.CFrame.rightVector * -1, part.CFrame.upVector
end

return SPUISystem
