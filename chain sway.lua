wait(1)
local clone = script.Parent:WaitForChild("Model"):Clone()
clone.Parent = script.Parent
clone.Name = "Chains"
--clone.Parent = workspace
script.Parent.Model:Destroy()

for _,i in pairs(clone:GetChildren()) do
	i.CanCollide = true
	i.Anchored = false
end

function biasRandom(min, max, bias, influence) 
	local rnd = math.random() * (max - min) + min
	local mix = math.random() * influence
	return rnd * (1 - mix) + bias * mix
end

local vectorForce

for x,v in pairs(clone:GetDescendants()) do
	if v:IsA("VectorForce") then
		vectorForce = v
	end
end

while true do
	vectorForce.Force = Vector3.new(biasRandom(0,1500,250,0.8),0,0)
	wait(3)
end
