local tweenService = game:GetService("TweenService")
local playerService = game:GetService("Players")

local remoteEvent = script.Parent:WaitForChild("button"):WaitForChild("RemoteEvent")

local Door = script.Parent:WaitForChild("Door"):WaitForChild("Hinge")
local hitbox = script.Parent:WaitForChild("Door"):WaitForChild("Hitbox")
local buttonScript = script.Parent:WaitForChild("button"):WaitForChild("DoorOpen")

local tweenInfo = TweenInfo.new(
	1,
	Enum.EasingStyle.Quad,
	Enum.EasingDirection.InOut,
	0,
	true
)

local DoorTween = tweenService:Create(Door, tweenInfo, {CFrame = Door.CFrame * CFrame.Angles(0,math.rad(90),0)})

local userIdList = {}
for i,userId in pairs(script.Parent:GetAttributes()) do
	table.insert(userIdList, userId)
end

function playerCheck(player)
	for i=1, #userIdList do
		if player.UserId == userIdList[i] then
			buttonScript.Enabled = true
		end
	end
end

for i, player in playerService:GetPlayers() do
	playerCheck(player)
end

playerService.PlayerAdded:Connect(playerCheck)

remoteEvent.OnServerEvent:Connect(function(player)
	for i=1, #userIdList do
		if player.UserId == userIdList[i] then
			if DoorTween.PlaybackState == Enum.PlaybackState.Begin or DoorTween.PlaybackState == Enum.PlaybackState.Completed then
				hitbox.CanCollide = false
				DoorTween:Play()
				wait(1)
				DoorTween:Pause()
				wait(1)
				DoorTween:Play()
				wait(1)
				hitbox.CanCollide = true
			end
		end
	end
end)
