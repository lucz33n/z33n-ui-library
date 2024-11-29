-- UILibrary.lua
local UILibrary = {}

-- Store all components
UILibrary.Components = {}

-- Helper function to add components
function UILibrary:AddComponent(name, func)
    self.Components[name] = func
end

-- Button Component
UILibrary:AddComponent("Button", {
    Create = function(properties)
        local button = Instance.new("TextButton")
        button.Name = properties.Name or "Button"
        button.Text = properties.Text or "Click Me"
        button.Size = properties.Size or UDim2.new(0, 100, 0, 50)
        button.Position = properties.Position or UDim2.new(0.5, 0, 0.5, 0)
        button.AnchorPoint = properties.AnchorPoint or Vector2.new(0.5, 0.5)
        button.BackgroundColor3 = properties.BackgroundColor3 or Color3.fromRGB(50, 50, 50)
        button.TextColor3 = properties.TextColor3 or Color3.new(1, 1, 1)
        button.Font = properties.Font or Enum.Font.Gotham
        button.Parent = properties.Parent or game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

        if properties.Callback then
            button.MouseButton1Click:Connect(properties.Callback)
        end

        return button
    end
})

-- Slider Component
UILibrary:AddComponent("Slider", {
    Create = function(properties)
        local frame = Instance.new("Frame")
        frame.Name = properties.Name or "Slider"
        frame.Size = properties.Size or UDim2.new(0, 200, 0, 50)
        frame.Position = properties.Position or UDim2.new(0.5, 0, 0.5, 0)
        frame.AnchorPoint = properties.AnchorPoint or Vector2.new(0.5, 0.5)
        frame.BackgroundColor3 = properties.BackgroundColor3 or Color3.fromRGB(30, 30, 30)
        frame.Parent = properties.Parent or game.Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("ScreenGui")

        local slider = Instance.new("Frame")
        slider.Name = "SliderFill"
        slider.Size = UDim2.new(properties.Default or 0.5, 0, 1, 0)
        slider.BackgroundColor3 = properties.SliderColor or Color3.fromRGB(100, 100, 255)
        slider.Parent = frame

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
})

return UILibrary
