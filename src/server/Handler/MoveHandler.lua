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
			{
				InputObject = Enum.KeyCode.Two,
				Move = require(MovesFolder.SnapGate),
			},
			{
				InputObject = Enum.KeyCode.Three,
				Move = require(MovesFolder.SnapViribus),
			},
		},
		Player = Player,
		Cooldowns = {},
		activeMoves = {},
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

function module.changeKeybind(self: MoveHandler, key: Enum.KeyCode, num: number)
	if not self.Moves[num] then
		return
	end
	self.Moves[num].InputObject = key
end

function module.getMoveFromInput(self: MoveHandler, input: Enum.KeyCode): MovesM.Move?
	for i = 1, #self.Moves do
		if not self.Moves[i] then
			continue
		end
		if not (self.Moves[i].InputObject == input) then
			continue
		end
		return self.Moves[i].Move
	end
end

function module.anyMoveActive(self: MoveHandler) : boolean?
	for _, b in pairs(self.activeMoves) do
		if not b then
			continue
		end
		return true
	end
end

function module.input(self: MoveHandler, input: Enum.KeyCode)
	local Move = self:getMoveFromInput(input)
	if not Move then
		return
	end
	if self.Cooldowns[Move] then
		return
	end
	if self.Cooldowns[Move] then
		return
	end
	--You can change this with a bit of code if you want
	if self:anyMoveActive() then
		return
	end
	if not self.Player.Character then
		return
	end
	self.activeMoves[Move] = true
	Move:activate(self.Player)
end

function module.resetCooldowns(self: MoveHandler)
	self.Cooldowns = {}
end

function module.deactivate(self: MoveHandler, move: string)
	local moveC = self.getMoveFromName(move)
	if not moveC then
		return
	end
	moveC:deactivate(self.Player)
	self:addCooldown(moveC)
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
	activeMoves: { [MovesM.Move]: boolean? },
}
export type MoveHandler = typeof(setmetatable({}, module)) & MoveHandlerInit

return module
