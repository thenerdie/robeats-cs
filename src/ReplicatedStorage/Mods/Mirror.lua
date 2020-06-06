local mod = {}

mod.Name = "Mirror"
mod.Decription = "Like things in reverse, huh?"
mod.Color = Color3.fromRGB(10, 213, 23)

function mod:PushBackNote(data)
	local properties = {
		
		track = 5-data.Track
		
	} return properties
end

function mod:PushBackHold(data)
	local properties = {
		
		track = 5-data.Track
		
	} return properties
end

return mod