local Chat = require(game.ReplicatedStorage.Helpers.Chat)

--[[pcall(function()
	local DataStoreService = game:GetService("DataStoreService")
	local Bans = DataStoreService:GetDataStore("Bans")

	game.Players.PlayerAdded:Connect(function(player)
		local uid = tostring(player.UserId)
		local get = Bans:GetAsync(uid)
		if get ~= nil then
			player:Kick(get)
		end
	end)
end)]]--

game.Players.PlayerAdded:Connect(function(player)
	Chat:GiveRolesToSpeaker(player.Name, {
		Chat.role("Cool", Color3.fromRGB(16, 137, 173))
	})
end)

--[[
local r = game.ReplicatedStorage

local function connectRemoteFunction(inst, call)
	if inst ~= nil then
		inst.OnServerInvoke = call
	end
end

local function connectRemoteEvent(inst, call)
	if inst ~= nil then
		inst.OnServerEvent:Connect(call)
	end
end

local HTTP = game:GetService("HttpService")

local function getServerLocation(p_ID)
	local headers = {
		["Content-Type"] = "application/json";
	}
	local params = {
		Headers=headers;
		Method="GET";
		Url="http://ip-api.com/json/";
	}
	local res = nil
	local suc, err = pcall(function()
		res = HTTP:RequestAsync(params)
	end)
	if not suc then
		warn(err)
		return nil
	else
		return HTTP:JSONDecode(res.Body)
	end
end

local ip_info = getServerLocation()

--game.ReplicatedStorage.GetServerLocation.OnServerInvoke = function(player)
	--return ip_info
--end

-----------------------------------------------------------------------------
local games = {}

local function genNewGame(mapInst, mapId, plr_ob, r, m, ps, co)
	return {
		bgmTime = 0;
		hits={};
		spectators={};
		map=mapInst;
		id=mapId;
		uid=plr_ob.UserId or 0;
		plr=plr_ob;
		rate=r;
		mods=m;
		scrollSpeed=ps;
	}
end

connectRemoteFunction(r.Spectating.GetGame, function(plr, plrToSpec)
	local specGame = nil
	for i, v in pairs(games) do
		if v.plr == plrToSpec then
			specGame = v
			break
		end
	end
	if specGame ~= nil then
		local clientResponse = r.Spectating.GetGame:InvokeClient(plrToSpec)
		if clientResponse ~= nil then
			specGame.hits = clientResponse.hits
		end
		return specGame
	end
	return nil
end)

connectRemoteEvent(r.Spectating.NewGame, function(plr, mapInst, mapId, rate, mods, scrollSpeed, noteColor)
	for i, v in pairs(games) do
		if v.plr == plr then
			return
		end
	end
	games[#games+1] = genNewGame(mapInst, mapId, plr, rate, mods, scrollSpeed, noteColor)
end)

connectRemoteEvent(r.Spectating.RegisterSpectator, function(player, plrToSpec)
	local specGame = nil
	for i, v in pairs(games) do
		if v.plr == plrToSpec then
			specGame = v
			break
		end
	end
	if specGame ~= nil then
		specGame.spectators[#specGame.spectators+1] = player
	end
end)

local function dereg_serv(player, plrToSpec)
	local specGame = nil
	for i, v in pairs(games) do
		if v.plr == plrToSpec then
			specGame = v
			break
		end
	end
	if specGame ~= nil then
		for i, plr in pairs(specGame.spectators) do
			if plr == player then
				specGame.spectators[i] = nil
			end
		end
	end
end

connectRemoteEvent(r.Spectating.DeregisterSpectator, function(player, plrToSpec)
	dereg_serv(player, plrToSpec)
end)

connectRemoteEvent(r.Spectating.UpdateGame, function(plr, data)
	local curGame = nil
	for i, v in pairs(games) do
		if v.plr == plr then
			curGame = v
			break
		end
	end
	if curGame ~= nil then
		if data.bgmTime then
			curGame.bgmTime = data.bgmTime
		end
	end
end)

connectRemoteEvent(r.Spectating.TeardownGame, function(plr)
	for i, v in pairs(games) do
		if v.plr == plr then
			games[i] = nil
			break
		end
	end
end)

connectRemoteFunction(r.Spectating.GetOngoingGames, function(plr)
	return games
end)

game.Players.PlayerRemoving:Connect(function(plr)
	for i, v in pairs(games) do
		if v.plr == plr then
			games[i] = nil
			break
		end
	end
	for i, room in pairs(games) do
		dereg_serv(plr, room.plr)
	en
end)
]]--