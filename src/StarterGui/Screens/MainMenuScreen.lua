local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Roact = require(ReplicatedStorage.Roact)
local Rodux = require(ReplicatedStorage.Rodux)
local RoactRodux = require(ReplicatedStorage.RoactRodux)
local LocalPlayer = game.Players.LocalPlayer

local Utils = script.Parent.Parent.Utils
local Screens = require(Utils.ScreenUtil) 
local SongLibrary = require(Utils.Songs)
local Online = require(Utils.Online)
local Metrics = require(Utils.Metrics)
local Math = require(Utils.Math)
local Settings = require(Utils.Settings)

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Frameworks = PlayerGui.Frameworks
local Graph = require(Frameworks.Graph)
local UI = require(Frameworks.UI)

local self = {}
	
local handle = {}

local options = {}
local numNames = 6

local function Option(props, optionNumber)
	return Roact.createElement(UI.new("TextButton"), {
		Size=UDim2.new(1,0,1/numNames,0);
		Position=UDim2.new(0,0,(optionNumber-1)/numNames,0);
		TextSize=18;
		Text=props.Name;
		OnClick=props.Click
	})
	--[[Roact.createElement("TextButton", {
		Size=UDim2.new(1,0,1/numNames,0);
		Position=UDim2.new(0,0,(optionNumber-1)/numNames,0);
		TextSize=18;
		Text=props.Name;
		[Roact.Event.MouseButton1Click] = props.Click
	})]]--
end

local function AddOption(option)
	options[#options+1] = option
end

function self:DoOptions(props)
	AddOption(Option({
		Name="Play";
		Click = function()
			self:Unmount()
			Screens:FindScreen("SongSelectScreen"):DoSongSelect()
		end
	},1))
	AddOption(Option({
		Name="Ranking";
		Click = function()
			
		end
	},2))
	AddOption(Option({
		Name="Options";
		Click = function()
			self:Unmount()
			Screens:FindScreen("OptionsScreen"):DoOptions()
		end
	},3))
	AddOption(Option({
		Name="Update Notes";
		Click = function()
			
		end
	},4))
	AddOption(Option({
		Name="Global Leaderboard";
		Click = function()
			
		end
	},5))
	AddOption(Option({
		Name="Spectate";
		Click = function()
			
		end
	},6))
	
	local frame = Roact.createElement(UI.new("Frame"), {
		Children=options;
		Size=UDim2.new(0.4,0,0.6,0);
	})
	local tree = Roact.createElement("ScreenGui", {}, frame)
	handle = Roact.mount(tree, PlayerGui, "MainMenu")
end

function self:Unmount()
	Roact.unmount(handle)
end

return self