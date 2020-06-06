-- This timepoint also spawn Kureha.

local modevent = {}

local storage = game:GetService("ReplicatedStorage")
local kurehabase = storage:FindFirstChild("Kureha")

modevent.spawnloc = Vector3.new(1.163, 49, -4.925)
modevent.spawnangle = CFrame.Angles(0,math.rad(135),0)
modevent.spawncframe = CFrame.new(modevent.spawnloc) * modevent.spawnangle

local TweenService = game:GetService("TweenService")
modevent.runtime = 0.1
modevent.easingstyle = Enum.EasingStyle.Quint
modevent.easingdirection = Enum.EasingDirection.InOut
modevent.goal = {}

local ContentProvider = game:GetService("ContentProvider")

function modevent:loadanimations(model)
	local anims = {}
	for i,v in pairs(model:GetChildren()) do
		if v:IsA("Animation") then
			table.insert(anims,v)
		end
	end
	ContentProvider:PreloadAsync(anims)
end

function modevent:start(rate,camorigin)
	if kurehabase then
		local kureha = kurehabase:Clone()
		local hum = kureha.Humanoid
		local anim_idle = kureha.Anim_Idle
		kureha:SetPrimaryPartCFrame(modevent.spawncframe)
		print("Kureha spawned")
		kureha.Parent = workspace
		spawn(function()
			modevent:loadanimations(kureha)
			local track_idle = hum:LoadAnimation(anim_idle)
			track_idle:Play()
			track_idle:AdjustSpeed(rate)
		end)
	else
		print("Where's the Kureha model!?")
	end
	modevent.goal.CFrame = camorigin
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
