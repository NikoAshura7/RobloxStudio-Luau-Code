local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local locked

-- Track when any prompt is triggered
ProximityPromptService.PromptTriggered:Connect(function(prompt, player)
	if prompt.Name == "RedDoorPrompt" or prompt.Name == "BlueDoorPrompt" then
		
		local checkLocked = prompt.Parent.Parent:FindFirstChild("Locked")
		if not checkLocked then
			locked = Instance.new("BoolValue")
			locked.Name = "Locked"
			locked.Value = true
			locked.Parent = prompt.Parent.Parent
		end

		local hinge = prompt.Parent.Parent.Doorframe.Hinge
		local goalOpen = {}
		goalOpen.CFrame = hinge.CFrame * CFrame.Angles(0, math.rad(90), 0)
		local goalClose = {}
		goalClose.CFrame = hinge.CFrame * CFrame.Angles(0, math.rad(-90), 0)
		local tweenInfo = TweenInfo.new(1)
		local tweenOpen = TweenService:Create(hinge, tweenInfo, goalOpen)
		local tweenClose = TweenService:Create(hinge, tweenInfo, goalClose)
		
		if not locked then
			if prompt.ActionText == "Close" then
				tweenClose:Play()
				prompt.ActionText = "Open"
			else
				tweenOpen:Play()
				prompt.ActionText = "Close"
			end
		else
			if player.Character:FindFirstChild("Key") then

				player.Character:FindFirstChild("Key"):Destroy()
				locked = false
				prompt.ActionText = "Open"
			end
		end
	end
end)