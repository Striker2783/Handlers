local Moves = require(script.Parent)

local module: Moves.MoveFunctions = {
    COOLDOWN = 5,
    ACTIVE_TIME = 0,
    activate = function(Player: Player)
        return {}
    end
}


return Moves;