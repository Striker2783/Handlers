--!strict
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
	self:constructor(...)
	return self :: PlayerHandler
end

function module.constructor(self: PlayerHandler)
	super.constructor(self)
end

function module.addPlayer(self: PlayerHandler, Player: Player)
	local PlayerC = PlayerM.new(Player)
	self.Players[Player] = PlayerC
end

export type PlayerInit = {
	Players: { [Player]: PlayerM.PlayerC },
}

export type PlayerHandler = typeof(setmetatable({}, module)) & PlayerInit

return module
