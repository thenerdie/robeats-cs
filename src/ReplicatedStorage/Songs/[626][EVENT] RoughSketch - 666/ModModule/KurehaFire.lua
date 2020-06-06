local modevent = {}

function modevent:start(rate,camorigin)
	local kureha = workspace:FindFirstChild("Kureha")
	if kureha then
		local root = kureha.HumanoidRootPart
		root.PointLight.Enabled = true
		local att_fire = root.Att_Fire
		att_fire.Emitter1.Enabled = true
		att_fire.Emitter2.Enabled = true
	else
		print("Where's the Kureha model!?")
	end
end

return modevent
