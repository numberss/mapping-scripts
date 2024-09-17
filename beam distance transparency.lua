local RunService = game:GetService("RunService")
local camera = workspace.CurrentCamera

local minDist = 30 -- how close the player should be until it is fully visible
local maxDist = 100 -- how close the player should be until it is fully invisible

local minTransparency = 0
local maxTransparency = 1

RunService.RenderStepped:Connect(function()
	for _,part in pairs(script.Parent:GetDescendants()) do
		if not part:IsA("Beam") then continue end -- if its not a beam then the iteration ends
		--takes the lowest distance to one of the two beam attachments
		local distance = math.min((part.Attachment0.WorldPosition - camera.CFrame.Position).Magnitude, (part.Attachment1.WorldPosition - camera.CFrame.Position).Magnitude)

		if distance < minDist then
			part.Transparency = NumberSequence.new(minTransparency)
		elseif distance > maxDist then
			part.Transparency = NumberSequence.new(maxTransparency)
		else
			-- takes the highest between the distance and the min transparency value so that you never go below the min transparency
			part.Transparency = NumberSequence.new(math.max((distance - minDist) / (maxDist - minDist), minTransparency))
		end
	end
	
end)
