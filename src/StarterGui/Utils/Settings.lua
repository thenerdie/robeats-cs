local Rodux = require(game.ReplicatedStorage.Rodux)
local Settings = {}

Settings.Options = {
	ScrollSpeed = 20;
	NoteColor = Color3.new(0.5,0.5,0.5);
	Keybinds = {
		[1] = Enum.KeyCode.Z;
		[2] = Enum.KeyCode.X;
		[3] = Enum.KeyCode.Comma;
		[4] = Enum.KeyCode.Period;
	}
}

function Settings:ChangeOption(key, value)
	Settings.Options[key] = value
end

function Settings:BindToSetting(name, call)
	local setn = name
	local event = Instance.new("BindableEvent", nil)
	event.Event:Connect(function(new)
		call(new)
	end)
	spawn(function()
		local lastVal = nil
		local first = true
		while true do
			local sn = Settings.Options[setn]
			if lastVal ~= sn then
				if first then
					first = false
				else
					event:Fire(sn)
				end
				lastVal = sn
			end
			wait()
		end
	end)
	return event
end

function Settings:ParseStringColor3(option, str)
	local pse = string.split(str, ",")
	local c3 = Color3.fromRGB(pse[1] or 0, pse[2] or 0, pse[3] or 0)
	Settings:ChangeOption(option, c3)
end

function Settings:ParseStringNumber(option, str)
	local num = tonumber(str) or 0
	Settings:ChangeOption(option, num)
end

function Settings:Increment(key, value)
	if typeof(Settings.Options[key]) == "number" then
		Settings.Options[key] = Settings.Options[key] + value
	end
end

function Settings:LoadFromDatabaseSave()
	warn("Not implemented.")
end

function Settings:SaveToDatabase()
	warn("Not implemented.")
end

return Settings