local mod = {}

mod.Name = "Invisible"
mod.Decription = "The true test."
mod.Color = Color3.fromRGB(28, 27, 33)

function mod:UpdateNote(data)
	local ret = {
		transparency = 1
	} return ret
end
function mod:UpdateHeldNote(data)
	local ret = {
		transparency = 1
	} return ret
end

return mod