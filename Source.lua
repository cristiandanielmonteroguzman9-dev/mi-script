local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local ActivationKey = Enum.KeyCode.Z
local cooldown = false

-- UI
local gui = Instance.new("ScreenGui")
gui.Name = "SanguineUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Name = "ZButton"
button.Size = UDim2.new(0, 80, 0, 80)
button.Position = UDim2.new(1, -100, 1, -120)
button.AnchorPoint = Vector2.new(0, 0)
button.BackgroundColor3 = Color3.fromRGB(140, 0, 255)
button.Text = "Z"
button.TextScaled = true
button.TextColor3 = Color3.new(1, 1, 1)
button.BorderSizePixel = 0
button.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = button

local function Dash()
	if cooldown then
		return
	end

	local character = player.Character
	if not character then
		return
	end

	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end

	cooldown = true

	local targetPos = mouse.Hit.Position
	local direction = (targetPos - hrp.Position).Unit

	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
	bodyVelocity.Velocity = direction * 180
	bodyVelocity.Parent = hrp

	task.wait(0.25)
	bodyVelocity:Destroy()

	task.wait(1)
	cooldown = false
end

button.MouseButton1Click:Connect(Dash)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then
		return
	end

	if input.KeyCode == ActivationKey then
		Dash()
	end
end)
