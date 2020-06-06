local mod = {}

mod.Name = "Fade-Out"
mod.Decription = "Hit them if you can."
mod.Color = Color3.fromRGB(206, 217, 2)

function mod:UpdateNote(data)
	local ret = {
		transparency = data.Alpha*1.2
	} return ret
end
function mod:UpdateHeldNote(data)
	local ret = {
		h_transparency = (data.HeadAlpha)*1.2;
		b_transparency = ((data.HeadAlpha+data.TailAlpha)/2)*1.2;
		t_transparency = (data.TailAlpha)*1.2
	} return ret
end

return mod