local Players = game:GetService("Players")
local PlayerHandlerM = require(script.Parent.Handler.PlayerHandler)
local MoveM = require(script.Parent.Moves)
local RS = game:GetService("ReplicatedStorage")
local Handlers = {
	PlayerHandler = PlayerHandlerM.new(),
}

game:BindToClose(function()
	Handlers.PlayerHandler:closedGame()
end)

Players.PlayerAdded:Connect(function(player)
	Handlers.PlayerHandler:addPlayer(player)
end)

Players.PlayerRemoving:Connect(function(player)
	Handlers.PlayerHandler:removePlayer(player)
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

RS.Events.ChangeKeybind.OnServerEvent:Connect(function(player, input: Enum.KeyCode, moveNum: number)
	Handlers.PlayerHandler:changeKeybind(player, input, moveNum)
end)