local UDimObjWrapper = {}

function UDimObjWrapper:new(obj)
	local self = {}	
	self._obj = obj
	self._x = obj.Position.X.Offset
	self._y = obj.Position.Y.Offset
	self._sizex = self._obj.Size.X.Offset
	self._sizey = self._obj.Size.Y.Offset
	local _parent = obj.Parent
	self._visible = true
	function self:get_pos()
		return Vector2.new(self._x,self._y)
	end
	function self:set_pos(x,y)
		self._x = x
		self._y = y
		self._obj.Position = UDim2.new(0,self._x,0,self._y)
		return self
	end	
	function self:get_size()
		return Vector2.new(self._sizex, self._sizey)
	end
	function self:set_size(x,y)
		self._sizex = x
		self._sizey = y
		self._obj.Size = UDim2.new(0,self._sizex,0,self._sizey)
		return self
	end
	function self:set_visible(val)
		self._visible = val
		if val == true then
			obj.Parent = _parent
		else
			obj.Parent = nil
		end
		return self
	end
	function self:set_parent(parent)
		_parent = parent
		obj.Parent = parent
		return self
	end
	function self:set_name(name)
		obj.Name = name
	end
	return self
end

return UDimObjWrapper
