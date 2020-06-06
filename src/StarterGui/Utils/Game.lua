local SPUtil = require(game.ReplicatedStorage.Shared.SPUtil)
local DebugOut = require(game.ReplicatedStorage.Local.DebugOut)
local SFXManager = require(game.ReplicatedStorage.Local.SFXManager)
local ObjectPool = require(game.ReplicatedStorage.Local.ObjectPool)
local EffectSystem = require(game.ReplicatedStorage.Effects.EffectSystem)
local InputUtil = require(game.ReplicatedStorage.Shared.InputUtil)
local CurveUtil = require(game.ReplicatedStorage.Shared.CurveUtil)
local EnvironmentSetup = require(game.ReplicatedStorage.LocalShared.EnvironmentSetup)
local GameJoin = require(game.ReplicatedStorage.Local.GameJoin)
local SPUISystem = require(game.ReplicatedStorage.Shared.SPUISystem)
local EnqueueFn = require(game.ReplicatedStorage.Shared.EnqueueFn)
local HitCache = require(game.ReplicatedStorage.Local.HitCache)
local ModManager = require(game.ReplicatedStorage.ModManager)

local RunService = game:GetService("RunService")
local s = game.ReplicatedStorage.Spectating

EnvironmentSetup:initial_setup(game.Players.LocalPlayer, workspace.CurrentCamera)

local Game = {}

function Game:new()
	local g = {}
	g._local_services = {}
	g.local_game = {}
	function g:StartGame(song, rate, keys, note_color, scroll_speed)
		print(song:GetDisplayName())
		local _local_services = {}
		_local_services = {
			_spui = SPUISystem:new(5);
			_game_join = GameJoin:new();
			_input = InputUtil:new(keys);
			_sfx_manager = SFXManager:new(EnvironmentSetup:get_element());
			_object_pool = ObjectPool:new(EnvironmentSetup:get_element());
			_update_enqueue_fn = EnqueueFn:new();
			hit_cache = HitCache:new()
		}
		g._local_services = _local_services
		_local_services._game_join:game_init(_local_services, EnvironmentSetup:get_environment(), false)
		wait()
		local localGame = _local_services._game_join:load_game(
			_local_services,
			song,
			rate,
			scroll_speed,
			EnvironmentSetup:get_environment(),
			EnvironmentSetup:get_protos(), 
			EnvironmentSetup:get_element(),
			note_color,
			0, 
			0,
			{},
			nil,
			ModManager:GetActivatedMods() or {}
		)
		g.local_game = localGame
		
		local function getCurrentGameStatus()
			local plr = game.Players.LocalPlayer
			if plr then
				return game.ReplicatedStorage.Spectating.GetGame:InvokeServer(plr)
			end
		end
		
		local hC = localGame._hit_cache
		
		s.GetGame.OnClientInvoke = function()
			return {
				hits=hC.hits
			}
		end
		
		local function getTime()
			return _local_services._game_join:get_songTime()
		end
		
		repeat wait() until localGame:is_ready() and _local_services._game_join:is_game_audio_loaded()
		
		print(localGame:is_ready(), _local_services._game_join:is_game_audio_loaded())
		
		_local_services._game_join:start_game(EnvironmentSetup:get_protos())
		local game_force_end = false
		local isDone = false
		
		local tries = 0	
		
		local timeSinceLast = 0
		local selfgamedata = nil
		
		
		local function handleSpectators()
			--[[local timeNow = getTime()
			if timeNow - timeSinceLast > 2500 then
				timeSinceLast = timeNow
				selfgamedata = getCurrentGameStatus()
				if selfgamedata then
					for i, ob in pairs(Spectators:GetChildren()) do
						if ob.Name == script.Spectator.Name then
							ob:Destroy()
						end
					end
					for i, plr_ in pairs(selfgamedata.spectators) do
						local ob = script.Spectator:Clone()
						ob.Text = plr_.Name
						ob.Parent = Spectators
					end
				end
			end--]]
		end
		
		
		local checkCount = 1
		local songTime = 0
		local songLength = _local_services._game_join:get_songLength()/1000
		local timeLeft = 0
		local timeText = ""
		local prevTimeLeft = 0
		while isDone == false and game_force_end == false do
			local tickDelta = RunService.Heartbeat:wait()
			local dt_scale = CurveUtil:DeltaTimeToTimescale(tickDelta)
					
			_local_services._game_join:update(dt_scale)
			_local_services._spui:layout()
			_local_services._update_enqueue_fn:update(dt_scale)
	
			_local_services._sfx_manager:update(dt_scale,_local_services)
			_local_services._input:post_update()
			songTime = _local_services._game_join:get_songTime()/1000
			isDone = _local_services._game_join:check_songDone()
			spawn(function()
				local suc, err = pcall(handleSpectators)
				if not suc then warn(err) end
			end)
		end
	end
	function g:DestroyStage()
		g._local_services._game_join:finishGame()
		local so = workspace.CurrentCamera:GetChildren()
		for i=1, #so do
			if so[i].Name ~= "LocalElements" and so[i].Name ~= "GameEnvironment" then
				so[i]:Destroy()
			elseif so[i].Name == "LocalElements" then
				local lo = so[i]:GetChildren()
				for j=1, #lo do
					lo[j]:Destroy()
				end
			elseif so[i].Name == "GameEnvironment" then
				so[i].Parent = nil
			end
		end
	end
	function g:GetGame()
		return g.local_game
	end
	function g:GetLocalServices()
		return g._local_services
	end
	return g
end

return Game