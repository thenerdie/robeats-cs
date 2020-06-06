local modevent = {}

function modevent:start(rate,camorigin)
	local kureha = workspace:FindFirstChild("Kureha")
	if kureha then
		local hum = kureha.Humanoid
		local anim_sliceup = kureha.Anim_SliceUp
		local track_sliceup = hum:LoadAnimation(anim_sliceup)
		track_sliceup:Play()
		track_sliceup:AdjustSpeed(rate)
	else
		print("Where's the Kureha model!?")
	end
end

return modevent
