local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")

UIS.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent then return end
    RS.Events.Input:FireServer(input)
end)