--!strict
local module = {}
module.__index = module

function module.new() : MoveHandler
    local self: MoveHandlerInit = {}
    setmetatable(self, module)
    return self :: MoveHandler
end

export type MoveHandlerInit = {

}
export type MoveHandler = typeof(setmetatable({}, module)) & MoveHandlerInit

return module;