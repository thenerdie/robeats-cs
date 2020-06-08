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
	
	function self:GetDisplayName() --ok so lets fix this seriously
		--[[local str = string.gsub(self.instance.Name, "%b[]", "", 1)
		if str:sub(1,2) == " " then
			str = str:sub(2, str:len())
		end]]--
		local str = "[" .. self:GetDifficulty() .. "] " .. self:GetArtist() .. " - " .. self:GetSongName()
		
		local diffName = self:GetDifficultyName()
		
		if diffName ~= nil then
			str = "[" .. diffName .. "]" .. str
		end
		
		return str
	end
	
	function self:GetButtonColor()
		return Color3.new(0.3,0.3,0.3)
	end
	
	function self:GetDifficulty()
		local ret = 0
		if not hasCalced then
			hasCalced = true
			cachedRating = self:GetData().AudioDifficulty or 0
		end
		return cachedRating
	end
	
	function self:GetSongVersion()
		return 1
	end
	
	function self:GetId()
		local retString = ""
		itrString(self.instance.Name, function(char)
			if char ~= "[" then
				if char == "]" then return -1 end
				retString = retString .. char
			end
		end)
		return retString
	end
	
	function self:GetDifficultyName()
		local retString = ""
		local canDoNext = false
		local numbrac = 0
		itrString(self.instance.Name, function(char)
			local canDoThis = canDoNext
			if char == "[" then
				numbrac = numbrac + 1
			end
			if char == "]" and numbrac == 2 then
				canDoThis = false
				return -1
			end
			if numbrac == 2 then
				canDoNext = true
			end
			if canDoThis then
				retString = retString .. char
			end
		end)
		if retString == "" then
			retString = nil
		end
		return retString
	end
	
	function self:GetArtist()
		local retString = ""
		local canDoNext = false
		local prevChar = ""
		local numbrac = 0
		itrString(self.instance.Name, function(char)
			local canDoThis = canDoNext
			if char == " " then
				canDoNext = true
			elseif char == "-" and prevChar == " " then
				return -1
			end
			if canDoThis then
				retString = retString .. char
			end
			prevChar = char
		end)
		return retString:sub(1, retString:len()-1)
	end
	
	function self:GetSongName() --not 100% accurate, expand later
		local retString = ""
		local canDoNext = false
		local prevChar = ""
		local numbrac = 0
		itrString(self.instance.Name, function(char)
			local canDoThis = canDoNext
			if char == " " and prevChar == "-" then
				canDoNext = true
			end
			if char == "(" then
				return -1
			end
			if canDoThis then
				retString = retString .. char
			end
			prevChar = char
		end)
		return retString
	end
	
	function self:GetColor()
		local diff = self:GetDifficulty()
		return Metrics:GetTierData(diff).Color
	end
	
	return self
end

return SongObject
