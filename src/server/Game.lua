--!strict
local module = {}
local Players = game:GetService("Players")
local PlayerHandlerM = require(script.Parent.Handler.PlayerHandler)
local RS = game:GetService("ReplicatedStorage")
--No metatable this time because we only need 1 of these
local Handlers = {
	PlayerHandler = PlayerHandlerM.new(),
}

Players.PlayerAdded:Connect(function(player)
	Handlers.PlayerHandler:addPlayer(player);
end)

RS.Events.Input.OnServerEvent:Connect(function(Player: Player, Input: Enum.KeyCode)
	Handlers.PlayerHandler:input(Player, Input)
end)

return module
