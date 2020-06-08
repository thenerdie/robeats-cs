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

    local rating = Metrics:CalculateSR(rate or 1, 35, acc) --35 is the rating

    local gradedata = Metrics:GetGradeData(acc)
	local tierdata = Metrics:GetTierData(rating)

    return Roact.createElement("ScreenGui", {}, {
        Score=Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.new(0.1,0.1,0.1);
            TextColor3 = Color3.fromRGB(163, 163, 163);
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Right;
            Text = Math.round(score);
            TextSize=35;
            AnchorPoint = Vector2.new(1,0);
            Position = UDim2.new(0.95,0,0.05,0);
        });
        Accuracy=Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.new(0.1,0.1,0.1);
            TextColor3 = gradedata.Color;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Right;
            Text = Math.round(acc, 2) .. "% (" .. gradedata.Title .. ")";
            TextSize=24;
            AnchorPoint = Vector2.new(1,0);
            Position = UDim2.new(0.95,0,0.14,0);
        });
        Rating=Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.new(0.1,0.1,0.1);
            TextColor3 = tierdata.Color;
            TextStrokeTransparency = 0;
            TextXAlignment = Enum.TextXAlignment.Right;
            Text = Math.round(rating, 2) .. " SR";
            TextSize = 24;
            AnchorPoint = Vector2.new(1,1);
            Position = UDim2.new(0.95,0,0.95,0);
        });
        BackButton=Roact.createElement("TextButton", {
            BackgroundColor3=Color3.fromRGB(232, 49, 49);
            AnchorPoint=Vector2.new(0,1);
            Text="BACK";
            Position=UDim2.new(0.02,0,0.98,0);
            Size=UDim2.new(0.09,0,0.05,0);
            [Roact.Event.MouseButton1Click] = function(rbx)
                self:Unmount()
                game_.force_quit = true
            end;
        });
    })
end

function self:Initialize(props, g)
    game_ = g
    tree = DoBase(props)
    handle = Roact.mount(tree, PlayerGui, "GameplayScreen")
end

function self:Update(props)
    tree = DoBase(props)
    Roact.update(handle, tree)
end

function self:Unmount()
    Roact.unmount(handle)
end

return self
