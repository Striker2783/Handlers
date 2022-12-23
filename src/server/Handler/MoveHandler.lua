local module = {}
module.__index = module

function module.new()
    
end

export type MoveHandlerInit = {

}
export type MoveHandler = typeof(setmetatable({}, module)) & MoveHandlerInit

return module;