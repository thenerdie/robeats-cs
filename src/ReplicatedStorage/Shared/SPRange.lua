local SPRange = {}

function SPRange:new(min,max)
	local self = {
		Type = "SPRange";
		_min = min;
		_max = max;
	}
	function self:set_min_max(min,max)
		if min == nil or max == nil then
			error("SPRange set_min_max nil",min,max)
		end		
		self._min = min
		self._max = max
	end
	return self		
end

return SPRange
