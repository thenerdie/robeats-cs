local AdminPanel = script.Parent.Parent

local toggle = false
local showhide = {
	[true] = "Hide";
	[false] = "Show"
}

script.Parent.MouseButton1Click:Connect(function()
	toggle = not toggle
	script.Parent.Text = showhide[toggle] .. " Admin"
	AdminPanel.AdminFrames.Enabled = toggle
end)