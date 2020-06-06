local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPMultiDict = require(game.ReplicatedStorage.Shared.SPMultiDict)
local SPList = require(game.ReplicatedStorage.Shared.SPList)
local SPUISystem = require(game.ReplicatedStorage.Shared.SPUISystem)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local InputUtil = require(game.ReplicatedStorage.Shared.InputUtil)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local MenuSystem = {}

MenuSystem.INPUT_MODE_CURSOR = 1
MenuSystem.INPUT_MODE_PAD = 2

MenuSystem.MODE_TRANSITION_IN = 0
MenuSystem.MODE_OPEN = 1
MenuSystem.MODE_TRANSITION_OUT = 2
MenuSystem.MODE_HIDDEN = 3

function MenuSystem:new()
	local self = {}	
	
	local _menu_stack = SPList:new()
	local _closing_menus = SPList:new()
	local _input_mode = MenuSystem.INPUT_MODE_PAD
	function self:get_input_mode() return _input_mode end
	
	function self:menu_count()
		return _menu_stack:count()
	end	
	
	function self:push_menu(menu)
		_menu_stack:push_back(menu)
		return menu
	end
	
	function self:contains_menu(menu)
		for i=1,_menu_stack:count() do
			if _menu_stack:get(i) == menu then
				return true
			end
		end
		return false
	end
	
	function self:remove_menu(menu)
		local target = nil
		for i=_menu_stack:count(),1,-1 do
			local itr_menu = _menu_stack:get(i)
			if itr_menu == menu then
				target = itr_menu
				_menu_stack:remove_at(i)
				i = -1
			end
		end
		if target == nil then
			return
		end
		target:set_is_top_element(false)
		_closing_menus:push_back(target)
	end
	
	function self:remove_all_menus()
		for i=_menu_stack:count(),1,-1 do
			local itr_menu = _menu_stack:get(i)
			_menu_stack:remove_at(i)
			
			itr_menu:set_is_top_element(false)
			_closing_menus:push_back(itr_menu)
		end
	end
	
	function self:update(dt_scale, _local_services)
		if _local_services._input:get_cursor_delta():magnitude() > 0.05 then
			_input_mode = MenuSystem.INPUT_MODE_CURSOR
			
		elseif _local_services._input:control_just_pressed(InputUtil.KEY_UP) or 
			_local_services._input:control_just_pressed(InputUtil.KEY_DOWN) or
			_local_services._input:control_just_pressed(InputUtil.KEY_LEFT) or
			_local_services._input:control_just_pressed(InputUtil.KEY_RIGHT) or
			_local_services._input:control_just_pressed(InputUtil.KEY_MENU_ENTER) or
			_local_services._input:control_just_pressed(InputUtil.KEY_MENU_BACK) or
			_local_services._input:control_just_pressed(InputUtil.KEY_MENU_OPEN)
			then			
			
			_input_mode = MenuSystem.INPUT_MODE_PAD
		end
		
		for i=_closing_menus:count(),1,-1 do
			local itr_menu = _closing_menus:get(i)
			itr_menu:visual_update(dt_scale, _local_services)
			if itr_menu._current_mode == MenuSystem.MODE_HIDDEN then
				itr_menu:do_remove(_local_services)
				_closing_menus:remove_at(i)
			end
		end

		if _menu_stack:count() > 0 then
			_menu_stack:back():behaviour_update(dt_scale,_local_services)
		end
		for i=_menu_stack:count(),1,-1 do
			local itr_menu = _menu_stack:get(i)
			if i == _menu_stack:count() then
				itr_menu:set_is_top_element(true)
			else
				itr_menu:set_is_top_element(false)
			end
			
			itr_menu:visual_update(dt_scale, _local_services)
		end		
	end
	
	function self:get_top_element()
		return _menu_stack:back()
	end
	
	return self
end

return MenuSystem
