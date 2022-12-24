--Module that has the stats for moves
local module: MoveStats = {
	COOLDOWN = 1, --Cooldown in seconds
	ACTIVE_TIME = 1, --Active time in seconds
}
module.__index = module
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

return module
