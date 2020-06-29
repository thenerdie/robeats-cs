local DataStoreService = game:GetService("DataStoreService")
local Bans = DataStoreService:GetDataStore("Bans")

return function(cmdContext, player, reason)
    local uid = player.UserId
    Bans:SetAsync(tostring(uid), reason)
    player:Kick()
end