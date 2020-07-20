local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Boundary = require(ReplicatedStorage.Frameworks.Boundary)
local BoundaryServer = Boundary.Server

local MultiplayerRoom = {}

function MultiplayerRoom:new()
    local room = {}

    room.song = nil
    room.players = {}
    room.host = {}

    function room:AddPlayer(plr)
        room[#room+1] = plr
    end

    function room:ChangeSong(song)
        room.song = song
    end
    
    function room:StartGame()
        
    end

    return room    
end

return MultiplayerRoom
