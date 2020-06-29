local UserInputService = game:GetService("UserInputService")

local Keybind = {}

function Keybind:listen(keyCode, callback)
    callback = callback or function()
        warn("Callback not implemented! Please check your code!")
    end
    local connection = nil
    local function setListener()
        connection = UserInputService.InputBegan:Connect(function(u)
            if u.KeyCode == keyCode then
                callback(u)
            end
        end)
    end
    setListener()
    self = {}

    function self:stop()
        connection:Disconnect()
    end

    function self:begin()
        setListener()
    end

    return self
end

return Keybind
