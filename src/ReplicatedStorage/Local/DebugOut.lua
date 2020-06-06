local DebugOut = {}

local _display = Instance.new("Message")
_display.Name = "DebugOut"

function DebugOut:show()
	_display.Parent = game.Workspace
end
function DebugOut:hide()
	_display.Parent = nil
end
function DebugOut:puts(str,...)
	local out_str =	 string.format(
		"[Client] %s",
		string.format(str,...)
	)
	--print(out_str)
	_display.Text = out_str
end
function DebugOut:errf(str,...)
	local out_str =	 string.format(
		"[Client] %s",
		string.format(str,...)
	)
	error(out_str)
	_display.Text = out_str
end
function DebugOut:warnf(str,...)
	local out_str =	 string.format(
		"[Client] %s",
		string.format(str,...)
	)
	warn(out_str)
	_display.Text = out_str
end

return DebugOut
