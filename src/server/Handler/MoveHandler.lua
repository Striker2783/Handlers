--!strict
local module = {}
module.__index = module

local MovesM = require(script.Parent.Parent.Moves)

function module.new() : MoveHandler
    local self: MoveHandlerInit = {
        Moves = {}
    }
    setmetatable(self, module)
    return self :: MoveHandler
end

export type MoveHandlerInit = {
    Moves: {[InputObject]: MovesM.MoveFunctions};
}
export type MoveHandler = typeof(setmetatable({}, module)) & MoveHandlerInit

return module;