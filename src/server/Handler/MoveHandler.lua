--!strict
local module = {}
module.__index = module

local MovesM = require(script.Parent.Parent.Moves)

function module.new(): MoveHandler
	local self: MoveHandlerInit = {
		Moves = {
			{
				InputObject = Enum.KeyCode.One,
				Move = nil,
			},
		},
	}
	setmetatable(self, module)
	return self :: MoveHandler
end

function module.getMoveFromInput(self: MoveHandler, input: InputObject)
	for i = 1, #self.Moves do
		if not (self.Moves[i].InputObject == input.KeyCode) then
			continue
		end
		return self.Moves[i].Move
	end
end

function module.input(self: MoveHandler, input: InputObject)
	local Move = self:getMoveFromInput(input)
	if not Move then
		return
	end
    return Move.activate()
end

export type MoveHandlerInit = {
	Moves: { [number]: { InputObject: InputObject, Move: MovesM.MoveFunctions? } },
}
export type MoveHandler = typeof(setmetatable({}, module)) & MoveHandlerInit

return module
