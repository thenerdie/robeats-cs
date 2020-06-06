local mod = {}

mod.Name = "Random"
mod.Decription = "Living wild."
mod.Color = Color3.fromRGB(10, 5, 23)

function mod:PushBackNote(originalTrack, originalTime)
	local properties = {
		
		track = math.random(1,4)
		
	} return properties
end

function mod:PushBackHold(originalTrack, originalTime, orginalEndTime)
	local properties = {
		
		track = math.random(1,4)
		
	} return properties
end

return mod