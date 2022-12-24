--TODO DO THIS
--FIXME
local MovesM = require(script.Parent)
local RS = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Info = TweenInfo.new(2, Enum.EasingStyle.Sine)

local v2 = {Size = Vector3.new(0.05, 7, 7)}
local v3 = {Size = Vector3.new(0.05,0.05,0.05)}

local module: Move = {
    
}

export type Move = typeof(module) & MovesM.Move

return module
-- game.Players.PlayerAdded:Connect(function(Player)
-- 	Player.Chatted:Connect(function(msg)
-- 		for i,v in pairs(game.Workspace.TeleportLocations:GetChildren()) do
-- 			if msg:lower() == v.Name then
-- 				local LoadAnim = Player.Character.Humanoid:LoadAnimation(script.SnapGate)
-- 				local TeleportPad = game.ReplicatedStorage.TeleportPad
-- 				local TPD = TeleportPad:Clone()
--  
-- 				Player.Character.Humanoid.WalkSpeed = 0
-- 				Player.Character.Humanoid.JumpPower = 0
--  
-- 				TPD.Position = Player.Character.HumanoidRootPart.Position + Vector3.new(0,-3,0)
-- 				TPD.Parent = workspace
-- 				LoadAnim:Play()
-- 				local Tweenv1 = TweenService:Create(TPD, Info, v2)
-- 				Tweenv1:Play()
--  
-- 				TPD.Touched:Connect(function(Hit)
-- 					if Hit.Parent:FindFirstChild("Humanoid") and Hit.Parent ~= Player.Character then
-- 						Hit.Parent.HumanoidRootPart.Position = v.Position
-- 					end
-- 				end)
--  
-- 				Tweenv1.Completed:Connect(function()
-- 					Player.Character.HumanoidRootPart.Position = v.Position
-- 					wait(1)
-- 					local Reversev1 = TweenService:Create(TPD, Info, v3):Play()
-- 					Player.Character.Humanoid.WalkSpeed = 16
-- 					Player.Character.Humanoid.JumpPower = 50
-- 					TPD:Destroy()
-- 				end)
-- 			end
-- 		end
-- 	end)
-- end)