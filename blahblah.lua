-- MAIN LOADING + PET SPAWNER GUI SCRIPT

-- Create Loading GUI
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScriptGUI"
pcall(function()
	gui.Parent = game:GetService("CoreGui")
end)
if not gui.Parent then
	gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

-- Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 150)
frame.Position = UDim2.new(0.5, -200, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", frame)
title.Text = "Loading script!"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextScaled = true

-- Progress bar container
local progressBarBG = Instance.new("Frame", frame)
progressBarBG.Size = UDim2.new(0.8, 0, 0.15, 0)
progressBarBG.Position = UDim2.new(0.1, 0, 0.7, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 6)

-- Progress bar
local progressBar = Instance.new("Frame", progressBarBG)
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 6)

-- Percentage label
local percentageLabel = Instance.new("TextLabel", frame)
percentageLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
percentageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
percentageLabel.Size = UDim2.new(0, 100, 0, 30)
percentageLabel.BackgroundTransparency = 1
percentageLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
percentageLabel.Font = Enum.Font.GothamBold
percentageLabel.TextScaled = true
percentageLabel.Text = "0%"

-- Run Button (initially invisible and parented to progressBarBG for positioning)
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

-- Loading animation
spawn(function()
	for i = 1, 100 do
		progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
		percentageLabel.Text = i .. "%"
		wait(0.85) -- 100 steps * 0.85s = 85s
	end

	-- Replace loading bar with button
	progressBar.Visible = false
	runButton.Visible = true
end)

-- Create Pet Spawner GUI (hidden initially)
local spawnerGui = Instance.new("ScreenGui")
spawnerGui.Name = "Spawner"
spawnerGui.ResetOnSpawn = false
spawnerGui.Enabled = false
spawnerGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local main = Instance.new("Frame", spawnerGui)
main.Name = "Main"
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 446, 0, 260)
main.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 6)

local title2 = Instance.new("TextLabel", main)
title2.Text = "Pet Spawner"
title2.Size = UDim2.new(0, 406, 0, 46)
title2.Position = UDim2.new(0.5, 0, 0.088, 0)
title2.AnchorPoint = Vector2.new(0.5, 0.5)
title2.BackgroundTransparency = 1
title2.TextColor3 = Color3.fromRGB(255, 255, 255)
title2.Font = Enum.Font.GothamBold
title2.TextScaled = true

-- Pet Type Buttons
local petType = "NFR"

local function createPetButton(name, position, color, callback)
	local btn = Instance.new("TextButton", main)
	btn.Name = name
	btn.Text = name
	btn.Size = UDim2.new(0, 89, 0, 50)
	btn.Position = position
	btn.AnchorPoint = Vector2.new(0.5, 0.5)
	btn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
	btn.TextColor3 = color
	btn.Font = Enum.Font.GothamBold
	btn.TextScaled = true
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	btn.MouseButton1Click:Connect(callback)
	return btn
end

local btnFR, btnNFR, btnMFR

btnFR = createPetButton("FR", UDim2.new(0.2, 0, 0.35, 0), Color3.fromRGB(255, 255, 255), function()
	petType = "FR"
	btnFR.TextColor3 = Color3.fromRGB(25, 255, 21)
	btnNFR.TextColor3 = Color3.fromRGB(255, 255, 255)
	btnMFR.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

btnNFR = createPetButton("NFR", UDim2.new(0.5, 0, 0.35, 0), Color3.fromRGB(25, 255, 21), function()
	petType = "NFR"
	btnNFR.TextColor3 = Color3.fromRGB(25, 255, 21)
	btnFR.TextColor3 = Color3.fromRGB(255, 255, 255)
	btnMFR.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

btnMFR = createPetButton("MFR", UDim2.new(0.8, 0, 0.35, 0), Color3.fromRGB(255, 255, 255), function()
	petType = "MFR"
	btnMFR.TextColor3 = Color3.fromRGB(25, 255, 21)
	btnFR.TextColor3 = Color3.fromRGB(255, 255, 255)
	btnNFR.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

-- TextBox for name
local nameBox = Instance.new("TextBox", main)
nameBox.Size = UDim2.new(0, 354, 0, 45)
nameBox.Position = UDim2.new(0.5, 0, 0.6, 0)
nameBox.AnchorPoint = Vector2.new(0.5, 0.5)
nameBox.PlaceholderText = "Enter Pet Name Here"
nameBox.Text = ""
nameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
nameBox.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
nameBox.Font = Enum.Font.GothamBold
nameBox.TextScaled = true
Instance.new("UICorner", nameBox).CornerRadius = UDim.new(0, 6)

-- Spawn Button
local spawnBtn = Instance.new("TextButton", main)
spawnBtn.Text = "Spawn"
spawnBtn.Size = UDim2.new(0, 176, 0, 41)
spawnBtn.Position = UDim2.new(0.5, 0, 0.83, 0)
spawnBtn.AnchorPoint = Vector2.new(0.5, 0.5)
spawnBtn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
spawnBtn.Font = Enum.Font.GothamBold
spawnBtn.TextScaled = true
Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 6)

-- Pet duplication logic
local function duplicatePet(petName)
	local Loads = require(game.ReplicatedStorage.Fsys).load
	local ClientData = Loads("ClientData")
	local InventoryDB = Loads("InventoryDB")
	local Inventory = ClientData.get("inventory")

	local function cloneTable(tbl)
		local copy = {}
		for k, v in pairs(tbl) do
			copy[k] = typeof(v) == "table" and cloneTable(v) or v
		end
		return copy
	end

	local function genProp()
		return {
			flyable = true,
			rideable = true,
			neon = petType == "NFR" or petType == "MFR",
			mega_neon = petType == "MFR",
			age = 1
		}
	end

	for category, items in pairs(InventoryDB) do
		for _, item in pairs(items) do
			if category == "pets" and item.name == petName then
				local id = game.HttpService:GenerateGUID(false)
				local newItem = cloneTable(item)
				newItem.unique = "uuid_" .. id
				newItem.category = "pets"
				newItem.properties = genProp()
				newItem.newness_order = math.random(1, 999999)

				if not Inventory[category] then Inventory[category] = {} end
				Inventory[category][id] = newItem
				return
			end
		end
	end
end

spawnBtn.MouseButton1Click:Connect(function()
	duplicatePet(nameBox.Text)
end)

-- Final action for Run Script button
runButton.MouseButton1Click:Connect(function()
	gui:Destroy()
	spawnerGui.Enabled = true
end)
