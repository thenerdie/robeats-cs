local ServerScriptService = game:GetService("ServerScriptService")
local Chat = require(ServerScriptService:WaitForChild('ChatServiceRunner'):WaitForChild('ChatService'))

function Chat:GiveRolesToSpeaker(plr, roles)
    assert(plr ~= nil, "PlayerName (speaker) must be a string!")
    assert(roles ~= nil, "Roles must not be nil!")
    local skr = self:GetSpeaker(plr)
    if skr then
        local tags = {}
        for i, role in pairs(roles) do
            tags[i] = {
                TagText = role.Name;
                TagColor = role.Color;
            }
        end
        skr:SetExtraData("Tags", tags)
    end
end

function Chat.role(name, color)
    return {
        Name = name;
        Color = color;
    }
end

return Chat