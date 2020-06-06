-- by Regen_erate
--// SERVER BACKEND FOR ADMIN PANEL FOR ROBEATS CS

local events = game:GetService("ReplicatedStorage").AdminPanelEvents
local ban = game:GetService("DataStoreService"):GetDataStore("Bans")
local ServerStorage = game:GetService("ServerStorage")
local AdminPanel = ServerStorage:WaitForChild("AdminPanel")
--[[
events.--.OnServerEvent:Connect(function(player, message)
	if isAdmin(player) then
		
	end
end)
]]--
local function isAdmin(player)
	local p_ID = player.UserId
	if player:IsInGroup(4342575) then
		if player:GetRankInGroup(4342575) >= 253 then
			return true
		end
	end
	return false
end

events.Kick.OnServerEvent:Connect(function(player, kickPlayer, reason)
	if not reason then
		reason = "No reason given by " .. player.Name
	end
	if isAdmin(player) then
		kickPlayer:Kick(reason)
	end
end)

events.Ban.OnServerEvent:Connect(function(player, kickPlayer, reason)
	if not reason then
		reason = "You have been banned by " .. player.Name
	end
	if isAdmin(player) then
		kickPlayer:Kick(reason)
		ban:SetAsync(tostring(player.UserId), reason)
	end
end)

events.Unban.OnServerEvent:Connect(function(player, unbanPlayer)
	if isAdmin(player) then
		ban:RemoveAsync(tostring(player.UserId))
	end
end)

events.Message.OnServerEvent:Connect(function(player, message)
	if isAdmin(player) then
		workspace.Message.Text = message
	end
end)

events.Audio.OnServerEvent:Connect(function(player, id)
	if isAdmin(player) then
		workspace.Sound:Stop()
		local audioId = ""
		if tonumber(id) == nil then
			audioId = id
		else
			audioId = "rbxassetid://" .. tostring(id)
		end
		workspace.Sound.SoundId = audioId
		repeat wait() until workspace.Sound.IsLoaded
		workspace.Sound:Play()
	end
end)

events.Warn.OnServerEvent:Connect(function(player, playerWarned, message)
	if isAdmin(player) then
		local warningGui = ServerStorage.AdminWarning:Clone()
		local warningGuiFrame = warningGui:WaitForChild("WarningFrame")
		warningGuiFrame.WarningFrom.Text = "You have recieved a warning from " .. player.Name
		warningGuiFrame.Warning.Text = message
		warningGuiFrame.Exit.Text = "..."
		warningGuiFrame.Exit.Active = false
		delay(5, function()
			warningGuiFrame.Exit.Text = "OK, I understand."
			warningGuiFrame.Exit.Active = true
		end)
		warningGui.Parent = playerWarned:WaitForChild("PlayerGui")
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	local banReason = ban:GetAsync(tostring(player.UserId))
	if banReason then
		player:Kick(banReason)
	end
	if isAdmin(player) then
		local adminPanel = AdminPanel:Clone()
		adminPanel.Parent = player:WaitForChild("PlayerGui")
	end
end)