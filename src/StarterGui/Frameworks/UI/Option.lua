local Roact = require(game.ReplicatedStorage.Roact)
local UI = script.Parent
local Element = Roact.Component:extend("Option")

local Settings = require(script.Parent.Parent.Parent.Utils.Settings)

local function c(name)
	return require(UI:FindFirstChild(name))
end

local function frag(c)
	return Roact.createFragment(c)
end

local function genProps(self)
	
	local other = {}
	
	if self.props.type == "number" then
		other = frag({
			OptionValue=Roact.createElement(c("TextLabel"), {
				Size=UDim2.new(0.25,0,1,0);
				Position=UDim2.new(1/4,0,0,0);
				BTransparency=0.7;
				Text=self.state[self.props.Setting]
			});
			Plus=Roact.createElement(c("TextButton"), {
				Text="+";
				Size=UDim2.new(0.25,0,1,0);
				Position=UDim2.new(2/4,0,0,0);
				BTransparency=0.7;
				OnClick = function(rbx)
					Settings:Increment(self.props.Setting, 1)
					self:setState(Settings.Options)
				end
			});
			Minus=Roact.createElement(c("TextButton"), {
				Text="-";
				Size=UDim2.new(0.25,0,1,0);
				Position=UDim2.new(3/4,0,0,0);
				BTransparency=0.7;
				OnClick = function(rbx)
					Settings:Increment(self.props.Setting, -1)
					self:setState(Settings.Options)
				end
			});
		})
	end
	
	if self.props.type == "string" then
		other = frag({
			Text=Roact.createElement(c("TextBox"), {
				Text="";
				Size=UDim2.new(0.75,0,1,0);
				Position=UDim2.new(1/4,0,0,0);
				BTransparency=0.7;
				OnChange = function(rbx)
					Settings:ChangeOption(self.props.Setting, rbx.Text)
				end
			})
		})
	end
	
	if self.props.type == "color" then
		other = frag({
			Text=Roact.createElement(c("TextBox"), {
				Text="nil,nil,nil";
				Size=UDim2.new(0.75,0,1,0);
				Position=UDim2.new(1/4,0,0,0);
				BTransparency=0.7;
				OnChange = function(rbx)
					Settings:ParseStringColor3(self.props.Setting, rbx.Text)
				end
			})
		})
	end
	
	return frag({
		OptionName=Roact.createElement(c("TextLabel"),{
			Text=self.props.Name .. ":";
			Size=UDim2.new(0.25,0,1,0);
			BTransparency=1;
		});
		Other=other;
	})
end

function Element:init()
	self:setState(Settings.Options)
end

function Element:render()	
    return Roact.createElement("Frame", {
		BackgroundTransparency=0.9;
		BackgroundColor3=Color3.new(0.1,0.1,0.1);
		Size=UDim2.new(1,0,1/self.props.max_opt,0);
		Position=UDim2.new(0,0,(self.props.opt_num-1)/self.props.max_opt,0);
	}, {
		Props=genProps(self)
	})
end

return Element
