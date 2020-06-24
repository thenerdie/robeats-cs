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
local Search = require(Utils.Search)
local Logger = require(Utils.Logger):register(script)
local Color = require(Utils.Color)

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
local mapname = ""
local diffname = ""
local artistname = ""

local tree = {}
local handle = {}

local function getNumSlots()
	local num = #lb
	if num > maxSlots then
		return maxSlots
	else
		return num
	end
end

local function SongButton(instance, song, songNum)
	return Roact.createElement("ImageButton", {
		Size = UDim2.new(0.975,0,0,60);
		BackgroundColor3 = song:GetButtonColor();
		Position = UDim2.new(0,0,0,(songNum-1)*60);
		Image = "";
		BorderSizePixel = 0;
		[Roact.Event.MouseButton1Click] = function()
			self.curSelected = song
			self:UpdateLeaderboard()
			self:UpdateMapInfo()
		end
	}, {
		Difficulty = Roact.createElement("TextLabel", {
			AnchorPoint = Vector2.new(0,0.5);
			Size = UDim2.new(0.125,0,0.8,0);
			BackgroundTransparency = 1;
			Position = UDim2.new(0.01,0,0.5,0);
			TextScaled = true;
			Font = Enum.Font.GothamBlack;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			TextStrokeTransparency = 0.75;
			Text = "["..math.floor(tonumber(song:GetDifficulty()) + 0.5).."]",
		}),
		SongName = Roact.createElement("TextLabel", {
			Size = UDim2.new(0.85,0,0.5,0);
			BackgroundTransparency = 1;
			Position = UDim2.new(0.15,0,0.05,0);
			TextScaled = true;
			Font = Enum.Font.GothamBlack;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			TextStrokeTransparency = 0.75;
			Text = song:GetSongName(),
			TextXAlignment = Enum.TextXAlignment.Left;
		}),
		ArtistAndMapperName = Roact.createElement("TextLabel", {
			Size = UDim2.new(0.85,0,0.4,0);
			BackgroundTransparency = 1;
			Position = UDim2.new(0.15,0,0.5,0);
			TextScaled = true;
			Font = Enum.Font.GothamBlack;
			TextColor3 = Color3.fromRGB(255, 255, 255);
			TextStrokeTransparency = 0.75;
			Text = song:GetArtist().." - ?",
			TextXAlignment = Enum.TextXAlignment.Left;
		}),
	})
end

local function LeaderboardSlot(data,slotNum)
	return Roact.createElement("Frame", {
		Size = UDim2.new(0.96,0,0,70);
		BackgroundColor3 = Color3.fromRGB(17, 17, 17);
		Position = UDim2.new(0,0,0,(slotNum-1)*72);
		BorderSizePixel = 0;
	}, {
		SlotNumber = Roact.createElement("TextLabel", {
			Text = tostring(slotNum)..".";
			TextColor3 = Color3.new(1,1,1);
			TextScaled = true;
			BackgroundTransparency = 1;
			Position = UDim2.new(0.02,0,0.05,0);
			Size = UDim2.new(0.07,0,0.35,0);
			Font = Enum.Font.GothamBlack;
		});
		PlayerName = Roact.createElement("TextLabel", {
			TextXAlignment = Enum.TextXAlignment.Left;
			Text = data.PlayerName;
			TextColor3 = Color3.new(1,1,1);
			TextScaled = true;
			BackgroundTransparency = 1;
			Position = UDim2.new(0.1,0,0.05,0);
			Size = UDim2.new(0.875,0,0.35,0);
			Font = Enum.Font.GothamBlack;
		});
		PlayData=Roact.createElement("TextLabel", {
			AnchorPoint = Vector2.new(0.5,0);
			Text = "Rating: " .. Math.round(data.Rating,2) .. " | Score: " .. Math.round(data.Score) .. " | Accuracy: " .. Math.round(data.Accuracy,2) .. "%";
			TextXAlignment = Enum.TextXAlignment.Left;
			TextColor3 = Color3.new(1,1,1);
			TextScaled = true;
			BackgroundTransparency = 1;
			Position = UDim2.new(0.5,0,0.425,0);
			Size = UDim2.new(0.94,0,0.5,0);
			Font = Enum.Font.GothamBlack;
		});
	})
end

local function SongButtons(props)
	local bttns = {}	
	for i, song in pairs(props.songs) do
		local doAdd = Search:find(song.instance.Name, props.search)
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
	local tgraph = Graph.new("Bar")
	tgraph.xinterval = 50
	tgraph.xceiling = 1000
	tgraph.yceiling = 10
	for i = 1, 1000 do
		tgraph:AddObject(i, Math.positive(math.sin(i)))
	end

	local sbuttons, found = SongButtons({
		songs = songs;
		search = search or nil
	})
	return Roact.createElement("ScreenGui",{},{
		SongSelectFrame=Roact.createElement("Frame", {
			Size = UDim2.new(1,0,1,0);
			AnchorPoint = Vector2.new(0.5,0.5);
			Position = UDim2.new(0.5, 0,0.5, 0),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(32, 32, 32),
		}, {
			Scale = Roact.createElement("UIScale", {
				Scale = 0.8,
			}),
			Background = Roact.createElement("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0),
				Size = UDim2.new(1, 0, 0.2, 0),
				Position = UDim2.new(0.5, 0, 0, 0),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				ScaleType = Enum.ScaleType.Crop,
				BackgroundColor3 = Color3.fromRGB(223, 179, 179),
				BackgroundTransparency = 0,
				ScaleType = Enum.ScaleType.Crop,
				ImageTransparency = 1,
				--Image = "http://www.roblox.com/asset/?id=2404285030"
			}, {
				ArtistName = Roact.createElement("ImageLabel", {
					Size = UDim2.new(0.5, 0, 0.3, 0),
					Position = UDim2.new(0.02, 0, 0.35, 0),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ScaleType = Enum.ScaleType.Slice,
					Image = "rbxassetid://2790382281",
					SliceCenter = Rect.new(4, 4, 252, 252),
					SliceScale = 1,
					ImageColor3 = Color3.fromRGB(27, 27, 27)
				}, {
					Data = Roact.createElement("TextLabel", {
						AnchorPoint = Vector2.new(0.5,0.5);
						Text = artistname;
						TextColor3 = Color3.new(1,1,1);
						TextScaled = true;
						BackgroundTransparency = 1;
						Position = UDim2.new(0.5,0,0.55,0);
						Size = UDim2.new(0.96,0,0.6,0);
						Font = Enum.Font.GothamBlack;
					});
				}),
				SongName = Roact.createElement("ImageLabel", {
					Size = UDim2.new(0.5, 0, 0.3, 0),
					Position = UDim2.new(0.02, 0, 0.1, 0),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ScaleType = Enum.ScaleType.Slice,
					Image = "rbxassetid://2790382281",
					SliceCenter = Rect.new(4, 4, 252, 252),
					SliceScale = 1,
					ImageColor3 = Color3.fromRGB(35, 35, 35)
				}, {
					Data = Roact.createElement("TextLabel", {
						AnchorPoint = Vector2.new(0.5,0.5);
						Text = mapname;
						TextColor3 = Color3.new(1,1,1);
						TextScaled = true;
						BackgroundTransparency = 1;
						Position = UDim2.new(0.5,0,0.5,0);
						Size = UDim2.new(0.96,0,0.7,0);
						Font = Enum.Font.GothamBlack;
					});
				}),
				DifficultyName = Roact.createElement("ImageLabel", {
					Size = UDim2.new(0.5, 0, 0.25, 0),
					Position = UDim2.new(0.02, 0, 0.7, 0),
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ScaleType = Enum.ScaleType.Slice,
					Image = "rbxassetid://2790382281",
					SliceCenter = Rect.new(4, 4, 252, 252),
					SliceScale = 1,
					ImageColor3 = Color3.fromRGB(27, 27, 27)
				}, {
					Data = Roact.createElement("TextLabel", {
						AnchorPoint = Vector2.new(0.5,0.5);
						Text = diffname;
						TextColor3 = Color3.new(1,1,1);
						TextScaled = true;
						BackgroundTransparency = 1;
						Position = UDim2.new(0.5,0,0.5,0);
						Size = UDim2.new(0.96,0,0.7,0);
						Font = Enum.Font.GothamBlack;
					});
				})
			}),
			SearchBox = Roact.createElement("Frame", {
				AnchorPoint = Vector2.new(1,0);
				Position = UDim2.new(0.99, 0,0.87, 0),
				Size = UDim2.new(0.4,0,0.06,0),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BorderSizePixel = 0,
			},{
				SearchBar = Roact.createElement("TextBox", {
					AnchorPoint = Vector2.new(0.5,0.5);
					Text = "";
					PlaceholderText = "Search here";
					PlaceholderColor3 = Color3.fromRGB(178, 178, 178);
					TextColor3 = Color3.fromRGB(255, 255, 255);
					TextScaled = true;
					Font = Enum.Font.GothamBlack;
					BackgroundTransparency = 1;
					Position = UDim2.new(0.5,0,0.5,0);
					Size = UDim2.new(0.98,0,0.55,0);
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
			}),
			Leaderboards = Roact.createElement("Frame", {
				Position = UDim2.new(0.01, 0,0.22, 0),
				Size = UDim2.new(0.3,0,0.71,0),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BorderSizePixel = 0,
			}, {
				List = Roact.createElement("ScrollingFrame", {
					AnchorPoint = Vector2.new(0.5,0.5);
					Position = UDim2.new(0.5,0,0.5,0);
					Size = UDim2.new(0.96,0,0.97,0);
					BackgroundTransparency = 1;
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(0,0,0,getNumSlots()*72);
					VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left;
					ScrollBarThickness = 6,
					TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
				}, {
					Layout = Roact.createElement("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Right,
						SortOrder = Enum.SortOrder.LayoutOrder,
					}),
					Leaderboard = Roact.createElement(Leaderboard);
				});
			}),
			TestBarGraph = Roact.createElement(tgraph.component, {
				Position = UDim2.new(0.5,0,0.5,0)
			}),
			Songs = Roact.createElement("Frame", {
				AnchorPoint = Vector2.new(1,0);
				Position = UDim2.new(0.99, 0,0.22, 0),
				Size = UDim2.new(0.4,0,0.63,0),
				BackgroundColor3 = Color3.fromRGB(25, 25, 25),
				BorderSizePixel = 0,
			}, {
				List = Roact.createElement("ScrollingFrame", {
					AnchorPoint = Vector2.new(0.5,0.5);
					Position = UDim2.new(0.5,0,0.5,0);
					Size = UDim2.new(0.97,0,0.97,0);
					BackgroundTransparency = 1;
					CanvasSize = UDim2.new(0,0,0,found*60);
					VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right;
					ScrollBarThickness = 6,
					BorderSizePixel = 0,
					TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
					BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png",
				}, {
					Layout = Roact.createElement("UIListLayout", {
						HorizontalAlignment = Enum.HorizontalAlignment.Left,
					}),
					Buttons = sbuttons;
				});
			}),
			BackButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(232, 49, 49),
				Size = UDim2.new(0.3, 0, 0.05, 0),
				Position =  UDim2.new(0.01,0,0.99,0),
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
					TextStrokeTransparency = 0.75;
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
			PlayButton = Roact.createElement("ImageButton", {
				BackgroundColor3 = Color3.fromRGB(43, 255, 110),
				Size = UDim2.new(0.4, 0, 0.05, 0),
				Position =  UDim2.new(0.59,0,0.99,0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ScaleType = Enum.ScaleType.Slice,
				Image = "rbxassetid://2790382281",
				SliceCenter = Rect.new(4, 4, 252, 252),
				SliceScale = 1,
				ImageColor3 = Color3.fromRGB(43, 255, 110),
				AnchorPoint =  Vector2.new(0,1),
				[Roact.Event.MouseButton1Click] = function()
					local g = Game:new()
					self:Unmount()
					local rate = Settings.Options.Rate
					local note_color_opt = Settings.Options.NoteColor
					local noteColor = Color:convertHSV(note_color_opt)
					g:StartGame(self.curSelected, rate, Settings.Options.Keybinds, noteColor, Settings.Options.ScrollSpeed)
					Screens:FindScreen("ResultsScreen"):DoResults({
						gamejoin=g._local_services._game_join;
						localgame=g.local_game;
					}, rate, self.curSelected)
					g:DestroyStage()
				end;
			}, {
				PlayButton = Roact.createElement("TextLabel", {
					TextStrokeTransparency = 0.75;
					AnchorPoint =  Vector2.new(0.5,0.5),
					Text = "PLAY",
					Position = UDim2.new(0.5, 0, 0.5, 0),
					Size = UDim2.new(0.9, 0, 0.6, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBlack,
					TextScaled = true,
					TextWrapped = true,
					TextColor3 = Color3.fromRGB(255, 255, 255)
				});
			});
		})
	})
end

function self:DoSongSelect()
	Logger:Log("Entering song select...")
	tree = Base()
	handle = Roact.mount(tree, PlayerGui, "SongSelectMenu")
	Logger:Log("Song select screen mounted!")
end

function self:Unmount()
	Roact.unmount(handle)
	Logger:Log("Song select screen unmounted!")
end

function self:UpdateLeaderboard()
	Logger:Log("Leaderboard updated...")
	spawn(function()
		lb = Online:GetMapLeaderboard(self.curSelected:GetId())
		tree = Base()
		Roact.update(handle,tree)
	end)
end
function self:UpdateMapInfo()
	Logger:Log("Map info updated...")
	spawn(function()
		mapname = self.curSelected:GetSongName()
		artistname = self.curSelected:GetArtist()
		if self.curSelected:GetDifficultyName() == nil then
			diffname = "["..tostring(math.floor(tonumber(self.curSelected:GetDifficulty()) + 0.5)).."]"
		else
			diffname = "["..tostring(math.floor(tonumber(self.curSelected:GetDifficulty()) + 0.5)).."] "..self.curSelected:GetDifficultyName()
		end
		tree = Base()
		Roact.update(handle,tree)
	end)
end

return self