--[[ LightingChange by RedAce (thanks quat)
							INSTRUCTIONS
				
Put a part entirely covering the area you want changed with a part in the Areas folder
Create a new array in the same name as the part, and put in your new lighting values. Make sure to follow the same format as the arrays shown
If you have lighting effects, make a folder with the same name as the part and put in your lighting effects, including those that arent changing

Make sure your default lighting is set up in the Default folder and array. Do not delete the default folder and array.

You can have as many parts as you want as long as they are named correctly, and as many areas as you want as long as they are set up correctly.
There is a max range of 1000 units. Any parts more than 1000 units above the player wont be caught and so the lighting will not change if that happens.

]]

local ChangedValues = {
	["Default"] = {
		["Ambient"] = Color3.fromRGB(70, 70, 70),
		["Brightness"] = 2,
		["OutdoorAmbient"] = Color3.fromRGB(70, 70, 70),
		["ClockTime"] = 14.5,
		["GeographicLatitude"] = 0,
		["ExposureCompensation"] = 0
	},
	
	["Pink"] = {
		["Ambient"] = Color3.fromRGB(55, 44, 138),
		["Brightness"] = 0.5,
		["OutdoorAmbient"] = Color3.fromRGB(77, 81, 107),
		["ClockTime"] = 8,
		["ExposureCompensation"] = -0.5
	},
	
	["Green"] = {
		["Ambient"] = Color3.fromRGB(138, 138, 138),
		["Brightness"] = 2,
		["OutdoorAmbient"] = Color3.fromRGB(107, 39, 106),
		["ClockTime"] = 16,
		["ExposureCompensation"] = 0
	},
	
	["NoEffects"] = {
		["Ambient"] = Color3.fromRGB(138, 75, 76),
		["Brightness"] = 1,
		["OutdoorAmbient"] = Color3.fromRGB(107, 70, 95),
		["ClockTime"] = 12,
		["ExposureCompensation"] = 0
	}
}

local lighting = game:GetService("Lighting")
local camera = workspace.CurrentCamera

local DefaultLighting = script:WaitForChild'Default'
local currentLighting = DefaultLighting -- starts on default lighting

local params = RaycastParams.new()
params.FilterType = Enum.RaycastFilterType.Include
params.FilterDescendantsInstances = {script}

game:GetService("RunService").Heartbeat:Connect(function()
	local parts = workspace:GetPartBoundsInRadius(camera.CFrame.Position, 1, params)

	local newLighting = DefaultLighting
	for _, part in parts do
		newLighting = part
		break
	end

	if currentLighting ~= newLighting then
		if currentLighting and newLighting then -- makes sure it exists and there are new effects to change to
			for _,effect in lighting:GetChildren() do -- moves the effects FROM lighting TO their folder
				effect.Parent = currentLighting
			end

			for _,effect in newLighting:GetChildren() do -- moves the effects FROM their folder TO lighting
				effect.Parent = lighting
			end
		end

		for property,value in ChangedValues[newLighting] do -- changes the lighting properties
			lighting[property] = value
		end
		currentLighting = newLighting
	end
end)
