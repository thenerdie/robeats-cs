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
local Logger = require(Utils.Logger):register(script)

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Frameworks = PlayerGui.Frameworks
local Graph = require(Frameworks.Graph)

local DT = require(game.ReplicatedStorage.DateTime)

local self = {}
	
local handle = {}


function self:DoResults(props, doSubmit)
	Logger:Log("Results screen mounting...")

	doSubmit = doSubmit or false

	--_marv_count,_perfect_count,_great_count,_good_count,_ok_count,_miss_count,_total_count,self:get_acc(),self._score,self._chain,_max_chain
	
	--local audio_manager = localgame._audio_manager
	
	local marvs = props.marv
	local perfs = props.perf
	local greats = props.great
	local goods = props.good
	local okays = props.okay
	local misses = props.miss
	local total = props.total	
	local acc = props.acc
	local score = props.score
	local chain = props.chain
	local maxcombo = props.maxcombo
	local npsgraph = props.npsgraph
	local song = props.song
	local songLen = props.songlen
	local rate = props.rate
	local playername = props.playername
	local playerid = props.playerid
	local now = props.datetime or DT:GetDateTime()

	--[[
	gamejoin:get_songLength()/1000
	gamejoin:get_data()
	]]--

	local ratio = 0
	
	ratio = Math.round(marvs/perfs, 2)
	
	local rating = Metrics:CalculateSR(rate or 0, song:GetDifficulty(), acc)
	local spread = string.split(props.Spread or "","/")
	
	local gradedata = Metrics:GetGradeData(acc)
	local tierdata = Metrics:GetTierData(rating)
	
	Logger:Log("Data grabbed successfully!")

	local graph = Graph.new("Dot")
	
	graph.xinterval = 20
	graph.yinterval = 50
	
	graph.xfloor = 0
	graph.xceiling = songLen
	
	graph.yfloor = -250
	graph.yceiling = 250
	
	if npsgraph ~= nil then
		for i, hit in pairs(npsgraph) do
			local judgeNum = hit[3]
			if judgeNum ~= 6 then
				graph:AddObject(hit[1]*songLen, hit[2], Metrics:GetJudgementColor(judgeNum))
			else
				graph:AddBreak(hit[1]*songLen)
			end
		end
	end

	Logger:Log("Graph generated successfully!")
	
	local frame = Roact.createElement("ScreenGui", {
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global
	}, {
		Results = Roact.createElement("Frame", {
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.new(1, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			ZIndex = 1,
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(37, 37, 37)	
		}, 
		{
			Scale = Roact.createElement("UIScale", {
				Scale = 0.8,
			}),
			Background = Roact.createElement("ImageLabel", {
				AnchorPoint = Vector2.new(0.5, 0),
				Size = UDim2.new(1, 0, 0.3, 0),
				Position = UDim2.new(0.5, 0, 0, 0),
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromRGB(223, 179, 179),
				BackgroundTransparency = 0,
				ScaleType = Enum.ScaleType.Crop,
				ImageTransparency = 1
			}, {
				Rating = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.new(0.8, 0, 0.9, 0),
					Position = UDim2.new(0.5, 0, 0.5, 0),
					ZIndex = 4,
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ScaleType = Enum.ScaleType.Fit,
					Image = "http://www.roblox.com/asset/?id=4873211876",
					ImageColor3 = Color3.fromRGB(35, 35, 35)
				}, {
					Scale = Roact.createElement("UIAspectRatioConstraint", {
						DominantAxis = Enum.DominantAxis.Width,
					}),
					Data = Roact.createElement("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.new(0.6, 0, 0.6,0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						ZIndex = 5,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						Text = gradedata.Title,
						Font = Enum.Font.GothamBlack,
						TextScaled = true,
						TextWrapped = true,
						TextColor3 = gradedata.Color
					}),
					RatingBG = Roact.createElement("ImageLabel", {
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.new(0.95, 0, 0.95, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						ZIndex = 3,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						ScaleType = Enum.ScaleType.Fit,
						Image = "http://www.roblox.com/asset/?id=4512064807",
						ImageColor3 = gradedata.Color
					}),
				}), 
				User = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(0, 0.5),
					Size = UDim2.new(0.15, 0, 0.8, 0),
					Position = UDim2.new(0.025, 0, 0.5, 0),
					ZIndex = 8,
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ScaleType = Enum.ScaleType.Slice,
					Image = "rbxassetid://2790382281",
					SliceCenter = Rect.new(4, 4, 252, 252),
					SliceScale = 1,
					ImageColor3 = Color3.fromRGB(35, 35, 35)
				}, {
					Scale = Roact.createElement("UIAspectRatioConstraint", {
						DominantAxis = Enum.DominantAxis.Width,
					}),
					Username = Roact.createElement("ImageLabel", {
						Size = UDim2.new(1.25, 0, 0.25, 0),
						Position = UDim2.new(0.9, 0, 0, 0),
						ZIndex = 6,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						ScaleType = Enum.ScaleType.Slice,
						Image = "rbxassetid://2790382281",
						SliceCenter = Rect.new(4, 4, 252, 252),
						SliceScale = 1,
						ImageColor3 = Color3.fromRGB(35, 35, 35)
					}, {
						Data = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0, 0.5),
							Size = UDim2.new(0.85, 0, 0.7, 0),
							Position = UDim2.new(0.125, 0, 0.5, 0),
							ZIndex = 7,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = playername,
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						})
					}),
					Rank = Roact.createElement("ImageLabel", {
						Size = UDim2.new(1.1, 0, 0.25, 0),
						Position = UDim2.new(0.95, 0, 0.2, 0),
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						ScaleType = Enum.ScaleType.Slice,
						Image = "rbxassetid://2790382281",
						SliceCenter = Rect.new(4, 4, 252, 252),
						SliceScale = 1,
						ImageColor3 = Color3.fromRGB(27, 27, 27)
					},{
						Data = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0, 0.5),
							Size = UDim2.new(0.825, 0, 0.7, 0),
							Position = UDim2.new(0.15, 0, 0.6, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = "#??",
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						})
					}),
					Date = Roact.createElement("ImageLabel", {
						AnchorPoint = Vector2.new(0, 0),
						Size = UDim2.new(2, 0, 0.2, 0),
						Position = UDim2.new(0.95, 0, 0.45, 0),
						ZIndex = 3,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						ScaleType = Enum.ScaleType.Slice,
						Image = "rbxassetid://2790382281",
						SliceCenter = Rect.new(4, 4, 252, 252),
						SliceScale = 1,
						ImageColor3 = Color3.fromRGB(63, 63, 63)
					},{
						Data = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0.85, 0, 0.7, 0),
							Position = UDim2.new(0.5, 0, 0.5, 0),
							ZIndex = 4,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = now:format("Played at #M/#d/#Y at #H:#m:#s #a"),
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						})
					}),
					Image = Roact.createElement("ImageLabel", {
						Size = UDim2.new(1, 0, 1, 0),
						Position = UDim2.new(0, 0, 0, 0),
						ZIndex = 8,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						ScaleType = Enum.ScaleType.Fit,
						Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..playerid.."&width=420&height=420&format=png",
					})
				}),
				Song = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(1, 0),
					Size = UDim2.new(0.25, 0, 0.2, 0),
					Position = UDim2.new(0.98, 0, 0.1, 0),
					ZIndex = 5,
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
						ZIndex = 6,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						Text = string.format(song:GetSongName() .. " (%0.2fx)", rate),
						Font = Enum.Font.GothamBlack,
						TextScaled = true,
						TextWrapped = true,
						TextColor3 = Color3.fromRGB(255, 255, 255)
					})
				}),
				Artist = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(1, 0),
					Size = UDim2.new(0.2, 0, 0.2, 0),
					Position = UDim2.new(0.98, 0, 0.25, 0),
					ZIndex = 3,
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ScaleType = Enum.ScaleType.Slice,
					Image = "rbxassetid://2790382281",
					SliceCenter = Rect.new(4, 4, 252, 252),
					SliceScale = 1,
					ImageColor3 = Color3.fromRGB(27, 27, 27)
				},{
					Data = Roact.createElement("TextLabel", {
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.new(0.85, 0, 0.7, 0),
						Position = UDim2.new(0.5, 0, 0.6, 0),
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						Text = song:GetArtist(),
						Font = Enum.Font.GothamBlack,
						TextScaled = true,
						TextWrapped = true,
						TextColor3 = Color3.fromRGB(255, 255, 255)
					})
				}),
				Back = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(1, 0),
					Size = UDim2.new(0.125, 0, 0.2, 0),
					Position = UDim2.new(0.98, 0, 0.7, 0),
					ZIndex = 3,
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ScaleType = Enum.ScaleType.Slice,
					Image = "rbxassetid://2790382281",
					SliceCenter = Rect.new(4, 4, 252, 252),
					SliceScale = 1,
					ImageColor3 = Color3.fromRGB(35, 35, 35)
				},{
					Data = Roact.createElement("TextButton", {
						AnchorPoint = Vector2.new(0.5, 0.5),
						Size = UDim2.new(1, 0, 0.7, 0),
						Position = UDim2.new(0.5, 0, 0.5, 0),
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						Text = "BACK",
						Font = Enum.Font.GothamBlack,
						TextScaled = true,
						TextWrapped = true,
						TextColor3 = Color3.fromRGB(255,255,255),
						[Roact.Event.MouseButton1Click] = function()
							self:Unmount()
							Screens:FindScreen("SongSelectScreen"):DoSongSelect()
						end
					})
				})
			}),
			Info = Roact.createElement("Frame", {
				Size = UDim2.new(1, 0, 0.7, 0),
				Position = UDim2.new(0, 0, 0.3, 0),
				ZIndex = 2,
				BorderSizePixel = 0,
				BackgroundColor3 = Color3.fromRGB(26, 26, 26)	
			},{
				Stats = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(0.5, 0),
					Size = UDim2.new(0.95, 0, 0.2, 0),
					Position = UDim2.new(0.5, 0, 0.05, 0),
					ZIndex = 3,
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ScaleType = Enum.ScaleType.Slice,
					Image = "rbxassetid://2790382281",
					SliceCenter = Rect.new(4, 4, 252, 252),
					SliceScale = 1,
					ImageColor3 = Color3.fromRGB(35, 35, 35)
				}, {
					MapRanking = Roact.createElement("Frame", {
						Size = UDim2.new(0.2, 0, 1, 0),
						Position = UDim2.new(0, 0, 0, 0),
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					}, {
						Data = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0.6, 0, 0.3, 0),
							Position = UDim2.new(0.5, 0, 0.6, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = "#??",
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}),
						Label = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0),
							Size = UDim2.new(0.8, 0, 0.2, 0),
							Position = UDim2.new(0.5, 0, 0.1, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = "Map Ranking",
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}),
					}),
					Accuracy = Roact.createElement("Frame", {
						Size = UDim2.new(0.2, 0, 1, 0),
						Position = UDim2.new(0.2, 0, 0, 0),
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					}, {
						Data = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0.6, 0, 0.3, 0),
							Position = UDim2.new(0.5, 0, 0.6, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = Math.round(acc, 2) .. "%",
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}),
						Label = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0),
							Size = UDim2.new(0.8, 0, 0.2, 0),
							Position = UDim2.new(0.5, 0, 0.1, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = "Accuracy",
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}),
					}),
					Combo = Roact.createElement("Frame", {
						Size = UDim2.new(0.2, 0, 1, 0),
						Position = UDim2.new(0.4, 0, 0, 0),
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					}, {
						Data = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0.6, 0, 0.3, 0),
							Position = UDim2.new(0.5, 0, 0.6, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = Math.format(maxcombo),
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}),
						Label = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0),
							Size = UDim2.new(0.8, 0, 0.2, 0),
							Position = UDim2.new(0.5, 0, 0.1, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = "Max Combo",
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}),
					}),
					Score = Roact.createElement("Frame", {
						Size = UDim2.new(0.2, 0, 1, 0),
						Position = UDim2.new(0.6, 0, 0, 0),
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					}, {
						Data = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0.6, 0, 0.3, 0),
							Position = UDim2.new(0.5, 0, 0.6, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = Math.format(Math.round(score, 2)),
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}),
						Label = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0),
							Size = UDim2.new(0.8, 0, 0.2, 0),
							Position = UDim2.new(0.5, 0, 0.1, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = "Total Score",
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}),
					}),
					Rating = Roact.createElement("Frame", {
						Size = UDim2.new(0.2, 0, 1, 0),
						Position = UDim2.new(0.8, 0, 0, 0),
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundTransparency = 1
					}, {
						Data = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0.6, 0, 0.3, 0),
							Position = UDim2.new(0.5, 0, 0.6, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = Math.round(rating, 2),
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = gradedata.Color
						}),
						Label = Roact.createElement("TextLabel", {
							AnchorPoint = Vector2.new(0.5, 0),
							Size = UDim2.new(0.8, 0, 0.2, 0),
							Position = UDim2.new(0.5, 0, 0.1, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							Text = "Rating",
							Font = Enum.Font.GothamBlack,
							TextScaled = true,
							TextWrapped = true,
							TextColor3 = Color3.fromRGB(255, 255, 255)
						}),
					}),
				}),
				DetailedStats = Roact.createElement("ImageLabel", {
					AnchorPoint = Vector2.new(0.5, 0),
					Size = UDim2.new(0.95, 0, 0.65, 0),
					Position = UDim2.new(0.5, 0, 0.3, 0),
					ZIndex = 3,
					BorderSizePixel = 0,
					BackgroundTransparency = 1,
					ScaleType = Enum.ScaleType.Slice,
					Image = "rbxassetid://2790382281",
					SliceCenter = Rect.new(4, 4, 252, 252),
					SliceScale = 1,
					ImageColor3 = Color3.fromRGB(35, 35, 35)
				}, {
					HitGraph = Roact.createElement(graph.component, {
						Size = UDim2.new(0.5, 0, 1, 0),
						Position = UDim2.new(0.5, 0, 0, 0),
						ZIndex=4
					}),
					TotalJudgements = Roact.createElement("ImageLabel", {
						Size = UDim2.new(0.5, 0, 1, 0),
						Position = UDim2.new(0, 0, 0, 0),
						ZIndex = 4,
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						ScaleType = Enum.ScaleType.Slice,
						Image = "rbxassetid://2790382281",
						SliceCenter = Rect.new(4, 4, 252, 252),
						SliceScale = 1,
						ImageColor3 = Color3.fromRGB(35, 35, 35)
					}, {
						Box = Roact.createElement("ImageLabel", {
							AnchorPoint = Vector2.new(0.5, 0.5),
							Size = UDim2.new(0.9, 0, 0.875, 0),
							Position = UDim2.new(0.5, 0, 0.5, 0),
							ZIndex = 5,
							BorderSizePixel = 0,
							BackgroundTransparency = 1,
							ScaleType = Enum.ScaleType.Slice,
							Image = "rbxassetid://2790382281",
							SliceCenter = Rect.new(4, 4, 252, 252),
							SliceScale = 1,
							ImageColor3 = Color3.fromRGB(22, 22, 22),
							ImageTransparency = 1
						}, {
							Marvelous = Roact.createElement("ImageLabel", {
								Size = UDim2.new(1, 0, 0.167, 0),
								Position = UDim2.new(0, 0, 0, 0),
								ZIndex = 6,
								BorderSizePixel = 0,
								BackgroundTransparency = 1,
								ScaleType = Enum.ScaleType.Slice,
								Image = "rbxassetid://2790382281",
								SliceCenter = Rect.new(4, 4, 252, 252),
								SliceScale = 1,
								ImageColor3 = Color3.fromRGB(83, 80, 60)
							}, {
								RemoveRoundCorner = Roact.createElement("Frame",{
									Size = UDim2.new(1, 0, 0.5, 0),
									Position = UDim2.new(0, 0, 0.5, 0),
									ZIndex = 7,
									BorderSizePixel = 0,
									BackgroundColor3 = Color3.fromRGB(83, 80, 60)
								}),
								Data = Roact.createElement("TextLabel", {
									AnchorPoint = Vector2.new(0, 0.5),
									Size = UDim2.new(0.25, 0, 0.6, 0),
									Position = UDim2.new(0.02, 0, 0.5, 0),
									ZIndex = 10,
									BorderSizePixel = 0,
									BackgroundTransparency = 1,
									Text = Math.format(marvs),
									Font = Enum.Font.GothamBlack,
									TextScaled = true,
									TextWrapped = true,
									TextColor3 = Color3.fromRGB(255, 255, 255),
									TextXAlignment = Enum.TextXAlignment.Left,
									TextStrokeTransparency = 0.5
								}),
								Total = Roact.createElement("ImageLabel", {
									Size = UDim2.new(marvs/total, 0, 1, 0),
									Position = UDim2.new(0, 0, 0, 0),
									ZIndex = 8,
									BorderSizePixel = 0,
									BackgroundTransparency = 1,
									ScaleType = Enum.ScaleType.Slice,
									Image = "rbxassetid://2790382281",
									SliceCenter = Rect.new(4, 4, 252, 252),
									SliceScale = 1,
									ImageColor3 = Color3.fromRGB(223, 214, 154)
								}, {
									RemoveRoundCorner = Roact.createElement("Frame",{
										Size = UDim2.new(1, 0, 0.5, 0),
										Position = UDim2.new(0, 0, 0.5, 0),
										ZIndex = 9,
										BorderSizePixel = 0,
										BackgroundColor3 = Color3.fromRGB(223, 214, 154)
									})
								}),
							}),
							Perfect = Roact.createElement("Frame",{
								Size = UDim2.new(1, 0, 0.167, 0),
								Position = UDim2.new(0, 0, 0.167, 0),
								ZIndex = 6,
								BorderSizePixel = 0,
								BackgroundColor3 = Color3.fromRGB(71, 71, 8)
							},{
								Total = Roact.createElement("Frame",{
									Size = UDim2.new(perfs/total, 0, 1, 0),
									Position = UDim2.new(0, 0, 0, 0),
									ZIndex = 7,
									BorderSizePixel = 0,
									BackgroundColor3 = Color3.fromRGB(188, 186, 1)
								}),
								Data = Roact.createElement("TextLabel", {
									AnchorPoint = Vector2.new(0, 0.5),
									Size = UDim2.new(0.25, 0, 0.6, 0),
									Position = UDim2.new(0.02, 0, 0.5, 0),
									ZIndex = 8,
									BorderSizePixel = 0,
									BackgroundTransparency = 1,
									Text = Math.format(perfs),
									Font = Enum.Font.GothamBlack,
									TextScaled = true,
									TextWrapped = true,
									TextColor3 = Color3.fromRGB(255, 255, 255),
									TextXAlignment = Enum.TextXAlignment.Left,
									TextStrokeTransparency = 0.5
								}),	
							}),
							Great = Roact.createElement("Frame",{
								Size = UDim2.new(1, 0, 0.167, 0),
								Position = UDim2.new(0, 0, 0.333, 0),
								ZIndex = 6,
								BorderSizePixel = 0,
								BackgroundColor3 = Color3.fromRGB(11, 59, 24)
							},{
								Total = Roact.createElement("Frame",{
									Size = UDim2.new(greats/total, 0, 1, 0),
									Position = UDim2.new(0, 0, 0, 0),
									ZIndex = 7,
									BorderSizePixel = 0,
									BackgroundColor3 = Color3.fromRGB(10, 150, 47)
								}),
								Data = Roact.createElement("TextLabel", {
									AnchorPoint = Vector2.new(0, 0.5),
									Size = UDim2.new(0.25, 0, 0.6, 0),
									Position = UDim2.new(0.02, 0, 0.5, 0),
									ZIndex = 8,
									BorderSizePixel = 0,
									BackgroundTransparency = 1,
									Text = Math.format(greats),
									Font = Enum.Font.GothamBlack,
									TextScaled = true,
									TextWrapped = true,
									TextColor3 = Color3.fromRGB(255, 255, 255),
									TextXAlignment = Enum.TextXAlignment.Left,
									TextStrokeTransparency = 0.5
								}),	
							}),
							Good = Roact.createElement("Frame",{
								Size = UDim2.new(1, 0, 0.167, 0),
								Position = UDim2.new(0, 0, 0.5, 0),
								ZIndex = 6,
								BorderSizePixel = 0,
								BackgroundColor3 = Color3.fromRGB(20, 26, 76)
							},{
								Total = Roact.createElement("Frame",{
									Size = UDim2.new(goods/total, 0, 1, 0),
									Position = UDim2.new(0, 0, 0, 0),
									ZIndex = 7,
									BorderSizePixel = 0,
									BackgroundColor3 = Color3.fromRGB(37, 54, 202)
								}),
								Data = Roact.createElement("TextLabel", {
									AnchorPoint = Vector2.new(0, 0.5),
									Size = UDim2.new(0.25, 0, 0.6, 0),
									Position = UDim2.new(0.02, 0, 0.5, 0),
									ZIndex = 8,
									BorderSizePixel = 0,
									BackgroundTransparency = 1,
									Text = Math.format(goods),
									Font = Enum.Font.GothamBlack,
									TextScaled = true,
									TextWrapped = true,
									TextColor3 = Color3.fromRGB(255, 255, 255),
									TextXAlignment = Enum.TextXAlignment.Left,
									TextStrokeTransparency = 0.5
								}),	
							}),
							Bad = Roact.createElement("Frame",{
								Size = UDim2.new(1, 0, 0.167, 0),
								Position = UDim2.new(0, 0, 0.666, 0),
								ZIndex = 6,
								BorderSizePixel = 0,
								BackgroundColor3 = Color3.fromRGB(36, 8, 45)
							},{
								Total = Roact.createElement("Frame",{
									Size = UDim2.new(okays/total, 0, 1, 0),
									Position = UDim2.new(0, 0, 0, 0),
									ZIndex = 7,
									BorderSizePixel = 0,
									BackgroundColor3 = Color3.fromRGB(84, 1, 111)
								}),
								Data = Roact.createElement("TextLabel", {
									AnchorPoint = Vector2.new(0, 0.5),
									Size = UDim2.new(0.25, 0, 0.6, 0),
									Position = UDim2.new(0.02, 0, 0.5, 0),
									ZIndex = 8,
									BorderSizePixel = 0,
									BackgroundTransparency = 1,
									Text = Math.format(okays),
									Font = Enum.Font.GothamBlack,
									TextScaled = true,
									TextWrapped = true,
									TextColor3 = Color3.fromRGB(255, 255, 255),
									TextXAlignment = Enum.TextXAlignment.Left,
									TextStrokeTransparency = 0.5
								}),
							}),
							Miss = Roact.createElement("ImageLabel", {
								Size = UDim2.new(1, 0, 0.167, 0),
								Position = UDim2.new(0, 0, 0.833, 0),
								ZIndex = 6,
								BorderSizePixel = 0,
								BackgroundTransparency = 1,
								ScaleType = Enum.ScaleType.Slice,
								Image = "rbxassetid://2790382281",
								SliceCenter = Rect.new(4, 4, 252, 252),
								SliceScale = 1,
								ImageColor3 = Color3.fromRGB(50, 21, 21)
							}, {
								Ratio = Roact.createElement("TextLabel", {
									AnchorPoint = Vector2.new(1, 0.5),
									Size = UDim2.new(0.25, 0, 0.6, 0),
									Position = UDim2.new(0.98, 0, 0.5, 0),
									ZIndex = 11,
									BorderSizePixel = 0,
									BackgroundTransparency = 1,
									Text = "RATIO: "..ratio..":1",
									Font = Enum.Font.GothamBlack,
									TextScaled = true,
									TextWrapped = true,
									TextXAlignment = Enum.TextXAlignment.Right;
									TextColor3 = Color3.fromRGB(255, 255, 255),
									TextStrokeTransparency = 0.5
								}),
								RemoveRoundCorner = Roact.createElement("Frame",{
									Size = UDim2.new(1, 0, 0.5, 0),
									Position = UDim2.new(0, 0, 0, 0),
									ZIndex = 7,
									BorderSizePixel = 0,
									BackgroundColor3 = Color3.fromRGB(50, 21, 21)
								}),
								Data = Roact.createElement("TextLabel", {
									AnchorPoint = Vector2.new(0, 0.5),
									Size = UDim2.new(0.25, 0, 0.6, 0),
									Position = UDim2.new(0.02, 0, 0.5, 0),
									ZIndex = 10,
									BorderSizePixel = 0,
									BackgroundTransparency = 1,
									Text = Math.format(misses),
									Font = Enum.Font.GothamBlack,
									TextScaled = true,
									TextWrapped = true,
									TextColor3 = Color3.fromRGB(255, 255, 255),
									TextXAlignment = Enum.TextXAlignment.Left,
									TextStrokeTransparency = 0.5
								}),
								Total = Roact.createElement("ImageLabel", {
									Size = UDim2.new(misses/total, 0, 1, 0),
									Position = UDim2.new(0, 0, 0, 0),
									ZIndex = 8,
									BorderSizePixel = 0,
									BackgroundTransparency = 1,
									ScaleType = Enum.ScaleType.Slice,
									Image = "rbxassetid://2790382281",
									SliceCenter = Rect.new(4, 4, 252, 252),
									SliceScale = 1,
									ImageColor3 = Color3.fromRGB(125, 38, 38)
								}, {
									RemoveRoundCorner = Roact.createElement("Frame",{
										Size = UDim2.new(1, 0, 0.5, 0),
										Position = UDim2.new(0, 0, 0, 0),
										ZIndex = 9,
										BorderSizePixel = 0,
										BackgroundColor3 = Color3.fromRGB(125, 38, 38)
									})
								}),
							})
						})
					})
				})
			})
		})
	})
	
	local tree = frame
	handle = Roact.mount(tree, PlayerGui, "Results")
	Logger:Log("Results screen mounted!")
	--// SUBMIT SCORE TO SERVER DATABASE
	local pkg_data = {
		score = score;
		rating = rating;
		accuracy = acc;
		marv = marvs;
		perf = perfs;
		great = greats;
		good = goods;
		okay = okays;
		miss = misses;
		mapid = song:GetId();
		mapname = song:GetDisplayName();
		rate = Math.round(rate, 2);
		combo = maxcombo;
	}
	if doSubmit then
		Logger:Log("Submitting score to database!")
		Online:SubmitScore(pkg_data)
	end
end

function self:Unmount()
	Roact.unmount(handle)
	Logger:Log("Results screen unmounted!")
end

return self