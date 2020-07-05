local Groups = game:GetService("GroupService")

function Groups:IsInGroup(g_ID, p_ID)
    local groups = self:GetGroupsAsync(p_ID)
    for i, v in pairs(groups) do
        if v.Id == g_ID then return true, v end
    end
    return false
end

return Groups