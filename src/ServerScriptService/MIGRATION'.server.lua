local songs = game:GetService("ReplicatedStorage").Songs
local override = false
local Grist = require(game.ReplicatedStorage.Grist.API)
--//players that can unlock epic secret songs (please add ur id now lol)
local AdminPlayers = {36304080, 33607300, 45616186, 167327389,35585415,77833049,58107975,77183382,526993347,479166713}
local DataStoreService = game:GetService("DataStoreService")
local TopPlays = nil
local GlobalLeaderboard = nil
local MapLeaderboards = nil
local pp = nil
local grist_loaded = false
spawn(function()
	GlobalLeaderboard = Grist:Get("GlobalLeaderboard")
	pp = Grist:Get("PlayerPlays")
	grist_loaded = true
end)
function getIdFromMap(map_name)
	local retString = ""
	for char in string.gmatch(map_name, ".") do
		if char ~= "[" then
			if char == "]" then break end
			retString = retString .. char
		end
	end
	return retString
end
--------------------------------------------------------------------------------------------------------------------
repeat wait() until grist_loaded
