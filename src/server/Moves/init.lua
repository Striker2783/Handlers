--Module that has the stats for moves
local default: MoveFunctions = {
	COOLDOWN = 1, --Cooldown in seconds
	ACTIVE_TIME = 1, --Active time in seconds
	deactivate = function()
		return
	end,
	activate = function()
		return {}
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
	activate: (Player) -> ({ [Humanoid]: number }),
	deactivate: (Player) -> (),
} & (MoveStats?)

return default
