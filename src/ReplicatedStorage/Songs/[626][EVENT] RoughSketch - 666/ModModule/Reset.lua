local modevent = {}

local TweenService = game:GetService("TweenService")
modevent.runtime = 0.5
modevent.easingstyle = Enum.EasingStyle.Quint
modevent.easingdirection = Enum.EasingDirection.InOut
modevent.goal = {}

function modevent:start(rate,camorigin)
	modevent.goal.CFrame = camorigin
	local info = TweenInfo.new(	modevent.runtime/rate,
								modevent.easingstyle,
								modevent.easingdirection)
	local camtween = TweenService:Create(	workspace.CurrentCamera,
											info,
											modevent.goal	)
	camtween:Play()
end

return modevent
