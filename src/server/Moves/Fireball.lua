local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RS = game:GetService("ReplicatedStorage")
local Moves = require(script.Parent)

local module: Moves.Move = {
    COOLDOWN = 5,
    activate = function(self: Moves.Move, Player: Player)
        print("Activated")
        task.wait(self.COOLDOWN)
        print(self.COOLDOWN)
        RS.Events.Deactivate:Fire(Player, script.Name)
    end,
    deactivate = function(self: Moves.Move, Player: Player)
        print("Deactivated")
    end
}
setmetatable(module, Moves)

return module;