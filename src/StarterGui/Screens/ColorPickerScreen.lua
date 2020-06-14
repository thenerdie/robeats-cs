local Roact = require(game.ReplicatedStorage.Roact)

local ColorPicker = {}

local tree = {}
local handle = {}
local pointerPosition = UDim2.new(0,0,0,0)
local pos, posChange = Roact.createBinding(pointerPosition)
local mouse = game.Players.LocalPlayer:GetMouse()
local canDrag = false
local screenActive = true

ColorPicker.SelectedColor = Color3.new(0, 0, 0)

function ColorPicker:DoColorPicker()
    tree = Roact.createElement("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5);
        Position = UDim2.new(0.5,0,0.5,0);
        Size = UDim2.new(0.35,0,0.35,0);
        BackgroundColor3 = Color3.new(0.1,0.1,0.1);
    }, {
        Wheel = Roact.createElement("ImageButton", {
            BackgroundTransparency = 1;
            Image = "rbxassetid://4674990774";
            Position = UDim2.new(0.35,0,0.5,0);
            Size = UDim2.new(0.35,0,0.35,0);
            [Roact.Event.MouseButton1Down] = function()
                canDrag = true
            end;
            [Roact.Event.MouseButton1Up] = function()
                canDrag = false
            end;
        }, {
            Pointer = Roact.createElement("ImageButton", {
                Image = "rbxassetid://5028661403";
                AnchorPoint = Vector2.new(0.5,0.5);
                Position = pos;
            });
        })
    })
    spawn(function()
        while true do
            if not screenActive then
                break
            end
            
        end
    end)
    handle = Roact.mount(tree, game.Players.LocalPlayer:WaitForChild("PlayerGui"), "ColorPickerScreen")
end

function ColorPicker:Unmount()
    Roact.unmount(handle, tree)
end

return ColorPicker