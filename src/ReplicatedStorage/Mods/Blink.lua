local mod = {}

mod.Name = "Seizure"
mod.Decription = "sxxdfjkhvjhsdbfhjkls bfkjhlsadb fhkjsadbfhkjasbdfhjkdabfkjhasdbfjk"
mod.Color = Color3.fromRGB(245, 0, 102)

local timeElapsed = {}

local possibleNums = {}

function mod:Init()
	possibleNums = {}
	timeElapsed = {}
	for i = 0, 6 do
		table.insert(possibleNums, i, i)
	end
end

function mod:UpdateNote(data)
	if timeElapsed[data.Id] == nil then
		timeElapsed[data.Id] = 0
	end
	timeElapsed[data.Id] = timeElapsed[data.Id] + 1
	local ret = {
		transparency = 0
	}
	if possibleNums[ timeElapsed[data.Id] % math.random(10,20) ] then
		ret.transparency = 1
	end
	return ret
end
function mod:UpdateHeldNote(data)
	if timeElapsed[data.Id] == nil then
		timeElapsed[data.Id] = 0
	end
	timeElapsed[data.Id] = timeElapsed[data.Id] + 1
	local ret = {
		transparency = 0
	}
	if possibleNums[ timeElapsed[data.Id] % math.random(10,20) ] then
		ret.transparency = 1
	end
	return ret
end

return mod