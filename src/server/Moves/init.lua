local RS = game:GetService("ReplicatedStorage")
--Module that has the stats for moves
local default: MoveFunctions = {
	COOLDOWN = 1, --Cooldown in seconds
	ACTIVE_TIME = 1, --Active time in seconds
	deactivate = function(self: Move, player: Player) end,
	activate = function(self: Move, player: Player)
		task.wait(self.COOLDOWN)
		RS.Events.Deactivate:Fire(player, script.Name)
	end,
	IS_PASSIVE = false --Does not disable other moves when active
}
default.__index = default
--Type for the Move's stats
export type MoveStats = {
	[string]: any,
	COOLDOWN: number,
	ACTIVE_TIME: number,
	IS_PASSIVE: boolean,
}
--Actual type for Move
export type MoveFunctions = {
	activate: (Move, Player) -> (),
	deactivate: ((Move, Player) -> ())?,
} & (MoveStats?)

export type Move = typeof(setmetatable({}, default)) & MoveFunctions

return default
