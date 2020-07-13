local Rodux = require(game.ReplicatedStorage.Rodux)
local Color = require(script.Parent.Color)
local FastSpawn = require(game.ReplicatedStorage.FastSpawn)

local Settings = {}

Settings.Options = {
	ScrollSpeed = 20;
	NoteColor = Color:newHSV(0,0,255);
	Rate = 1;
	ShowGameplayUI = true;
	Keybinds = {
		[1] = Enum.KeyCode.Z;
		[2] = Enum.KeyCode.X;
		[3] = Enum.KeyCode.Comma;
		[4] = Enum.KeyCode.Period;
	};
	QuickExitKeybind = {
		[1] = Enum.KeyCode.Backspace;
	};
	HideGameplayUI = {
		[1] = Enum.KeyCode.M;
	};
	ScorePos = UDim2.new(0.92,0,0.035,0);
	AccuracyPos = UDim2.new(0.92,0,0.08,0);
	ComboPos = UDim2.new(0.5,0,0.2,0);
	JudgementPos = UDim2.new(0.5,0,0.25,0);
	RatingPos = UDim2.new(0.065,0,0.05,0);
	BackButtonPos = UDim2.new(0.923,0,0.955,0);
	FOV = 70;
	SongSelectRateIncrement = 0.05;
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
	FastSpawn(function(name, call)
		local lastVal = nil
		local first = true
		while true do
			local sn = Settings.Options[name]
			if lastVal ~= sn then
				if first then
					first = false
				else
					print(sn)
					call(sn)
				end
				lastVal = sn
			end
			wait()
		end
	end, name, call)
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

function Settings:Increment(key, value, clamp)
	if typeof(Settings.Options[key]) == "number" then
		local huge = math.huge
		Settings.Options[key] = Settings.Options[key] + value
		print(clamp.max)
		Settings.Options[key] = math.clamp(Settings.Options[key], clamp.min or -huge, clamp.max or huge)
		return Settings.Options[key]
	end
	return 0
end

function Settings:GetOption(key)
	return Settings.Options[key]
end

function Settings:LoadFromDatabaseSave()
	warn("Not implemented.")
end

function Settings:SaveToDatabase()
	warn("Not implemented.")
end

return Settings