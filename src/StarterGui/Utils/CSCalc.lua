local Math = require(script.Parent.Math)

local calc = {}

-- LEGEND: Time, Type, Track, Duration

local function genDataset()
    return {
        jack=0;
        chord=0;
        stream=0;
        handstream=0;
        jumpstream=0;
    }
end

local function getStrain(data)
    local totalStrain = 0
    local i = 0
    for i, npsPoint in pairs(data) do
        totalStrain = totalStrain + npsPoint
    end
    totalStrain = totalStrain / i
    return totalStrain
end

function calc:DoRating(song)
    local data = song:GetData()
    local rating = 0;
    if data.totalNotes < 50 then
        return 0
    end
    local totalStrain = getStrain(data.NpsGraph)
    rating = totalStrain
    return rating
end

return calc