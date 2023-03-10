local MovesM = require(script.Parent)
local RS = game:GetService("ReplicatedStorage")
local Delays = 2
local YSize = 11
local PILLARS = 8
local DAMAGE = 10

local Animation = Instance.new("Animation")
Animation.AnimationId = "rbxassetid://6069690501"

local module: MovesM.Move = {
	COOLDOWN = 2,
	activate = function(self: MovesM.Move, player: Player)
		if not player.Character then
			return
		end
		--Animations
		local Character = player.Character
		local PrimaryPartCFrame = RS.Functions.getCharPrimaryPartPos:InvokeClient(player)
		local Animator = Character.Humanoid:FindFirstChildOfClass("Animator")
		local charAnimation = Animator:LoadAnimation(Animation)
		charAnimation:Play()
		task.wait(1 / 6)
		--Number of pillars
		for i = 1, PILLARS do
			--Raycast Result
			local RaycastR
			--Checks to see if there's a humanoid in the way
			local function Check(Param, Exclude)
				if i % 2 == 0 then
					RaycastR = workspace:Raycast(
						(PrimaryPartCFrame * CFrame.new(3, 0, -i * 3.6)).Position,
						Vector3.new(0, -180, 0) * 100,
						Param
					)
				else
					RaycastR = workspace:Raycast(
						(PrimaryPartCFrame * CFrame.new(-3, 0, -i * 3.6)).Position,
						Vector3.new(0, -180, 0) * 100,
						Param
					)
				end

				local Insta = RaycastR.Instance
				if Insta.Parent and Insta.Parent:FindFirstChild("Humanoid") then
					table.insert(Exclude, Insta.Parent)
					Param.FilterDescendantsInstances = Exclude
					Check(Param, Exclude)
				end
			end
			--Ray Cast Parameters
			local RayCastPa = RaycastParams.new()
			RayCastPa.FilterType = Enum.RaycastFilterType.Blacklist
			Check(RayCastPa, {})

			if not RaycastR then
				continue
			end

			local Hits = {}
			--Properties of Pillar
			local Pillar = RS.MoveStuff.Pillar:Clone()
			Pillar.Material = RaycastR.Material
			-- Pillar.Size = Pillar.Size + Vector3.new(0, 0, 1)
			Pillar.Parent = workspace
			Pillar.Position = RaycastR.Position + Vector3.new(0, Pillar.Size.Y / 2, 0)
			--Builds Pillars up
			game.TweenService
				:Create(Pillar, TweenInfo.new(0.2), {
					Position = Pillar.Position + Vector3.new(0, YSize / 2, 0),
					Size = Pillar.Size + Vector3.new(0, YSize, 0),
				})
				:Play()
			--Damages Humanoids that touch it
			task.delay(0.2, function()
				for _, part in pairs(Pillar:GetTouchingParts()) do
					if not part or not part.Parent or not part.Parent:FindFirstChild("Humanoid") then
						return
					end
					if part:IsDescendantOf(Character) then
						return
					end
					if table.find(Hits, part.Parent.Humanoid) then
						return
					end
					table.insert(Hits, part.Parent.Humanoid)
					RS.Events.Hit:Fire(player, part.Parent.Humanoid, DAMAGE)
				end
			end)
			--Retracts Pillars
			task.delay(0.8, function()
				game.TweenService
					:Create(Pillar, TweenInfo.new(0.2), {
						Position = Pillar.Position + Vector3.new(0, -YSize / 2, 0),
						Size = Pillar.Size * Vector3.new(1, 0, 1),
					})
					:Play()
			end)
			--Removes Pillar after 1 sec
			game.Debris:AddItem(Pillar, 1)
			--Damages other Humanoids who touch it
			Pillar.Touched:Connect(function(Hit)
				if not Hit or not Hit.Parent or not Hit.Parent:FindFirstChild("Humanoid") then
					return
				end
				if Hit:IsDescendantOf(Character) then
					return
				end
				if table.find(Hits, Hit.Parent.Humanoid) then
					return
				end
				table.insert(Hits, Hit.Parent.Humanoid)
				RS.Events.Hit:Fire(player, Hit.Parent.Humanoid, DAMAGE)
			end)
			task.wait(0.1)
		end
		task.wait(2)
		RS.Events.Deactivate:Fire(player, script.Name)
	end,
}

setmetatable(module, MovesM)
return module
