local UpdateNotes = {}
UpdateNotes.Versions = {}

local function AddVersion(versionNum, text)
    UpdateNotes.Versions[#UpdateNotes.Versions+1] = {
        Version = versionNum,
        Text = text
    }
end

AddVersion(0.1, [[
    Yo this is an epic update

    Yh kid we using multi LibraryName



    bro dude cool
]])
AddVersion(0.2, [[
    Yo this is an even more epic update

    Yh kid we using multi LibraryName



    bro dude cool
]])
AddVersion(0.3, [[
    bruh this is an even more epic update than before

    yeah we be addin a ton of features nowadays sooo uhhhhh yh kid
]])
AddVersion(0.4, [[
    Yo this is an even more even more even more epic update
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
]])


table.sort(UpdateNotes.Versions, function(a, b)
    return a.Version > b.Version
end)

return UpdateNotes