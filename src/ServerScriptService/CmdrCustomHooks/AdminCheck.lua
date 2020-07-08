local Permissions = require(game.ReplicatedStorage.Helpers.Permissions)

return function (registry)
	registry:RegisterHook("BeforeRun", function(context)
		if context.Group == "Admin" and not Permissions:IsAdmin(context.Executor.UserId) then
			return "You can't run this command."
		end
	end)
end