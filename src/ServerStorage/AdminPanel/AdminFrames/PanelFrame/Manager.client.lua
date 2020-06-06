local AdminPanel = script.Parent.Parent
local PlayerFrame = AdminPanel:WaitForChild("PlayerFrame")
local PanelFrame = script.Parent
local ActionFrame = AdminPanel:WaitForChild("ActionFrame")
local PlayerTemplate = script:WaitForChild("Player")
local Buttons = PanelFrame:WaitForChild("Buttons")
local BackToHome = AdminPanel:WaitForChild("BackToHome")
local Events = game.ReplicatedStorage.AdminPanelEvents

local oldState = nil

local function SwitchStates(newState)
	BackToHome.Visible = newState ~= PanelFrame
	if oldState == nil then
		newState.Visible = true
	else
		oldState.Visible = false
		newState.Visible = true
	end
	oldState = newState
end

SwitchStates(PanelFrame)

Buttons.kick.MouseButton1Click:Connect(function()
	SwitchStates(PlayerFrame)
	local players = game.Players:GetPlayers()
	for i, v in pairs(PlayerFrame.Players:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end
	for i, v in pairs(players) do
		local player = PlayerTemplate:Clone()
		player.Parent = PlayerFrame.Players
		player.Text = v.Name
		player.PlayerOb.Value = v
		player.MouseButton1Click:Connect(function()
			SwitchStates(ActionFrame)
			local con = nil
			con = ActionFrame.ActionBox.FocusLost:Connect(function(enterPressed) if enterPressed then
				Events.Kick:FireServer(player.PlayerOb.Value, ActionFrame.ActionBox.Text)
				SwitchStates(PanelFrame)
				con:Disconnect()
			end end)
		end)
		player.Visible = true
	end
end)

Buttons.ban.MouseButton1Click:Connect(function()
	SwitchStates(PlayerFrame)
	local players = game.Players:GetPlayers()
	for i, v in pairs(PlayerFrame.Players:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end
	for i, v in pairs(players) do
		local player = PlayerTemplate:Clone()
		player.Parent = PlayerFrame.Players
		player.Text = v.Name
		player.PlayerOb.Value = v
		player.MouseButton1Click:Connect(function()
			SwitchStates(ActionFrame)
			local con = nil
			con = ActionFrame.ActionBox.FocusLost:Connect(function(enterPressed) if enterPressed then
				Events.Ban:FireServer(player.PlayerOb.Value, ActionFrame.ActionBox.Text)
				SwitchStates(PanelFrame)
				con:Disconnect()
			end end)
		end)
		player.Visible = true
	end
end)

Buttons.audio.MouseButton1Click:Connect(function()
	SwitchStates(ActionFrame)
	local con = nil
	con = ActionFrame.ActionBox.FocusLost:Connect(function(enterPressed) if enterPressed then
		Events.Audio:FireServer(ActionFrame.ActionBox.Text)
		SwitchStates(PanelFrame)
	end end)
end)

Buttons.warn.MouseButton1Click:Connect(function()
	SwitchStates(PlayerFrame)
	local players = game.Players:GetPlayers()
	for i, v in pairs(PlayerFrame.Players:GetChildren()) do
		if v:IsA("TextButton") then
			v:Destroy()
		end
	end
	for i, v in pairs(players) do
		local player = PlayerTemplate:Clone()
		player.Parent = PlayerFrame.Players
		player.Text = v.Name
		player.PlayerOb.Value = v
		player.MouseButton1Click:Connect(function()
			SwitchStates(ActionFrame)
			local con = nil
			con = ActionFrame.ActionBox.FocusLost:Connect(function(enterPressed) if enterPressed then
				Events.Warn:FireServer(player.PlayerOb.Value, ActionFrame.ActionBox.Text)
				SwitchStates(PanelFrame)
				con:Disconnect()
			end end)
		end)
		player.Visible = true
	end
end)

Buttons.message.MouseButton1Click:Connect(function()
	SwitchStates(ActionFrame)
	local con = nil
	con = ActionFrame.ActionBox.FocusLost:Connect(function(enterPressed) if enterPressed then
		Events.Message:FireServer(ActionFrame.ActionBox.Text)
		SwitchStates(PanelFrame)
		con:Disconnect()
	end end)
end)

BackToHome.MouseButton1Click:Connect(function()
	SwitchStates(PanelFrame)
	BackToHome.Visible = false
end)