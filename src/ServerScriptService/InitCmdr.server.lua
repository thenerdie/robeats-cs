local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Cmdr = require(ServerScriptService:WaitForChild("Cmdr-v1.5.0"))

Cmdr:RegisterDefaultCommands()
Cmdr:RegisterCommandsIn(ServerScriptService:WaitForChild("CmdrCustomCommands"))