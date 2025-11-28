--BYW SCRIPT
local xrayEnabled = false
local xrayConnection

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XRayMenu"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

local xrayBtn = Instance.new("TextButton")
xrayBtn.Name = "XRayBtn"
xrayBtn.Size = UDim2.new(0, 40, 0, 40)
xrayBtn.Position = UDim2.new(0, 10, 0, 10)
xrayBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
xrayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
xrayBtn.Text = "B"
xrayBtn.TextSize = 28
xrayBtn.Font = Enum.Font.GothamBold
xrayBtn.BorderSizePixel = 0
xrayBtn.Active = true
xrayBtn.Draggable = true
xrayBtn.Parent = screenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = xrayBtn

local function toggleXRay()
    xrayEnabled = not xrayEnabled
    
    if xrayEnabled then
        xrayConnection = game:GetService("RunService").RenderStepped:Connect(function()
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and part.Parent ~= game.Players.LocalPlayer.Character then
                    part.LocalTransparencyModifier = 0.5
                end
            end
        end)
        xrayBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        if xrayConnection then
            xrayConnection:Disconnect()
            xrayConnection = nil
        end
        for _, part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                part.LocalTransparencyModifier = 0
            end
        end
        xrayBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end
end

xrayBtn.MouseButton1Click:Connect(function()
    toggleXRay()
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.X then
        toggleXRay()
    end
end)

print("BYW SCRIPT loaded!")
