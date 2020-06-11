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

local curSelected = ""

local optionNumber = 0
local tabNumber = 0
local maxOptionNumber = 7

local function formatColor(color3)
	return string.format("R: %3d, G: %3d, B: %3d", color3.R or 0, color3.G or 0, color3.B or 0)
end

local function formatKeys(keys)
	local ret = ""
	keys = keys or {}
	for i, v in pairs(keys) do
		local str = tostring(v)
		str = str:sub(12,#str)
		ret = i == #keys and str or str .. " "
	end

	return ret
end

local function NumberOption(name, bound, increment)
	increment = increment or 1
	local boundFire = "Update"..bound
	self[bound], self[boundFire] = Roact.createBinding(Settings.Options[bound])
	return Roact.createElement("Frame", {
		Size = UDim2.new(0.975,0,0.075,0);
		Position = UDim2.new(0, 0, (optionNumber-1) / (maxOptionNumber * 2) + ((optionNumber - 1) / 100), 0);
		BackgroundColor3 = Color3.fromRGB(27, 27, 27);
		BorderSizePixel = 0;
	}, {
		Name = Roact.createElement("TextLabel", {
			BackgroundTransparency = 1;
			Font = Enum.Font.GothamBlack;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			Text = name;
			TextScaled = true,
			TextWrapped = true,
			Position = UDim2.new(0.025,0,0.5,0);
			Size = UDim2.new(0.2,0,0.25,0);
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
			AnchorPoint = Vector2.new(1, 0.5),
			Size = UDim2.new(0.2,0,0.5,0),
			Position = UDim2.new(0.8,-60,0.5,0),
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
					local optionValue = Settings:Increment(bound, increment)
					self[boundFire](optionValue)
				end
			})
		});
		Minus = Roact.createElement("ImageLabel", {
			AnchorPoint = Vector2.new(1, 0.5),
			Size = UDim2.new(0.2,0,0.5,0),
			Position = UDim2.new(1,-30,0.5,0),
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
					local optionValue = Settings:Increment(bound, -increment)
					self[boundFire](optionValue)
				end
			})
		});
	})
end

local function KeybindOption(name, bound, numOfKeys)
	local boundFire = "Update"..bound
	self[bound], self[boundFire] = Roact.createBinding(formatKeys(Settings.Options[bound]))
	optionNumber = optionNumber + 1
	return Roact.createElement("Frame", {
		Size = UDim2.new(1,0,0.15,0);
		Position = UDim2.new(0, 0, (optionNumber-1) / maxOptionNumber, 0);
		BackgroundTransparency = 1;
    BorderSizePixel = 0;
	}, {
		Name = Roact.createElement("TextLabel", {
			BackgroundTransparency = 1;
			Font = Enum.Font.GothamBlack;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			Text = name;
			TextScaled = true,
			TextWrapped = true,
			Position = UDim2.new(0.025,0,0.5,0);
			Size = UDim2.new(0.2,0,0.25,0);
		});
		OptionValue = Roact.createElement("ImageLabel", {
			AnchorPoint = Vector2.new(1, 0.5),
			Size = UDim2.new(0.2,0,0.5,0),
			Position = UDim2.new(0.95,0,0.5,0),
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
				Text = formatKeys(self[bound]),
				Font = Enum.Font.GothamBlack,
				TextScaled = true,
				TextWrapped = true,
				TextColor3 = Color3.fromRGB(179, 179, 179)
			})
		});
	})
end

local function ColorOption(name, bound)
	local boundFire = "Update"..bound
	self[bound], self[boundFire] = Roact.createBinding(formatColor(Settings.Options[bound]))
	optionNumber = optionNumber + 1
	return Roact.createElement("Frame", {
		Size = UDim2.new(1,0,0.15,0);
		Position = UDim2.new(0, 0, (optionNumber-1) / maxOptionNumber, 0);
		BackgroundTransparency = 1;
    BorderSizePixel = 0;
	}, {
		Name = Roact.createElement("TextLabel", {
			BackgroundTransparency = 1;
			Font = Enum.Font.GothamBlack;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			Text = name;
			TextScaled = true,
			TextWrapped = true,
			Position = UDim2.new(0.025,0,0.5,0);
			Size = UDim2.new(0.2,0,0.25,0);
		});
		OptionValue = Roact.createElement("ImageLabel", {
			AnchorPoint = Vector2.new(0, 0.5),
			Size = UDim2.new(0.2,0,0.5,0),
			Position = UDim2.new(0.25,0,0.5,0),
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
				Text = formatColor(self[bound]),
				Font = Enum.Font.GothamBlack,
				TextScaled = true,
				TextWrapped = true,
				TextColor3 = Color3.fromRGB(179, 179, 179)
			})
		});
		ColorPicker = Roact.createElement("ImageLabel", {
			BackgroundTransparency = 1;
			Image = "rbxassetid://4674990774";
		})
	})
end

local totalSections = 4

local function NewSection(name, children)
	children = children or {}
	optionNumber = #children+1
	tabNumber = tabNumber + 1
	local isSelected = curSelected == name
	return {
		Tab = Roact.createElement("TextButton", {
			Font = Enum.Font.GothamBlack;
			TextSize = 30;
			Text = name;
			BackgroundTransparency = isSelected and 0.2 or 1;
			BackgroundColor3 = Color3.fromRGB(102, 164, 218);
			Size = UDim2.new(1,0,1/totalSections,0);
			Position = UDim2.new(0,0,(tabNumber-1)/totalSections,0);
			[Roact.Event.MouseButton1Click] = function(rbx)
				curSelected = name
				self:Update()
			end
		});
		OptionsList = Roact.createFragment(children);
		Name=name;
	}
end

local function Sections()
	tabNumber = 0
	return {
		[1] = NewSection("General", {

		});
		[2] = NewSection("Song", {
			SongRate = NumberOption("Song Rate", "Rate", 0.05);
		});
		[3] = NewSection("Gameplay", {
			ScrollSpeed = NumberOption("Scroll Speed", "ScrollSpeed");
			NoteColor = ColorOption("Note Color", "NoteColor");
		});
	}
end

local function Base()
	optionNumber = 0
	local sections = Sections()
	local tabs = {}
	local options = {}

	for i , v in pairs(sections) do
		tabs[i] = v.Tab
		if v.Name == curSelected then
			options = v.OptionsList
		end
	end

	tabs = Roact.createFragment(tabs)

	return Roact.createElement("ScreenGui", {
		ResetOnSpawn = false,
	}, {
		OptionsFrame = Roact.createElement("ImageLabel", {
			AnchorPoint =  Vector2.new(0.5,0.5);
			Position =  UDim2.new(0.5,0,0.5,0);
			BackgroundColor3 = Color3.fromRGB(12,12,12);
			BackgroundTransparency = 0.2;
			Size = UDim2.new(1,0,1,0);
			BorderSizePixel = 0;
			BackgroundTransparency = 1;
			ScaleType = Enum.ScaleType.Slice;
			Image = "rbxassetid://2790382281";
			SliceCenter = Rect.new(4, 4, 252, 252);
			SliceScale = 1;
			ImageColor3 = Color3.fromRGB(27, 27, 27);
		}, {
			Scale = Roact.createElement("UIScale", {
				Scale = 0.8,
			}),
			Tabs = Roact.createElement("ImageLabel", {
				Size = UDim2.new(0.2,0,0.89,0);
				Position = UDim2.new(0.005,0,0.01,0);
				BackgroundTransparency = 1;
				BorderSizePixel = 0;
				ScaleType = Enum.ScaleType.Slice;
				Image = "rbxassetid://2790382281";
				SliceCenter = Rect.new(4, 4, 252, 252);
				SliceScale = 1;
				ImageColor3 = Color3.fromRGB(17, 17, 17);
			}, tabs),
			OptionsContainer = Roact.createElement("ImageLabel", {
				AnchorPoint = Vector2.new(0,0.5);
				Size = UDim2.new(0.785,0,0.98,0);
				Position = UDim2.new(0.21,0,0.5,0);
				BackgroundTransparency = 1;
				BorderSizePixel = 0;
				ScaleType = Enum.ScaleType.Slice;
				Image = "rbxassetid://2790382281";
				SliceCenter = Rect.new(4, 4, 252, 252);
				SliceScale = 1;
				ImageColor3 = Color3.fromRGB(17, 17, 17);
			}, {
				List = Roact.createElement("ScrollingFrame", {
				AnchorPoint = Vector2.new(0.5,0.5);
				Size = UDim2.new(0.975,0,0.965,0);
				Position = UDim2.new(0.5,0,0.5,0);
				BackgroundTransparency = 1;
				BorderSizePixel = 0;
				TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
				BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png";
				ScrollBarThickness = 10
				}, options),
			}),
			BackButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(232, 49, 49),
				Size = UDim2.new(0.2, 0, 0.08, 0),
				Position =  UDim2.new(0.005,0,0.99,0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ScaleType = Enum.ScaleType.Slice,
				Image = "rbxassetid://2790382281",
				SliceCenter = Rect.new(4, 4, 252, 252),
				SliceScale = 1,
				ImageColor3 = Color3.fromRGB(232, 49, 49),
				AnchorPoint =  Vector2.new(0,1),
				[Roact.Event.MouseButton1Click] = function()
					self:Unmount()
					Screens:FindScreen("MainMenuScreen"):DoOptions()
				end;
			}, {
				BackButton = Roact.createElement("TextLabel", {
					AnchorPoint =  Vector2.new(0.5,0.5),
					Text = "BACK",
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.9, 0, 0.6, 0),
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

function self:Update()
	print("self:Update() was called with no arguments.")
	tree = Base()
	Roact.update(handle,tree)
end

function self:Unmount()
	Roact.unmount(handle)
end

return self