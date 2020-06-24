local TweenService = game:GetService("TweenService")

local CurrentCamera = workspace.CurrentCamera
local cam_origin = CurrentCamera.CFrame

local function tween(obj, time, pt, syn)
    local ti = TweenInfo.new(time or 1)
    local tween = TweenService:Create(obj, ti, pt)
    tween:Play()
    if syn then
        repeat wait() until tween.PlaybackState == Enum.PlaybackState.Completed
    end
end

local Modchart = {}

function Modchart:Init()
    cam_origin = CurrentCamera.CFrame
end

function Modchart:BounceCam(amount, time)
    amount = amount or 10
    time = time or 0.1
    local oldAmt = CurrentCamera.FieldOfView
    tween(CurrentCamera, time, {
        FieldOfView = oldAmt - amount;
    }, true)
    tween(CurrentCamera, time, {
        FieldOfView = oldAmt;
    }, true)
end

function Modchart:RotateCam(angles, time)
    amount = amount or 10
    time = time or 0.1
    tween(CurrentCamera, time, {
        CFrame = cam_origin*angles;
    })
end

function Modchart:PositionCam(offset, time)
    print(offset)
    time = time or 0.1
    tween(CurrentCamera, time, {
        CFrame = cam_origin+offset;
    })
end

function Modchart:SetTimeOfDay(ctime, time)
    tween(game.Lighting, time, {
        ClockTime = ctime;
    })
end

return Modchart