local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Cmdr = require(ServerScriptService:WaitForChild("Cmdr-v1.5.0"))

Cmdr:RegisterCommandsIn(ServerScriptService:WaitForChild("CmdrCustomCommands"))
Cmdr:RegisterHooksIn(ServerScriptService:WaitForChild("CmdrCustomHooks"))