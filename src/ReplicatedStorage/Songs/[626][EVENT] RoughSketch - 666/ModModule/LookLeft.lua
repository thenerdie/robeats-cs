local modevent = {}

local TweenService = game:GetService("TweenService")
modevent.runtime = 0.2
modevent.easingstyle = Enum.EasingStyle.Quint
modevent.easingdirection = Enum.EasingDirection.In
modevent.goal = {}

function modevent:start(rate,camorigin)
	local kureha = workspace:FindFirstChild("Kureha")
	if kureha then
		local hum = kureha.Humanoid
		local root = kureha.HumanoidRootPart
		local att_circle = root.Att_Circle
		att_circle.Emitter.Size = NumberSequence.new(28)
		att_circle.Emitter.Enabled = true
		local anim_handsup = kureha.Anim_Handsup
		local track_handsup = hum:LoadAnimation(anim_handsup)
		track_handsup:Play()
		track_handsup:AdjustSpeed(rate)
	else
		print("Where's the Kureha model!?")
	end
	modevent.goal.CFrame = camorigin*CFrame.new(-6,-2,-5)
	local info = TweenInfo.new(	modevent.runtime/rate,
								modevent.easingstyle,
								modevent.easingdirection)
	local camtween = TweenService:Create(	workspace.CurrentCamera,
											info,
											modevent.goal	)
	camtween:Play()
end

return modevent
