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

function module.load(self: MoveHandler, Moves: {[number]: {InputObject: string, Move: string}})
    
end

function module.getMoveFromInput(self: MoveHandler, input: InputObject)
	for i = 1, #self.Moves do
		if not self.Moves[i] then
			continue
		end
		if not (self.Moves[i].InputObject == input.KeyCode) then
			continue
		end
		return self.Moves[i].Move
	end
end

function module.input(self: MoveHandler, input: Enum.KeyCode)
	print(input)
	local Move = self:getMoveFromInput(input)
	if not Move then
		return
	end
	return Move.activate()
end

export type MoveHandlerInit = {
	Moves: { [number]: { InputObject: Enum.KeyCode, Move: MovesM.MoveFunctions? } },
}
export type MoveHandler = typeof(setmetatable({}, module)) & MoveHandlerInit

return module
