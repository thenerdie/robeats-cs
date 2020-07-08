local UpdateNotes = {}
UpdateNotes.Versions = {}

local function AddChange(changeText)
    return {
        ChangeText = changeText
    }
end

local function AddVersion(versionNum, cngs)
    UpdateNotes.Versions[#UpdateNotes.Versions+1] = {
        Version = versionNum,
        Changes = cngs,
    }
end

AddVersion("0.1.0", {
    AddChange("ENTIRE GAME REWRITTEN!"),
    AddChange("Game is open-source on GitHub so anyone can make changes!")
})

return UpdateNotes