--Module that has the stats for moves
local module: MoveStats = {
	COOLDOWN = 1, --Cooldown in seconds
	ACTIVE_TIME = 1, --Active time in seconds
	isActive = false,
	isOnCooldown = false,
}
module.__index = module
--Type for the Move's stats
export type MoveStats = {
	[string]: any,
	isActive: boolean,
	isOnCooldown: boolean,
	COOLDOWN: number,
	ACTIVE_TIME: number,
}
--Actual type for Move
export type MoveFunctions = {
	activate: (Player, ...any) -> ({ [Humanoid]: number }),
} & (MoveStats?)

return module
