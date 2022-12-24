--Handler that handles all the players in the game
local module = {}
module.__index = module
local super = require(script.Parent)
setmetatable(module, super)

local PlayerM = require(script.Parent.Parent.Player)
--Creates a new Player Handler
function module.new(...): PlayerHandler
	local self: PlayerInit = {
		Players = {},
	}
	setmetatable(self, module)
	return self :: PlayerHandler
end
--Adds a Player to the Player Handler
function module.addPlayer(self: PlayerHandler, Player: Player)
	local PlayerC = PlayerM.new(Player)
	self.Players[Player] = PlayerC
end
--Removes a Player from the Player Handler
function module.removePlayer(self: PlayerHandler, Player: Player)
	local PlayerC = self:getPlayerCFromPlayer(Player)
	if not PlayerC then
		return
	end
	PlayerC:leave()
	self.Players[Player] = nil
end
--Gets a PlayerC from the handler based on the Player class
function module.getPlayerCFromPlayer(self: PlayerHandler, Player: Player): PlayerM.PlayerC?
	return self.Players[Player]
end
--Fires when a user inputs something
function module.input(self: PlayerHandler, Player: Player, Input: Enum.KeyCode)
	local PlayerC = self:getPlayerCFromPlayer(Player)
	PlayerC:input(Input)
end

function module.deactivate(self: PlayerHandler, player: Player, move: string)
	local PlayerC: PlayerM.PlayerC = self:getPlayerCFromPlayer(player)
	if not PlayerC then
		return
	end
	PlayerC:deactivateMove(move)
end
function module.hit(self: PlayerHandler, player: Player, hum: Humanoid, baseDmg: number)
	--If you want like a Character system that allows for some defense, block, etc, then tell us :-)
	local PlayerC = self:getPlayerCFromPlayer(player)
	if not PlayerC then
		return
	end
	PlayerC:hit(hum, baseDmg)
end
function module.changeKeybind(self: PlayerHandler, player: Player, key: Enum.KeyCode, num: number)
	local PlayerC = self:getPlayerCFromPlayer(player)
	if not PlayerC then
		return
	end
	PlayerC.MoveHandler:changeKeybind(key, num)
end
--Type forr initial PlayerHandler
export type PlayerInit = {
	Players: { [Player]: PlayerM.PlayerC },
}
--Actual type of PlayerHandler
export type PlayerHandler = typeof(setmetatable({}, module)) & PlayerInit

return module
