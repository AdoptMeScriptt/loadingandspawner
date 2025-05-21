-- Roblox Loader with Pet Spawner Integration
local function createLoaderAndSpawner()
    -- Loader GUI
    local gui = Instance.new("ScreenGui")
    gui.Name = "LoadingScriptGUI"

    pcall(function()
        gui.Parent = game:GetService("CoreGui")
    end)
    if not gui.Parent then
        gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 150)
    frame.Position = UDim2.new(0.5, -200, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

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
    progressBarBG.Parent = frame

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(0, 6)
    barCorner.Parent = progressBarBG

    local progressBar = Instance.new("Frame")
    progressBar.Size = UDim2.new(0, 0, 1, 0)
    progressBar.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
    progressBar.Parent = progressBarBG

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 6)
    fillCorner.Parent = progressBar

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
    runButton.Size = UDim2.new(0.4, 0, 0.2, 0)
    runButton.Position = UDim2.new(0.5, 0, 0.88, 0)
    runButton.AnchorPoint = Vector2.new(0.5, 0.5)
    runButton.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
    runButton.TextColor3 = Color3.fromRGB(0, 0, 0)
    runButton.Font = Enum.Font.GothamBold
    runButton.TextScaled = true
    runButton.Text = "Run Script"
    runButton.Visible = false
    runButton.Parent = frame

    local runCorner = Instance.new("UICorner")
    runCorner.CornerRadius = UDim.new(0, 8)
    runCorner.Parent = runButton

    task.spawn(function()
        for i = 1, 100 do
            progressBar.Size = UDim2.new(i / 100, 0, 1, 0)
            percentageLabel.Text = i .. "%"
            task.wait(0.03)
        end
        runButton.Visible = true
    end)

    runButton.MouseButton1Click:Connect(function()
        gui:Destroy()

        -- Pet Spawner GUI Code Here
        local Spawner = Instance.new("ScreenGui")
        Spawner.Name = "Spawner"
        Spawner.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

        local Main = Instance.new("Frame")
        Main.Size = UDim2.new(0, 446, 0, 260)
        Main.Position = UDim2.new(0.5, 0, 0.5, 0)
        Main.AnchorPoint = Vector2.new(0.5, 0.5)
        Main.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
        Main.Parent = Spawner

        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 6)
        UICorner.Parent = Main

        local T = Instance.new("TextLabel")
        T.Text = "Pet Spawner"
        T.Font = Enum.Font.GothamBold
        T.TextColor3 = Color3.fromRGB(255, 255, 255)
        T.TextScaled = true
        T.Size = UDim2.new(0, 406, 0, 46)
        T.Position = UDim2.new(0.5, 0, 0.088, 0)
        T.AnchorPoint = Vector2.new(0.5, 0.5)
        T.BackgroundTransparency = 1
        T.Parent = Main

        local petType = "NFR"

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
                for key, value in pairs(original) do
                    copy[key] = type(value) == "table" and cloneTable(value) or value
                end
                return copy
            end

            for category_name, category_table in pairs(InventoryDB) do
                for id, item in pairs(category_table) do
                    if category_name == "pets" and item.name == petName then
                        local fake_uuid = game.HttpService:GenerateGUID(false)
                        local n_item = cloneTable(item)

                        n_item["unique"] = "uuid_" .. fake_uuid
                        n_item["category"] = "pets"
                        n_item["properties"] = generate_prop()
                        n_item["newness_order"] = math.random(1, 900000)

                        Inventory[category_name] = Inventory[category_name] or {}
                        Inventory[category_name][fake_uuid] = n_item
                        return
                    end
                end
            end
        end

        local NameBox = Instance.new("TextBox")
        NameBox.PlaceholderText = "Enter Pet Name Here"
        NameBox.Size = UDim2.new(0, 354, 0, 45)
        NameBox.Position = UDim2.new(0.5, 0, 0.6, 0)
        NameBox.AnchorPoint = Vector2.new(0.5, 0.5)
        NameBox.Text = ""
        NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameBox.Font = Enum.Font.GothamBold
        NameBox.TextScaled = true
        NameBox.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
        NameBox.Parent = Main

        local Spawn = Instance.new("TextButton")
        Spawn.Text = "Spawn"
        Spawn.Size = UDim2.new(0, 176, 0, 41)
        Spawn.Position = UDim2.new(0.5, 0, 0.82, 0)
        Spawn.AnchorPoint = Vector2.new(0.5, 0.5)
        Spawn.BackgroundColor3 = Color3.fromRGB(6, 6, 6)
        Spawn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Spawn.Font = Enum.Font.GothamBold
        Spawn.TextScaled = true
        Spawn.Parent = Main

        Spawn.MouseButton1Click:Connect(function()
            duplicatePet(NameBox.Text)
        end)
    end)
end

createLoaderAndSpawner()
