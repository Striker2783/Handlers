local Players = game:GetService("Players")
--!strict
local module = {}
module.__index = module

local MovesFolder = script.Parent.Parent.Moves
local MovesM = require(script.Parent.Parent.Moves)
local ToolsM = require(script.Parent.Parent.Tools)

function module.new(Player: Player): MoveHandler
	local self: MoveHandlerInit = {
		Moves = {
			{
				InputObject = Enum.KeyCode.One,
				Move = require(MovesFolder.Fireball),
			},
		},
		Player = Player,
		Cooldowns = {},
	}
	setmetatable(self, module)
	return self :: MoveHandler
end
--Gets the move module from name
function module.getMoveFromName(name: string): MovesM.MoveFunctions?
	for _, v in pairs(MovesFolder:GetChildren()) do
		if v.Name ~= name then
			continue
		end
		return require(v) :: MovesM.MoveFunctions
	end
end
--Loads a table of move settings
function module.load(self: MoveHandler, MoveStats: { [number]: { InputObject: number, Move: string } })
	for i, v in pairs(MoveStats) do
		local keycode = ToolsM.getMatchingKeyCodeFromValue(v.InputObject)
		local Move = self.getMoveFromName(v.Move)
		self.Moves[i].InputObject = keycode
		self.Moves[i].Move = Move
	end
end

function module.getMoveFromInput(self: MoveHandler, input: Enum.KeyCode) : MovesM.Move?
	for i = 1, #self.Moves do
		if not self.Moves[i] then
			continue
		end
		if not (self.Moves[i].InputObject == input) then
			continue
		end
		print(self.Moves[i])
		return self.Moves[i].Move
	end
end

function module.input(self: MoveHandler, input: Enum.KeyCode)
	local Move = self:getMoveFromInput(input)
	if not Move then
		return
	end
	if self.Cooldowns[Move] then return end
	self.Cooldowns[Move] = true
	Move.activate(self.Player)
end

function module.deactivate(self: MoveHandler, move: string)
	local Move = self.getMoveFromName(move)
	if not Move then
		return
	end
	Move.deactivate(self.Player)
end

function module.addCooldown(self: MoveHandler, move: MovesM.Move)
	self.Cooldowns[move] = true
	coroutine.wrap(function()
		task.wait(move.COOLDOWN)
		self.Cooldowns[move] = nil
	end)()
end

export type MoveHandlerInit = {
	Moves: { [number]: { InputObject: Enum.KeyCode, Move: MovesM.Move? } },
	Player: Player,
	Cooldowns: { [MovesM.Move]: boolean? },
}
export type MoveHandler = typeof(setmetatable({}, module)) & MoveHandlerInit

return module
