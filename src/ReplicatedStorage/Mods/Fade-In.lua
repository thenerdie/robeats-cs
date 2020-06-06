local mod = {}

mod.Name = "Fade-In"
mod.Decription = "Hit them if you can."
mod.Color = Color3.fromRGB(206, 217, 2)

function mod:UpdateNote(data)
	local ret = {
		transparency = (1-data.Alpha)/0.8
	} return ret
end
function mod:UpdateHeldNote(data)
	local ret = {
		h_transparency = (1-data.HeadAlpha)/0.8;
		b_transparency = 
		(
			(
				(1-data.HeadAlpha)+(1-data.TailAlpha)
			)/2/0.8
		);
		t_transparency = (1-data.TailAlpha)/0.8
	}
	return ret
end

return mod