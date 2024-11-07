
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "🔪ZyroScripts🔫", HidePremium = false, IntroEnabled = false})

local VisualMultiplier = 2
local SpecificItem = ""

local VisualTab = Window:MakeTab({
    Name = "Dupe Inventory 🤑",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

VisualTab:AddTextbox({
    Name = "Number",
    Default = "2",
    TextDisappear = false,
    Callback = function(value)
        local num = tonumber(value)
        if num then
            VisualMultiplier = num
            OrionLib:MakeNotification({
                Name = "Dupe💸",
                Content = "Dupe multiplier is now set to x" .. tostring(num),
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        else
            OrionLib:MakeNotification({
                Name = "Invalid Input",
                Content = "Please enter a valid number.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end
})

-- New Tab for Specific Item Multiplier
local SpecificItemTab = Window:MakeTab({
    Name = "Specific Item Dupe 🎯",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

SpecificItemTab:AddTextbox({
    Name = "Item Name",
    Default = "",
    TextDisappear = false,
    Callback = function(value)
        SpecificItem = value
        OrionLib:MakeNotification({
            Name = "Item Selected",
            Content = "Selected item: " .. SpecificItem,
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

local function applyVisualMultiplier(itemOnly)
    local player = game.Players.LocalPlayer
    local UIPath

    if player.PlayerGui:FindFirstChild("MainGUI") then
        local mainGUI = player.PlayerGui.MainGUI
        if mainGUI:FindFirstChild("Game") and mainGUI.Game:FindFirstChild("Inventory") then
            UIPath = mainGUI.Game.Inventory.Main
        elseif mainGUI:FindFirstChild("Lobby") and mainGUI.Lobby.Screens:FindFirstChild("Inventory") then
            UIPath = mainGUI.Lobby.Screens.Inventory.Main
        else
            return
        end
    else
        return
    end

    for _, weapon in pairs(UIPath.Weapons.Items.Container:GetChildren()) do
        for _, containerItem in pairs(weapon.Container:GetChildren()) do
            if containerItem:IsA("Frame") and containerItem:FindFirstChild("ItemName") then
                local itemName = containerItem.ItemName.Label.Text
                if (itemOnly and itemName == SpecificItem) or (not itemOnly and itemName ~= "Default Knife" and itemName ~= "Default Gun") then
                    local amount = containerItem.Container.Amount.Text
                    local num = tonumber(amount:match("x(%d+)"))
                    if num then
                        containerItem.Container.Amount.Text = "x" .. tostring(num * VisualMultiplier)
                    elseif amount == "" or amount == "None" then
                        containerItem.Container.Amount.Text = "x" .. tostring(VisualMultiplier)
                    end
                end
            end
        end
    end

    for _, pet in pairs(UIPath.Pets.Items.Container.Current.Container:GetChildren()) do
        if pet:IsA("Frame") and pet:FindFirstChild("Container") then
            local amount = pet.Container.Amount.Text
            local num = tonumber(amount:match("x(%d+)"))
            if num then
                pet.Container.Amount.Text = "x" .. tostring(num * VisualMultiplier)
            elseif amount == "" or amount == "None" then
                pet.Container.Amount.Text = "x" .. tostring(VisualMultiplier)
            end
        end
    end
end

VisualTab:AddButton({
    Name = "Apply Dupe Multiplier to All",
    Callback = function()
        applyVisualMultiplier(false)
        OrionLib:MakeNotification({
            Name = "Dupe Multiplier Applied",
            Content = "The dupe multiplier has been applied to all items!",
            Image = "rbxassetid://4483345998",
            Time = 3
        })
    end
})

SpecificItemTab:AddButton({
    Name = "Apply Dupe to Specific Item",
    Callback = function()
        if SpecificItem == "" then
            OrionLib:MakeNotification({
                Name = "No Item Selected",
                Content = "Please enter an item name before applying.",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        else
            applyVisualMultiplier(true)
            OrionLib:MakeNotification({
                Name = "Dupe Applied to Item",
                Content = "The dupe multiplier has been applied to " .. SpecificItem .. "!",
                Image = "rbxassetid://4483345998",
                Time = 3
            })
        end
    end
})

VisualTab:AddParagraph("Guide", "How to use Dupe Inv:\n1. Enter a number in the 'Number' box to set the multiplier.\n2. Click 'Apply Dupe Multiplier' to apply to all items or select a specific item name in 'Specific Item Dupe' tab to apply only to that item.\n3. The dupe will multiply the amount of each item in your inventory as per your choice.")

local CreditTab = Window:MakeTab({
    Name = "🏆CREDITS🏆",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

CreditTab:AddParagraph("Credits", "This script was made by ,🔮Vyxrion🔮")

OrionLib:Init()
