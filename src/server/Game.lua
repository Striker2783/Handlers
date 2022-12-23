--!strict
local module = {}
local Players = game:GetService("Players")
local PlayerHandlerM = require(script.Parent.Handler.PlayerHandler)
--No metatable this time because we only need 1 of these
local Handlers = {
	PlayerHandler = PlayerHandlerM.new(),
}

Players.PlayerAdded:Connect(function(player)
	Handlers.PlayerHandler:addPlayer(player);
end)

return module
