local r = game.ReplicatedStorage


local Online = {}

function Online:GetMapLeaderboard(m_ID)
	return r.GetSongLeaderboard:InvokeServer(m_ID)
end

function Online:GetPlayerPlays(p_ID)
	return r.GetTopPlays:InvokeServer()
end

function Online:GetGlobalLeaderboard()
	return r.GetGlobalLeaderboard:InvokeServer()
end

return Online
