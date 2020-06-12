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
local Keybind = require(Utils.Keybind)

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Frameworks = PlayerGui.Frameworks
local Graph = require(Frameworks.Graph)
local UI = require(Frameworks.UI)

local self = {}

local listenerPool = {}

local handle = {}
local tree = {}

local GPlayers = {}

local game_ = nil

local function GetPlayers()
    local ret = {}

    table.sort(GPlayers, function(a, b)
        
    end)

    for i, plr in pairs(GPlayers) do
        ret[#ret+1] = Roact.createElement("Frame", {
            Position = UDim2.new(0, 0, (i-1)/#GPlayers, 0);
            Size = UDim2.new(1,0,1/#GPlayers,0);
            BackgroundTransparency = 0.8;
            BackgroundColor3 = Color3.new(0.1,0.1,0.1);
        }, {
        })
    end
    
    return ret
end

local function DoBase(props)
    local playdata = props.Data
    local rate = props.Rate
    local song = props.Song

    local marvs = playdata[1]
	local perfs = playdata[2]
	local greats = playdata[3]
	local goods = playdata[4]
	local okays = playdata[5]
	local misses = playdata[6]
	local total = playdata[7]	
	local acc = playdata[8]
	local score = playdata[9]
	local chain = playdata[10]
    local maxcombo = playdata[11]

    local rating = Metrics:CalculateSR(rate or 1, song:GetDifficulty(), acc)

    local gradedata = Metrics:GetGradeData(acc)
    local tierdata = Metrics:GetTierData(rating)

    return Roact.createElement("ScreenGui", {}, {
        Score = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(25,25,25);
            TextColor3 = Color3.fromRGB(255,255,255);
			BackgroundTransparency = 1;
            TextXAlignment = Enum.TextXAlignment.Right;
            Text = Math.format(Math.round(score));
            TextScaled = true;
			TextWrapped = true;
			Font = Enum.Font.GothamBlack;
            AnchorPoint = Vector2.new(1,0);
            Position = UDim2.new(0.98,0,0.035,0);
			Size = UDim2.new(0.15,0,0.06,0);
        });
        Accuracy = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(25,25,25);
            TextColor3 = gradedata.Color;
            TextXAlignment = Enum.TextXAlignment.Right;
			BackgroundTransparency = 1;
            Text = Math.round(acc, 2) .. "% (" .. gradedata.Title .. ")";
            TextScaled = true;
			TextWrapped = true;
			Font = Enum.Font.GothamBlack;
            AnchorPoint = Vector2.new(1,0);
            Position = UDim2.new(0.98,0,0.1,0);
			Size = UDim2.new(0.15,0,0.03,0);
        });
		Combo = Roact.createElement("TextLabel", {
			BackgroundTransparency = 1;
            Text = chain .. "x";
			TextColor3 = Color3.fromRGB(255,255,255);
            TextScaled = true;
			TextWrapped = true;
			Font = Enum.Font.GothamBlack;
            AnchorPoint = Vector2.new(0.5,0.5);
            Position = UDim2.new(0.5,0,0.2,0);
			Size = UDim2.new(0.125,0,0.05,0);
        });
		Judgement = Roact.createElement("TextLabel", {
			BackgroundTransparency = 1;
            Text = "";
			TextColor3 = Color3.fromRGB(255,255,255);
            TextScaled = true;
			TextWrapped = true;
			Font = Enum.Font.GothamBlack;
            AnchorPoint = Vector2.new(0.5,0.5);
            Position = UDim2.new(0.5,0,0.25,0);
			Size = UDim2.new(0.15,0,0.05,0);
        });
        Rating = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(25,25,25);
            TextColor3 = tierdata.Color;
			BackgroundTransparency = 1;
            Text = Math.round(rating, 2) .. " SR";
            TextScaled = true;
			TextWrapped = true;
			Font = Enum.Font.GothamBlack;
            Position = UDim2.new(0.02,0,0.035,0);
			Size = UDim2.new(0.125,0,0.05,0);
        });
		BackButton = Roact.createElement("ImageButton", {
			Size = UDim2.new(0.14, 0, 0.06, 0),
			AnchorPoint = Vector2.new(1,1);
			Position = UDim2.new(0.975, 0, 0.955, 0),
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			Image = "rbxassetid://2790382281",
			SliceCenter = Rect.new(4, 4, 252, 252),
			SliceScale = 1,
			ImageColor3 = Color3.fromRGB(232, 49, 49),
			[Roact.Event.MouseButton1Click] = function(rbx)
            	game_.force_quit = true
     		end;
		}, {
			Label = Roact.createElement("TextLabel", {
            	TextColor3 = Color3.fromRGB(255,255,255);
				BackgroundTransparency = 1;
            	Text = "BACK";
            	TextScaled = true;
				TextWrapped = true;
				Font = Enum.Font.GothamBlack;
            	AnchorPoint = Vector2.new(0.5,0.5);
           		Position = UDim2.new(0.5,0,0.5,0);
				Size = UDim2.new(0.9,0,0.6,0);
        	});
		});
    })
end

function self:Initialize(props, g)
    game_ = g

    listenerPool[#listenerPool+1] = Keybind:listen(Settings.Options.QuickExitKeybind[1], function()
        game_.force_quit = true
    end)

    tree = DoBase(props)
    handle = Roact.mount(tree, PlayerGui, "GameplayScreen")
end

function self:Update(props)
    tree = DoBase(props)
    Roact.update(handle, tree)
end

function self:Unmount()
    for i, v in pairs(listenerPool) do
        v:stop()
    end
    listenerPool = {}
    Roact.unmount(handle)
end

return self
