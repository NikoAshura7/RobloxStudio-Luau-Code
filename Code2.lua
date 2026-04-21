local ProximityPromptService = game:GetService("ProximityPromptService")
local tweenService = game:GetService("TweenService")
local TweenInfo = TweenInfo.new(1)

local texts = {
	["1"] = "First one",
	["2"] = "Second one",
	["3"] = "Third one",
	["4"] = "Fourth one",
	["5"] = "Fifth one"
}
local startGoal = {}
startGoal.Size = UDim2.new(0, 0, 0, 0)
local endGoal = {}
endGoal.Size = UDim2.new(0, 200, 0, 200)




function showText(prompt)
	
	local gui = prompt.parent:FindFirstChild("BillboardGui")
	local id = prompt.parent.Name
	local tweenOpen = tweenService:Create(gui, TweenInfo, endGoal)
	local tweenClose = tweenService:Create(gui, TweenInfo, startGoal)
	tweenOpen:Play()
	
	prompt.Enabled = false
	gui.TextLabel.Text = texts[id]
	task.wait(1)
	tweenClose:Play()
	prompt.Enabled = true
end

-- Track when any prompt is triggered
ProximityPromptService.PromptTriggered:Connect(function(prompt, player)
	if prompt.Name == "PhonePrompt" then
		showText(prompt)
	end
end)