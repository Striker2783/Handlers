--!strict
local module: MoveStats = {
	COOLDOWN = 1, --Cooldown in seconds
	ACTIVE_TIME = 1, --Active time in seconds
	isActivate = false,
	isOnCooldown = false,
}
module.__index = module
export type MoveStats = {
	[string]: any,
	isActivate: boolean,
	isOnCooldown: boolean,
	COOLDOWN: number,
	ACTIVE_TIME: number,
}
export type MoveFunctions = {
	activate: (Player, ...any) -> ({ [Humanoid]: number }),
} & MoveStats

return module
