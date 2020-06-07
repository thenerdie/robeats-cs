local r = game.ReplicatedStorage
local m = r:WaitForChild("Misc")

local Online = {}

function Online:GetMapLeaderboard(m_ID)
	return m.GetSongLeaderboard:InvokeServer(m_ID)
end

function Online:GetPlayerPlays(p_ID)
	return m.GetTopPlays:InvokeServer()
end

function Online:GetGlobalLeaderboard()
	return m.GetGlobalLeaderboard:InvokeServer()
end

return Online
