--// Regen_erate's map adder plugin - ver 0.0.1 - beta
--// This will allow you to add maps into the game much more cleanly, and without much hassle other than setting the audio offset (which is super annoying tbh)

--// FUNCTIONS

function getIdFromMap(map_name)
	local retString = ""
	for char in string.gmatch(map_name, ".") do
		if char ~= "[" then
			if char == "]" then break end
			retString = retString .. char
		end
	end
	return retString
end

local function newElement(type_, parent, suppressDefaults)
	local element = Instance.new(type_)
	if not suppressDefaults then
		pcall(function()
			element.Parent = parent
			element.Visible = true
			element.BorderSizePixel = 0
			element.TextSize = 10
			element.BackgroundTransparency = 1
			element.AnchorPoint = Vector2.new(0,0)
			element.Size = UDim2.new(1,0,0.09,0)
			element.Position = UDim2.new(0,0,0,0)
			element.SizeConstraint = Enum.SizeConstraint.RelativeYY
			element.TextColor3 = Color3.fromRGB(256, 256, 256)
			element.Text = "Click Me"
		end)
	end
	return element
end

local function getIDForNewMap()
	local highestID = 0
	for i, v in ipairs(game.ReplicatedStorage:WaitForChild("Songs", 4):GetChildren()) do
		local mapID_ = tonumber(getIdFromMap(v.Name))
		if mapID_ > highestID then
			highestID = mapID_
		end
	end
	return tostring(highestID + 1)
end

local function getDiff(diff)
	if diff == "null" then
		return ""
	end
	return "[" .. diff .. "]"
end

-- // VARIABLES
local toolbar = plugin:CreateToolbar("RoBeats CS")
local toggleEnabled = toolbar:CreateButton("Add Map", "Add a map to the game", "rbxassetid://73737626")
-- // MAIN
local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,  -- Widget will be initialized in floating panel
	false,   -- Widget will be initially enabled
	false,  -- Don't override the previous enabled state
	500,    -- Default width of the floating window
	500,    -- Default height of the floating window
	500,    -- Minimum width of the floating window
	500     -- Minimum height of the floating window
)
local mainWidget = plugin:CreateDockWidgetPluginGui("TestWidget", widgetInfo)
mainWidget.Title = "RCS MAP ADDER"

------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------
------------------------------------------------------------------------------

toggleEnabled.Click:Connect(function()
	mainWidget.Enabled = not mainWidget.Enabled
end)

local bg_Frame = newElement("Frame", mainWidget)
bg_Frame.Size = UDim2.new(1,0,1,0)
bg_Frame.BackgroundColor3 = Color3.fromRGB(117, 114, 114)
bg_Frame.Parent = mainWidget

local listLayout = Instance.new("UIListLayout")
listLayout.Parent = bg_Frame

local Artist = newElement("TextBox", bg_Frame)
Artist.Text = "[Artist]"
Artist.TextXAlignment = Enum.TextXAlignment.Left

local SongName = newElement("TextBox", bg_Frame)
SongName.Text = "[Song Name]"
SongName.TextXAlignment = Enum.TextXAlignment.Left

local Difficulty = newElement("TextBox", bg_Frame)
Difficulty.Text = "[Map Difficulty]"
Difficulty.TextXAlignment = Enum.TextXAlignment.Left

local ButtonColor = newElement("TextBox", bg_Frame)
ButtonColor.Text = "[Button Color (seperated by commas)]"
ButtonColor.TextXAlignment = Enum.TextXAlignment.Left

local Mapper = newElement("TextBox", bg_Frame)
Mapper.Text = "[Mapper]"
Mapper.TextXAlignment = Enum.TextXAlignment.Left

local MapsetDiff = newElement("TextBox", bg_Frame)
MapsetDiff.Text = "[Mapset Difficulty (LIGHT, HEAVY, etc. Put 'null' if not applicable.)]"
MapsetDiff.TextXAlignment = Enum.TextXAlignment.Left

local InsertButton = newElement("TextButton", mainWidget)
InsertButton.AnchorPoint = Vector2.new(1,1)
InsertButton.Position = UDim2.new(1,0,1,0)
InsertButton.Style = "RobloxButton"
InsertButton.Size = UDim2.new(0.2,0,0.1,0)
InsertButton.TextColor3 = Color3.fromRGB(242, 242, 242)
InsertButton.TextScaled = true
InsertButton.Text = "INSERT MAP"

InsertButton.MouseButton1Click:Connect(function()
	local mapModule = Instance.new("ModuleScript")
	local mapID = getIDForNewMap()
	mapModule.Name = "[" .. mapID .. "]" .. getDiff(MapsetDiff.Text) .. " " .. Artist.Text .. " - " .. SongName.Text .. " (" .. Mapper.Text .. ")"
	
	local ButtonColor_ob = Instance.new("Color3Value")
	local SongDiff = Instance.new("IntValue")
	local SongVersion = Instance.new("IntValue")
	
	ButtonColor_ob.Parent = mapModule
	ButtonColor_ob.Name = "ButtonColor"
	SongDiff.Parent = mapModule
	SongDiff.Name = "SongDiff"
	SongVersion.Parent = mapModule
	SongVersion.Name = "SongVersion"
	
	local color3 = string.split(ButtonColor.Text, ",")
	
	ButtonColor_ob.Value = Color3.fromRGB(tonumber(color3[1]), tonumber(color3[2]), tonumber(color3[3]))
	SongDiff.Value = tonumber(Difficulty.Text)
	SongVersion.Value = 1
	
	mapModule.Parent = game:GetService("ReplicatedStorage"):WaitForChild("Songs")
	plugin:OpenScript(mapModule)
end)