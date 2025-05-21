-- Loading + Pet Spawner GUI Script (Fixed for Moonsec Obfuscation)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- LOADING GUI SETUP
local gui = Instance.new("ScreenGui")
gui.Name = "LoadingScriptGUI"

pcall(function()
    gui.Parent = game:GetService("CoreGui")
end)
if not gui.Parent then
    gui.Parent = player:WaitForChild("PlayerGui")
end

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 150)
frame.Position = UDim2.new(0.5, -200, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
frame.Parent = gui

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Text = "Loading script!"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 10)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = frame

local progressBarBG = Instance.new("Frame")
progressBarBG.Size = UDim2.new(0.8, 0, 0.15, 0)
progressBarBG.Position = UDim2.new(0.1, 0, 0.7, 0)
progressBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
progressBarBG.Name = "ProgressBarBG"
progressBarBG.Parent = frame

Instance.new("UICorner", progressBarBG).CornerRadius = UDim.new(0, 6)

local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
progressBar.Parent = progressBarBG

Instance.new("UICorner", progressBar).CornerRadius = UDim.new(0, 6)

local percentageLabel = Instance.new("TextLabel")
percentageLabel.Position = UDim2.new(0.5, 0, 0.55, 0)
percentageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
percentageLabel.Size = UDim2.new(0, 100, 0, 30)
percentageLabel.BackgroundTransparency = 1
percentageLabel.TextColor3 = Color3.fromRGB(0, 255, 170)
percentageLabel.Font = Enum.Font.GothamBold
percentageLabel.TextScaled = true
percentageLabel.Text = "1%"
percentageLabel.Parent = frame

local runButton = Instance.new("TextButton")
runButton.Size = progressBarBG.Size
runButton.Position = progressBarBG.Position
runButton.AnchorPoint = Vector2.new(0, 0)
runButton.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
runButton.TextColor3 = Color3.fromRGB(0, 0, 0)
runButton.Font = Enum.Font.GothamBold
runButton.TextScaled = true
runButton.Text = "Run Script"
runButton.Visible = false
runButton.Parent = frame

Instance.new("UICorner", runButton).CornerRadius = UDim.new(0, 8)

spawn(function()
    for i = 1, 100 do
        progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
        percentageLabel.Text = i .. "%"
        wait(0.85) -- 100 * 0.85 = 85 seconds
    end
    progressBar.Visible = false
    runButton.Visible = true
end)

-- PET SPAWNER GUI
local function createSpawnerGUI()
    local Spawner = Instance.new("ScreenGui")
    Spawner.Name = "Spawner"
    Spawner.Parent = player:WaitForChild("PlayerGui")

    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = Spawner
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 446, 0, 260)
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 6)

    local T = Instance.new("TextLabel")
    T.Parent = Main
    T.AnchorPoint = Vector2.new(0.5, 0.5)
    T.BackgroundTransparency = 1
    T.Position = UDim2.new(0.5, 0, 0.088, 0)
    T.Size = UDim2.new(0, 406, 0, 46)
    T.Font = Enum.Font.GothamBold
    T.Text = "Pet Spawner"
    T.TextColor3 = Color3.fromRGB(255, 255, 255)
    T.TextScaled = true

    local petType = "NFR"

    local function makeTypeButton(name, position, callback)
        local btn = Instance.new("TextButton")
        btn.Name = name
        btn.Parent = Main
        btn.AnchorPoint = Vector2.new(0.5, 0.5)
        btn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
        btn.Position = position
        btn.Size = UDim2.new(0, 89, 0, 50)
        btn.Font = Enum.Font.GothamBold
        btn.Text = name
        btn.TextColor3 = name == "NFR" and Color3.fromRGB(25, 255, 21) or Color3.fromRGB(255, 255, 255)
        btn.TextScaled = true
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        btn.MouseButton1Click:Connect(function()
            petType = name
            for _, sibling in ipairs({"FR", "NFR", "MFR"}) do
                if sibling ~= name then
                    Main:FindFirstChild(sibling).TextColor3 = Color3.fromRGB(255, 255, 255)
                end
            end
            btn.TextColor3 = Color3.fromRGB(25, 255, 21)
        end)
        return btn
    end

    makeTypeButton("FR", UDim2.new(0.202, 0, 0.35, 0))
    makeTypeButton("NFR", UDim2.new(0.498, 0, 0.35, 0))
    makeTypeButton("MFR", UDim2.new(0.797, 0, 0.35, 0))

    local NameBox = Instance.new("TextBox")
    NameBox.Parent = Main
    NameBox.AnchorPoint = Vector2.new(0.5, 0.5)
    NameBox.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
    NameBox.Position = UDim2.new(0.5, 0, 0.60, 0)
    NameBox.Size = UDim2.new(0, 354, 0, 45)
    NameBox.PlaceholderText = "Enter Pet Name Here"
    NameBox.Font = Enum.Font.GothamBold
    NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameBox.TextScaled = true
    Instance.new("UICorner", NameBox).CornerRadius = UDim.new(0, 6)

    local Spawn = Instance.new("TextButton")
    Spawn.Parent = Main
    Spawn.AnchorPoint = Vector2.new(0.5, 0.5)
    Spawn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
    Spawn.Position = UDim2.new(0.5, 0, 0.825, 0)
    Spawn.Size = UDim2.new(0, 176, 0, 41)
    Spawn.Font = Enum.Font.GothamBold
    Spawn.Text = "Spawn"
    Spawn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Spawn.TextScaled = true
    Instance.new("UICorner", Spawn).CornerRadius = UDim.new(0, 6)

    local function duplicatePet(petName)
        local Loads = require(game.ReplicatedStorage.Fsys).load
        local ClientData = Loads("ClientData")
        local InventoryDB = Loads("InventoryDB")
        local Inventory = ClientData.get("inventory")

        local function cloneTable(tbl)
            local copy = {}
            for k, v in pairs(tbl) do
                copy[k] = type(v) == "table" and cloneTable(v) or v
            end
            return copy
        end

        local function generate_prop()
            return {
                flyable = true,
                rideable = true,
                neon = petType == "NFR" or petType == "MFR",
                mega_neon = petType == "MFR",
                age = 1
            }
        end

        for cat, catTbl in pairs(InventoryDB) do
            for id, item in pairs(catTbl) do
                if cat == "pets" and item.name == petName then
                    local fake_uuid = HttpService:GenerateGUID(false)
                    local n_item = cloneTable(item)
                    n_item["unique"] = "uuid_" .. fake_uuid
                    n_item["category"] = "pets"
                    n_item["properties"] = generate_prop()
                    n_item["newness_order"] = math.random(1, 900000)
                    Inventory[cat] = Inventory[cat] or {}
                    Inventory[cat][fake_uuid] = n_item
                    return
                end
            end
        end
    end

    Spawn.MouseButton1Click:Connect(function()
        duplicatePet(NameBox.Text)
    end)
end

runButton.MouseButton1Click:Connect(function()
    gui:Destroy()
    createSpawnerGUI()
end)
