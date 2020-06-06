local id = "rbxassetid://384094353"

game:GetService("MessagingService"):SubscribeAsync("sd", function(message)
	local sound = Instance.new("Sound", workspace)
	sound.SoundId = id
	repeat wait() until sound.IsLoaded
	sound:Play()
	sound.Volume = 1.2
end)