--[[

CLIENT.LUA

CLIENT SIDE LOGIC FOR ROBEATS CS

--]]

repeat wait() until game.Players.LocalPlayer.Character ~= nil
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Rodux = require(ReplicatedStorage.Rodux)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local LocalPlayer = game.Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Utils = script.Parent.Utils
local Frameworks = script.Parent.Frameworks
local Game = require(Utils.Game)
local ScreenUtil = require(Utils.ScreenUtil) 
local SongLibrary = require(Utils.Songs)
local Online = require(Utils.Online)
local Metrics = require(Utils.Metrics)
local Math = require(Utils.Math)
local Settings = require(Utils.Settings)
local Graph = require(Frameworks.Graph)
local UI = require(Frameworks.UI)

for i, screen in pairs(PlayerGui:WaitForChild("Screens"):GetChildren()) do
	ScreenUtil:NewScreen(screen.Name, require(screen))
end

ScreenUtil:FindScreen("MainMenuScreen"):DoOptions()