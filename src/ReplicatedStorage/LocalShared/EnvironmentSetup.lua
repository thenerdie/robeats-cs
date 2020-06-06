local SPVector = require(game.ReplicatedStorage.Shared.SPVector)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)
local SPDict = require(game.ReplicatedStorage.Shared.SPDict)
local Player = nil
local Location = nil
local Protos = nil
local LocalElements = nil

local EnvironmentSetup = {}
EnvironmentSetup.Mode = {
	Lobby = 0;
	Game = 1;
}

local _npcs = SPDict:new()

local _game_environment = nil

function EnvironmentSetup:initial_setup(player, location)
	Location = location
	_game_environment = game.ReplicatedStorage.GameEnvironment:Clone()
	Player = player
	Protos = _game_environment.ElementProtos
	
	--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
	game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)

	location.CameraType = Enum.CameraType.Scriptable
	Protos.Parent = nil

	--do
		LocalElements = Instance.new("Folder",location)
		LocalElements.Name = "LocalElements"
	--end

	--do
		--local WorldUI = Instance.new("Folder",game.Workspace)
		--WorldUI.Name = "WorldUI"
	--end

	_game_environment.Parent = nil
	
end


function EnvironmentSetup:set_mode(mode)
	if _game_environment.Parent ~= nil then
		_game_environment.Parent = nil
	end

	if mode == EnvironmentSetup.Mode.Lobby then

	elseif mode == EnvironmentSetup.Mode.Game then
		-- game.Lighting.Brightness = 0.25
		-- game.Lighting.ColorShift_Bottom = SPVector:new(0,0,0):to_color3()
		-- game.Lighting.ColorShift_Top = SPVector:new(0,0,0):to_color3()

		_game_environment.Parent = Location

	end
end

function EnvironmentSetup:get_environment()
	return _game_environment
end

function EnvironmentSetup:get_protos()
	return Protos
end

function EnvironmentSetup:get_element()
	return LocalElements
end

return EnvironmentSetup
