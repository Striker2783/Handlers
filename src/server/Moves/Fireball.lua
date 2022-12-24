local RS = game:GetService("ReplicatedStorage")
local Moves = require(script.Parent)

local module: Moves.Move = {
	COOLDOWN = 5,
    SPEED = 100,
    DAMAGE = 5,
    SURVIVE = 5,
	activate = function(self: Move, player: Player)
		if not player.Character then
			return
		end
		local pos: Vector3 = RS.Functions.getHitPos:InvokeClient(player)

		local Clone = RS.MoveStuff.Fireball:Clone()
		Clone.Parent = workspace
		Clone.Position = player.Character.PrimaryPart.CFrame:PointToWorldSpace(Vector3.new(0, 0, -5))
        
		local BV = Instance.new("BodyVelocity", Clone)
		BV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		BV.P = math.huge
		BV.Velocity = CFrame.new(Clone.Position, pos).LookVector * self.SURVIVE
		local Deb = {}
		Clone.Touched:Connect(function(Hit)
			if Hit.Parent:FindFirstChild("Humanoid") then
				if
					not table.find(Deb, Hit.Parent.Humanoid)
					and Hit.Parent.Humanoid ~= player.Character:FindFirstChild("Humanoid")
				then
					table.insert(Deb, Hit.Parent.Humanoid)
					game.Debris:AddItem(Clone, 0.2)
                    RS.Events.Hit:Fire(player, Hit.Parent.Humanoid, self.DAMAGE)
				end
			end
		end)
		game.Debris:AddItem(Clone, self.SURVIVE)
		RS.Events.Deactivate:Fire(player, script.Name)
	end,
	deactivate = function(self: Move, Player: Player) end,
}
setmetatable(module, Moves)
export type Move = typeof(module)

return module
