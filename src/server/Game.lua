--!strict
local module = {}
local Players = game:GetService("Players")
local PlayerHandlerM = require(script.Parent.Handler.PlayerHandler)
local MoveM = require(script.Parent.Moves)
local RS = game:GetService("ReplicatedStorage")
--No metatable this time because we only need 1 of these
local Handlers = {
	PlayerHandler = PlayerHandlerM.new(),
}

Players.PlayerAdded:Connect(function(player)
	Handlers.PlayerHandler:addPlayer(player)
end)

RS.Events.Input.OnServerEvent:Connect(function(player: Player, input: Enum.KeyCode)
	Handlers.PlayerHandler:input(player, input)
end)

RS.Events.Deactivate.Event:Connect(function(player, move: string)
	Handlers.PlayerHandler:deactivate(player, move)
end)

RS.Events.Hit.Event:Connect(function(player: Player, hum: Humanoid, baseDmg: number)
	Handlers.PlayerHandler:hit(player, hum, baseDmg)
end)

return module
