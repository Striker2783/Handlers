--Handler that handles all the players in the game
local module = {}
module.__index = module
local super = require(script.Parent)
setmetatable(module, super)

local PlayerM = require(script.Parent.Parent.Player)

function module.new(...): PlayerHandler
	local self: PlayerInit = {
		Players = {},
	}
	setmetatable(self, module)
	return self :: PlayerHandler
end

function module.addPlayer(self: PlayerHandler, Player: Player)
	local PlayerC = PlayerM.new(Player)
	self.Players[Player] = PlayerC
end

function module.removePlayer(self: PlayerHandler, Player: Player)
	local PlayerC = self:getPlayerCFromPlayer(Player)
	if not PlayerC then return end
	PlayerC:leave()
end

function module.getPlayerCFromPlayer(self: PlayerHandler, Player: Player): PlayerM.PlayerC?
	return self.Players[Player]
end

function module.input(self: PlayerHandler, Player: Player, Input: Enum.KeyCode)
	local PlayerC = self:getPlayerCFromPlayer(Player)
	PlayerC:input(Input)
end

export type PlayerInit = {
	Players: { [Player]: PlayerM.PlayerC },
}

export type PlayerHandler = typeof(setmetatable({}, module)) & PlayerInit

return module
