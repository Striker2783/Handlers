local RS = game:GetService("ReplicatedStorage")
local Moves = require(script.Parent)
local SPEED = 100
local DAMAGE = 10
local SURVIVE = 5
local module: Moves.Move = {
	COOLDOWN = 8,
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
		BV.Velocity = CFrame.new(Clone.Position, pos).LookVector * SPEED
		local Deb = {}
		Clone.Touched:Connect(function(Hit)
			if Hit.Parent:FindFirstChild("Humanoid") then
				if
					not table.find(Deb, Hit.Parent.Humanoid)
					and Hit.Parent.Humanoid ~= player.Character:FindFirstChild("Humanoid")
				then
					table.insert(Deb, Hit.Parent.Humanoid)
					game.Debris:AddItem(Clone, 0.2)
					RS.Events.Hit:Fire(player, Hit.Parent.Humanoid, DAMAGE)
				end
			end
		end)
		game.Debris:AddItem(Clone, SURVIVE)
		RS.Events.Deactivate:Fire(player, script.Name)
	end,
}
setmetatable(module, Moves)
export type Move = typeof(module)

return module
