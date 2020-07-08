local r = game.ReplicatedStorage
local m = r:WaitForChild("Misc")

local Online = {}

function Online:GetMapLeaderboard(m_ID)
	return m.GetSongLeaderboard:InvokeServer(m_ID)
end

function Online:GetPlayerPlays()
	return m.GetTopPlays:InvokeServer()
end

function Online:GetGlobalLeaderboard()
	return m.GetGlobalLeaderboard:InvokeServer()
end

function Online:SubmitScore(pkg_data)
	m.SubmitScore:InvokeServer(pkg_data)
end

return Online
