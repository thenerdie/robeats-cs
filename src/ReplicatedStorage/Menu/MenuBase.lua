local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local SPMultiDict = require(game.ReplicatedStorage.Shared.SPMultiDict)
local SPList = require(game.ReplicatedStorage.Shared.SPList)
local SPUISystem = require(game.ReplicatedStorage.Shared.SPUISystem)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local InputUtil = require(game.ReplicatedStorage.Shared.InputUtil)
local MenuSystem = require(game.ReplicatedStorage.Menu.MenuSystem)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)

local MenuBase = {}

function MenuBase:new(_spui,_menu_system)
	local self = SPUISystem:SPUIObjectBase()
	
	self._current_mode = MenuSystem.MODE_TRANSITION_IN
	self._transition_t = 0
	self._transition_incr = CurveUtil:NormalizedDefaultExptValueInSeconds(1.0)	
	
	function self:do_remove(_local_services) end	
	
	function self:visual_update(dt_scale, _local_services) self:visual_update_base(dt_scale,_local_services) end
	function self:behaviour_update(dt_scale, _local_services) self:behaviour_update_base(dt_scale,_local_services) end	
	function self:swallows_input() return true end	
	
	function self:set_alpha(val) end
	function self:get_alpha() return 1 end
	function self:set_scale(val) end
	function self:get_scale() return 1 end	
	
	function self:layout() end
	
	function self:visual_update_base(dt_scale, _local_services)
		self:transition_update(dt_scale,_local_services)
		self:layout()
		self:update_cycle_elements(dt_scale,_local_services)
	end
	function self:behaviour_update_base(dt_scale, _local_services)
		if self._current_mode == MenuSystem.MODE_OPEN then
			self:update_default_cycle_element_behaviour(dt_scale,_local_services)
		end
	end
	
	function self:set_is_top_element(val)
		if val then
			if self._current_mode == MenuSystem.MODE_TRANSITION_OUT or self._current_mode == MenuSystem.MODE_HIDDEN then
				self._current_mode = MenuSystem.MODE_TRANSITION_IN
				self._transition_t = 0
			end
		else
			if self._current_mode == MenuSystem.MODE_TRANSITION_IN or self._current_mode == MenuSystem.MODE_OPEN then
				self._current_mode = MenuSystem.MODE_TRANSITION_OUT
				self._transition_t = 0
			end
		end	
	end	
	
	function self:transition_update(dt_scale, _local_services)
		if self._current_mode == MenuSystem.MODE_TRANSITION_IN then
			self._transition_t = SPUtil:clamp(self._transition_t + self._transition_incr * dt_scale, 0, 1)
			if self._transition_t >= 1 then
				self._current_mode = MenuSystem.MODE_OPEN
			end			
			
		elseif self._current_mode == MenuSystem.MODE_OPEN then
			
		elseif self._current_mode == MenuSystem.MODE_TRANSITION_OUT then
			self._transition_t = SPUtil:clamp(self._transition_t + self._transition_incr * dt_scale, 0, 1)
			if self._transition_t >= 1 then
				self._current_mode = MenuSystem.MODE_HIDDEN
			end				
			
		end
		self:transition_update_visual(self._transition_t)
	end
	
	local __scale = -1
	local __alpha = -1
	function self:transition_update_visual(t)
		local tar_scale = 1
		local tar_alpha = 1
		if self._current_mode == MenuSystem.MODE_TRANSITION_IN then
			tar_scale = CurveUtil:YForPointOf2PtLine(Vector2.new(0,1.25), Vector2.new(1,1), self._transition_t)
			tar_alpha = CurveUtil:YForPointOf2PtLine(Vector2.new(0,0), Vector2.new(1,1), self._transition_t)
		elseif self._current_mode == MenuSystem.MODE_OPEN then
			tar_scale = 1
			tar_alpha = 1
		elseif self._current_mode == MenuSystem.MODE_TRANSITION_OUT then
			tar_scale = CurveUtil:YForPointOf2PtLine(Vector2.new(0,1), Vector2.new(1,1.25), self._transition_t)
			tar_alpha = CurveUtil:YForPointOf2PtLine(Vector2.new(0,1), Vector2.new(1,0), self._transition_t)
		elseif self._current_mode == MenuSystem.MODE_HIDDEN then
			tar_scale = 1.25
			tar_alpha = 0
		end	
		
		if tar_scale ~= __scale then
			__scale = tar_scale
			self:set_scale(__scale)			
		end	
		if tar_alpha ~= __alpha then
			__alpha = tar_alpha
			self:set_alpha(__alpha)
		end	
	end
		
	self._cycle_lists = SPMultiDict:new()
	self._cycle_list_horizontal_i = 1
	self._cycle_list_vertical_i = 1
	
	function self:get_cycle_list_selected_element()
		if self._cycle_lists:count_of(self._cycle_list_horizontal_i) < self._cycle_list_vertical_i then
			return nil
		end
		return self._cycle_lists:list_of(self._cycle_list_horizontal_i):get(self._cycle_list_vertical_i)
	end
	
	function self:reset_selected_item()
		self._cycle_list_horizontal_i = 1
		self._cycle_list_vertical_i = 1
	end
	
	function self:update_default_cycle_element_behaviour(dt_scale,_local_services)		
		if _local_services._menus:get_input_mode() == MenuSystem.INPUT_MODE_CURSOR then
			self:update_default_input_cursor_cycle_element_behaviour(dt_scale,_local_services)
		elseif _local_services._menus:get_input_mode() == MenuSystem.INPUT_MODE_PAD then
			self:update_default_input_pad_cycle_element_behaviour(dt_scale,_local_services)
		end				
	end
	
	function self:update_default_input_cursor_cycle_element_behaviour(dt_scale,_local_services)
		self:update_default_input_cursor_cycle_element_behaviour_base(dt_scale,_local_services)
	end	
	
	function self:update_default_input_cursor_cycle_element_behaviour_base(dt_scale,_local_services)
		local cursor_nxy = _spui:get_cursor_nxy()
		local found = false	
		
		local frame_selected_element = nil
		
		for i_h=1,self._cycle_lists:count() do
			local itr_list = self._cycle_lists:list_of(i_h)			
			for i_v=1,itr_list:count() do
				local itr = itr_list:get(i_v)
				
				local bounds = itr:get_nrect(_spui)
				if itr:is_selectable() and bounds:contains_vec2(cursor_nxy) then
					self._cycle_list_horizontal_i = i_h
					self._cycle_list_vertical_i = i_v
					
					frame_selected_element = itr			
				end
			end
		end		
		
		for i_h=1,self._cycle_lists:count() do
			local itr_list = self._cycle_lists:list_of(i_h)			
			for i_v=1,itr_list:count() do
				local itr = itr_list:get(i_v)
				
				if itr == frame_selected_element then
					itr:set_selected(_local_services, true)
				else
					itr:set_selected(_local_services, false)
				end
			end
		end
		
		if _local_services._input:control_just_pressed(InputUtil.KEY_CLICK) and frame_selected_element ~= nil then
			frame_selected_element:trigger_element(_local_services)
		end
	end	
	
	function self:update_default_input_pad_cycle_element_behaviour(dt_scale,_local_services)
		if _local_services._input:control_just_pressed(InputUtil.KEY_UP) then
			self:cycle_list_vertical(_local_services,-1)
		elseif _local_services._input:control_just_pressed(InputUtil.KEY_DOWN) then
			self:cycle_list_vertical(_local_services,1)			
		elseif _local_services._input:control_just_pressed(InputUtil.KEY_LEFT) then
			self:cycle_list_horizontal(_local_services,-1)			
		elseif _local_services._input:control_just_pressed(InputUtil.KEY_RIGHT) then
			self:cycle_list_horizontal(_local_services,1)
		end
		
		if _local_services._input:control_just_pressed(InputUtil.KEY_MENU_ENTER) then
			local selected_element = self:get_cycle_list_selected_element()
			if selected_element ~= nil then
				selected_element:trigger_element(_local_services)
			end				
			
		elseif _local_services._input:control_just_pressed(InputUtil.KEY_MENU_BACK) then
			--SPTODO: back
		end
	end
		
	function self:update_cycle_elements(dt_scale,_local_services)
		for i_h=1,self._cycle_lists:count() do
			local itr_list = self._cycle_lists:list_of(i_h)			
			for i_v=1,itr_list:count() do
				local itr = itr_list:get(i_v)
				itr:update(dt_scale,_local_services)
			end
		end
	end
	
	function self:add_cycle_element(_local_services,list_index,element)
		self._cycle_lists:push_back_to(list_index,element)
		if _menu_system:get_input_mode() == MenuSystem.INPUT_MODE_PAD then
			self:cycle_list_updated(_local_services)
		end
		return element
	end
	
	function self:remove_cycle_element(element)
		for i_h=1,self._cycle_lists:count() do
			local itr_list = self._cycle_lists:list_of(i_h)			
			itr_list:remove(element)
		end	
	end
	
	function self:cycle_list_updated(_local_services)
		for i_h=1,self._cycle_lists:count() do
			local itr_list = self._cycle_lists:list_of(i_h)			
			for i_v=1,itr_list:count() do
				local itr = itr_list:get(i_v)
				if itr:is_selectable() and i_h == self._cycle_list_horizontal_i and i_v == self._cycle_list_vertical_i then
					itr:set_selected(_local_services,true)
				else
					itr:set_selected(_local_services,false)
				end
			end
		end		
	end
	
	local function cyclelist_column_any_selectable(list)
		if list:count() == 0 then
			return false
		end
		for i=1,list:count() do
			if list:get(i):is_selectable() then
				return true
			end
		end
		return false
	end	
	
	function self:cycle_list_vertical(_local_services,offset)
		local v_list = self._cycle_lists:list_of(self._cycle_list_horizontal_i)
		if cyclelist_column_any_selectable(v_list) == false then
			return
		end		
		
		local i_v = self._cycle_list_vertical_i
		local i_v_max = v_list:count()
		
		if i_v_max == 0 then
			i_v = 1
		else	
			i_v = i_v + offset
			if offset > 0 then
				if i_v > i_v_max then
					i_v = 1
				end
			elseif offset < 0 then
				if i_v <= 0 then
					i_v = i_v_max
				end
			end
		end
		
		for offset=0,v_list:count() do
			local index = i_v + offset
			if index > v_list:count() then
				index = index - v_list:count()
			end	
			
			if v_list:get(index):is_selectable() == true then
				break
			else
				i_v = i_v + 1
				if i_v > v_list:count() then
					i_v = 1
				end
			end
		end		
		
		self._cycle_list_vertical_i = i_v
		self:cycle_list_updated(_local_services)
	end
	
	function self:cycle_list_horizontal(_local_services,offset)
		local i_h = self._cycle_list_horizontal_i
		i_h = i_h + offset
		if i_h <= 0 then
			local i_test = 1
					
			while true do
				if self._cycle_lists:count_of(i_test) == 0 then
					break
				end
				i_test = i_test + 1
			end
			
			i_h = i_test + 1
		end
		
		if self._cycle_lists:count_of(i_h) == 0 then
			i_h = 1 --Intentional (SongSelectUI depends on this behaviour)
		end
		self._cycle_list_vertical_i = 1
		local v_list = self._cycle_lists:list_of(i_h)
		for i=1,v_list:count() do
			if v_list:get(i):is_selectable() then
				self._cycle_list_vertical_i = i
				break
			end
		end			
		
		self._cycle_list_horizontal_i = i_h
		self:cycle_list_updated(_local_services)
	end
	
	return self
end

return MenuBase