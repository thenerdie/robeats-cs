local modevent = {}

local TweenService = game:GetService("TweenService")
modevent.runtime = 0.2
modevent.easingstyle = Enum.EasingStyle.Quint
modevent.easingdirection = Enum.EasingDirection.In
modevent.goal = {}

function modevent:start(rate,camorigin)
	modevent.goal.CFrame = camorigin*CFrame.new(6,-2,-5)
	local info = TweenInfo.new(	modevent.runtime/rate,
								modevent.easingstyle,
								modevent.easingdirection)
	local camtween = TweenService:Create(	workspace.CurrentCamera,
											info,
											modevent.goal	)
	camtween:Play()
end

return modevent
