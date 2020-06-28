local SongObject = require(script.Parent.SongObject)
local AllSongs = game.ReplicatedStorage:WaitForChild("Songs")

local Songs = {}

function Songs:GetAllSongs()
	local sgs = {}
	for i, song in pairs(AllSongs:GetChildren()) do
		sgs[#sgs+1] = SongObject:new(song)
	end
	return sgs
end

return Songs
