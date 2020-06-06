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

local DT = require(game.ReplicatedStorage.DateTime)

local self = {}
	
local handle = {}


function self:DoResults(props, rate, song)
	--_marv_count,_perfect_count,_great_count,_good_count,_ok_count,_miss_count,_total_count,self:get_acc(),self._score,self._chain,_max_chain
	local localgame = props.localgame
	local gamejoin = props.gamejoin
	
	local audio_manager = localgame._audio_manager
	
	local songLen = gamejoin:get_songLength()/1000
	
	local data = gamejoin:get_data()
	
	local marvs = data[1]
	local perfs = data[2]
	local greats = data[3]
	local goods = data[4]
	local okays = data[5]
	local misses = data[6]
	local total = data[7]	
	local acc = data[8]
	local score = data[9]
	local chain = data[10]
	local maxchain = data[11]
	
	local ratio = 0
	
	ratio = Math.round(marvs/perfs, 2)
	
	local rating = Metrics:CalculateSR(rate or 0, song:GetDifficulty(), acc)
	local spread = string.split(props.Spread or "","/")
	
	local gradedata = Metrics:GetGradeData(acc)
	local tierdata = Metrics:GetTierData(rating)
	
	local graph = Graph.new("Dot")
	
	graph.xinterval = 20
	graph.yinterval = 50
	
	graph.xfloor = 0
	graph.xceiling = songLen
	
	graph.yfloor = audio_manager.NOTE_REMOVE_TIME
	graph.yceiling = math.abs(audio_manager.NOTE_REMOVE_TIME)
	
	for i, hit in pairs(gamejoin:GetMsDeviance()) do
		graph:AddObject(hit[1]*songLen, hit[2], Metrics:GetJudgementColor(hit[3]))
	end
	
	local now = DT:GetDateTime()
	
	local frame = Roact.createElement(UI.new("Frame"), {
		Children={
			Date=Roact.createElement(UI.new("TextLabel"), {
				Text=now:format("Played by " .. LocalPlayer.Name .. " | Played at #W #d, #Y #H:#m:#s #a");
				TextSize=11;
				Position=UDim2.new(0.02,0,0.0148,0);
				Size=UDim2.new(0.4,0,0.02,0);
				BTransparency=1;
				TextXAlignment=Enum.TextXAlignment.Left;
			});
			SongInfo=Roact.createElement(UI.new("TextLabel"), {
				Text=song:GetDisplayName() .. " [" .. (rate or "??") .. "x rate]";
				Color=Color3.new(0.4,0.4,0.4);
				TextSize=11;
				Position=UDim2.new(0.03,0,0.02,0);
				Size=UDim2.new(0.8,0,0.1,0);
				BTransparency=1;
				TextXAlignment=Enum.TextXAlignment.Left;
			});
			Grade=Roact.createElement(UI.new("TextLabel"),{
				Text=gradedata.Title;
				Color=gradedata.Color;
				TextSize=100;
				Size=UDim2.new(0.12,0,0.35,0);
				BTransparency=1;
				Anchor=Vector2.new(0,0);
				Position=UDim2.new(0.05,0,0.1,0);
			});
			Accuracy=Roact.createElement(UI.new("TextLabel"), {
				TextXAlignment=Enum.TextXAlignment.Left;
				Text=Math.round(acc, 2) .. "%";
				TextSize=18;
				Anchor=Vector2.new(0,0);
				Position=UDim2.new(0.2,0,0.16,0);
				Size=UDim2.new(0.1,0,0.1,0);
				BTransparency=1;
			});
			Score=Roact.createElement(UI.new("TextLabel"), {
				TextXAlignment=Enum.TextXAlignment.Left;
				Text=Math.round(score);
				TextSize=18;
				Anchor=Vector2.new(0,0);
				Position=UDim2.new(0.2,0,0.22,0);
				Size=UDim2.new(0.1,0,0.1,0);
				BTransparency=1;
			});
			Rating=Roact.createElement(UI.new("TextLabel"), {
				TextXAlignment=Enum.TextXAlignment.Left;
				Text=Math.round(rating, 2) .. "SR";
				Color=tierdata.Color;
				TextSize=18;
				Anchor=Vector2.new(0,0);
				Position=UDim2.new(0.2,0,0.28,0);
				Size=UDim2.new(0.1,0,0.1,0);
				BTransparency=1;
			});
			Spread=Roact.createElement(UI.new("Frame"),{
				Anchor=Vector2.new(1,1);
				Position=UDim2.new(0.85,0,0.92,0);
				Size=UDim2.new(0.475,0,0.42,0);
				Children={
					Data=Roact.createFragment({
						Marvs=Roact.createElement(UI.new("Frame"), {
							Anchor=Vector2.new(0,0);
							BColor3=Color3.fromRGB(212, 202, 133);
							BTransparency=0.7;
							Size=UDim2.new(1,0,1/6,0);
							Position=UDim2.new(0,0,0/6,0);
							Children={
								Pct=Roact.createElement(UI.new("Frame"), {
									Position=UDim2.new(0,0,0,0);
									Anchor=Vector2.new(0,0);
									BorderSize=0;
									BColor3=Color3.fromRGB(212, 202, 133);
									BTransparency=0.15;
									Size=UDim2.new(marvs/total,0,1,0)
								});
								Number=Roact.createElement(UI.new("TextLabel"), {
									Size=UDim2.new(1,0,1,0);
									BTransparency=1;
									Position=UDim2.new(0.02,0,0,0);
									TextSize=15;
									TextXAlignment=Enum.TextXAlignment.Left;
									Text=tostring(marvs)
								});
							}
						});
						Perfs=Roact.createElement(UI.new("Frame"), {
							Anchor=Vector2.new(0,0);
							BColor3=Color3.fromRGB(209, 206, 0);
							BTransparency=0.7;
							Size=UDim2.new(1,0,1/6,0);
							Position=UDim2.new(0,0,1/6,0);
							Children={
								Pct=Roact.createElement(UI.new("Frame"), {
									Position=UDim2.new(0,0,0,0);
									Anchor=Vector2.new(0,0);
									BorderSize=0;
									BColor3=Color3.fromRGB(209, 206, 0);
									BTransparency=0.15;
									Size=UDim2.new(perfs/total,0,1,0)
								});
								Number=Roact.createElement(UI.new("TextLabel"), {
									Size=UDim2.new(1,0,1,0);
									BTransparency=1;
									Position=UDim2.new(0.02,0,0,0);
									TextSize=15;
									TextXAlignment=Enum.TextXAlignment.Left;
									Text=tostring(perfs)
								});
							}
						});
						Greats=Roact.createElement(UI.new("Frame"), {
							Anchor=Vector2.new(0,0);
							BColor3=Color3.fromRGB(10, 166, 51);
							BTransparency=0.7;
							Size=UDim2.new(1,0,1/6,0);
							Position=UDim2.new(0,0,2/6,0);
							Children={
								Pct=Roact.createElement(UI.new("Frame"), {
									Position=UDim2.new(0,0,0,0);
									Anchor=Vector2.new(0,0);
									BorderSize=0;
									BColor3=Color3.fromRGB(10, 166, 51);
									BTransparency=0.15;
									Size=UDim2.new(greats/total,0,1,0)
								});
								Number=Roact.createElement(UI.new("TextLabel"), {
									Size=UDim2.new(1,0,1,0);
									BTransparency=1;
									Position=UDim2.new(0.02,0,0,0);
									TextSize=15;
									TextXAlignment=Enum.TextXAlignment.Left;
									Text=tostring(greats)
								});
							}
						});
						Goods=Roact.createElement(UI.new("Frame"), {
							Anchor=Vector2.new(0,0);
							BColor3=Color3.fromRGB(40, 59, 224);
							BTransparency=0.7;
							Size=UDim2.new(1,0,1/6,0);
							Position=UDim2.new(0,0,3/6,0);
							Children={
								Pct=Roact.createElement(UI.new("Frame"), {
									Position=UDim2.new(0,0,0,0);
									Anchor=Vector2.new(0,0);
									BorderSize=0;
									BColor3=Color3.fromRGB(40, 59, 224);
									BTransparency=0.15;
									Size=UDim2.new(goods/total,0,1,0)
								});
								Number=Roact.createElement(UI.new("TextLabel"), {
									Size=UDim2.new(1,0,1,0);
									BTransparency=1;
									Position=UDim2.new(0.02,0,0,0);
									TextSize=15;
									TextXAlignment=Enum.TextXAlignment.Left;
									Text=tostring(goods)
								});
							}
						});
						Okays=Roact.createElement(UI.new("Frame"), {
							Anchor=Vector2.new(0,0);
							BColor3=Color3.fromRGB(92, 0, 122);
							BTransparency=0.7;
							Size=UDim2.new(1,0,1/6,0);
							Position=UDim2.new(0,0,4/6,0);
							Children={
								Pct=Roact.createElement(UI.new("Frame"), {
									Position=UDim2.new(0,0,0,0);
									Anchor=Vector2.new(0,0);
									BorderSize=0;
									BColor3=Color3.fromRGB(92, 0, 122);
									BTransparency=0.15;
									Size=UDim2.new(okays/total,0,1,0)
								});
								Number=Roact.createElement(UI.new("TextLabel"), {
									Size=UDim2.new(1,0,1,0);
									BTransparency=1;
									Position=UDim2.new(0.02,0,0,0);
									TextSize=15;
									TextXAlignment=Enum.TextXAlignment.Left;
									Text=tostring(okays)
								});
							}
						});
						Misses=Roact.createElement(UI.new("Frame"), {
							Anchor=Vector2.new(0,0);
							BColor3=Color3.fromRGB(138, 41, 41);
							Size=UDim2.new(1,0,1/6,0);
							BTransparency=0.7;
							Position=UDim2.new(0,0,5/6,0);
							Children={
								Pct=Roact.createElement(UI.new("Frame"), {
									Position=UDim2.new(0,0,0,0);
									Anchor=Vector2.new(0,0);
									BorderSize=0;
									BColor3=Color3.fromRGB(138, 41, 41);
									BTransparency=0.15;
									Size=UDim2.new(misses/total,0,1,0)
								});
								Number=Roact.createElement(UI.new("TextLabel"), {
									Size=UDim2.new(1,0,1,0);
									BTransparency=1;
									Position=UDim2.new(0.02,0,0,0);
									TextSize=15;
									TextXAlignment=Enum.TextXAlignment.Left;
									Text=tostring(misses)
								});
							}
						});
						Ratio=Roact.createElement(UI.new("TextLabel"), {
							BTransparency=1;
							Text="Ratio: " .. ratio .. ":1";
							TextSize=13;
							Anchor=Vector2.new(1,1);
							Position=UDim2.new(0.92,0,1,0);
						});
					});
				};
			});
			NoteDevianceGraph=Roact.createElement(graph.component, {
				Anchor=Vector2.new(0,1);
				Position=UDim2.new(0.01,0,0.99,0);
				Size=UDim2.new(0.98,0,0.47,0);
			});
			BackButton=Roact.createElement("TextButton", {
				BackgroundColor3=Color3.fromRGB(224, 72, 34);
				AnchorPoint=Vector2.new(1,0);
				Text="BACK";
				Position=UDim2.new(1,-5,0,5);
				Size=UDim2.new(0.14,0,0.08,0);
				[Roact.Event.MouseButton1Click] = function(rbx)
					self:Unmount()
					Screens:FindScreen("SongSelectScreen"):DoSongSelect()
				end;
			});
		}
	})
	
	
	local tree = Roact.createElement("ScreenGui", {}, frame)
	handle = Roact.mount(tree, PlayerGui, "MainMenu")
end

function self:Unmount()
	Roact.unmount(handle)
end

return self