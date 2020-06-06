local GameRooms = workspace.GameRooms
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Multiplayer = ReplicatedStorage.Multiplayer
local TextService = game:GetService("TextService")
local maps = game.ReplicatedStorage.Songs:GetChildren()

local HTTP = game:GetService("HttpService")

local GradeAcc = {}
GradeAcc[1] = 100
GradeAcc[2] = 95
GradeAcc[3] = 90
GradeAcc[4] = 80
GradeAcc[5] = 70
GradeAcc[6] = 0
GradeAcc[7] = -10

function GetGradeIndex(grade)
	for i=1,7 do
		if grade >= GradeAcc[i] then
			return i
		end
	end
end

--//text filtering idk

local function getTextObject(message, fromPlayerId)
	local textObject
	local success, errorMessage = pcall(function()
		textObject = TextService:FilterStringAsync(message, fromPlayerId)
	end)
	if success then
		return textObject
	elseif errorMessage then
		print("Error generating TextFilterResult:", errorMessage)
	end
	return false
end

local function round(number, digits)
	local newnum = number * (10^digits)
	local remainder = newnum - math.floor(newnum)
	newnum = newnum - remainder
	if remainder >= 0.5 then
		newnum = newnum + 1
	end
	return newnum/100
end

local function getFilteredMessage(textObject)
	local filteredMessage
	local success, errorMessage = pcall(function()
		filteredMessage = textObject:GetNonChatStringForBroadcastAsync()
	end)
	if success then
		return filteredMessage
	elseif errorMessage then
		print("Error filtering message:", errorMessage)
	end
	return false
end

--//end

local function calculateRating(rate, acc, difficulty)
	local ratemult = 1
	if rate then
		if rate >= 1 then
			ratemult = 1 + (rate-1) * 0.6
		else
			ratemult = 1 + (rate-1) * 2
		end
	end
	return ratemult * ((acc/97)^4) * difficulty
	--rateMultiplier * math.pow(results[8]/97, 4) * map_Diff
end

local function update_values(player, results, finished)
	player.Okays.Value = results[5]
	player.Goods.Value = results[4]
	player.Greats.Value = results[3]
	player.Perfects.Value = results[2]
	player.Marvelouses.Value = results[1]
	player.Misses.Value = results[6]
	player.judgeCount.Value = results[7]
	player.Accuracy.Value = results[8]
	player.Score.Value = results[9]
	player.Grade.Value = GetGradeIndex(results[8])
	player.CurCombo.Value = results[10]
	player.MaxCombo.Value = results[11]
	player.AverageOffset.Value = results[12]
	player.UnstableRate.Value = results[13]
	player.Grade.Value = GetGradeIndex(results[8])
	return true
end

local function update_mavalues(player, CurrentRoom, results, finished)
	if CurrentRoom then
		local map_Diff = maps[CurrentRoom.SelectedSongIndex.Value].SongDiff.Value
		
		update_values(player, results, finished)
		
		local playRate = CurrentRoom.SelectedSongRate.Value
		local rateMultiplier = 1
		if playRate >= 1 then
			rateMultiplier = 1 + (playRate-1) * 0.6
		else
			rateMultiplier = 1 + (playRate-1) * 1.5
		end
		player.PlayRating.Value = calculateRating(playRate, results[8], map_Diff)
	end
	return true
end

function JoinRoom(player, CurrentRoom, curpw)
	local tarpw = CurrentRoom.Password.Value
	local pw = true
	if tarpw == nil or tarpw == "" then
		pw = false
	end
	print("The password for " .. CurrentRoom.Name .. " is " .. tarpw)
	if curpw == tarpw or pw == false then
		local ob = Instance.new("ObjectValue", CurrentRoom.Players)
		ob.Name = player.Name
		ob.Value = player
		ob = Instance.new("BoolValue", ob)
		ob.Name = "IsReady"
		ob.Value = false
	end
	return true
end

function SetMap(player, CurrentRoom, songindex)
	if CurrentRoom then
		local host = CurrentRoom.Players.Value
		if player == host then
			CurrentRoom.SelectedSongIndex.Value = songindex
		end
	end
	return true
end

function SetPlayRate(player, CurrentRoom, songrate)
	if CurrentRoom then
		local host = CurrentRoom.Players.Value
		if player == host then
			CurrentRoom.SelectedSongRate.Value = round(songrate, 2)
		end
	end
	return true
end

function DeleteRoom(player, CurrentRoom)	
	if CurrentRoom then
		CurrentRoom:Destroy()
	end
	return true
end

function TransferHost(player, CurrentRoom, target_player)
	if CurrentRoom then
		local host = CurrentRoom.Players
		if player == host.Value then
			host.Value = target_player
		end
	end
	return true
end

function ChangeName(player, CurrentRoom, new_name)
	if CurrentRoom then
		local host = CurrentRoom.Players.Value
		if player == host then
			local textobject = getTextObject(new_name, player.UserId)
			local filtered_name = ""
			filtered_name = getFilteredMessage(textobject)
			CurrentRoom.Value = filtered_name
		end
	end
	return true
end

function ChangePassword(player, CurrentRoom, new_password)
	if CurrentRoom then
		local host = CurrentRoom.Players.Value
		if player == host then
			CurrentRoom.Password.Value = new_password
		end
	end
	return true
end

function KickPlayer(player, CurrentRoom, kicked_player)
	if CurrentRoom then
		local host = CurrentRoom.Players.Value
		if player == host then
			if kicked_player ~= player then
				CurrentRoom.Players[kicked_player.Name]:Destroy()
			end
		end
		if #CurrentRoom.Players:GetChildren() == 0 then
			DeleteRoom(player, CurrentRoom)
		end
	end
	return true
end

function LeaveRoom(player, CurrentRoom)
	if CurrentRoom then
		local ob = CurrentRoom.Players:FindFirstChild(player.Name)
		local host = CurrentRoom.Players.Value
		if ob then
			ob:Destroy()
		end
		if #CurrentRoom.Players:GetChildren() == 0 then
			DeleteRoom(player, CurrentRoom)
		elseif player == host then
			CurrentRoom.Players.Value = CurrentRoom.Players:GetChildren()[math.random(1, #CurrentRoom.Players:GetChildren())]
		end
	end
	return true
end

function Ready(player, CurrentRoom)
	if CurrentRoom then
		local ob = CurrentRoom.Players:FindFirstChild(player.Name)
		local host = CurrentRoom.Players.Value
		if player == host then
			CurrentRoom.SongStarted.Value = false
		end
		if ob then
			ob.IsReady.Value = true
		end
	end
end

function Finished(player, CurrentRoom, leftGame)
	if CurrentRoom and not leftGame then
		local host = CurrentRoom.Players.Value
		if player == host then
			CurrentRoom.InGame.Value = false
		end
	end
end

function PlayMap(player, CurrentRoom)
	if CurrentRoom then
		local host = CurrentRoom.Players.Value
		if player == host then
			for i, player in pairs(CurrentRoom.Players:GetChildren()) do
				player.IsReady.Value = false
			end
			CurrentRoom.SongStarted.Value = true
			CurrentRoom.InGame.Value = true
		end
	end
	return true
end

function BuildMPRoom(player, roomName, password, map_Selected, playRate)
	local CurrentRoom = Instance.new("StringValue", workspace.GameRooms)
	CurrentRoom.Name = roomName
	CurrentRoom.Value = roomName
	local ob = Instance.new("StringValue", CurrentRoom)
	ob.Name = "Password"
	ob.Value = password
	ob = Instance.new("IntValue", CurrentRoom)
	ob.Name = "SelectedSongIndex"
	ob.Value = map_Selected
	ob = Instance.new("NumberValue", CurrentRoom)
	ob.Name = "SelectedSongRate"
	ob.Value = playRate
	ob = Instance.new("BoolValue", CurrentRoom)
	ob.Name = "SongStarted"
	ob.Value = false
	ob = Instance.new("BoolValue", CurrentRoom)
	ob.Name = "InGame"
	ob.Value = false
	ob = Instance.new("ObjectValue", CurrentRoom)
	ob.Name = "Players"
	ob.Value = player
	wait()
	CurrentRoom.Parent = GameRooms
	return CurrentRoom
end

game.Players.PlayerRemoving:Connect(function(player)
	local name = player.Name
	for i, room in pairs(GameRooms:GetChildren()) do
		for i, room_player in pairs(room.Players:GetChildren()) do
			if player == room_player.Value then
				room_player:Destroy()
				if #room.Players:GetChildren() > 0 then
					local host = room.Players
					if player == host.Value then
						room.Players.Value = host:GetChildren()[math.random(1, #host:GetChildren())]
					end
				end
			end
		end
		if #room.Players:GetChildren() == 0 then
			DeleteRoom(player, room)
		end
	end
end)
game.Players.PlayerAdded:Connect(function(p)
	--[[
		player.Okays.Value = results[5]
		player.Goods.Value = results[4]
		player.Greats.Value = results[3]
		player.Perfects.Value = results[2]
		player.Marvelouses.Value = results[1]
		player.Misses.Value = results[6]
		player.judgeCount.Value = results[7]
		player.Accuracy.Value = results[8]
		player.Score.Value = results[9]
		player.CurCombo.Value = results[10]
		player.MaxCombo.Value = results[11]
	--]]
	local __ = Instance.new("IntValue",p)
	__.Name = "Okays"
	__ = Instance.new("NumberValue",p)
	__.Name = "Goods"
	__ = Instance.new("NumberValue",p)
	__.Name = "Greats"
	__ = Instance.new("NumberValue",p)
	__.Name = "Perfects"
	__ = Instance.new("NumberValue",p)
	__.Name = "Marvelouses"
	__ = Instance.new("NumberValue",p)
	__.Name = "Misses"
	__ = Instance.new("NumberValue",p)
	__.Name = "judgeCount"
	__ = Instance.new("NumberValue",p)
	__.Name = "Accuracy"
	__ = Instance.new("NumberValue",p)
	__.Name = "Score"
	__ = Instance.new("NumberValue",p)
	__.Name = "CurCombo"
	__ = Instance.new("NumberValue",p)
	__.Name = "MaxCombo"
	__ = Instance.new("NumberValue",p)
	__.Name = "Grade"
	__ = Instance.new("NumberValue",p)
	__.Name = "PlayRating"
	__ = Instance.new("NumberValue",p)
	__.Name = "UnstableRate"
	__ = Instance.new("NumberValue",p)
	__.Name = "AverageOffset"
	__ = Instance.new("StringValue",p)
	__.Name = "NoteDeviance"
end)

function SubmitNoteDeviance(player, data)
	local ND_obj = player:WaitForChild("NoteDeviance")
	ND_obj.Value = HTTP:JSONEncode(data)
end

Multiplayer.JoinRoom.OnServerInvoke = JoinRoom
Multiplayer.SetMap.OnServerInvoke = SetMap
Multiplayer.SetPlayRate.OnServerInvoke = SetPlayRate
Multiplayer.TransferHost.OnServerInvoke = TransferHost
Multiplayer.ChangeName.OnServerInvoke = ChangeName
Multiplayer.ChangePassword.OnServerInvoke = ChangePassword
Multiplayer.KickPlayer.OnServerInvoke = KickPlayer
Multiplayer.LeaveRoom.OnServerInvoke = LeaveRoom
Multiplayer.PlayMap.OnServerInvoke = PlayMap
Multiplayer.CreateRoom.OnServerInvoke = BuildMPRoom
Multiplayer.Ready.OnServerInvoke = Ready
Multiplayer.Finished.OnServerInvoke = Finished
Multiplayer.UpdateMAValues.OnServerEvent:Connect(update_mavalues)
Multiplayer.SubmitNoteDeviance.OnServerEvent:Connect(SubmitNoteDeviance)
Multiplayer.UpdateValues.OnServerEvent:Connect(update_values)