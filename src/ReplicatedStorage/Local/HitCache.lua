local s = game.ReplicatedStorage:WaitForChild("Spectating")
local HttpService = game:GetService("HttpService")

local HitCache = {}

function HitCache:new()
	self = {}
	self.hits = {}
	
	function self:addToCache(hit)
		self.hits[#self.hits+1] = hit
	end
	
	function self:genNewHit(time_, track, action, note_result, id)
		return {
			Time=time_;
			Track=track;
			Action=action;
			Result=note_result;
			Id=id
		}
	end
	
	function self:DebugExport()
		if not game:GetService("RunService"):IsStudio() then return end
		warn("Not implemented...")
	end
	
	return self
end

return HitCache
