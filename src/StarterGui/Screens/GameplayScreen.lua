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

    tree = Roact.createElement("ScreenGui", {}, {
        Score=Roact.createElement("TextLabel", {
            BackgroundColor3 = Color3.new(0.1,0.1,0.1);
            Text = score;
            TextSize=18;
            AnchorPoint = Vector2.new(1,0);
            Position = UDim2.new(1,-5,0,5);
        })
    })
end

function self:Initialize(props)
    DoBase(props)
    handle = Roact.mount(tree, {}, "GameplayScreen")
end

function self:Update(props)
    DoBase(props)
    Roact.update(tree, handle)
end

return self
