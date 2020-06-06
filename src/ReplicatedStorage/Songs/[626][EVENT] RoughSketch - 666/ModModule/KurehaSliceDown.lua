local modevent = {}

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

local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local plrs_serivce = game:GetService("Players")
local localplr = plrs_serivce.LocalPlayer
local plrgui = localplr:FindFirstChild("PlayerGui")
modevent.runtime = 0.5
modevent.goal = {BackgroundTransparency = 1}

function modevent:start(rate,camorigin)
	local flashui = script.FlashUI:Clone()
	local flashframe = flashui.Frame
	local localelements = cam:FindFirstChild("LocalElements")
	local environment = cam:FindFirstChild("GameEnvironment")
	if (not localelements) or (not environment) then return end
	local tb1 = localelements.TriggerButtonProto1
	local tb2 = localelements.TriggerButtonProto2
	local tb3 = localelements.TriggerButtonProto3
	local tb4 = localelements.TriggerButtonProto4
	local track1 = cam.Track1
	local track2 = cam.Track2
	local track3 = cam.Track3
	local track4 = cam.Track4
	local background = environment.Background
	local kureha = workspace:FindFirstChild("Kureha")
	if kureha then
		local hum = kureha.Humanoid
		local anim_slicedown = kureha.Anim_SliceDown
		local track_slicedown = hum:LoadAnimation(anim_slicedown)
		local function SplitTrack()
			flashui.Parent = plrgui
			local tweentime = modevent.runtime/rate
			local info = TweenInfo.new(tweentime)
			local flashtween = TweenService:Create(flashframe,info,modevent.goal)
			if background then
				background.Stage.Union.Transparency = 1
				background.Stage.Union2.Transparency = 1
				background.Stage.Union3.Transparency = 0
			end
			modevent:setcframe_left(tb1)
			modevent:setcframe_left(tb2)
			modevent:setcframe_right(tb3)
			modevent:setcframe_right(tb4)
			modevent:setcframe_left(track1)
			modevent:setcframe_left(track2)
			modevent:setcframe_right(track3)
			modevent:setcframe_right(track4)
			flashtween:Play()
			Debris:AddItem(flashui,tweentime+1)
		end
		track_slicedown:GetMarkerReachedSignal("Slice"):Connect(SplitTrack)
		track_slicedown:Play()
		track_slicedown:AdjustSpeed(rate)
	else
		print("Where's the Kureha model!?")
	end
end

return modevent
