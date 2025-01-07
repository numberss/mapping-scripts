local tweenService = game:GetService("TweenService")
local info = TweenInfo.new(2, Enum.EasingStyle.Circular, Enum.EasingDirection.Out)

local firstPart = script.Parent:WaitForChild("Part")
local startPos = firstPart.Position
local pos = startPos
local step = 5
local steps = 10

local parts = {}

for i=1, steps do
	local newPos = pos + Vector3.new(0,0,step)
	
	local clone = firstPart:Clone()
	clone.BrickColor = BrickColor.new("Cyan")
	parts[i] = clone
	clone.Parent = workspace
	clone.Position = newPos
	Instance.new("Attachment", clone)
	pos = newPos
	
	if i == 1 then continue end
	local beam = Instance.new("Beam", clone)
	beam.Attachment0 = clone.Attachment
	beam.Attachment1 = parts[i-1].Attachment
	beam.Width0 = 20
	beam.Width1 = 20
	beam.Color = ColorSequence.new(Color3.fromRGB(255, 150, 255))
	beam.Transparency = NumberSequence.new(0)
end

local accum = 0
local db = 0
game:GetService("RunService").Heartbeat:Connect(function(dt)
	accum += dt
	db += dt
	if db >= 3 then
		for _,part in pairs(parts) do
			local offset = math.random(0,75)/10 - 2.5
			tweenService:Create(part, info, {Position = Vector3.new(part.Position.X, startPos.Y + offset, part.Position.Z)}):Play()
		end
		db = 0
	end
end)
