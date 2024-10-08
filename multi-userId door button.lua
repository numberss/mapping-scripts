local part = script.Parent
local camera = workspace.CurrentCamera
local remoteEvent = script.Parent:WaitForChild("RemoteEvent")

if game:GetService("Players").LocalPlayer.UserId ~= script.Parent.Parent:GetAttribute("UserID") then
	script.Enabled = false
end

local function onStep(player)
	local distance = (part.Position - camera.CFrame.Position).Magnitude
	
	if distance <= part.Size.X / 2 then
		remoteEvent:FireServer()
	end
end

game:GetService("RunService").RenderStepped:Connect(onStep)
