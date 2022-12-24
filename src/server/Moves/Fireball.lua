local Moves = require(script.Parent)

local module: Moves.MoveFunctions = {
    COOLDOWN = 5,
    activate = function(Player: Player)
        print("Activated")
        return {}
    end,
    deactivate = function()
        print("Deactivated")
    end
}
setmetatable(module, Moves)

return Moves;