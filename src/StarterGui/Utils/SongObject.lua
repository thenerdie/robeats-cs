local Metrics = require(script.Parent.Metrics)
local CSCalc = require(script.Parent.CSCalc)

local SongObject = {}

function SongObject:new(instance)
	local self = {}
	local cachedRating = 0
	local hasCalced = false

	self.instance = instance
	
	local function itrString(str, clb)
		for char in string.gmatch(self.instance.Name, ".") do
			if clb then
				local ret = clb(char)
				if ret == -1 then
					break
				end
			end
		end
	end
	
	local function isWhiteSpace(str)
		local i = 0
		itrString(str, function(char)
			if char == "" or " " then i = i + 1 end
		end)
		if i == str:len() then
			return true
		end
		return false
	end
	
	function self:GetData()
		return require(self.instance)
	end
	
	function self:GetName()
		return self.instance.Name
	end
	
	function self:GetDisplayName()
		local str = "[" .. self:GetDifficulty() .. "] " .. self:GetArtist() .. " - " .. self:GetSongName()
		
		local diffName = self:GetDifficultyName()
		
		if diffName ~= nil then
			str = "[" .. diffName .. "]" .. str
		end
		
		return str
	end
	
	function self:GetButtonColor()
		return self:GetData().AudioButtonColor or Color3.new(0.4,0.4,0.4)
	end
	
	function self:GetDifficulty()
		if not hasCalced then
			hasCalced = true
			cachedRating = self:GetData().AudioDifficulty or CSCalc:DoRating(self)
		end
		return cachedRating
	end
	
	function self:GetSongVersion()
		return self:GetData().AudioSongVersion or 1
	end

	function self:GetLength()
		local hitObs = self:GetData().HitObjects
		local lastHitOb = hitObs[#hitObs]
		return lastHitOb.Time + (lastHitOb.Duration or 0)
	end

	function self:GetObjectNumber()
		local hitObs = self:GetData().HitObjects
		local num = 0
		for i, v in pairs(hitObs) do
			num = num + v.Type
		end
		return num
	end

	function self:GetNpsGraph()
		local points = {}
		local lastMs = 0
		local objects = self:GetData().HitObjects
		local curNps = 0
		for i, object in pairs(objects) do
			local curTime = object.Time
			if curTime - lastMs > 1000 then
				lastMs = curTime
				points[#points+1] = curNps
				curNps = 0
			end
			curNps = curNps + 1
		end
		return points
	end
	
	function self:GetId()
		return self:GetData().AudioId
	end
	
	function self:GetDifficultyName()
		return self:GetData().AudioDifficultyName
	end
	
	function self:GetArtist()
		return self:GetData().AudioArtist
	end

	function self:GetCreator()
		return self:GetData().AudioMapper
	end
	
	function self:GetSongName() --not 100% accurate, expand later
		return self:GetData().AudioFilename
	end
	
	function self:GetColor()
		local diff = self:GetDifficulty()
		return Metrics:GetTierData(diff).Color
	end
	
	return self
end

return SongObject
