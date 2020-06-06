local modevent = {}

local TweenService = game:GetService("TweenService")
modevent.runtime = 0.3
modevent.easingstyle = Enum.EasingStyle.Back
modevent.easingdirection = Enum.EasingDirection.Out
modevent.goal = {}

function modevent:start(rate,camorigin)
	modevent.goal.CFrame = camorigin*CFrame.Angles(0,0,math.rad(-35))
	local info = TweenInfo.new(	modevent.runtime/rate,
								modevent.easingstyle,
								modevent.easingdirection)
	local camtween = TweenService:Create(	workspace.CurrentCamera,
											info,
											modevent.goal	)
	camtween:Play()
end

return modevent
