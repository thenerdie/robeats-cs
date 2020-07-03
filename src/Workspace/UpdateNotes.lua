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

AddVersion(0.1, {
    AddChange("bro"),
    AddChange("what"),
})


table.sort(UpdateNotes.Versions, function(a, b)
    return a.Version > b.Version
end)

return UpdateNotes