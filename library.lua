-- Main Library Table
local Library = {}

-- Define the Button Component
Library.Button = {} -- Initialize Button as a subtable of Library

-- Define the Create function for Button
function Library.Button:Create(properties)
    print("Button:Create called!") -- Debug message
    local button = Instance.new("TextButton") -- Create a TextButton
    button.Name = properties.Name or "Button"
    button.Text = properties.Text or "Click Me"
    button.Size = properties.Size or UDim2.new(0, 200, 0, 50)
    button.Position = properties.Position or UDim2.new(0.5, 0, 0.5, 0)
    button.AnchorPoint = properties.AnchorPoint or Vector2.new(0.5, 0.5)
    button.BackgroundColor3 = properties.BackgroundColor3 or Color3.fromRGB(50, 50, 50)
    button.TextColor3 = properties.TextColor3 or Color3.new(1, 1, 1)
    button.Font = properties.Font or Enum.Font.Gotham
    button.Parent = properties.Parent or game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

    -- Connect the callback if provided
    if properties.Callback then
        button.MouseButton1Click:Connect(properties.Callback)
    end

    return button -- Return the created button
end

print("Library loaded!") -- Debug message

-- Return the Library Table
return Library
