local mod = {}

mod.Name = "Rainbow"
mod.Decription = "Ooh, pretty!"
mod.Color = Color3.fromRGB(247, 37, 163)

local colors = {}

local function randColor()
	return Color3.fromRGB(
			math.random(0, 255),
			math.random(0, 255),
			math.random(0, 255)
		)
end

function mod:Init()
	colors = {}
end

function mod:UpdateNote(data)
	if colors[data.Id] == nil then
		colors[data.Id] = randColor()
	end
	local ncolor = data.OriginalColor:lerp(colors[data.Id], data.Alpha)
	local ret = {
		color = ncolor
	} return ret
end
function mod:UpdateHeldNote(data)
	if colors[data.Id] == nil then
		colors[data.Id] = randColor()
	end
	local ncolor = data.OriginalColor:lerp(colors[data.Id], (data.HeadAlpha+data.TailAlpha)/2)
	local ret = {
		color = ncolor
	} return ret
end

return mod