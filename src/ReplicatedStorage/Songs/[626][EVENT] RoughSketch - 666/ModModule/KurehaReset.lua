local modevent = {}

function modevent:start(rate,camorigin)
	local kureha = workspace:FindFirstChild("Kureha")
	if kureha then
		local hum = kureha.Humanoid
		local root = kureha.HumanoidRootPart
		root.PointLight.Enabled = false
		local att_fire = root.Att_Fire
		att_fire.Emitter1.Enabled = false
		att_fire.Emitter2.Enabled = false
		local att_circle = root.Att_Circle
		att_circle.Emitter.Enabled = false
		local tracks = hum:GetPlayingAnimationTracks()
		for i,track in pairs(tracks) do
			track:Stop()
		end
		local anim_idle = kureha.Anim_Idle
		local track_idle = hum:LoadAnimation(anim_idle)
		track_idle:Play()
		track_idle:AdjustSpeed(rate)
	else
		print("Where's the Kureha model!?")
	end
end

return modevent
