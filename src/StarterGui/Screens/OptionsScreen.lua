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
local tree = {}

local function NewOption(props)
	return UI.new("Option",props)
end

local function Base()
	
	
	return Roact.createElement("ScreenGui", {}, {
		OptionsFrame=Roact.createElement(UI.new("Frame"), {
			Children={
				OptionsContainer=Roact.createElement(UI.new("ScrollingFrame"), {
					Size=UDim2.new(1,0,0.9,0);
					Anchor=Vector2.new(0,0);
					Position=UDim2.new(0,0,0,0);
					BTransparency=1;
					Children={
						O=Roact.createElement()
					}
				});
				BackButton=Roact.createElement("TextButton", {
					BackgroundColor3=Color3.fromRGB(232, 49, 49);
					AnchorPoint=Vector2.new(0,1);
					Text="BACK";
					Position=UDim2.new(0,5,1,-5);
					Size=UDim2.new(0.14,0,0.08,0);
					[Roact.Event.MouseButton1Click] = function(rbx)
						self:Unmount()
						Screens:FindScreen("MainMenuScreen"):DoOptions()
					end;
				});
			}
		});
	});
end

function self:DoOptions()
	tree = Base()
	handle = Roact.mount(tree, PlayerGui, "SongSelectMenu")
end

function self:Unmount()
	Roact.unmount(handle)
end

return self