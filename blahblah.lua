-- Combined Loader + Pet Spawner GUI
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Destroy existing GUIs (optional cleanup)
if playerGui:FindFirstChild("LoadingScriptGUI") then playerGui.LoadingScriptGUI:Destroy() end
if playerGui:FindFirstChild("Spawner") then playerGui.Spawner:Destroy() end

-- Loader GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScriptGUI"
gui.Parent = playerGui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 150)
frame.Position = UDim2.new(0.5, -200, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", frame)
title.Text = "Loading script!"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local progressBarBG = Instance.new("Frame", frame)
progressBarBG.Size = UDim2.new(0.8, 0, 0.15, 0)
progressBarBG.Position = UDim2.new(0.1, 0, 0.7, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 6)

local progressBar = Instance.new("Frame", progressBarBG)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 6)

local percentageLabel = Instance.new("TextLabel", frame)
percentageLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
percentageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
percentageLabel.Size = UDim2.new(0, 100, 0, 30)
percentageLabel.BackgroundTransparency = 1
percentageLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
percentageLabel.Font = Enum.Font.GothamBold
percentageLabel.TextScaled = true
percentageLabel.Text = "1%"

local runButton = Instance.new("TextButton", progressBarBG)
runButton.Size = UDim2.new(1, 0, 1, 0)
runButton.Position = UDim2.new(0, 0, 0, 0)
runButton.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
runButton.TextColor3 = Color3.fromRGB(0, 0, 0)
runButton.Font = Enum.Font.GothamBold
runButton.TextScaled = true
runButton.Text = "Run Script"
runButton.Visible = false
Instance.new("UICorner", runButton).CornerRadius = UDim.new(0, 6)

-- Animate loading bar
task.spawn(function()
	for i = 1, 100 do
		progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
		percentageLabel.Text = i .. "%"
		task.wait(0.03)
	end
	runButton.Visible = true
end)

-- On button click: remove loader, open pet spawner
runButton.MouseButton1Click:Connect(function()
	gui:Destroy()

	-- PET SPAWNER GUI CODE BELOW
	local Spawner = Instance.new("ScreenGui", playerGui)
	Spawner.Name = "Spawner"
	Spawner.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local Main = Instance.new("Frame", Spawner)
	Main.Name = "Main"
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 446, 0, 260)
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)

	local T = Instance.new("TextLabel", Main)
	T.Text = "Pet Spawner"
	T.Size = UDim2.new(0, 406, 0, 46)
	T.Position = UDim2.new(0.5, 0, 0.088, 0)
	T.AnchorPoint = Vector2.new(0.5, 0.5)
	T.BackgroundTransparency = 1
	T.TextColor3 = Color3.new(1, 1, 1)
	T.Font = Enum.Font.GothamBold
	T.TextScaled = true

	local petType = "NFR"
	local function makeButton(name, pos, onClick)
		local btn = Instance.new("TextButton", Main)
		btn.Name = name
		btn.Text = name
		btn.Size = UDim2.new(0, 89, 0, 50)
		btn.Position = pos
		btn.AnchorPoint = Vector2.new(0.5, 0.5)
		btn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
		btn.TextColor3 = name == "NFR" and Color3.fromRGB(25, 255, 21) or Color3.fromRGB(255, 255, 255)
		btn.Font = Enum.Font.GothamBold
		btn.TextScaled = true
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
		btn.MouseButton1Click:Connect(onClick)
		return btn
	end

	local FR, NFR, MFR
	FR = makeButton("FR", UDim2.new(0.2, 0, 0.35, 0), function()
		petType = "FR"
		FR.TextColor3 = Color3.fromRGB(25, 255, 21)
		NFR.TextColor3, MFR.TextColor3 = Color3.new(1,1,1), Color3.new(1,1,1)
	end)
	NFR = makeButton("NFR", UDim2.new(0.5, 0, 0.35, 0), function()
		petType = "NFR"
		NFR.TextColor3 = Color3.fromRGB(25, 255, 21)
		FR.TextColor3, MFR.TextColor3 = Color3.new(1,1,1), Color3.new(1,1,1)
	end)
	MFR = makeButton("MFR", UDim2.new(0.8, 0, 0.35, 0), function()
		petType = "MFR"
		MFR.TextColor3 = Color3.fromRGB(25, 255, 21)
		FR.TextColor3, NFR.TextColor3 = Color3.new(1,1,1), Color3.new(1,1,1)
	end)

	local NameBox = Instance.new("TextBox", Main)
	NameBox.Size = UDim2.new(0, 354, 0, 45)
	NameBox.Position = UDim2.new(0.5, 0, 0.6, 0)
	NameBox.AnchorPoint = Vector2.new(0.5, 0.5)
	NameBox.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
	NameBox.PlaceholderText = "Enter Pet Name Here"
	NameBox.Text = ""
	NameBox.TextColor3 = Color3.new(1,1,1)
	NameBox.Font = Enum.Font.GothamBold
	NameBox.TextScaled = true
	Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 6)

	local Spawn = Instance.new("TextButton", Main)
	Spawn.Text = "Spawn"
	Spawn.Size = UDim2.new(0, 176, 0, 41)
	Spawn.Position = UDim2.new(0.5, 0, 0.82, 0)
	Spawn.AnchorPoint = Vector2.new(0.5, 0.5)
	Spawn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
	Spawn.TextColor3 = Color3.new(1, 1, 1)
	Spawn.Font = Enum.Font.GothamBold
	Spawn.TextScaled = true
	Instance.new("UICorner", Spawn).CornerRadius = UDim.new(0, 6)

	-- Spawner logic
	local function duplicatePet(petName)
		local Loads = require(game.ReplicatedStorage.Fsys).load
		local ClientData = Loads("ClientData")
		local InventoryDB = Loads("InventoryDB")
		local Inventory = ClientData.get("inventory")

		local function generate_prop()
			return {
				flyable = true,
				rideable = true,
				neon = petType == "NFR" or petType == "MFR",
				mega_neon = petType == "MFR",
				age = 1
			}
		end

		local function cloneTable(original)
			local copy = {}
			for k, v in pairs(original) do
				copy[k] = type(v) == "table" and cloneTable(v) or v
			end
			return copy
		end

		for cat, catTbl in pairs(InventoryDB) do
			for id, item in pairs(catTbl) do
				if cat == "pets" and item.name == petName then
					local uuid = HttpService:GenerateGUID()
					local n_item = cloneTable(item)
					n_item["unique"] = "uuid_" .. uuid
					n_item["category"] = "pets"
					n_item["properties"] = generate_prop()
					n_item["newness_order"] = math.random(1, 999999)
					Inventory[cat] = Inventory[cat] or {}
					Inventory[cat][uuid] = n_item
					return
				end
			end
		end
	end

	Spawn.MouseButton1Click:Connect(function()
		duplicatePet(NameBox.Text)
	end)

	-- Make GUI draggable
	local UIS = game:GetService("UserInputService")
	local dragToggle, dragStart, startPos
	Main.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragToggle = true
			dragStart = input.Position
			startPos = Main.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
			local delta = input.Position - dragStart
			local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			TweenService:Create(Main, TweenInfo.new(0.25), {Position = newPos}):Play()
		end
	end)
end)
