local modevent = {}

local TweenService = game:GetService("TweenService")
modevent.runtime = 0.3
modevent.easingstyle = Enum.EasingStyle.Quint
modevent.easingdirection = Enum.EasingDirection.Out
modevent.goal = {}

local cam = workspace.CurrentCamera
modevent.offset = Vector3.new(1.5,0,1.5)

function modevent:setcframe_left(model)
	for i,v in pairs(model:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Position = v.Position - modevent.offset
		end
	end
end
function modevent:setcframe_right(model)
	for i,v in pairs(model:GetDescendants()) do
		if v:IsA("BasePart") then
			v.Position = v.Position + modevent.offset
		end
	end
end


function modevent:start(rate,camorigin)
	local localelements = cam:FindFirstChild("LocalElements")
	if not localelements then return end
	local tb1 = localelements:FindFirstChild("TriggerButtonProto1")
	local tb2 = localelements:FindFirstChild("TriggerButtonProto2")
	local tb3 = localelements:FindFirstChild("TriggerButtonProto3")
	local tb4 = localelements:FindFirstChild("TriggerButtonProto4")
	local track1 = cam:FindFirstChild("Track1")
	local track2 = cam:FindFirstChild("Track2")
	local track3 = cam:FindFirstChild("Track3")
	local track4 = cam:FindFirstChild("Track4")
	local environment = cam:FindFirstChild("GameEnvironment")
	local background = environment:FindFirstChild("Background")
	if background then
		background.Stage.Union.Transparency = 0
		background.Stage.Union2.Transparency = 1
		background.Stage.Union3.Transparency = 1
	end
	if tb1 and tb2 and tb3 and tb4
	and track1 and track2 and track3 and track4 then
		modevent:setcframe_left(tb3)
		modevent:setcframe_left(tb4)
		modevent:setcframe_right(tb1)
		modevent:setcframe_right(tb2)
		modevent:setcframe_left(track3)
		modevent:setcframe_left(track4)
		modevent:setcframe_right(track1)
		modevent:setcframe_right(track2)
	end
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
