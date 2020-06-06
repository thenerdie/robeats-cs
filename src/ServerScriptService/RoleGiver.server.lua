local ChatService = require(game:GetService('ServerScriptService'):WaitForChild('ChatServiceRunner'):WaitForChild('ChatService'))

local players = {
	[1181488946] = {Title="Abstract", Color=Color3.fromRGB(21, 181, 230)};
	[18923632] = {Title="Classy Code", Color=Color3.fromRGB(21, 181, 230)};
	[274122395] = {Title="GBAR", Color=Color3.fromRGB(21, 181, 230)}
}

local function isAdmin(player)
	local p_ID = player.UserId
	if player:IsInGroup(5863946) then
		local rank = player:GetRankInGroup(5863946)
		if rank >= 251 then
			return true, rank
		end
	end
	return false
end

local function isTop10(player)
	local p_ID = player.UserId
	if player:IsInGroup(5863946) then
		if player:GetRankInGroup(5863946) == 3 then
			return true
		end
	end
	return false
end

local rankToTag = {
	[251] = {"MOD", Color3.fromRGB(3, 94, 252)};
	[252] = {"ADMIN", Color3.fromRGB(65, 252, 3)};
	[253] = {"ADMIN+", Color3.fromRGB(166, 255, 115)};
	[254] = {"DEV", Color3.fromRGB(224, 47, 27)};
	[255] = {"DEV/OWNER", Color3.fromRGB(245, 221, 10)};
}

game.Players.PlayerAdded:Connect(function(player)	
	if isTop10(player) then
		local speaker
		while not speaker do
			speaker = ChatService:GetSpeaker(player.Name)
	  		wait()
	 	end
  		speaker:SetExtraData("Tags", {{ TagText = "TOP 10", TagColor = Color3.fromRGB(52, 180, 235) }})
	end
	
	local meta = players[player.UserId]
	if meta ~= nil then
		local speaker
		while not speaker do
			speaker = ChatService:GetSpeaker(player.Name)
	  		wait()
	 	end
  		speaker:SetExtraData("Tags", {{ TagText = meta.Title, TagColor = meta.Color }})
	end
	
	local admin, rank = isAdmin(player)
	if admin then
		local speaker
		while not speaker do
			speaker = ChatService:GetSpeaker(player.Name)
	  		wait()
	 	end
  		speaker:SetExtraData("Tags",
			{
				{
					TagText = rankToTag[rank][1], TagColor = rankToTag[rank][2]
				}
			}
		)
	end
end)