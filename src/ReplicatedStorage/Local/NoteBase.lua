local NoteBase = {}

local __color_powerbar_active = BrickColor.White() --BrickColor.new(1019)
local __color_powerbar_inactive = BrickColor.White() --BrickColor.new(1017)

local COLOR3_POWERBAR_INACTIVE = Color3.fromRGB(254, 226, 19)
local COLOR3_POWERBAR_ACTIVE = Color3.fromRGB(95, 244, 255)

local Colors = {}
Colors[1] = Color3.new(1.0,0.0,0.0)
Colors[2] = Color3.new(0.0,0.0,5.0)
Colors[3] = Color3.new(0.5,0.0,1.0)
Colors[4] = Color3.new(1.0,1.0,0.0)
Colors[5] = Color3.new(1.0,0.0,1.0)
Colors[6] = Color3.new(1.0,0.5,0.0)
Colors[7] = Color3.new(0.0,1.0,0.0)
Colors[8] = Color3.new(0.0,0.0,1.0)

function NoteBase:NoteBase()
	local self = {}

	function self:update(dt_scale, _game) error("NoteBase must implement update") end
	function self:should_remove(_game) error("NoteBase must implement should_remove") return false end
	function self:do_remove(_game) error("NoteBase must implement do_remove") end

	function self:test_hit(_game) error("NoteBase must implement test_hit") return false,0 end
	function self:on_hit(_game,note_result,i_notes) error("NoteBase must implement on_hit") end

	function self:test_release(_game) error("NoteBase must implement test_release") return false,0 end
	function self:on_release(_game,note_result,i_notes) error("NoteBase must implement on_release") end

	function self:get_track_index(_game) error("NoteBase must implement get_track_index") return 0 end

	function self:color_for_slot(slot, is_powerbar_active)
		if is_powerbar_active then
			return __color_powerbar_active
		end
		return __color_powerbar_inactive
	end

	function self:get_base_transparency(is_powerbar_active)
		if 2 == 1 then
			return 1
		else
			return 0 --0.15
		end
	end

	return self
end

return NoteBase
