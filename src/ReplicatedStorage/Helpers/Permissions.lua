local Groups = require(script.Parent.Groups)

local Permissions = {}

Permissions.GroupId = 5863946
Permissions.AdminRank = 252

local function newRole(roleName, rank, color)
    return {
        Name = roleName;
        Rank = rank;
        Color = color;
    }
end

Permissions.Roles = {
    newRole("Group Owner/Core Dev", 255, Color3.fromRGB(255, 251, 5)),
    newRole("Developer", 254, Color3.fromRGB(255, 119, 0)),
    newRole("Admin+", 253, Color3.fromRGB(162, 255, 0)),
    newRole("Admin", 252, Color3.fromRGB(81, 255, 0)),
    newRole("Moderator", 251, Color3.fromRGB(5, 222, 255)),
}

function Permissions:IsAdmin(p_ID)
    local isAdmin = false
    local isInGroup, info = Groups:IsInGroup(Permissions.GroupId, p_ID)
    if isInGroup then
        return info.Rank > Permissions.AdminRank
    end
    return isAdmin
end

function Permissions:GetUserRoleData(p_ID)
    local isInGroup, info = Groups:IsInGroup(Permissions.GroupId, p_ID)
    if isInGroup then
        for i, role in pairs(Permissions.Roles) do
            if role.Rank == info.Rank then
                return role
            end
        end
    end
    return false
end

return Permissions