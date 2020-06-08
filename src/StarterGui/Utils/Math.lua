local Math = {}

function Math.round(number, places)
	local mult = 10^(places or 0)
	return math.floor(number * mult + 0.5) / mult
end

function Math.format(number)
	return string.gsub(number, "^(-?%d+)(%d%d%d)", '%1,%2')
end

return Math
