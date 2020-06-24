-- todo: make this function live
local HTTP = game:GetService("HttpService")
local LOCA = game:GetService("LocalizationService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Misc = ReplicatedStorage:WaitForChild("Misc")

local baseUrl = "robeatscsgame.com/api/"

baseUrl = "https://" .. baseUrl

print(baseUrl)

local function sendScore(data)
	local headers = {
		["Content-Type"] = "application/json";
	}
	local params = {
		Headers=headers;
		Body=HTTP:JSONEncode(data);
		Method="POST";
		Url=baseUrl.."/submitscore";
	}
	local res = nil
	local suc, err = pcall(function()
		res = HTTP:RequestAsync(params)
	end)
	if not suc then
		warn(err)
	else
		print("Score sent with a status code of: " .. res.StatusCode)
		if res.StatusCode ~= 200 then return {} end
		local ret = {}
		local suc, err = pcall(function()
			ret = HTTP:JSONDecode(res.Body)
		end)
		if not suc then
			ret = {}
		end
		return ret
	end
end

local function getPlays(p_ID)
	p_ID = "P"..tostring(p_ID)
	local headers = {
		["Content-Type"] = "application/json";
	}
	local params = {
		Headers=headers;
		Method="GET";
		Url=baseUrl.."/user/" + p_ID;
	}
	local res = nil
	local suc, err = pcall(function()
		res = HTTP:RequestAsync(params)
	end)
	if not suc then
		warn(err)
		return {}
	else
		if res.StatusCode ~= 200 then return {} end
		local ret = {}
		local suc, err = pcall(function()
			ret = HTTP:JSONDecode(res.Body)
		end)
		if not suc then
			ret = {}
		end
		return ret
	end
end

local function getMapLeaderboard(m_ID)
	local headers = {
		["Content-Type"] = "application/json";
	}
	local params = {
		Headers=headers;
		Method="GET";
		Url=baseUrl.."/maps/" .. m_ID;
	}
	local res = nil
	local suc, err = pcall(function()
		res = HTTP:RequestAsync(params)
	end)
	if not suc then
		warn(err)
		return {}
	else
		if res.StatusCode ~= 200 then return {} end
		local ret = {}
		local suc, err = pcall(function()
			ret = HTTP:JSONDecode(res.Body)
		end)
		if not suc then
			ret = {}
		end
		return ret
	end
end

local function getGlobalLeaderboard()
	local headers = {
		["Content-Type"] = "application/json";
	}
	local params = {
		Headers=headers;
		Method="GET";
		Url=baseUrl.."/global";
	}
	local res = nil
	local suc, err = pcall(function()
		res = HTTP:RequestAsync(params)
	end)
	if not suc then
		warn(err)
		return {}
	else
		if res.StatusCode ~= 200 then return {} end
		local ret = {}
		local suc, err = pcall(function()
			ret = HTTP:JSONDecode(res.Body)
		end)
		if not suc then
			ret = {}
		end
		return ret
	end
end

local function getStats(p_ID)
	p_ID = "P"..tostring(p_ID)
	local headers = {
		["Content-Type"] = "application/json";
	}
	local params = {
		Headers=headers;
		Method="GET";
		Url=baseUrl.."/stats/" .. p_ID;
	}
	local res = nil
	local suc, err = pcall(function()
		res = HTTP:RequestAsync(params)
	end)
	if not suc then
		warn(err)
		return {}
	else
		print(res.Body, res.StatusCode)
		if res.StatusCode ~= 200 then return {} end
		local ret = {}
		local suc, err = pcall(function()
			ret = HTTP:JSONDecode(res.Body)
		end)
		print(ret)
		if not suc then
			ret = {}
		end
		return ret
	end
end
--------------------------------------------------------------------------------------------------------------------
local hint = Instance.new("Hint")
hint.Parent = workspace
--------------------------------------------------------------------------------------------------------------------

--HttpWrapper:GetAsync("5dfc1fd5c9734b7cbb9cdaeb", false)
--MapLeaderboards = HttpWrapper:GetAsync("5dfea492bda54254c5f0b62b", false)
--TopPlays = HttpWrapper:GetAsync("5dfeac44bda54254c5f0b941", false)
--------------------------------------------SLOT REFERENCE--------------------------------------------------------------------------
-- GL SLOT ->>> [(num) INDEX] = {(num) Rating=0; (string) PlayerName=""; (num) TotalMapsPlayed=0; (string) UserId=""}
-- PLAY SLOT ->>> [(num) INDEX] = {(num) Score=0; (num) Rating=0; (num) Accuracy=0 (string) Rate=""; (string) Spread=""; (string) PlayerName=""; (string) UserId=""}
-- TP SLOT ->>> same as PLAY SLOT
------------------------------------------------------------------------------------------------------------------------------------
--//players who are banned from the game

local function gen_play_slot(s, r, acc, rate, pn, ud, spd)
	return {Score=s; Rating=r; Accuracy=acc; Rate=rate; PlayerName=pn; UserId=ud; Spread=spd}
end

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
---------------------

function calculateRating(rate, acc, difficulty)
	local ratemult = 1
	if rate then
		if rate >= 1 then
			ratemult = 1 + (rate-1) * 0.6
		else
			ratemult = 1 + (rate-1) * 2
		end
	end
	return ratemult * ((acc/97)^4) * difficulty
end

local function DidCheat(player, map, score, accuracy, rate, spread)
	local playRating = calculateRating(rate, accuracy, map.SongDiff.Value)
	local cheated = false
	if not map then
		cheated = true
	end
	if accuracy > 100 then
		cheated = true
	end
	local spd = {}
	local splt = string.split(spread, '/')
	for i, v in pairs(splt) do
		if i > 1 then
			spd[#spd+1] = tonumber(v)
		end
	end
	local zeroJud = 0
	for i, v in pairs(spd) do
		if v == 0 then
			zeroJud = zeroJud + 1
		end
	end
	if zeroJud == 5 and playRating > 50 then
		cheated = true
	end
	if cheated then
		warn("Player " .. player.Name .. " most likely cheated with spread " .. spread .. ", accuracy " .. tostring(accuracy) .. ", rate " .. tostring(rate) .. ", and score " .. tostring(score) .. " on map " .. map.Name .. ".")
	end
	return cheated
end

local function valStat(stat)
	if stat ~= nil then
		return (stat.Rank ~= nil and stat.Data ~= nil)
	else
		return false
	end
end

local function getAvatarUrl(p_ID)
	local uri = game:GetService("Players"):GetUserThumbnailAsync(p_ID, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	return uri
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

game.Players.PlayerAdded:Connect(function(p)
	local p_ID = p.UserId
	local leaderstats = Instance.new("IntValue")
	leaderstats.Parent = p
	leaderstats.Name = "leaderstats"
	local rank = Instance.new("StringValue")
	rank.Parent = leaderstats
	rank.Name = "Rank"
	local rating = Instance.new("NumberValue")
	rating.Parent = leaderstats
	rating.Name = "Rating"
	local country = Instance.new("StringValue")
	country.Parent = leaderstats
	country.Name = "Country"
	country.Value = LOCA:GetCountryRegionForPlayerAsync(p)
	
	local data = getStats(p_ID)
	if valStat(data) then
		if data.Rank then
			rank.Value = "#" .. tostring(tonumber(data.Rank) + 1)
		end
		if data.Data.Rating then
			rating.Value = data.Data.Rating
		end
	else
		rank.Value = "#??"
		rating.Value = 0
	end
end)

game.Players.PlayerRemoving:Connect(function(p)
	-- idk bye i guess
end)

Misc.GetSongLeaderboard.OnServerInvoke = function(player, m_ID)
	return getMapLeaderboard(m_ID)
end

Misc.GetTopPlays.OnServerInvoke = function(player)
	local p_ID = "P" .. tostring(player.UserId)
	return getPlays(p_ID)
end

Misc.GetGlobalLeaderboard.OnServerInvoke = function()
	return getGlobalLeaderboard()
end

Misc.SubmitScore.OnServerInvoke = function(player, map, score, accuracy, rate, spread, tierColor, hitData) --plr, inst, num, num, string, color, [array]
	print("// Score Submission Started...")
	local cheated = DidCheat(player, map, score, accuracy, rate, spread)
	local leaderstats = player:WaitForChild("leaderstats")
	local map_name = getIdFromMap(map.Name)
	local rating = calculateRating(rate, accuracy, map.SongDiff.Value)
	local p_ID = "P" .. tostring(player.UserId)
	local play_slot = gen_play_slot(score, rating, accuracy, rate, player.Name, p_ID, spread)
	local submit = true
	if cheated then
		submit = false
	end
	if submit then
		local data = {}
		local gl_data = {}
		gl_data.Rating = {}
		gl_data.TotalMapsPlayed = {}
		gl_data.PlayerName = {}
		gl_data.UserId = p_ID
		data.Rating = play_slot.Rating
		data.Score = play_slot.Score
		data.Spread = play_slot.Spread
		data.UserId = play_slot.UserId
		data.PlayerName = play_slot.PlayerName
		data.Accuracy = play_slot.Accuracy
		data.Rate = play_slot.Rate
		data.MapName = map.Name
		data.MapId = map_name
		local data_res = sendScore(data)
		if not valStat(data_res) then
			data_res = {}
			data_res.Data = {}
			data_res.Data.Rating = 0
			data_res.Rank = -1
		else -- update leaderstats based on what the server returned
			local plr_stats = leaderstats
			if plr_stats then
				plr_stats.Rating.Value = data_res.Data.Rating
				plr_stats.Rank.Value = "#" .. tostring(tonumber(data_res.Rank) + 1)
			end
		end
		data.RawUserId = player.UserId
		data.TierColor = tierColor
		return "#" .. data_res.Rank+1, data_res.Data.Rating
	end
end

--[[local function CalculatePlayerRating(p_ID)
	local maps = game.ReplicatedStorage:WaitForChild("Songs")
	local ratings = {}
	local names = {}
	local rating = 0
	local maxNumOfScores = 25
	table.sort(ratings, function(a,b)
		return a > b
	end)
	for i, r in pairs(ratings) do
		if (not (i > maxNumOfScores)) then
			if i <= 10 then
				rating = rating + r * 1.5
			else
				rating = rating + r
			end
		end
	end
	local plr_rating = math.floor(100 * rating / 30) / 100
	return plr_rating
end]]--
