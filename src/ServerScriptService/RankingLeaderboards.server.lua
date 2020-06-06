-- todo: make this function live
local HTTP = game:GetService("HttpService")
local LOCA = game:GetService("LocalizationService")

--local webhookURI = "https://discordapp.com/api/webhooks/688098285512425493/BRzzdm3skcsqjyaAR5hyup2xamrlAMHrlsD7b1uZ6J11DiNs-ZtM49TLI9x-f0bSCUT1"

local webhookID = "688098285512425493"
local webhookToken = "BRzzdm3skcsqjyaAR5hyup2xamrlAMHrlsD7b1uZ6J11DiNs-ZtM49TLI9x-f0bSCUT1"

local DiscordWebhookModule = require(game.ServerScriptService.DiscordWebhook)

local DiscordWebhook = DiscordWebhookModule.new(webhookID, webhookToken)
local formatter = DiscordWebhookModule:GetFromatHelper()

local baseUrl = "rcs-backend.glitch.me/"

local useTestBase = true

if useTestBase then
	baseUrl = "test-" .. baseUrl
end

baseUrl = "https://" .. baseUrl

print(baseUrl)

local function sendScore(data)
	local headers = {
		["Content-Type"] = "application/json";
		["auth-key"] = "HCQVcEs2NZdaMvJhDXJPdbR1l3Wy45h5QdLSZNXtN6ouU"
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
	local headers = {
		["Content-Type"] = "application/json";
		["auth-key"] = "HCQVcEs2NZdaMvJhDXJPdbR1l3Wy45h5QdLSZNXtN6ouU";
		["userid"] = p_ID;
	}
	local params = {
		Headers=headers;
		Method="GET";
		Url=baseUrl.."/plays";
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
		["auth-key"] = "HCQVcEs2NZdaMvJhDXJPdbR1l3Wy45h5QdLSZNXtN6ouU";
		["mapid"] = m_ID;
	}
	local params = {
		Headers=headers;
		Method="GET";
		Url=baseUrl.."/maps";
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
		["auth-key"] = "HCQVcEs2NZdaMvJhDXJPdbR1l3Wy45h5QdLSZNXtN6ouU";
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
	local headers = {
		["Content-Type"] = "application/json";
		["auth-key"] = "HCQVcEs2NZdaMvJhDXJPdbR1l3Wy45h5QdLSZNXtN6ouU";
		["userid"] = p_ID
	}
	local params = {
		Headers=headers;
		Method="GET";
		Url=baseUrl.."/stats";
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

local songs = game:GetService("ReplicatedStorage").Songs
local override = false
--//players that can unlock epic secret songs (please add ur id now lol)
local AdminPlayers = {36304080, 33607300, 45616186, 167327389,35585415,77833049,58107975,77183382,526993347}
local DataStoreService = game:GetService("DataStoreService")
--------------------------------------------------------------------------------------------------------------------
local hint = Instance.new("Hint")
hint.Parent = workspace
local function NoSaveWarning()
	hint.Text = "FATAL ERROR: DATABASE UNABLE TO BE INITIALIZED, OR ERRORED. SCORES WILL NOT BE SAVED; JOIN ANOTHER SERVER TO SAVE SCORES"
end
local function IssueServerWarning()
	hint.Text = "SCORES AT THIS TIME WILL OR MAY NOT BE SUBMITTED, DUE TO THROTTLING OR BANDWIDTH ISSUES. CONSIDER MOVING OUT OF THE SERVER."
end
local function UnissueServerWarning()
	hint.Text = ""
end
function getAlphabet()
    local letters = {}
    for ascii = 97, 122 do table.insert(letters, string.char(ascii)) end
    return letters
end
local function URLify(str)
	local finStr = ""
	local allowedChars = getAlphabet()
	for char in string.gmatch(str,".") do
		local allowed = false
		for itr, itr_char in pairs(allowedChars) do
			if itr_char == string.lower(char) then
				allowed = true
			end
		end
		if allowed then
			finStr = finStr .. char
		end
	end
	return finStr
end
function tabempty(tab)
    for _, _ in pairs(tab) do
        return false
    end
    return true
end
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
local toxicPlayers = {
	544802279, --Lord_Believe
	328239043, --Main Acc of Lord_Believe
}
--//players who are shadowbanned
local bannedPlayers = {
	544802279, --Lord_Believe
	328239043, --Main Acc of Lord_Believe
}

local function gen_gl_slot(r, pn, tmp, ud)
	return {Rating=r; PlayerName=pn; TotalMapsPlayed=tmp; UserId=ud}
end

local function gen_play_slot(s, r, acc, rate, pn, ud, spd)
	return {Score=s; Rating=r; Accuracy=acc; Rate=rate; PlayerName=pn; UserId=ud; Spread=spd}
end

---------------------
function encodeChar(chr)
	return string.format("%%%X",string.byte(chr))
end
 
function encodeString(str)
	local output, t = string.gsub(str,"[^%w]",encodeChar)
	return output
end

function decodeChar(hex)
	return string.char(tonumber(hex,16))
end
 
function decodeString(str)
	local output, t = string.gsub(str,"%%(%x%x)",decodeChar)
	return output
end
---------------------
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

local function CalculatePlayerRating(p_ID)
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
end

--//1 is for the scores, 2 is for the ratings.
local scriptstats = {}
local cloned = false
local AdminSongs = game.ReplicatedStorage.AdminSongs:GetChildren()

local function valStat(stat)
	if stat ~= nil then
		return (stat.Rank ~= nil and stat.Data ~= nil)
	else
		return false
	end
end

local function randomColor()
	return Color3.fromRGB(
		math.random(0,255),
		math.random(0,255),
		math.random(0,255)
	)
end

local function getAvatarUrl(p_ID)
	local uri = game:GetService("Players"):GetUserThumbnailAsync(p_ID, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
	return uri
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

local function sendWebhook(play_slot, map)
	local avatarUrl = getAvatarUrl(play_slot.RawUserId)
	local msg = DiscordWebhook:NewMessage()
	msg:SetUsername("Score Watchdog")
	msg:SetAvatarUrl("https://t7.rbxcdn.com/ccf7d7ff226460ef5e6abc2c3ecd39a8")
	local mentions = msg:GetAllowedMention()
	local embed = msg:NewEmbed()
	embed:SetTitle("Score Submitted")
	embed:Append("A score was submitted for user " .. play_slot.PlayerName .. " (".. play_slot.UserId ..")")
	embed:SetURL("https://www.roblox.com/users/" .. play_slot.RawUserId .. "/profile")
	embed:SetTimestamp(tick())
	embed:SetColor3(play_slot.TierColor)
	embed:AppendFooter("This was an automated in-game message.")
	embed:SetAuthorName("Score Watchdog")
	
	embed:SetThumbnailIconURL(avatarUrl)
	
	local PlayStatField = embed:NewField()
	
	PlayStatField:SetName("Play Stats")
	PlayStatField:AppendLine("Map: " .. formatter:CodeblockLine(play_slot.MapName))
	PlayStatField:AppendLine("Rating: " .. formatter:CodeblockLine(tostring(round(play_slot.Rating, 2)) .. " SR"))
	PlayStatField:AppendLine("Accuracy: " .. formatter:CodeblockLine(tostring(round(play_slot.Accuracy, 2)) .. "%"))
	PlayStatField:AppendLine("Spread: " .. formatter:CodeblockLine(tostring(play_slot.Spread)))
	PlayStatField:AppendLine("Score: " .. formatter:CodeblockLine(tostring(play_slot.Score)))
	
	local RemarksField = embed:NewField()	
	
	RemarksField:SetName("Remarks")
	
	if play_slot.Rating > 64 then
		mentions:AddGlobalMention("Database Manager")
		RemarksField:AppendLine("This play is suspicious due to the very high rating. Database Managers will investigate.")
		RemarksField:AppendLine("@Database Manager")
	else
		RemarksField:AppendLine("This play seems OK.")
	end
	
	msg:Send()
	print("Webhook sent!")
end

game.Players.PlayerAdded:Connect(function(p)
	-- throttle
	repeat wait() until grist_loaded
	print("Player added to game.")
	local p_ID = "P" .. tostring(p.UserId)
	-- clone admin songs, if the user is an admin
	if AdminPlayers[p.UserId] and not cloned then
		cloned = true
		local copy = AdminSongs
		for i=1, #copy do
			copy[i]:Clone().Parent = game.ReplicatedStorage.Songs
		end
	end
	-- init leaderstats
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

game.ReplicatedStorage.GetSongLeaderboard.OnServerInvoke = function(player, m_ID)
	return getMapLeaderboard(m_ID)
end

game.ReplicatedStorage.GetTopPlays.OnServerInvoke = function(player)
	local p_ID = "P" .. tostring(player.UserId)
	return getPlays(p_ID)
end

game.ReplicatedStorage.GetGlobalLeaderboard.OnServerInvoke = function(player, map, maxToReturn)
	return getGlobalLeaderboard()
end

game.ReplicatedStorage.SubmitScore.OnServerInvoke = function(player, map, score, accuracy, rate, spread, tierColor, hitData) --plr, inst, num, num, bool
	print("// Score Submission Started...")
	local cheated = DidCheat(player, map, score, accuracy, rate, spread)
	local leaderstats = player:WaitForChild("leaderstats")
	local map_name = getIdFromMap(map.Name)
	local rating = calculateRating(rate, accuracy, map.SongDiff.Value)
	local p_ID = "P" .. tostring(player.UserId)
	local play_slot = gen_play_slot(score, rating, accuracy, rate, player.Name, p_ID, spread)
	local submit = true
	if cheated then submit = false end
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
			local plr_stats = player:FindFirstChild("leaderstats")
			if plr_stats then
				plr_stats.Rating.Value = data_res.Data.Rating
				plr_stats.Rank.Value = "#" .. tostring(tonumber(data_res.Rank) + 1)
			end
		end
		data.RawUserId = player.UserId
		data.TierColor = tierColor
		sendWebhook(data, map)
		return "#" .. data_res.Rank+1, data_res.Data.Rating
	end
end
print("Got past")
	
game.ReplicatedStorage.CalculatePlayerRating.OnServerEvent:Connect(function(player)
	CalculatePlayerRating(player)
end)