local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPList = require(game.ReplicatedStorage.Shared.SPList)
local SPUISystem = require(game.ReplicatedStorage.Shared.SPUISystem)
local MenuBase = require(game.ReplicatedStorage.Menu.MenuBase)
local SPUIChild = require(game.ReplicatedStorage.Shared.SPUIChild)
local SPUIChildButton = require(game.ReplicatedStorage.Menu.SPUIChildButton)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)
local PropChange = require(game.ReplicatedStorage.Shared.PropChange)
local SFXManager = require(game.ReplicatedStorage.Local.SFXManager)

local PopupMessageUI = {}
PopupMessageUI.Type = "PopupMessageUI"

function PopupMessageUI:new(_local_services,_spui,_menus)
	local self = MenuBase:new(_spui,_menus)
	self.Type = PopupMessageUI.Type

	local _obj = nil

	local _alpha = 1
	local _scale = 1

	local _close_button = nil
	local _on_close_fn = nil

	local _prop_changes = PropChange.List:new()

	function self:cons()
		_obj = game.ReplicatedStorage.LobbyElementProtos.WorldUIProto.PopupMessageV2UI:Clone()
		_obj.Parent = game.Workspace.WorldUI

		self._native_size = _obj.PrimaryPart.Size
		self._size = self._native_size

		_close_button = self:add_cycle_element(_local_services, 1, SPUIChildButton:new(
			SPUIChild:new(self, _obj.PrimaryPart, _obj.BackButtonSurface),
			_spui,
			function() self:on_back_button() end
		))

		_prop_changes:add(PropChange:new(function()
			return SPUtil:tra(_obj.MainSurface.SurfaceGui.Frame.Title.BackgroundTransparency)
		end, function(updated_alpha)
			local setval = updated_alpha * 0.35
			_obj.MainSurface.SurfaceGui.Frame.Title.BackgroundTransparency = SPUtil:tra(setval)
			_obj.MainSurface.SurfaceGui.Frame.Sub.BackgroundTransparency = SPUtil:tra(setval)
		end))

		self:reset_selected_item()
		self:transition_update_visual(0)
		self:layout()
	end

	function self:set_on_close_fn(fn)
		_on_close_fn = fn
		return self
	end

	function self:set_close_button_visible(val)
		_close_button:set_visible(val)
		return self
	end

	--[[Override--]] function self:do_remove(_local_services)
		_obj:Destroy()
	end

	function self:set_text(title,sub)
		_obj.MainSurface.SurfaceGui.Frame.Title.TextLabel.Text = title
		_obj.MainSurface.SurfaceGui.Frame.Sub.TextLabel.Text = sub
		return self
	end

	function self:on_back_button()
		_menus:remove_menu(self)
		_local_services._sfx_manager:play_sfx(SFXManager.SFX_MENU_CLOSE)
		if _on_close_fn ~= nil then
			_on_close_fn()
			_on_close_fn = nil
		end
	end

	--[[Override--]] function self:visual_update(dt_scale, _local_services)
		self:visual_update_base(dt_scale,_local_services)
		_prop_changes:force_update()
	end

	--[[Override--]] function self:layout()
		_spui:uiobj_rescale_to_max_nxy(self, 0.85, 0.75,_scale)
		_obj:SetPrimaryPartCFrame(_spui:get_cframe({
			PositionNXY = Vector2.new(0.5,0.5);
			OffsetXYZ = self:anchored_offset(0.5,0.5);
			LocalRotationOffset = Vector3.new(0,0,0);
		}))
	end

	--[[Override--]] function self:set_alpha(val)
		if _alpha ~= val then
			_alpha = val
			SPUtil:r_set_alpha(_obj,_alpha)
		end
	end
	--[[Override--]] function self:get_alpha() return _alpha end
	--[[Override--]] function self:set_scale(val) _scale = val end
	--[[Override--]] function self:get_scale() return _scale end

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

return PopupMessageUI
