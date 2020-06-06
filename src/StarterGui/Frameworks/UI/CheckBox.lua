local Roact = require(game.ReplicatedStorage.Roact)
local Element = Roact.Component:extend("CheckBox")

function Element:init()
    self:setState({
		Value=false;
	})
end

function Element:render()
    return Roact.createElement("ImageButton", {
		Size=UDim2.new(0,15,0,15);
		BackgroundColor3=self.state.Value and Color3.new(1,1,1) or Color3.new(0.2,0.2,0.2);
        ImageTransparency=1;
		[Roact.Event.MouseButton1Click] = function(rbx)
			self:setState(function(state)
				return {
					Value=not state.Value;
				}
			end)
		end;
    })
end

return Element
