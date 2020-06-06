local Roact = require(game.ReplicatedStorage.Roact)
local Element = Roact.Component:extend("CheckBox")

function Element:init()
    self:setState({
		Value="";
	})
	self.props.OnChange = self.props.OnChange or function()
	
	end
end

function Element:render()
    return Roact.createElement("TextBox", {
		Text=self.props.Text;
		TextColor3=self.props.Color or Color3.new(1,1,1);
		Position=self.props.Position;
		Size=self.props.Size or UDim2.new(0.1,0,0.15,0);
		BackgroundTransparency=self.props.BTransparency or 0;
		TextSize=self.props.TextSize or 14;
		PlaceholderText=self.props.Hint or "";
		PlaceholderColor3=self.props.HintColor or Color3.new(0.3,0.3,0.3);
		BackgroundColor3=self.props.BColor3 or Color3.new(0.1,0.1,0.1);
		AnchorPoint=self.props.Anchor or Vector2.new(0,0);
		TextXAlignment=self.props.TextXAlignment or Enum.TextXAlignment.Center;
		TextStrokeTransparency=self.props.TSTransparency or 0;
		[Roact.Event.Changed] = function(rbx)
			self.props.OnChange(rbx)
			self:setState(function(state)
				return {
					Value=rbx.Text;
				}
			end)
		end;
    })
end

return Element
