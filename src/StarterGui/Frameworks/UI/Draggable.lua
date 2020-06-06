local Roact = require(game.ReplicatedStorage.Roact)
local Element = Roact.Component:extend("CheckBox")

local asset_uri = "rbxassetid://5028661403"

function Element:init()
    self:setState({
		Value=false;
	})
end

function Element:render()
    return Roact.createElement("ImageButton", {
		Image=asset_uri;
		Size=UDim2.new(0,15,0,15);
		BackgroundTransparency=1;
		Draggable=true;
    })
end

function Element:didMount()
	--[[spawn(function()
		while true do
			
			wait()
		end
	end)]]--
end

return Element
