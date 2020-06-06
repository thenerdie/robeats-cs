local calc = {}

function calc:DoRating(song)
    local data = song:GetData()
    local rating = 0;
    if data.totalNotes < 20 or data.maxNps > 53 then
        return 0
    end
    local total = 0
    for i, kps in pairs(data.NpsGraph) do
        total = i
        rating = rating + kps
    end
    rating = rating / total
    return rating
end

return calc