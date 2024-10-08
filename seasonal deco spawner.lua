local Seasons = {"Spring", "Summer", "Autumn", "Winter"}
local Events = {["StPatrick"] = "Mar 17",
	["Valentines"] = "Feb 14",
	["July4th"] = "Jul 4",
	["Thanksgiving"] = "Nov 28",
	["RememberanceDay"] = "Nov 11",
	["Easter"] = "Apr 20",
	["Christmas"] = "Dec 25",
	["NewYearEve"] = "Dec 31",
	["NewYearDay"] = "Jan 1",
	["LunarNewYear"] = "Jan 29",
	["Haloween"] = "Oct 31"}


function spawner(season, event)
	local PartStorage = script.Parent.PartStorage
	local objects = {}
	-- gets all the objects in the season folder. can have more than just trees and rocks but you need to put its respective Marker part around the place
	-- i dont even know why i made it so modular its really only going to be trees and rocks in the future
	-- (i guess flowers maybe but i think ill put them in the Rock folder) oh wait a field of poppys for rememberance day would be cool
	-- also the names of the models in the folder must match the name of the marker part in the markers folder
	for x,v in pairs(PartStorage:FindFirstChild(season):GetChildren()) do
		table.insert(objects, v.Name)
	end
	
	for _,i in pairs(script.Parent.Markers:GetDescendants()) do
		for m,n in pairs(objects) do
			local Models = PartStorage:FindFirstChild(season):FindFirstChild(n):GetChildren()
			-- defaults to models being under the season folder
			-- if there is an event folder it will override the models in the season folder
			if PartStorage:FindFirstChild(event) then
				if PartStorage:FindFirstChild(event):FindFirstChild(n) then
					Models = PartStorage:FindFirstChild(event):FindFirstChild(n):GetChildren()
				end
			end
			-- creates a clone of the model and moves it to its respective Markers. some random size and rotation so it doesnt look bad
			if n.."Marker" == i.Name and i:IsA("BasePart") then
				local objectClone = Models[math.random(1,#Models)]:Clone()
				objectClone.Parent = PartStorage
				objectClone:ScaleTo(math.random(800,1300)/1000)
				objectClone:SetPrimaryPartCFrame(i.CFrame * CFrame.Angles(math.rad(math.random(-5,5)),math.rad(math.random(-180,180)),math.rad(math.random(-5,5))))
				local parts = objectClone:GetDescendants()
				-- thinking about whether or not they should have collision. for now they dont
				for x,v in pairs(objectClone:GetDescendants()) do
					if v:IsA("MeshPart") or v:IsA("BasePart") then
						v.Transparency = 0
						v.CanCollide = false
					end
				end
				objectClone.PrimaryPart:Destroy() -- saving fps 1 part at a time
				i:Destroy()
			end
		end
	end
end

-- i dont know how to get a numerical value for the month without this sorry
local months = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"}
local currentSeason = "Summer" -- default
local currentEvent = "None" -- default

-- splits os.date() into an array value at every space. follows dotw/mm/dd/time/year
local month = os.date():split(" ")[2]
local day = tonumber(os.date():split(" ")[3])
local date = month.." "..day

-- rounds up the months into the general season (not accurate but thats ok its for the vibe)
for i in months do
	if months[i] == month then
		if i <= 2 or i == 12 then
			currentSeason = "Winter"
		elseif i >= 9 and i <= 11 then
			currentSeason = "Autumn"
		elseif i >= 6 and i <= 8 then
			currentSeason = "Summer"
		else
			currentSeason = "Spring"
		end
	end
end
for e in Events do
	if date == Events[e] then
		currentEvent = e
	end
end

-- even if no event is going on "None" isnt a folder that exists so it will only use the season's folder
spawner(currentSeason,currentEvent)
