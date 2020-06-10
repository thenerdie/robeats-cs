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
local Game = require(Utils.Game)

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Frameworks = PlayerGui.Frameworks
local Graph = require(Frameworks.Graph)
local UI = require(Frameworks.UI)

local songs = SongLibrary:GetAllSongs()

local self = {}
	
local maxSlots = 50

local search = nil
local lb = {}
local lb_gui = {}
self.curSelected = nil

local tree = {}
local handle = {}

local function getNumSlots()
	local num = #lb
	if num > maxSlots then
		return 50
	else
		return num
	end
end

local function SongButton(instance, song, songNum)
	return Roact.createElement("TextButton", {
		Size=UDim2.new(1,0,0,45);
		BackgroundColor3=song:GetButtonColor();
		Position=UDim2.new(0,0,0,(songNum-1)*45);
		TextXAlignment=Enum.TextXAlignment.Left;
		TextSize=10;
		TextColor3=Color3.fromRGB(255, 255, 255);
		TextStrokeTransparency=0.1;
		Text=song:GetDisplayName();
		[Roact.Event.MouseButton1Click] = function()
			self.curSelected = song
			self:UpdateLeaderboard()
		end
	})
end

local function LeaderboardSlot(data,slotNum)
	return Roact.createElement("Frame", {
		Size=UDim2.new(1,0,0,37);
		BackgroundColor3=Color3.fromRGB(9, 68, 107);
		Position=UDim2.new(0,0,0,(slotNum-1)*37);
		BackgroundTransparency=0.4;
	}, {
		SlotNumber=Roact.createElement("TextLabel", {
			TextXAlignment=Enum.TextXAlignment.Left;
			Text=tostring(slotNum)..".";
			TextColor3=Color3.new(1,1,1);
			TextSize=18;
			BackgroundTransparency=1;
			Size=UDim2.new(0.15,0,1,0);
		});
		PlayerName=Roact.createElement("TextLabel", {
			TextXAlignment=Enum.TextXAlignment.Left;
			Text=data.PlayerName;
			TextColor3=Color3.new(1,1,1);
			TextSize=15;
			BackgroundTransparency=1;
			Position=UDim2.new(0.15,0,0,0);
			Size=UDim2.new(0.8,0,0.75,0);
		});
		PlayData=Roact.createElement("TextLabel", {
			AnchorPoint=Vector2.new(0,1);
			TextXAlignment=Enum.TextXAlignment.Left;
			Text="Rating: " .. Math.round(data.Rating,2) .. " | Score: " .. Math.round(data.Score) .. " | Accuracy: " .. Math.round(data.Accuracy,2) .. "%";
			TextColor3=Color3.new(1,1,1);
			TextSize=7;
			BackgroundTransparency=1;
			Position=UDim2.new(0.15,0,1,-2);
			Size=UDim2.new(0.8,0,0.25,0);
		});
	})
end

local function SongButtons(props)
	local bttns = {}
	local search = props.search or nil
	
	if search ~= nil then
		search = search:lower()
		search = string.split(search, " ")
	end
	
	for i, song in pairs(props.songs) do
		local doAdd = false
		
		local foundNumber = 0
		
		if search == nil then
			doAdd = true
		else
			for i, searchWord in pairs(search) do
				if string.find(song.instance.Name:lower(), searchWord) ~= nil then
					foundNumber = foundNumber + 1
				end
			end
			if foundNumber == #search then
				doAdd = true
			end
		end
		
		if doAdd then bttns[#bttns+1] = SongButton(song.instance, song, i) end
	end
	return Roact.createFragment(bttns), #bttns
end

local function Leaderboard()
	local lb_gui = {}
	for i, slot in pairs(lb) do
		if i > maxSlots then break end
		lb_gui[#lb_gui+1] = LeaderboardSlot(slot, i)
	end
	return Roact.createFragment(lb_gui)
end

local function Base()	
	local sbuttons, found = SongButtons({
		songs=songs;
		search=search or nil
	})
	return Roact.createElement("ScreenGui",{},{
		SongSelectFrame=Roact.createElement(UI.new("Frame"), {
			Size=UDim2.new(0.7,0,0.82,0);
			Children={
				SongButtonList=Roact.createElement("ScrollingFrame",{
					Size=UDim2.new(0.31,0,1,-20);
					BackgroundColor3=Color3.new(0.1,0.1,0.1);
					CanvasSize=UDim2.new(0,0,0,found*45);
				},{
					Buttons=sbuttons;
					List=Roact.createElement("UIListLayout")
				});
				SearchBar=Roact.createElement("TextBox", {
					AnchorPoint=Vector2.new(0,1);
					Text="";
					PlaceholderText="Search here...";
					PlaceholderColor3=Color3.fromRGB(65, 65, 65);
					Position=UDim2.new(0,0,1,0);
					Size=UDim2.new(0.31,0,0,20);
					[Roact.Event.Changed] = function(rbx)
						local text = rbx.Text
						if text == "" then
							text = nil
						end
						search = text
						tree = Base()
						Roact.update(handle,tree)
					end;
				});
				Leaderboard=Roact.createElement("ScrollingFrame", {
					Position=UDim2.new(0.31,0,0,0);
					Size=UDim2.new(0.31,0,0.8,0);
					BackgroundColor3=Color3.new(0.1,0.1,0.1);
					CanvasSize=UDim2.new(0,0,0,getNumSlots()*37);
				}, {
					Leaderboard=Roact.createElement(Leaderboard);
				});
				PlayButton=Roact.createElement("TextButton", {
					BackgroundColor3=Color3.fromRGB(0,255,45);
					AnchorPoint=Vector2.new(1,1);
					Text="PLAY";
					Position=UDim2.new(1,0,1,0);
					Size=UDim2.new(0.14,0,0.08,0);
					[Roact.Event.MouseButton1Click] = function(rbx)
						local g = Game:new()
						self:Unmount()
						local rate = Settings.Options.Rate
						g:StartGame(self.curSelected, rate, Settings.Options.Keybinds, Settings.Options.NoteColor, Settings.Options.ScrollSpeed)
						Screens:FindScreen("ResultsScreen"):DoResults({
							gamejoin=g._local_services._game_join;
							localgame=g.local_game;
						}, rate, self.curSelected)
						g:DestroyStage()
					end;
				});
			}
		})
	})
end

function self:DoSongSelect()
	tree = Base()
	handle = Roact.mount(tree, PlayerGui, "SongSelectMenu")
end

function self:Unmount()
	Roact.unmount(handle)
end

function self:UpdateLeaderboard()
	spawn(function()
		lb = Online:GetMapLeaderboard(self.curSelected:GetId())
		tree = Base()
		Roact.update(handle,tree)
	end)
end

return self