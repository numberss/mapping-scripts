local lanternFolder = script.Parent:WaitForChild("SpawnedLanterns")
local lantern = script.Parent:WaitForChild("Lantern")
local spawners = script.Parent:WaitForChild("Spawners"):GetChildren()

local lifetime = 20
local accum = 0

local function spawnLantern(lantern : MeshPart, spawner : BasePart)
	local x1 = spawner.Position.X + spawner.Size.X / 2
	local x0 = x1 - spawner.Size.X
	local z1 = spawner.Position.Z + spawner.Size.Z / 2
	local z0 = z1 - spawner.Size.Z
	local y0 = spawner.Position.Y
	local y1 = y0 + 100

	local x = math.random(x0, x1)
	local z = math.random(z0, z1)
	local y = math.random(y0, y1)
	lantern.CFrame = CFrame.new(Vector3.new(x, y, z)) * CFrame.Angles(0, math.random(0,360), 0)
	
	lantern:SetAttribute("x", x)
	lantern:SetAttribute("z", z)
	lantern:SetAttribute("SpawnedTime", tick() + (math.random(5,50)/10))
end

task.wait(1)

local lanternTable = {}
for i=1, 500 do
	local clone = lantern:Clone()
	spawnLantern(clone, spawners[math.random(1, #spawners)])
	clone.Parent = lanternFolder
	lanternTable[i] = clone
end

game:GetService("RunService").Heartbeat:Connect(function(dt)
	accum += dt
	if accum >= 1/30 then
		accum = 0
		for _,lantern in lanternTable do	
			local spawnedTime = lantern:GetAttribute("SpawnedTime")
			local sin = math.sin(math.pi * 6 * ((tick() - spawnedTime) / lifetime)) * 2
			lantern.CFrame = CFrame.new(lantern:GetAttribute("x") + sin, lantern.Position.Y + math.random(2,5)/100, lantern:GetAttribute("z"))
			
			if tick() - spawnedTime > lifetime then
				spawnLantern(lantern, spawners[math.random(1, #spawners)])
				lanternTable[lantern] = tick()
			end
		end
	end
end)
