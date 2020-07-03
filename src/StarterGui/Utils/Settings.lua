local Rodux = require(game.ReplicatedStorage.Rodux)
local Color = require(script.Parent.Color)

local Settings = {}

Settings.Options = {
	ScrollSpeed = 20;
	NoteColor = Color:newHSV();
	Rate = 1;
	Keybinds = {
		[1] = Enum.KeyCode.Z;
		[2] = Enum.KeyCode.X;
		[3] = Enum.KeyCode.Comma;
		[4] = Enum.KeyCode.Period;
	};
	QuickExitKeybind = {
		[1] = Enum.KeyCode.Backspace;
	};
	ScorePos = UDim2.new(0.92,0,0.035,0);
	AccuracyPos = UDim2.new(0.92,0,0.08,0);
	ComboPos = UDim2.new(0.5,0,0.2,0);
	JudgementPos = UDim2.new(0.5,0,0.25,0);
	RatingPos = UDim2.new(0.065,0,0.05,0);
	BackButtonPos = UDim2.new(0.923,0,0.955,0);
}

Settings.DefaultUIPos = { -- Used to reset to default, wip
	Score = UDim2.new(0.92,0,0.035,0);
	Accuracy = UDim2.new(0.92,0,0.08,0);
	Combo = UDim2.new(0.5,0,0.2,0);
	Judgement = UDim2.new(0.5,0,0.25,0);
	Rating = UDim2.new(0.065,0,0.05,0);
	BackButton = UDim2.new(0.923,0,0.955,0);
}

function Settings:ChangeOption(key, value)
	Settings.Options[key] = value
	return value
end

function Settings:BindToSetting(name, call)
	local setn = name
	local event = Instance.new("BindableEvent")
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
	return Settings:ChangeOption(option, c3)
end

function Settings:ParseStringNumber(option, str)
	local num = tonumber(str) or 0
	return Settings:ChangeOption(option, num)
end

function Settings:Increment(key, value)
	if typeof(Settings.Options[key]) == "number" then
		Settings.Options[key] = Settings.Options[key] + value
		return Settings.Options[key]
	end
	return 0
end

function Settings:LoadFromDatabaseSave()
	warn("Not implemented.")
end

function Settings:SaveToDatabase()
	warn("Not implemented.")
end

return Settings