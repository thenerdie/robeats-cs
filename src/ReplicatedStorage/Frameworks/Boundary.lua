local RunService = game:GetService("RunService")

local Boundary = {}
Boundary.Server = {}
Boundary.Client = {}

--// CLIENT METHODS:

function Boundary.Client:Execute(name, ...)
    local r = script:WaitForChild(name, 5)
    if r ~= nil then
        return r:InvokeServer(...)
    end
    return nil
end

--// SERVER METHODS:

function Boundary.Server:Register(name, callback)
    local rf = Instance.new("RemoteFunction")
    rf.Name = name
    rf.OnServerInvoke = callback
    rf.Parent = script
end



return Boundary