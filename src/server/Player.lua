--!strict
local module = {}
module.__index = module

local DSS = game:GetService("DataStoreService")
local PlayerSaves = DSS:GetDataStore("DebugSave1")
local MoveHandler = require(script.Parent.Handler.MoveHandler)

function module.new(Player: Player): PlayerC
	local self = {
		Player = Player,
		Loaded = false,
		Stats = {
			Money = 0,
			Level = 1,
			EXP = 0,
		},
		MoveHandler = MoveHandler.new(),
	}
	setmetatable(self, module)
	self:loadDSS()
	return self :: PlayerC
end

function module.loadDSS(self: PlayerC)
	local success, Data = pcall(function()
		return PlayerSaves:GetAsync(self.Player.UserId)
	end)
	if success then
		if Data then
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
	self:createLeaderstats()
end

function module.createLeaderstats(self: PlayerC)
	local leaderstats = Instance.new("Folder", self.Player)
	leaderstats.Name = "leaderstats"

	local Level = Instance.new("IntValue", leaderstats)
	Level.Name = "Level"
	Level.Value = self.Stats.Level

	local Money = Instance.new("IntValue", leaderstats)
	Money.Name = "Money"
	Money.Value = self.Stats.Money
end

function module.toSaveTable(self: PlayerC)
	return {
		Stats = self.Stats,
	}
end

function module.saveDSS(self: PlayerC)
	if not self.Loaded then
		return
	end
	local Data = self:toSaveTable()
	PlayerSaves:SetAsync(self.Player.UserId, Data)
end
--Calculates Base Damage
function module.calculateBaseDmg(self: PlayerC)
	return 1.1 ^ (self.Stats.Level - 1) --Every Increase of 1 level increases base damage by 1.1x, starting at 1 for level 1
end

function module.calculateNextLevelUp(self: PlayerC)
	return 10 * self.Stats.Level
end

function module.hasEnoughEXP(self: PlayerC)
	return self.Stats.EXP >= self:calculateNextLevelUp()
end

function module.input(self: PlayerC, input: InputObject)
	
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
	Level: number,
	EXP: number,
	Money: number,
}
export type PlayerCInit = {
	Player: Player,
	Loaded: boolean,
	Stats: Stats,
	MoveHandler: MoveHandler.MoveHandler,
}
export type PlayerC = typeof(setmetatable({}, module)) & PlayerCInit

return module
