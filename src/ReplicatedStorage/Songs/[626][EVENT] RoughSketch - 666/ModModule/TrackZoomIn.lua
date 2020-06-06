local modevent = {}

local TweenService = game:GetService("TweenService")
modevent.runtime = 0.4
modevent.easingstyle = Enum.EasingStyle.Cubic
modevent.easingdirection = Enum.EasingDirection.Out
modevent.goal = {}

function modevent:start(rate,camorigin)
	modevent.goal.CFrame = camorigin*CFrame.new(0,10,-7)
									*CFrame.Angles(math.rad(-30),0,0)
	local info = TweenInfo.new(	modevent.runtime/rate,
								modevent.easingstyle,
								modevent.easingdirection)
	local camtween = TweenService:Create(	workspace.CurrentCamera,
											info,
											modevent.goal	)
	camtween:Play()
end

return modevent
