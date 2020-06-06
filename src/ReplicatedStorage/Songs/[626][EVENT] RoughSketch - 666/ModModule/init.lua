local mod = {}

local RunService = game:GetService("RunService")

local module_reset = require(script.Reset)
local module_quickreset = require(script.QuickReset)
local module_tiltleft = require(script.TiltLeft)
local module_tiltright = require(script.TiltRight)
local module_trackzoomin = require(script.TrackZoomIn)
local module_tracklookdown = require(script.TrackLookDown)
local module_kurehasliceup = require(script.KurehaSliceUp)
local module_kurehaslicedown = require(script.KurehaSliceDown)
local module_kurehafire = require(script.KurehaFire)
local module_lookleft = require(script.LookLeft)
local module_lookright = require(script.LookRight)
local module_trackreset = require(script.TrackReset)
local module_kurehareset = require(script.KurehaReset)

mod.timepoints = {}

mod.timepoints[1] = {timepoint = 41.037, module = module_tiltleft}
mod.timepoints[2] = {timepoint = 43.920, module = module_tiltright}
mod.timepoints[3] = {timepoint = 46.082, module = module_reset}
mod.timepoints[4] = {timepoint = 52.568, module = module_trackzoomin}
mod.timepoints[5] = {timepoint = 63.740, module = module_reset}
mod.timepoints[6] = {timepoint = 74.190, module = module_tracklookdown}
mod.timepoints[7] = {timepoint = 75.271, module = module_quickreset}
mod.timepoints[8] = {timepoint = 85.361, module = module_kurehasliceup}
mod.timepoints[9] = {timepoint = 85.631, module = module_kurehaslicedown}
mod.timepoints[10] = {timepoint = 99.776, module = module_kurehafire}
mod.timepoints[11] = {timepoint = 111.487, module = module_lookleft}
mod.timepoints[12] = {timepoint = 113.649, module = module_reset}
mod.timepoints[13] = {timepoint = 114.370, module = module_lookright}
mod.timepoints[14] = {timepoint = 115.812, module = module_trackreset}
mod.timepoints[15] = {timepoint = 117.433, module = module_kurehareset}

mod.camorigin = nil
mod.running = false

function mod:run(rate,songbgm)
	-- Initialization
	mod.camorigin = workspace.CurrentCamera.CFrame
	mod.running = true
	spawn(function()
		while mod.running do
			local step = 1
			while step <= #mod.timepoints do
				if (songbgm.TimePosition >= mod.timepoints[step].timepoint) then
					mod.timepoints[step].module:start(rate,mod.camorigin)
					step = step + 1
				end
				RunService.Heartbeat:Wait()
			end
			break
		end
	end)
end

function mod:stop() --Clean up
	print("[mod] Cleaning up...")
	workspace.CurrentCamera.CFrame = mod.camorigin
	local kureha = workspace:FindFirstChild("Kureha")
	if kureha then
		kureha:Destroy() --Bye bye kureha
	end
end

return mod
