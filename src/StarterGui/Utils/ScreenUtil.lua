local Screen = require(script.Parent.Screen)

local self = {}
self.Screens = {}

function self:FindScreen(name)
	assert(name ~= nil, "Expected string got nil")
	for name_s, screen in pairs(self.Screens) do
		if name_s == name then
			return screen
		end
	end
end

function self:NewScreen(name, meta, props)
	assert(name and meta, "Error!")
	local scr = Screen:new(name, meta, props)
	self.Screens[name] = scr
	return scr
end

return self
