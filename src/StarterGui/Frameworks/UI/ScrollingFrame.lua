local Roact = require(game.ReplicatedStorage.Roact)
return function(props)
	local children = props.Children or {}
	local canvas_size = props.CanvasSize or UDim2.new(1,0,1,0)
	
	return Roact.createElement("ScrollingFrame", {
		AnchorPoint=props.Anchor or Vector2.new(0.5,0.5);
		Position=props.Position or UDim2.new(0.5,0,0.5,0);
		BackgroundColor3=props.BColor3 or Color3.fromRGB(12,12,12);
		BackgroundTransparency=props.BTransparency or 0.2;
		Size=props.Size or UDim2.new(0.7,0,0.82,0);
		CanvasSize=canvas_size;
		BorderSizePixel=props.BorderSize or 1;
	}, children)
end