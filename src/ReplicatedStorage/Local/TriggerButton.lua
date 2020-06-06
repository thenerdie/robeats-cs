local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local GameSlot = require(game.ReplicatedStorage.Shared.GameSlot)
local TriggerButton = {}
scrollmode = {Value=2}

function TriggerButton:new(_game, position, track_system, track_index)
	local self = {}

	local _triggerbutton_obj = nil
	local _triggerbutton_decal = nil
	local _tar_glow_transparency = 1
	local _parent_track_system = track_system

	function self:cons()
		
		_triggerbutton_obj =  _game:get_game_protos().TriggerButtonProto:Clone()
		
		
		
		
		if scrollmode.Value == 1 then
			
			_triggerbutton_obj.Outer.Transparency = 1
			_triggerbutton_obj.Outer.Interior.Transparency = 1
			_triggerbutton_obj.Outer.InteriorGlow.Transparency = 1
			_triggerbutton_obj.Outer2D.Decal.Transparency = 0
			
			_triggerbutton_obj.Outer2D.Transparency = 1
			
			
			
			_triggerbutton_obj:SetPrimaryPartCFrame(CFrame.new(Vector3.new(position.X, _game:get_game_environment_center().Y - 1 , position.Z)) * SPUtil:part_cframe_rotation(_triggerbutton_obj.PrimaryPart))
		else
			
			_triggerbutton_obj.Outer.Transparency = 0
			_triggerbutton_obj.Outer.Interior.Transparency = 0
			_triggerbutton_obj.Outer.InteriorGlow.Transparency = 0
			
			_triggerbutton_obj.Outer2D.Transparency = 1
			_triggerbutton_obj.Outer2D.Decal.Transparency = 1
			
			
			
			
			_triggerbutton_obj:SetPrimaryPartCFrame(CFrame.new(Vector3.new(position.X, _game:get_game_environment_center().Y + 1 , position.Z)) * SPUtil:part_cframe_rotation(_triggerbutton_obj.PrimaryPart))
		end
		_triggerbutton_obj.Parent = _game:get_game_element()
	end

	function self:teardown()
		_triggerbutton_obj:Destroy()
		_triggerbutton_obj = nil
		_parent_track_system = nil
		_game = nil
		track_system = nil
		self = nil
	end

	function self:press()

		
		if scrollmode.Value == 1 then
			
			_tar_glow_transparency = 0
			_triggerbutton_obj.Outer2D.Decal.Transparency = 0

		else

			
			_triggerbutton_obj.Outer2D.Decal.Transparency = 1
			_tar_glow_transparency = 0
		end
		
	end

	function self:release()
		
		if scrollmode.Value == 1 then
			
			_triggerbutton_obj.Outer2D.Decal.Transparency = 0
			
			_tar_glow_transparency = 1
		else
			
			
			_triggerbutton_obj.Outer2D.Decal.Transparency = 1
			_tar_glow_transparency = 1
		end
	end

	function self:update_brick_color(_game)
		if _game._players._slots:contains(_parent_track_system._game_slot) == false then
			return
		end

		if scrollmode.Value ~= 1 then
		_triggerbutton_obj.Outer.BrickColor, _triggerbutton_obj.Outer.Transparency =
			GameSlot:slot_to_color_and_transparency(
				_parent_track_system._game_slot,
				_game._players._slots:get(_parent_track_system._game_slot)._power_bar_active
			)
			
		else
			
			_triggerbutton_obj.Outer2D.Transparency = 0
			_triggerbutton_obj.Outer.Transparency = 1
			
		end
		

	end

	function self:update(dt_scale, _game)
		if scrollmode.Value ~= 1 then
		_triggerbutton_obj.Outer.InteriorGlow.Transparency = CurveUtil:Expt(
			_triggerbutton_obj.Outer.InteriorGlow.Transparency,
			_tar_glow_transparency,
			CurveUtil:NormalizedDefaultExptValueInSeconds(0.45),
			dt_scale
		)

		self:update_brick_color(_game)
		
		else
			_triggerbutton_obj.Outer.InteriorGlow.Transparency = 1
			self:update_brick_color(_game)
			
		end
		
	end

	self:cons()
	return self
end

return TriggerButton
