local part = script.Parent -- put the script in a part above the whole area you want to change the lighting in
local camera = workspace.CurrentCamera
local lighting = game:GetService("Lighting")

local originalLighting = Instance.new("Folder", script)

-- stuff you want to change
local sky = script:WaitForChild("Sky")
local atmosphere = script:WaitForChild("Atmosphere")
local colorCorrection = script:WaitForChild("ColorCorrection")

-- the parts area
local x0 = part.Position.X - (part.Size.X / 2)
local x1 = part.Position.X + (part.Size.X / 2)
local z0 = part.Position.Z - (part.Size.Z / 2)
local z1 = part.Position.Z + (part.Size.Z / 2)

local changed = false -- db so that it only changes everything once am i good at optimising yet
game:GetService("RunService").RenderStepped:Connect(function(player)
	local x = camera.CFrame.Position.X
	local z = camera.CFrame.Position.Z

	if (x >= x0 and x <= x1) and (z >= z0 and z <= z1) then
		if not changed then
			for _,i in pairs(lighting:GetChildren()) do
				i.Parent = originalLighting
			end
			sky.Parent = lighting
			atmosphere.Parent = lighting
			colorCorrection.Parent = lighting
			changed = true
		end
	else
		if changed then
			for _,i in pairs(lighting:GetChildren()) do
				i.Parent = script
			end
			for _,i in pairs(originalLighting:GetChildren()) do
				i.Parent = lighting
			end
			changed = false
		end
	end
end)
