local RS = game:GetService("ReplicatedStorage")
--Module that has the stats for moves
local default: MoveFunctions = {
	COOLDOWN = 1, --Cooldown in seconds
	ACTIVE_TIME = 1, --Active time in seconds
	deactivate = function(self: MoveFunctions, player: Player) end,
	activate = function(self: MoveFunctions, player: Player)
		task.wait(self.COOLDOWN)
		RS.Events.Deactivate:Fire(player, script.Name)
	end,
}
default.__index = default
--Type for the Move's stats
export type MoveStats = {
	[string]: any,
	COOLDOWN: number,
	ACTIVE_TIME: number,
}
--Actual type for Move
export type MoveFunctions = {
	activate: (MoveFunctions, Player) -> (),
	deactivate: (MoveFunctions, Player) -> (),
} & (MoveStats?)

export type Move = typeof(setmetatable({}, default)) & MoveFunctions

return default
