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

local optionNumber = 0
local maxOptionNumber = 7

local function Option(name, type, bound)
	local boundFire = "Update"..bound
	self[bound], self[boundFire] = Roact.createBinding(type == "number" and 0 or "")
	optionNumber = optionNumber + 1
	return Roact.createElement("Frame", {
		Size = UDim2.new(1,0,0.15,0);
		Position = UDim2.new(0, 0, (optionNumber-1) / maxOptionNumber, 0);
		BackgroundTransparency = 1;
	}, {
		Name = Roact.createElement("TextLabel", {
			BackgroundTransparency = 1;
			Font = Enum.Font.GothamBlack;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			Text = name;
			TextSize = 30;
			Position = UDim2.new(0,0,0,0);
			Size = UDim2.new(0.2,0,1,0);
		});
		OptionValue = Roact.createElement("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.new(0.2,0,0.5,0),
			Position = UDim2.new(0.2,0,0.5,0),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			Image = "rbxassetid://2790382281",
			SliceCenter = Rect.new(4, 4, 252, 252),
			SliceScale = 1,
			ImageColor3 = Color3.fromRGB(35, 35, 35)
		},{
			Data = Roact.createElement("TextLabel", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0.85, 0, 0.7, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				Text = self[bound],
				Font = Enum.Font.GothamBlack,
				TextScaled = true,
				TextWrapped = true,
				TextColor3 = Color3.fromRGB(179, 179, 179)
			})
		});
		Plus = Roact.createElement("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.new(0.2,0,0.5,0),
			Position = UDim2.new(0.4,5,0.5,0),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			Image = "rbxassetid://2790382281",
			SliceCenter = Rect.new(4, 4, 252, 252),
			SliceScale = 1,
			ImageColor3 = Color3.fromRGB(32, 221, 32)
		},{
			Data = Roact.createElement("TextButton", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0.85, 0, 0.7, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				Text = "+",
				Font = Enum.Font.GothamBlack,
				TextScaled = true,
				TextWrapped = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				[Roact.Event.MouseButton1Click] = function(rbx)
					local optionValue = Settings:Increment(bound, 1)
					self[boundFire](optionValue)
				end
			})
		});
		Minus = Roact.createElement("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.new(0.2,0,0.5,0),
			Position = UDim2.new(0.6,5,0.5,0),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			Image = "rbxassetid://2790382281",
			SliceCenter = Rect.new(4, 4, 252, 252),
			SliceScale = 1,
			ImageColor3 = Color3.fromRGB(209, 47, 47)
		},{
			Data = Roact.createElement("TextButton", {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0.85, 0, 0.7, 0),
				Position = UDim2.new(0.5, 0, 0.5, 0),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				Text = "-",
				Font = Enum.Font.GothamBlack,
				TextScaled = true,
				TextWrapped = true,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				[Roact.Event.MouseButton1Click] = function(rbx)
					local optionValue = Settings:Increment(bound, -1)
					self[boundFire](optionValue)
				end
			})
		});
	})
end

local function Base()
	return Roact.createElement("ScreenGui", {
		ResetOnSpawn = false,
	}, {
		OptionsFrame = Roact.createElement("ImageLabel", {
			AnchorPoint =  Vector2.new(0.5,0.5);
			Position =  UDim2.new(0.5,0,0.5,0);
			BackgroundColor3 = Color3.fromRGB(12,12,12);
			BackgroundTransparency = 0.2;
			Size = UDim2.new(1,0,1,0);
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			Image = "rbxassetid://2790382281",
			SliceCenter = Rect.new(4, 4, 252, 252),
			SliceScale = 1,
			ImageColor3 = Color3.fromRGB(27, 27, 27),
		}, {
			Scale = Roact.createElement("UIScale", {
				Scale = 0.8,
			}),
			OptionsContainer = Roact.createElement("ScrollingFrame", {
				AnchorPoint = Vector2.new(0.5,0.5);
				Size = UDim2.new(0.975,0,0.95,0);
				Position = UDim2.new(0.5,0,0.5,0);
				BackgroundTransparency = 1;
			}, { -- OPTIONS GO HERE
				ScrollSpeed = Option("Scroll Speed", "number", "ScrollSpeed")
			}),
			BackButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(232, 49, 49),
				Size = UDim2.new(0.14, 0, 0.08, 0),
				Position =  UDim2.new(1.01,0,0,0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ScaleType = Enum.ScaleType.Slice,
				Image = "rbxassetid://2790382281",
				SliceCenter = Rect.new(4, 4, 252, 252),
				SliceScale = 1,
				ImageColor3 = Color3.fromRGB(232, 49, 49),
				[Roact.Event.MouseButton1Click] = function()
					self:Unmount()
					Screens:FindScreen("MainMenuScreen"):DoOptions()
				end;
			}, {
				AspectRatio = Roact.createElement("UIAspectRatioConstraint", {}),
				BackButton = Roact.createElement("TextLabel", {
					AnchorPoint =  Vector2.new(0.5,0.5),
					Text = "X",
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.9, 0, 0.9, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBlack,
					TextScaled = true,
					TextWrapped = true,
					TextColor3 = Color3.fromRGB(255, 255, 255)
				});
			});
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