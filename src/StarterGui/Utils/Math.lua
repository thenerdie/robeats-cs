local Math = {}

function Math.round(number, places)
	local mult = 10^(places or 0)
	return math.floor(number * mult + 0.5) / mult
end

return Math
