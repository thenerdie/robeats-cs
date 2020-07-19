local HTTP = game:GetService("HttpService")
local LOCA = game:GetService("LocalizationService")

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Boundary = require(ReplicatedStorage.Frameworks.Boundary)

--local Anticheat = require(ReplicatedStorage.Anticheat)

local baseUrl = "robeatscsgame.com/api"

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
		Url=baseUrl.."/score";
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

Boundary.Server:Register("SubmitScore", function(player, data)
	local RBLXLeaderstats = player:WaitForChild("leaderstats")
	data.userid = player.UserId
	data.username = player.Name
	sendScore(data)
end)

Boundary.Server:Register("GetMapLB", function(player, m_ID)
	return getMapLeaderboard(m_ID)
end)

Boundary.Server:Register("GetUserPlays", function(player, data)
	local p_ID = tostring(player.UserId)
	return getPlays(p_ID)
end)

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
