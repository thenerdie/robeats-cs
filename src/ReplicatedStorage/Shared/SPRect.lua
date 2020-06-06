local SPRect = {}

function SPRect:new(x,y,x2,y2)
	local self = {
		_x1 = x;
		_y1 = y;
		_x2 = x2;
		_y2 = y2;		
	}
	
	function self:set(x1,y1,x2,y2)
		self._x1 = x1
		self._y1 = y1
		self._x2 = x2
		self._y2 = y2
	end
	
	function self:set_centerxy_wid_hei(centerx,centery,wid,hei)
		self._x1 = centerx - wid * 0.5
		self._y1 = centery - hei * 0.5
		self._x2 = centerx + wid * 0.5
		self._y2 = centery + hei * 0.5
	end
	
	function self:contains_xy(x,y)
		return x >= self._x1 and x <= self._x2 and y >= self._y1 and y <= self._y2
	end
	
	function self:contains_vec2(vec2)
		return self:contains_xy(vec2.X, vec2.Y)
	end
	
	function self:contains_rect(r2)
		local r1 = self
		return not (r1._x1 > r2._x2 or
			r2._x1 > r1._x2 or
			r1._y1 > r2._y2 or
			r2._y1 > r1._y2)
	end
	
	function self:get_nxy(nx,ny)
		return (self._x2-self._x1) * nx + self._x1, (self._y2-self._y1) * ny + self._y1
	end
	
	function self:to_string()
		return string.format("{(%.2f,%.2f),(%.2f,%.2f)}",self._x1,self._y1,self._x2,self._y2)
	end
	
	return self
end

return SPRect
