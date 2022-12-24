local Moves = require(script.Parent)

local module: Moves.Move = {
    COOLDOWN = 5,
    activate = function(self: Moves.MoveFunctions, Player: Player)
        print("Activated")
        getmetatable(self):activate()
    end,
    deactivate = function(self: Moves.MoveFunctions, Player: Player)
        print("Deactivated")
    end
}
setmetatable(module, Moves)

return module;