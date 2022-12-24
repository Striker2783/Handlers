local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")

UIS.InputBegan:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end
    RS.Events.Input:FireServer(input.KeyCode)
end)

RS.Functions.getHitPos.OnClientInvoke = function()
    local Mouse = game.Players.LocalPlayer:GetMouse()
    return Mouse.Hit.Position
end