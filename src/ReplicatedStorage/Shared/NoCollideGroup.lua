local NoCollideGroup = {}

function NoCollideGroup:new()
	local self = {}	
	
	local _physics_service = game:GetService("PhysicsService")
	local _character_group_name = "Characters"
	local _character_group = _physics_service:CreateCollisionGroup(_character_group_name)	
	
	_physics_service:CollisionGroupSetCollidable(_character_group_name, _character_group_name, false)	
	
	local function add_children_to_group(instance)
		for _, v in pairs(instance:GetChildren()) do
			 if v:IsA("BasePart") then
			 	_physics_service:SetPartCollisionGroup(v, _character_group_name)
			 else
			 	add_children_to_group(v, _character_group_name)
			 end
		end
	end
	
	function self:add_to_group(obj)
		add_children_to_group(obj)
	end
	
	return self
end

return NoCollideGroup
