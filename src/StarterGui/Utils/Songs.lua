local RunService = game:GetService("RunService")

local SongObject = require(script.Parent.SongObject)
local AllSongs = game.ReplicatedStorage:WaitForChild("LocalStorage"):WaitForChild("Songs")
local TestSongs = game.ReplicatedStorage:WaitForChild("TestSongs", 5)

local Songs = {}

function Songs:GetAllSongs()
	local sgs = {}
	for i, song in pairs(AllSongs:GetChildren()) do
		sgs[#sgs+1] = SongObject:new(song)
	end
	if RunService:IsStudio() and TestSongs ~= nil then
		for i, song in pairs(TestSongs:GetChildren()) do
			sgs[#sgs+1] = SongObject:new(song)
		end
	end
	return sgs
end

return Songs
