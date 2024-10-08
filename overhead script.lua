local character = game:GetService("Players").LocalPlayer.Character

local playerParts = {}
for _,i in pairs(character:GetDescendants()) do
	if i:IsA("BasePart") and i.Name ~= "HumanoidRootPart" then
		table.insert(playerParts,i)
	elseif i.Name == "Humanoid" then
		i.NameDisplayDistance = 0
	end
end

local camera = workspace.CurrentCamera
local start = script.Parent.Parent:WaitForChild("Start"):WaitForChild("StartSphere")
local startPos = start.Position
local offset = 0
local height = 30

local heightButtons = script:WaitForChild("Part"):WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("Frame"):GetChildren()

local cameraToggleButton = script:WaitForChild("cameraToggle"):WaitForChild("SurfaceGui"):WaitForChild("Frame"):WaitForChild("TextButton")
local cameraOn = true

cameraToggleButton.Activated:Connect(function()
	if cameraOn == false then
		cameraOn = true	
	else
		cameraOn = false
	end
end)

local function onStep(dt)
	local cameraPos = camera.CFrame.Position
	local rx,ry,rz = camera.CFrame:ToEulerAnglesYXZ()
	local playerPos = character:WaitForChild("HumanoidRootPart").Position

	for _,i in pairs(heightButtons) do
		i.Activated:Connect(function()
			height = tonumber(i.Text)
		end)
	end
	
	-- distance is a spherical radius, set part to a ball to see the area it will activate
	local startDistance = math.sqrt((startPos.X - cameraPos.X)^2 + (startPos.Y - cameraPos.Y)^2 + (startPos.Z - cameraPos.Z)^2)

	if cameraOn then
		if startDistance <= start.Size.X / 2 then
			for x,v in pairs(playerParts) do
				v.Transparency = 1
			end
			offset = 0
			
		else
			if offset >= height then
				camera.CFrame = CFrame.new(playerPos.X, playerPos.Y + height, playerPos.Z) * CFrame.Angles(math.rad(-90),0,ry)
			else
				offset += height * math.sin(dt/2)
				camera.CFrame = CFrame.new(playerPos.X, playerPos.Y + offset, playerPos.Z) * CFrame.Angles(math.rad(-90),0,ry)
			end
			
			for x,v in pairs(playerParts) do
				v.Transparency = 0
			end
		end
	end
end

game:GetService("RunService").RenderStepped:Connect(onStep)
