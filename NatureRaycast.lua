local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = {workspace:WaitForChild("surf_gnome"):WaitForChild("Terrain")}

------======== TREES ========-------

local function spawnTrees(area:BasePart)
	local treeFolder : Folder = workspace:WaitForChild("main"):WaitForChild("Deco"):WaitForChild("Trees")
	local treeModels : Model = treeFolder:WaitForChild("BaseModels"):GetChildren()
	local treeNum = #treeModels
	
	local x1 = area.Position.X + (area.Size.X / 2)
	local x2 = area.Position.X - (area.Size.X / 2)
	local z1 = area.Position.Z + (area.Size.Z / 2)
	local z2 = area.Position.Z - (area.Size.Z / 2)
	local y = area.Position.Y + area.Size.Y
	
	repeat
		local ray : RaycastResult = workspace:Raycast(Vector3.new(x1 + math.random(-20,20), y, z1 + math.random(-20,20)), Vector3.new(0,-1000,0), params)
		if ray and ray.Instance.Name == area.Name then
			local randChild = math.round(1 + math.sqrt(-math.random(1,16)+16))
			local tree = treeModels[randChild]:Clone()
			tree.Parent = treeFolder:WaitForChild("SpawnedTrees")
			
			tree:ScaleTo(tree:GetScale() + (math.random(5,15)/10))
			tree:PivotTo(CFrame.new(ray.Position, ray.Position + ray.Normal - Vector3.new(0,1,0)) * CFrame.new(0,-5,0)) --* CFrame.Angles(math.rad(-90), 0, 0))
		end
		
		x1 -= math.random(40,80)
		if x1 <= x2 then
			x1 = area.Position.X + (area.Size.X / 2)
			z1 -= math.random(40,80)
		end
	until z1 <= z2
end


-------========	MUSHROOMS ==========--------

local groupParams = RaycastParams.new()
groupParams.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = {workspace:WaitForChild("surf_gnome"):WaitForChild("Terrain"), workspace:WaitForChild("main"):WaitForChild("Deco"):WaitForChild("Plants")}

local function spawnMushrooms(area:BasePart)
	local mushroomFolder = workspace:WaitForChild("main"):WaitForChild("Deco"):WaitForChild("Plants")
	local mushrooms = mushroomFolder:WaitForChild("Mushrooms"):GetChildren()

	local redMushrooms = mushroomFolder:WaitForChild("Mushrooms"):WaitForChild("RedMushrooms"):GetChildren()
	local brownMushrooms = mushroomFolder:WaitForChild("Mushrooms"):WaitForChild("BrownMushrooms"):GetChildren()

	local x1 = area.Position.X + (area.Size.X / 2)
	local x2 = area.Position.X - (area.Size.X / 2)
	local z1 = area.Position.Z + (area.Size.Z / 2)
	local z2 = area.Position.Z - (area.Size.Z / 2)
	local y = area.Position.Y + area.Size.Y

	repeat
		local ray : RaycastResult = workspace:Raycast(Vector3.new(x1 + math.random(-20,20), y, z1 + math.random(-20,20)), Vector3.new(0,-1000,0), params)
		if ray and ray.Instance.Name == area.Name then
			local colour = mushrooms[math.random(1,2)]
			local mushroom : BasePart = colour:GetChildren()[math.random(1, #colour:GetChildren())]:Clone()
			mushroom.Parent = mushroomFolder:WaitForChild("SpawnedMushrooms")
			
			local randomSize = math.random(-2,2) -- generated here to keep x and z consistent to prevent stretching 
			mushroom.Size += mushroom.Size + Vector3.new(randomSize, math.random(-2,2), randomSize)
			mushroom:PivotTo(CFrame.new(ray.Position - Vector3.new(3,0,0), ray.Position + ray.Normal - (Vector3.new(0,1,0))) * CFrame.new(0,mushroom.Size.Y/3,0) * CFrame.Angles(0,math.rad(math.random(0,180)),0))
			
			
			if math.random(1,10) == 1 then
				local mushroomModel = Instance.new("Model", mushroom.Parent)
				mushroomModel.Name = "RedMushroomGroup"
				mushroom.Parent = mushroomModel
				
				local mushroomGroup = redMushrooms
				if string.match(mushroom.Name, "Brown") then
					mushroomGroup = brownMushrooms
					mushroomModel.Name = "BrownMushroomGroup"
				end
				
				for n=1, math.random(5,10) do
					local groupRay = workspace:Raycast(Vector3.new(ray.Position.X + math.random(-25,25), y, ray.Position.Z + math.random(-25,25)), Vector3.new(0,-1000,0), params)
					if groupRay and not groupRay.Instance.Name:match("Mushroom") then
						local groupMushroom : BasePart = mushroomGroup[math.random(1,#mushroomGroup)]:Clone()
						groupMushroom.Parent = mushroomModel
						
						groupMushroom.Size += groupMushroom.Size + Vector3.new(randomSize, math.random(-2,2), randomSize)
						groupMushroom:PivotTo(CFrame.new(groupRay.Position - Vector3.new(3,0,0), groupRay.Position + groupRay.Normal - (Vector3.new(0,1,0))) * CFrame.new(0,groupMushroom.Size.Y/3,0) * CFrame.Angles(0,math.rad(math.random(0,180)),0))
					end
				end
			end
		end
			
		x1 -= math.random(40,80)
		if x1 <= x2 then
			x1 = area.Position.X + (area.Size.X / 2)
			z1 -= math.random(40,80)
		end
	until z1 <= z2
end


-------======= PLANTS =======--------

local function spawnPlants(area:BasePart)
	local plantsFolder = workspace:WaitForChild("main"):WaitForChild("Deco"):WaitForChild("Plants")
	local plants = plantsFolder:WaitForChild("BasePlants"):GetChildren()
	
	local x1 = area.Position.X + (area.Size.X / 2)
	local x2 = area.Position.X - (area.Size.X / 2)
	local z1 = area.Position.Z + (area.Size.Z / 2)
	local z2 = area.Position.Z - (area.Size.Z / 2)
	local y = area.Position.Y + area.Size.Y

	repeat
		local ray : RaycastResult = workspace:Raycast(Vector3.new(x1 + math.random(-20,20), y, z1 + math.random(-20,20)), Vector3.new(0,-1000,0), params)
		if ray and ray.Instance.Name == area.Name then
			local plant : BasePart = plants[math.random(1,#plants)]:Clone()
			plant.Parent = plantsFolder:WaitForChild("SpawnedPlants")

			-- i am sorry for hardcoding this i just couldnt get their different cframes to orient correctly i am dumb sorry
			if plant.Name == "Vines" then
				plant.CFrame = CFrame.new(ray.Position, ray.Normal + ray.Position) * CFrame.Angles(0, math.rad(90), 0)
			end
			if plant.Name == "Bush" then
				plant.CFrame = CFrame.new(ray.Position, ray.Normal + ray.Position) * CFrame.Angles(math.rad(-180), 0, 0)
			end
			if plant.Name == "LeafPile" then
				plant.CFrame = CFrame.new(ray.Position, ray.Normal + ray.Position) * CFrame.Angles(math.rad(-90), 0, 0)
				plant.Position -= Vector3.new(0, 10, 0)
			end
		end

		x1 -= math.random(40,80)
		if x1 <= x2 then
			x1 = area.Position.X + (area.Size.X / 2)
			z1 -= math.random(40,80)
		end
	until z1 <= z2
end
