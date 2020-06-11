local RunService = game:GetService("RunService")

local Logger = {}

local function genBase()
    local ret = ""
    if RunService:IsStudio() then
        ret  = ret .. "[TEST] "
    else
        ret  = ret .. "[RELEASE] "
    end
    if RunService:IsClient() then
        ret  = ret .. "[CLIENT] "
    else
        ret  = ret .. "[SERVER] "
    end
    return ret
end

local function out(msg)
    local base = genBase()
    print(base..msg)
end

function Logger:register(scr)
    local self = {}

    function self:Log(msg)
        out(scr:GetFullName() .. ".lua | " .. msg)
    end

    return self
end

return Logger
