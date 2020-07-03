local DataStoreService = nil
local Bans = nil
pcall(function()
    DataStoreService = game:GetService("DataStoreService")
    Bans = DataStoreService:GetDataStore("Bans")
end)


return function(cmdContext, player, reason)
    if DataStoreService ~= nil and Bans ~= nil then
        local uid = player.UserId
        Bans:SetAsync(tostring(uid), reason)
        player:Kick()
    end
end