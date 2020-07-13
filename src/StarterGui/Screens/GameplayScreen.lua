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
local Logger = require(Utils.Logger):register(script)
local DateTime = require(ReplicatedStorage.DateTime)

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

    local game_join = game_._local_services._game_join

    local curTime = 0
    local songLen = 1

    if game_join ~= nil then
        curTime = game_join:get_songTime()
        songLen = game_join:get_songLength()
    end

    local timeLeftMs = songLen - curTime
    local timeLeftAlpha = curTime/songLen
    local unformattedTL = DateTime:GetDateTime(timeLeftMs/1000)
    local formattedTL = unformattedTL:format("#m:#s")

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
            AnchorPoint = Vector2.new(0.5,0.5);
            Position = Settings.Options.ScorePos;
            Size = UDim2.new(0.15,0,0.06,0);
            Visible = Settings.Options.ShowGameplayUI;
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
            AnchorPoint = Vector2.new(0.5,0.5);
            Position = Settings.Options.AccuracyPos;
            Size = UDim2.new(0.15,0,0.03,0);
            Visible = Settings.Options.ShowGameplayUI;
        });
		Combo = Roact.createElement("TextLabel", {
			BackgroundTransparency = 1;
            Text = chain .. "x";
			TextColor3 = Color3.fromRGB(255,255,255);
            TextScaled = true;
			TextWrapped = true;
			Font = Enum.Font.GothamBlack;
            AnchorPoint = Vector2.new(0.5,0.5);
            Position = Settings.Options.ComboPos;
            Size = UDim2.new(0.125,0,0.05,0);
            Visible = Settings.Options.ShowGameplayUI;
        });
		Judgement = Roact.createElement("TextLabel", {
			BackgroundTransparency = 1;
            Text = "";
			TextColor3 = Color3.fromRGB(255,255,255);
            TextScaled = true;
			TextWrapped = true;
			Font = Enum.Font.GothamBlack;
            AnchorPoint = Vector2.new(0.5,0.5);
            Position = Settings.Options.JudgementPos;
            Size = UDim2.new(0.15,0,0.05,0);
            Visible = Settings.Options.ShowGameplayUI;
        });
        Rating = Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.fromRGB(25,25,25);
            TextColor3 = tierdata.Color;
			BackgroundTransparency = 1;
            Text = Math.round(rating, 2) .. " SR";
            TextScaled = true;
			TextWrapped = true;
            Font = Enum.Font.GothamBlack;
            AnchorPoint = Vector2.new(0.5,0.5);
            Position = Settings.Options.RatingPos;
            Size = UDim2.new(0.125,0,0.05,0);
            Visible = Settings.Options.ShowGameplayUI;
        });
		BackButton = Roact.createElement("ImageButton", {
			Size = UDim2.new(0.14, 0, 0.06, 0),
			AnchorPoint = Vector2.new(0.5,0.5);
			Position = Settings.Options.BackButtonPos;
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
        TimeLeftPGBar = Roact.createElement("Frame", {
            Size = UDim2.new(timeLeftAlpha,0,0,5);
            AnchorPoint = Vector2.new(0,1);
            Position = UDim2.new(0,0,1,0);
			      BackgroundColor3 = Color3.fromRGB(122, 122, 122);
			      Visible = Settings.Options.ShowGameplayUI;
        });
        TimeLeftTextLabel = Roact.createElement("TextLabel", {
            Text = formattedTL;
            TextSize = 20;
            TextColor3 = Color3.new(1,1,1);
            TextStrokeTransparency = 0.75;
            BackgroundTransparency = 1;
            TextXAlignment = Enum.TextXAlignment.Left;
            Size = UDim2.new(0.1,0,0.05,0);
            AnchorPoint = Vector2.new(0,1);
            Position = UDim2.new(0.005,0,0.995,0);
            Font = Enum.Font.GothamBlack;
			      BackgroundColor3 = Color3.fromRGB(122, 122, 122);
			      Visible = Settings.Options.ShowGameplayUI;
        });
    })
end

function self:Initialize(props, g)
    game_ = g

    Logger:Log("Initializing stage...")

    listenerPool[#listenerPool+1] = Keybind:listen(Settings.Options.QuickExitKeybind[1], function()
        game_.force_quit = true
	end)
	
	listenerPool[#listenerPool+1] = Keybind:listen(Settings.Options.HideGameplayUI[1], function()
        Settings.Options.ShowGameplayUI = not Settings.Options.ShowGameplayUI;
    end)
	
    tree = DoBase(props)
    handle = Roact.mount(tree, PlayerGui, "Gameplay")

    Logger:Log("Gameplay tree mounted!")
end

function self:Update(props)
    tree = DoBase(props)
    Roact.update(handle, tree)
end

function self:Unmount()
    Logger:Log("Tearing down stage...")
    for i, v in pairs(listenerPool) do
        v:stop()
    end
    listenerPool = {}
    Logger:Log("Event listeners destroyed...")
    Roact.unmount(handle)
    Logger:Log("Gameplay tree mounted!")
end

return self
