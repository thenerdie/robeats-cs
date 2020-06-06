local Screen = {}

function Screen:new(name, meta, props)
	self = meta or {}
	self.Name = name
	return self
end

return Screen
