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
    for k, curHitObj in pairs(data) do
        i = k
        if i > 1 then
            local lastHitObj = data[i-1]
            totalStrain = totalStrain + math.clamp(800-math.abs(curHitObj.Time - lastHitObj.Time), 0, 800)
            if curHitObj.Track == lastHitObj.Track then
                totalStrain = totalStrain + 120
            end
        end
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
    local totalStrain = getStrain(data.HitObjects)
    rating = totalStrain/10
    return rating
end

return calc