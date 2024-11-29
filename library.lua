-- Main Library Table
local Library = {}

-- Button Component
Library.Button = {}

function Library.Button:Create(properties)
    -- Create a TextButton
    local button = Instance.new("TextButton")
    button.Name = properties.Name or "Button"
    button.Text = properties.Text or "Click Me"
    button.Size = properties.Size or UDim2.new(0, 200, 0, 50)
    button.Position = properties.Position or UDim2.new(0.5, 0, 0.5, 0)
    button.AnchorPoint = properties.AnchorPoint or Vector2.new(0.5, 0.5)
    button.BackgroundColor3 = properties.BackgroundColor3 or Color3.fromRGB(50, 50, 50)
    button.TextColor3 = properties.TextColor3 or Color3.new(1, 1, 1)
    button.Font = properties.Font or Enum.Font.Gotham
    button.Parent = properties.Parent or game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

    -- Attach a callback function if provided
    if properties.Callback then
        button.MouseButton1Click:Connect(properties.Callback)
    end

    return button
end

-- Slider Component (Placeholder Example)
Library.Slider = {}

function Library.Slider:Create(properties)
    -- Create a Frame for the slider
    local frame = Instance.new("Frame")
    frame.Name = properties.Name or "Slider"
    frame.Size = properties.Size or UDim2.new(0, 200, 0, 50)
    frame.Position = properties.Position or UDim2.new(0.5, 0, 0.6, 0)
    frame.AnchorPoint = properties.AnchorPoint or Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = properties.BackgroundColor3 or Color3.fromRGB(30, 30, 30)
    frame.Parent = properties.Parent or game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

    -- Create the slider fill
    local slider = Instance.new("Frame")
    slider.Name = "SliderFill"
    slider.Size = UDim2.new(properties.Default or 0.5, 0, 1, 0)
    slider.BackgroundColor3 = properties.SliderColor or Color3.fromRGB(100, 100, 255)
    slider.Parent = frame

    -- Handle slider input
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            local pos = math.clamp(input.Position.X - frame.AbsolutePosition.X, 0, frame.AbsoluteSize.X)
            slider.Size = UDim2.new(pos / frame.AbsoluteSize.X, 0, 1, 0)
            if properties.Callback then
                properties.Callback(pos / frame.AbsoluteSize.X)
            end
        end
    end)

    return frame
end

-- Toggle Component (Placeholder Example)
Library.Toggle = {}

function Library.Toggle:Create(properties)
    -- Create a Frame for the toggle
    local frame = Instance.new("Frame")
    frame.Name = properties.Name or "Toggle"
    frame.Size = properties.Size or UDim2.new(0, 100, 0, 50)
    frame.Position = properties.Position or UDim2.new(0.5, 0, 0.7, 0)
    frame.AnchorPoint = properties.AnchorPoint or Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = properties.BackgroundColor3 or Color3.fromRGB(40, 40, 40)
    frame.Parent = properties.Parent or game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

    -- Create the toggle button
    local toggleButton = Instance.new("TextButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Size = UDim2.new(1, 0, 1, 0)
    toggleButton.Text = properties.Default and "On" or "Off"
    toggleButton.BackgroundColor3 = properties.Default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    toggleButton.Parent = frame

    local state = properties.Default or false
    toggleButton.MouseButton1Click:Connect(function()
        state = not state
        toggleButton.Text = state and "On" or "Off"
        toggleButton.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        if properties.Callback then
            properties.Callback(state)
        end
    end)

    return frame
end

-- Return the Library
return Library
