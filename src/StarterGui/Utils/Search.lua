local Search = {}

function Search:find(string, search)
    string = string or ""
    search = search or nil
	if search ~= nil then
		search = search:lower()
		search = string.split(search, " ")
	end
    local found = false
    local foundNumber = 0
    if search == nil then
        found = true
    else
        for i, searchWord in pairs(search) do
            if string.find(string:lower(), searchWord) ~= nil then
                foundNumber = foundNumber + 1
            end
        end
        if foundNumber == #search then
            found = true
        end
    end
    return found
end

return Search