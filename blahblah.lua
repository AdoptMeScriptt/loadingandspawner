-- Combined Loading + Pet Spawner GUI Script

--== LOADING GUI ==--
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScriptGUI"
pcall(function()
	gui.Parent = game:GetService("CoreGui")
end)
if not gui.Parent then
	gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
end

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
Instance.new("UICorner", runButton).CornerRadius = UDim.new(0, 8)

-- Animate loading
spawn(function()
	for i = 1, 100 do
		progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
		percentageLabel.Text = i .. "%"
		wait(0.05)
	end
	progressBar.Visible = false
	percentageLabel.Visible = false
	runButton.Visible = true
end)

--== PET SPAWNER GUI CODE ==--
local function createPetSpawnerGUI()
	local petType = "NFR"
	local Spawner = Instance.new("ScreenGui")
	Spawner.Name = "Spawner"
	Spawner.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	Spawner.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = Spawner
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 446, 0, 260)
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)

	local T = Instance.new("TextLabel", Main)
	T.Text = "Pet Spawner"
	T.Font = Enum.Font.GothamBold
	T.TextColor3 = Color3.fromRGB(255, 255, 255)
	T.TextScaled = true
	T.Size = UDim2.new(0, 406, 0, 46)
	T.Position = UDim2.new(0.5, 0, 0.1, 0)
	T.AnchorPoint = Vector2.new(0.5, 0.5)
	T.BackgroundTransparency = 1

	local function makeButton(name, text, pos, callback)
		local btn = Instance.new("TextButton", Main)
		btn.Name = name
		btn.Size = UDim2.new(0, 89, 0, 50)
		btn.Position = pos
		btn.AnchorPoint = Vector2.new(0.5, 0.5)
		btn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
		btn.Font = Enum.Font.GothamBold
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.TextScaled = true
		btn.Text = text
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
		btn.MouseButton1Click:Connect(callback)
		return btn
	end

	local frBtn = makeButton("FR", "FR", UDim2.new(0.2, 0, 0.35, 0), function()
		frBtn.TextColor3 = Color3.fromRGB(25, 255, 21)
		nfrBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		mfrBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		petType = "FR"
	end)

	local nfrBtn = makeButton("NFR", "NFR", UDim2.new(0.5, 0, 0.35, 0), function()
		nfrBtn.TextColor3 = Color3.fromRGB(25, 255, 21)
		frBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		mfrBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		petType = "NFR"
	end)

	local mfrBtn = makeButton("MFR", "MFR", UDim2.new(0.8, 0, 0.35, 0), function()
		mfrBtn.TextColor3 = Color3.fromRGB(25, 255, 21)
		frBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		nfrBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
		petType = "MFR"
	end)

	local NameBox = Instance.new("TextBox", Main)
	NameBox.Size = UDim2.new(0, 354, 0, 45)
	NameBox.Position = UDim2.new(0.5, 0, 0.6, 0)
	NameBox.AnchorPoint = Vector2.new(0.5, 0.5)
	NameBox.PlaceholderText = "Enter Pet Name Here"
	NameBox.Font = Enum.Font.GothamBold
	NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	NameBox.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
	NameBox.TextScaled = true
	Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 6)

	local spawnBtn = Instance.new("TextButton", Main)
	spawnBtn.Text = "Spawn"
	spawnBtn.Size = UDim2.new(0, 176, 0, 41)
	spawnBtn.Position = UDim2.new(0.5, 0, 0.83, 0)
	spawnBtn.AnchorPoint = Vector2.new(0.5, 0.5)
	spawnBtn.Font = Enum.Font.GothamBold
	spawnBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	spawnBtn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
	spawnBtn.TextScaled = true
	Instance.new("UICorner", spawnBtn).CornerRadius = UDim.new(0, 6)

	spawnBtn.MouseButton1Click:Connect(function()
		local petName = NameBox.Text
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
				copy[k] = typeof(v) == "table" and cloneTable(v) or v
			end
			return copy
		end

		for category_name, category_table in pairs(InventoryDB) do
			for id, item in pairs(category_table) do
				if category_name == "pets" and item.name == petName then
					local uuid = game.HttpService:GenerateGUID()
					local n_item = cloneTable(item)
					n_item["unique"] = "uuid_" .. uuid
					n_item["category"] = "pets"
					n_item["properties"] = generate_prop()
					n_item["newness_order"] = math.random(1, 999999)
					if not Inventory[category_name] then
						Inventory[category_name] = {}
					end
					Inventory[category_name][uuid] = n_item
					return
				end
			end
		end
	end)
end

-- Hook to Run Script button
runButton.MouseButton1Click:Connect(function()
	gui:Destroy()
	createPetSpawnerGUI()
end)
