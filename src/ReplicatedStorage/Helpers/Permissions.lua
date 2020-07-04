local Permissions = {}

local function newRole(roleName, rank)
    return {
        Name = roleName;
        Rank = rank;
    }
end

Permissions.Roles = {
    newRole("Group Owner/Core Dev", 255)
}

return Permissions