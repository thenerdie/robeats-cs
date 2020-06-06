local grades = {}

grades.GetAudioRanks = function(maxPoints)
	local newAudioRanks = {
		APlus = maxPoints*0.70;
		A = maxPoints*0.55;
		B = maxPoints*0.35;
		C = maxPoints*0.20;
	}
	return newAudioRanks
end

return grades
