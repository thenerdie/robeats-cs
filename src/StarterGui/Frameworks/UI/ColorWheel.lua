local Roact = require(game.ReplicatedStorage.Roact)
local Element = Roact.Component:extend("CheckBox")

local asset_uri = "rbxassetid://3678860818"

function Element:init()
    self:setState({
		IsDragging=false;
	})
end

function Element:render()
    return Roact.createElement("Frame", {
		Size=UDim2.new(0,15,0,15);
		BackgroundColor3=Color3.new(0.1,0.1,0.1);
        BackgroundTransparency=1;
		BackgroundTransparency=0.7;
    }, {
		Wheel=Roact.createElement("ImageLabel", {
			Image=asset_uri;
			Size=UDim2.new(1,0,1,0);
			BackgroundTransparency=1;
		}, {
			Pointer=Roact.Component:extend("Pointer")
		})
	})
end

return Element
