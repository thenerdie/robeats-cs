-- TODO: make this module rate limit itself so it doesnt like spam the database or anything like that

local r = game.ReplicatedStorage
local m = r:WaitForChild("Misc")

local _curSelected = nil

local Online = {}

function Online:GetMapLeaderboard(m_ID)
	_curSelected = m_ID
	wait(0.3)
	if m_ID ~= _curSelected then return {} end
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
