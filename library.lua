local Library = {}

-- Define CreateMainFrame as a method of Library
function Library.CreateMainFrame(self, properties)
    -- Main Frame
    local frame = Instance.new("Frame")
    frame.Name = properties.Name or "MainFrame"
    frame.Size = properties.Size or UDim2.new(0, 400, 0, 300)
    frame.Position = properties.Position or UDim2.new(0.5, 0, 0.5, 0)
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.BackgroundColor3 = properties.BackgroundColor3 or Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 0
    frame.Parent = properties.Parent or game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

    -- Top Bar
    local topBar = Instance.new("Frame")
    topBar.Name = "TopBar"
    topBar.Size = UDim2.new(1, 0, 0, 30)
    topBar.BackgroundColor3 = properties.TopBarColor or Color3.fromRGB(30, 30, 30)
    topBar.BorderSizePixel = 0
    topBar.Parent = frame

    -- Title Label
    local title = Instance.new("TextLabel")
    title.Name = "Title"
    title.Text = properties.Title or "GUI"
    title.Size = UDim2.new(1, -30, 1, 0)
    title.Position = UDim2.new(0, 5, 0, 0)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.Font = Enum.Font.Gotham
    title.TextSize = 16
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = topBar

    -- Close Button
    local closeButton = Instance.new("TextButton")
    closeButton.Name = "CloseButton"
    closeButton.Text = "X"
    closeButton.Size = UDim2.new(0, 30, 1, 0)
    closeButton.Position = UDim2.new(1, -30, 0, 0)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 75, 75)
    closeButton.TextColor3 = Color3.new(1, 1, 1)
    closeButton.Font = Enum.Font.Gotham
    closeButton.TextSize = 16
    closeButton.Parent = topBar

    -- Close Functionality
    closeButton.MouseButton1Click:Connect(function()
        frame.Visible = false -- Hides the GUI
        if properties.OnClose then
            properties.OnClose() -- Callback for additional close functionality
        end
    end)

    -- Dragging Functionality
    local dragging, dragStart, startPos
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    topBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    topBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    return frame
end

-- Button Component
Library.Button = {}

function Library.Button:Create(properties)
    local button = Instance.new("TextButton")
    button.Name = properties.Name or "Button"
    button.Text = properties.Text or "Click Me"
    button.Size = properties.Size or UDim2.new(1, 0, 0, 40)
    button.Position = properties.Position or UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = properties.BackgroundColor3 or Color3.fromRGB(50, 50, 50)
    button.TextColor3 = properties.TextColor3 or Color3.new(1, 1, 1)
    button.Font = properties.Font or Enum.Font.Gotham
    button.TextSize = properties.TextSize or 14
    button.Parent = properties.Parent

    if properties.Callback then
        button.MouseButton1Click:Connect(properties.Callback)
    end

    return button
end

return Library
