--!strict
local module = {}
module.__index = module

local DSS = game:GetService("DataStoreService")
local PlayerSaves = DSS:GetDataStore("DebugSave1")
local MoveHandler = require(script.Parent.Handler.MoveHandler)
local Settings = require(script.Parent.PlayerSettings)

function module.new(Player: Player): PlayerC
	local self = {
		Player = Player,
		Loaded = false,
		Money = 0,
		Stats = {
			Strength = 1,
			Level = 1,
			EXP = 0,
		},
		Settings = {},
		MoveHandler = MoveHandler.new()
	}
	setmetatable(self, module)
	return self :: PlayerC
end

function module:loadDSS(self: PlayerC)
	local success, Data = pcall(function()
		PlayerSaves:GetAsync(self.Player.UserId)
	end)
	if success then
		if Data then
			if Data.Money then
				self.Money = Data.Money
			end
			for i, _ in pairs(self.Stats) do
				if not Data.Stats[i] then
					continue
				end
				self.Stats[i] = Data.Stats[i]
			end
		end
		self.Loaded = true
	else
		self.Player:Kick("Failed to load datastore")
	end
end

function module.saveDSS(self: PlayerC)
	if not self.Loaded then
		return
	end
	local Data = {
		Money = self.Money,
		Stats = self.Stats,
	}
	PlayerSaves:SetAsync(self.Player.UserId, Data)
end

function module.calculateNextLevelUp(self: PlayerC)
	return 10 * self.Stats.Level
end

function module.hasEnoughEXP(self: PlayerC)
	return self.Stats.EXP >= self:calculateNextLevelUp()
end

function module.levelUp(self: PlayerC)
	if not self:hasEnoughEXP() then
		return
	end
	local EXP = self:calculateNextLevelUp()
	self.Stats.EXP -= EXP
	self.Stats.Level += 1
	self:levelUp()
end
export type Stats = {
	Strength: number,
	Level: number,
	EXP: number,
}
export type PlayerCInit = {
	Player: Player,
	Money: number,
	Loaded: boolean,
	Stats: Stats,
	MoveHandler: MoveHandler.MoveHandler,
}
export type PlayerC = typeof(setmetatable({}, module)) & PlayerCInit

return module
