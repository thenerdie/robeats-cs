local Math = require(script.Parent.Math)

local calc = {}

-- LEGEND: Time, Type, Track, Duration

local row_data_to_type = {
    [nil] = "unknown";
    [1] = "chord";
    [2] = "jump";
    [3] = "hand";
    [4] = "quad";
}

local function rowDataset()
    return {
        chord=false;
        hand=false;
        jump=false;
        single=false;
    }
end

local function datasetForRowData(rdata)
    local numNotes = 0
    local dataset = rowDataset()
    for i, v in pairs(rdata) do
        if v == true then
            numNotes = numNotes + 1
        end
    end
    dataset[row_data_to_type[numNotes]] = true
    return dataset
end

local function splitNoteGroups(hitObjects)
    local note_groups = {}
    local function generateRow(time, row_data)
        return {
            Time=time;
            RowData=row_data;
        }
    end
    local lastTime = 0
    for i, hit_object in pairs(hitObjects) do
        
    end
    return note_groups
end

function calc:DoRating(song)
    local data = song:GetData()
    local rating = 0;
    if data.totalNotes < 50 then
        return 0
    end
    local note_groups = splitNoteGroups(data.HitObjects)
    for i, group in pairs(note_groups) do

    end
    return rating
end

return calc