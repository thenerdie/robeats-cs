--MOD MANAGER
--FOR THE CLIENT ONLY!!!!

local function validateMod(mod)
	if typeof(mod) == "table" then
		error("Can't load mod as array! Pass mod instance instead of using require()")
	end
end

local activatedMods = {}
local activatedModsI = {}
local mods = game.ReplicatedStorage:WaitForChild("Mods")

local ModManager = {}

function ModManager:GetAllMods()
	return mods
end

function ModManager:GetActivatedMods()
	return activatedMods
end

function ModManager:GetActivatedInstMods()
	return activatedModsI
end

function ModManager:ApplyMod(mod)
	validateMod(mod)
	print(mod)
	local req_mod = require(mod)
	for i, v in pairs(activatedMods) do
		if v == req_mod then return	end
	end
	activatedModsI[#activatedModsI+1] = mod
	table.insert(activatedMods, req_mod)
end

function ModManager:UnapplyMod(mod)
	validateMod(mod)
	print(mod)
	local req_mod = require(mod)
	for i, v in pairs(activatedMods) do
		if v == req_mod then
			table.remove(activatedMods, i)
		end
	end
	for i, v in pairs(activatedModsI) do
		if v == mod then
			table.remove(activatedModsI, i)
		end
	end
end

function ModManager:ParseMod(mod)
	validateMod(mod)
	return require(mod)
end

return ModManager