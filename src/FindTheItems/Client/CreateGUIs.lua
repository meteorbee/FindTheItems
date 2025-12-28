local TweenService = game:GetService("TweenService")

local Shared = {}

function Shared.CreateNotifications()
	game.ReplicatedStorage:WaitForChild("FindTheItemsResources").ShowNotification.OnClientEvent:Connect(function(title, content, icon)
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = title,
			Text = content,
			Duration = 5,
			Icon = icon or nil
		})
	end)
end

local UISettings = require(script.Parent.Parent.Configurations.UI)
local InfoSettings = require(script.Parent.Parent.Configurations.Info)

export type Item = {
	Hitbox: BasePart?,
	DisplayName: string,
	ID: string,
	Rarity: string,
	Location: string,
	Desc: string,
	Icon: string,
	Creator: string,
	Realm: string,
	Hint: string,
	Badge: number,

	Pickup: (Player, Item) -> boolean
}

function Shared.CreateDex()
	local succ, err = pcall(function()
		local Dex = Instance.new("ScreenGui")
		Dex.Name = "Dex"
		Dex.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		Dex.Parent = game.Players.LocalPlayer.PlayerGui

		local Open = Instance.new("TextButton")
		Open.Name = "Open"
		Open.TextWrapped = true
		Open.BorderSizePixel = 0
		Open.TextScaled = true
		Open.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
		Open.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Open.TextSize = 14
		Open.Size = UDim2.new(0.13, 0.00, 0.08, 0.00)
		Open.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Open.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Open.Text = "Open Dex"
		Open.Position = UDim2.new(0.5, 0.00, 0.90, 0.00)
		Open.Parent = Dex
		Open.AnchorPoint = Vector2.new(0.5,0)

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(1.00, 0.00)
		UICorner.Parent = Open

		local Pattern = Instance.new("ImageLabel")
		Pattern.Name = "Pattern"
		Pattern.ScaleType = Enum.ScaleType.Tile
		Pattern.ImageTransparency = 0.8
		Pattern.Image = "rbxassetid://121480522"
		Pattern.TileSize = UDim2.new(0.00, 45.00, 0.00, 45.00)
		Pattern.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Pattern.BackgroundTransparency = 1
		Pattern.Parent = Open

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(1.00, 0.00)
		UICorner_1.Parent = Pattern

		local Dex_1 = Instance.new("Frame")
		Dex_1.Name = "Dex"
		Dex_1.AnchorPoint = Vector2.new(0.50, 0.00)
		Dex_1.Size = UDim2.new(0.65, 0.00, 0.86, 0.00)
		Dex_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Dex_1.Position = UDim2.new(0.50, 0.00, 1, 0.00)
		Dex_1.BorderSizePixel = 0
		Dex_1.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
		Dex_1.Parent = Dex
		Dex_1.Visible = false

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
		UICorner_1.Parent = Dex_1

		local Items = Instance.new("ScrollingFrame")
		Items.Name = "Items"
		Items.Active = true
		Items.ScrollingDirection = Enum.ScrollingDirection.Y
		Items.ZIndex = 2
		Items.BorderSizePixel = 0
		Items.CanvasSize = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Items.AutomaticCanvasSize = Enum.AutomaticSize.Y
		Items.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Items.Size = UDim2.new(0.62, 0.00, 0.92, 0.00)
		Items.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Items.ScrollBarThickness = 0
		Items.BackgroundTransparency = 1
		Items.Position = UDim2.new(0.00, 0.00, 0.08, 0.00)
		Items.Parent = Dex_1

		local UIGridLayout = Instance.new("UIGridLayout")
		UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIGridLayout.CellSize = UDim2.new(1 / UISettings.ItemsPerRow, 0.00, 1 / UISettings.ItemsPerRow, 0.00)
		UIGridLayout.Parent = Items

		local Title_1 = Instance.new("TextLabel")
		Title_1.Name = "Title"
		Title_1.TextWrapped = true
		Title_1.ZIndex = 5
		Title_1.BorderSizePixel = 0
		Title_1.TextScaled = true
		Title_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Title_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Title_1.AnchorPoint = Vector2.new(0.50, 0.00)
		Title_1.TextXAlignment = Enum.TextXAlignment.Left
		Title_1.TextSize = 14
		Title_1.Size = UDim2.new(0.90, 0.00, 0.08, 0.00)
		Title_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Title_1.Text = ("The %sDex 6000™"):format(InfoSettings.ItemNames)
		Title_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Title_1.BackgroundTransparency = 1
		Title_1.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		Title_1.Parent = Dex_1

		local ByName = Instance.new("TextButton")
		ByName.Name = "ByName"
		ByName.TextWrapped = true
		ByName.BorderSizePixel = 0
		ByName.TextScaled = true
		ByName.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ByName.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		ByName.AnchorPoint = Vector2.new(0.00, 0.50)
		ByName.TextSize = 14
		ByName.Size = UDim2.new(0.08, 0.00, 0.67, 0.00)
		ByName.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		ByName.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		ByName.Text = "Name"
		ByName.BackgroundTransparency = 0.8
		ByName.Position = UDim2.new(0.89, 0.00, 0.50, 0.00)
		ByName.Parent = Title_1

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.20, 0.00)
		UICorner_1.Parent = ByName

		local ByDifficulty = Instance.new("TextButton")
		ByDifficulty.Name = "ByDifficulty"
		ByDifficulty.TextWrapped = true
		ByDifficulty.BorderSizePixel = 0
		ByDifficulty.TextScaled = true
		ByDifficulty.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ByDifficulty.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		ByDifficulty.AnchorPoint = Vector2.new(0.00, 0.50)
		ByDifficulty.TextSize = 14
		ByDifficulty.Size = UDim2.new(0.08, 0.00, 0.67, 0.00)
		ByDifficulty.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		ByDifficulty.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		ByDifficulty.Text = "Difficulty"
		ByDifficulty.BackgroundTransparency = 0.8
		ByDifficulty.Position = UDim2.new(0.79, 0.00, 0.50, 0.00)
		ByDifficulty.Parent = Title_1

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.20, 0.00)
		UICorner_1.Parent = ByDifficulty

		local Search = Instance.new("TextBox")
		Search.Name = "Search"
		Search.TextWrapped = true
		Search.BorderSizePixel = 0
		Search.TextScaled = true
		Search.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Search.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Search.AnchorPoint = Vector2.new(0.00, 0.50)
		Search.TextSize = 14
		Search.Size = UDim2.new(0.35, 0.00, 0.56, 0.00)
		Search.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Search.Text = ""
		Search.TextColor3 = Color3.new(1,1,1)
		Search.PlaceholderText = ("Search for %s %s"):format(string.lower(UISettings.AnOrA), InfoSettings.ItemNames)
		Search.TextXAlignment = Enum.TextXAlignment.Left
		Search.BackgroundTransparency = 0.8
		Search.Position = UDim2.new(0.42, 0.00, 0.50, 0.00)
		Search.Parent = Title_1
		Search.ClearTextOnFocus = false

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.20, 0.00)
		UICorner_1.Parent = Search

		local SearchOptions = Instance.new("Frame")
		SearchOptions.Name = "SearchOptions"
		SearchOptions.Visible = false
		SearchOptions.Size = UDim2.new(1.00, 0.00, 4.50, 0.00)
		SearchOptions.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		SearchOptions.Position = UDim2.new(0.00, 0.00, 1.38, 0.00)
		SearchOptions.BorderSizePixel = 0
		SearchOptions.BackgroundTransparency = 0.00
		SearchOptions.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
		SearchOptions.Parent = Search

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
		UICorner_1.Parent = SearchOptions

		local ByName_1 = Instance.new("TextButton")
		ByName_1.Name = "ByName"
		ByName_1.TextWrapped = true
		ByName_1.BorderSizePixel = 0
		ByName_1.TextScaled = true
		ByName_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ByName_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		ByName_1.AnchorPoint = Vector2.new(0.00, 0.50)
		ByName_1.TextSize = 14
		ByName_1.Size = UDim2.new(0.40, 0.00, 0.29, 0.00)
		ByName_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		ByName_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		ByName_1.Text = "Name"
		ByName_1.BackgroundTransparency = 0.8
		ByName_1.Position = UDim2.new(0.03, 0.00, 0.30, 0.00)
		ByName_1.Parent = SearchOptions

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.20, 0.00)
		UICorner_1.Parent = ByName_1

		local UIGridLayout_1 = Instance.new("UIGridLayout")
		UIGridLayout_1.VerticalAlignment = Enum.VerticalAlignment.Center
		UIGridLayout_1.SortOrder = Enum.SortOrder.Name
		UIGridLayout_1.CellSize = UDim2.new(0.20, 0.00, 0.50, 0.00)
		UIGridLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIGridLayout_1.Parent = SearchOptions

		local ByDesc = Instance.new("TextButton")
		ByDesc.Name = "ByDesc"
		ByDesc.TextWrapped = true
		ByDesc.BorderSizePixel = 0
		ByDesc.TextScaled = true
		ByDesc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ByDesc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		ByDesc.AnchorPoint = Vector2.new(0.00, 0.50)
		ByDesc.TextSize = 14
		ByDesc.Size = UDim2.new(0.40, 0.00, 0.29, 0.00)
		ByDesc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		ByDesc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		ByDesc.Text = "Description"
		ByDesc.BackgroundTransparency = 0.8
		ByDesc.Position = UDim2.new(0.03, 0.00, 0.30, 0.00)
		ByDesc.Parent = SearchOptions

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.20, 0.00)
		UICorner_1.Parent = ByDesc

		local ByHint = Instance.new("TextButton")
		ByHint.Name = "ByHint"
		ByHint.TextWrapped = true
		ByHint.BorderSizePixel = 0
		ByHint.TextScaled = true
		ByHint.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ByHint.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		ByHint.AnchorPoint = Vector2.new(0.00, 0.50)
		ByHint.TextSize = 14
		ByHint.Size = UDim2.new(0.40, 0.00, 0.29, 0.00)
		ByHint.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		ByHint.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		ByHint.Text = "Hint"
		ByHint.BackgroundTransparency = 0.8
		ByHint.Position = UDim2.new(0.03, 0.00, 0.30, 0.00)
		ByHint.Parent = SearchOptions

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.20, 0.00)
		UICorner_1.Parent = ByHint

		local ByRealm = Instance.new("TextButton")
		ByRealm.Name = "ByRealm"
		ByRealm.TextWrapped = true
		ByRealm.BorderSizePixel = 0
		ByRealm.TextScaled = true
		ByRealm.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		ByRealm.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		ByRealm.AnchorPoint = Vector2.new(0.00, 0.50)
		ByRealm.TextSize = 14
		ByRealm.Size = UDim2.new(0.40, 0.00, 0.29, 0.00)
		ByRealm.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		ByRealm.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		ByRealm.Text = "Realm"
		ByRealm.BackgroundTransparency = 0.8
		ByRealm.Position = UDim2.new(0.03, 0.00, 0.30, 0.00)
		ByRealm.Parent = SearchOptions

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.20, 0.00)
		UICorner_1.Parent = ByRealm

		local Info = Instance.new("Frame")
		Info.Name = "Info"
		Info.Size = UDim2.new(0.40, 0.00, 0.91, 0.00)
		Info.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Info.Position = UDim2.new(0.60, 0.00, 0.09, 0.00)
		Info.BorderSizePixel = 0
		Info.ZIndex = 2
		Info.BackgroundTransparency = 1
		Info.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Info.Parent = Dex_1

		local Title_1 = Instance.new("TextLabel")
		Title_1.Name = "Title"
		Title_1.TextWrapped = true
		Title_1.BorderSizePixel = 0
		Title_1.TextScaled = true
		Title_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Title_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Title_1.AnchorPoint = Vector2.new(0.50, 0.00)
		Title_1.TextSize = 14
		Title_1.Size = UDim2.new(1.00, 0.00, 0.08, 0.00)
		Title_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Title_1.Text = ("Select %s %s"):format(UISettings.AnOrA, InfoSettings.ItemNames)
		Title_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Title_1.BackgroundTransparency = 1
		Title_1.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		Title_1.Parent = Info

		local Desc = Instance.new("TextLabel")
		Desc.Name = "Desc"
		Desc.TextWrapped = true
		Desc.BorderSizePixel = 0
		Desc.TextScaled = true
		Desc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Desc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Desc.AnchorPoint = Vector2.new(0.50, 0.00)
		Desc.TextSize = 14
		Desc.Size = UDim2.new(1.00, 0.00, 0.34, 0.00)
		Desc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Desc.Text = ("It would display a description here, but you need to select %s %s first!"):format(string.lower(UISettings.AnOrA), InfoSettings.ItemNames)
		Desc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Desc.BackgroundTransparency = 1
		Desc.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
		Desc.Parent = Info

		local Icon_1 = Instance.new("ImageLabel")
		Icon_1.Name = "Icon"
		Icon_1.BorderSizePixel = 0
		Icon_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Icon_1.Size = UDim2.new(0.42, 0.00, 0.36, 0.00)
		Icon_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Icon_1.BackgroundTransparency = 1
		Icon_1.Position = UDim2.new(0.30, 0.00, 0.11, 0.00)
		Icon_1.Parent = Info

		local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
		UIAspectRatioConstraint_1.Parent = Icon_1

		local Extras = Instance.new("Frame")
		Extras.Name = "Extras"
		Extras.Size = UDim2.new(1.00, 0.00, 0.07, 0.00)
		Extras.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Extras.Position = UDim2.new(0.00, 0.00, 0.90, 0.00)
		Extras.BorderSizePixel = 0
		Extras.BackgroundTransparency = 1
		Extras.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Extras.Parent = Info

		local UIGridLayout_1 = Instance.new("UIGridLayout")
		UIGridLayout_1.CellPadding = UDim2.new(0.03, 0.00, 0.00, 0.00)
		UIGridLayout_1.CellSize = UDim2.new(0.30, 0.00, 1.00, 0.00)
		UIGridLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIGridLayout_1.Parent = Extras

		local Found = Instance.new("TextLabel")
		Found.Name = "Found"
		Found.TextWrapped = true
		Found.BorderSizePixel = 0
		Found.TextScaled = true
		Found.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Found.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Found.TextSize = 14
		Found.Size = UDim2.new(0.00, 200.00, 0.00, 50.00)
		Found.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Found.Text = "Found in: ?"
		Found.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Found.BackgroundTransparency = 1
		Found.Parent = Extras

		local Difficulty = Instance.new("TextLabel")
		Difficulty.Name = "Difficulty"
		Difficulty.TextWrapped = true
		Difficulty.BorderSizePixel = 0
		Difficulty.TextScaled = true
		Difficulty.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Difficulty.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Difficulty.TextSize = 14
		Difficulty.Size = UDim2.new(0.00, 200.00, 0.00, 50.00)
		Difficulty.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Difficulty.Text = "Difficulty: ?"
		Difficulty.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Difficulty.BackgroundTransparency = 1
		Difficulty.Parent = Extras

		local Creator = Instance.new("TextLabel")
		Creator.Name = "Creator"
		Creator.TextWrapped = true
		Creator.BorderSizePixel = 0
		Creator.TextScaled = true
		Creator.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Creator.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Creator.TextSize = 14
		Creator.Size = UDim2.new(0.00, 200.00, 0.00, 50.00)
		Creator.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Creator.Text = "Creator: ?"
		Creator.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Creator.BackgroundTransparency = 1
		Creator.Parent = Extras

		local Pattern_1 = Instance.new("ImageLabel")
		Pattern_1.Name = "Pattern"
		Pattern_1.ScaleType = Enum.ScaleType.Tile
		Pattern_1.ImageTransparency = 0.8
		Pattern_1.Image = "rbxassetid://121480522"
		Pattern_1.TileSize = UDim2.new(0.00, 45.00, 0.00, 45.00)
		Pattern_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Pattern_1.BackgroundTransparency = 1
		Pattern_1.Parent = Dex_1

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
		UICorner_1.Parent = Pattern_1

		local SearchOptionsEnum = {
			Name = {Name = "Name", Value = 0, EnumType = SearchOptions},
			Description = {Name = "Description", Value = 1, EnumType = SearchOptions},
			Hint = {Name = "Hint", Value = 2, EnumType = SearchOptions},
			Realm = {Name = "Realm", Value = 3, EnumType = SearchOptions}
		}

		local Opened = false
		local OpenCooldown = false
		local SearchingBy = SearchOptions.Name
		
		local HighestSort = 0
		for i, v in require(script.Parent.Parent.Configurations.Rarities) do
			if v.Sort > HighestSort then
				HighestSort = v.Sort
			end
		end
		
		local RefreshSearchBindable = Instance.new("BindableEvent")
		
		local function AddIconToDex(ItemInfo:Item)
			local Item = Instance.new("Frame")
			Item.Name = ItemInfo.DisplayName
			Item.BackgroundTransparency = 1
			Item.Size = UDim2.new(0.00, 100.00, 0.00, 100.00)
			Item.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Item.BorderSizePixel = 0
			Item.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
			Item.Parent = Items
			Item.LayoutOrder = require(script.Parent.Parent.Configurations.Rarities)[ItemInfo.Rarity].Sort
			
			if ItemInfo.Rarity == "Missing" then
				Item.LayoutOrder = HighestSort + 1
			end

			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.BorderSizePixel = 0
			Icon.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Icon.Image = ItemInfo.Icon or "rbxassetid://14564074061"
			Icon.Size = UDim2.new(0.76, 0.00, 0.76, 0.00)
			Icon.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Icon.BackgroundTransparency = 1
			Icon.Position = UDim2.new(0.12, 0.00, 0.04, 0.00)
			Icon.Parent = Item

			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			UIAspectRatioConstraint.Parent = Icon

			local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
			UIAspectRatioConstraint_1.Parent = Item

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.TextWrapped = true
			Title.BorderSizePixel = 0
			Title.TextScaled = true
			Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Title.TextSize = 14
			Title.Size = UDim2.new(1.00, 0.00, 0.20, 0.00)
			Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Title.Text = ItemInfo.DisplayName or "Unknown Name"
			Title.TextColor3 = require(script.Parent.Parent.Configurations.Rarities)[ItemInfo.Rarity].Color
			Title.BackgroundTransparency = 1
			Title.Position = UDim2.new(0.00, 0.00, 0.80, 0.00)
			Title.Parent = Item

			local Interact = Instance.new("TextButton")
			Interact.Name = "Interact"
			Interact.BorderSizePixel = 0
			Interact.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Interact.TextSize = 14
			Interact.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
			Interact.TextColor3 = Color3.new(0.00, 0.00, 0.00)
			Interact.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Interact.Text = ""
			Interact.BackgroundTransparency = 1
			Interact.Parent = Item
			
			local fieldMap = {
				["Name"] = function(info) return info.DisplayName end,
				["Hint"] = function(info) return info.Hint end,
				["Description"] = function(info) return info.Desc end,
				["Realm"] = function(info) return info.Realm end,
			}
			
			local RefreshConnection = RefreshSearchBindable.Event:Connect(function()
				local query = string.lower(Search.Text)

				if query == "" then
					Item.Visible = true
					return
				end

				local getter = fieldMap[SearchingBy.Name]
				if not getter then
					Item.Visible = true
					return
				end

				local value = getter(ItemInfo)
				if not value then
					Item.Visible = false
					return
				end

				value = string.lower(value)

				Item.Visible = string.find(value, query, 1, true) ~= nil
			end)
			
			local MouseClickConnection = Interact.MouseButton1Click:Connect(function()
				Title_1.Text = ItemInfo.DisplayName
				Title_1.TextColor3 = require(script.Parent.Parent.Configurations.Rarities)[ItemInfo.Rarity].Color
				Desc.Text = ItemInfo.Desc
				Icon_1.Image = ItemInfo.Icon or "rbxassetid://14564074061"
				Difficulty.Text = ItemInfo.Rarity
				Found.Text = ("%s, %s"):format(ItemInfo.Location, ItemInfo.Realm)

				if ItemInfo.Owned == false then
					Icon_1.ImageColor3 = Color3.new(0,0,0)
					Desc.Text = ("Unlock this %s to view its description! Hint: %s"):format(InfoSettings.ItemNames, ItemInfo.Hint)
				else
					Icon_1.ImageColor3 = Color3.new(1,1,1)
				end
			end)
			
			if ItemInfo.Owned == false then
				Icon.ImageColor3 = Color3.new(0,0,0)
			end
			
			Item.Destroying:Once(function()
				RefreshConnection:Disconnect()
				MouseClickConnection:Disconnect()
			end)
		end

		local function ChangeOpenButton(text)
			Open.MaxVisibleGraphemes = string.len(Open.Text)

			local OpenButton = TweenService:Create(
				Open,
				TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
				{MaxVisibleGraphemes = 0}
			)

			OpenButton:Play()

			OpenButton.Completed:Connect(function()
				Open.Text = text
				local ShowOpenButton = TweenService:Create(
					Open,
					TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
					{MaxVisibleGraphemes = string.len(text)}
				)
				ShowOpenButton:Play()
			end)
		end
		
		local function ClearIcons()
			for i, v in Items:GetChildren() do
				if v:IsA("Frame") then
					v:Destroy()
				end
			end
		end
		
		local function AddIcons()
			local Items = game.ReplicatedStorage:WaitForChild("FindTheItemsResources").RequestItems:InvokeServer()
			
			for i, v in Items do
				AddIconToDex(v)
			end
		end
		
		Search:GetPropertyChangedSignal("Text"):Connect(function()
			RefreshSearchBindable:Fire()
		end)
		
		Search.Focused:Connect(function()
			SearchOptions.Visible = true
		end)
		
		Search.FocusLost:Connect(function(enter)
			if not enter then return end
			SearchOptions.Visible = false
		end)
		
		ByName.MouseButton1Click:Connect(function()
			UIGridLayout.SortOrder = Enum.SortOrder.Name
		end)
		
		ByDifficulty.MouseButton1Click:Connect(function()
			UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		end)
		
		ByName_1.MouseButton1Click:Connect(function()
			SearchingBy = SearchOptionsEnum.Name
			RefreshSearchBindable:Fire()
		end)
		
		ByDesc.MouseButton1Click:Connect(function()
			SearchingBy = SearchOptionsEnum.Description
			RefreshSearchBindable:Fire()
		end)
		
		ByRealm.MouseButton1Click:Connect(function()
			SearchingBy = SearchOptionsEnum.Realm
			RefreshSearchBindable:Fire()
		end)
		
		ByHint.MouseButton1Click:Connect(function()
			SearchingBy = SearchOptionsEnum.Hint
			RefreshSearchBindable:Fire()
		end)
		
		Open.MouseButton1Click:Connect(function()
			if OpenCooldown then return end
			OpenCooldown = true
			task.delay(1, function()
				OpenCooldown = false
			end)
			Opened = not Opened

			if Opened then
				AddIcons()
				
				local OpenTween = TweenService:Create(
					Dex_1,
					TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
					{Position = UDim2.new(0.50, 0.00, 0.00, 0.00)}
				)

				Dex_1.Visible = true

				OpenTween:Play()

				OpenTween.Completed:Connect(function()
					ChangeOpenButton("Close Dex")
				end)
			else
				local CloseTween = TweenService:Create(
					Dex_1,
					TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
					{Position = UDim2.new(0.50, 0.00, 1.00, 0.00)}
				)

				CloseTween:Play()

				CloseTween.Completed:Connect(function()
					Dex_1.Visible = false
					ClearIcons()
					ChangeOpenButton("Open Dex")
				end)
			end
		end)
		
	end)
	
	if not succ then
		warn("Error with the dex:",err)
	end
end

function Shared.CreateMenu()
	local succ, err = pcall(function()
		local Menu = Instance.new("ScreenGui")
		Menu.Name = "Menu"
		Menu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		Menu.Parent = game.Players.LocalPlayer.PlayerGui

		local Menu_1 = Instance.new("Frame")
		Menu_1.Name = "Menu"
		Menu_1.AnchorPoint = Vector2.new(0.50, 0.50)
		Menu_1.Size = UDim2.new(0.40, 0.00, 0.86, 0.00)
		Menu_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Menu_1.Position = UDim2.new(0.50, 0.00, 1.50, 0.00)
		Menu_1.BorderSizePixel = 0
		Menu_1.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
		Menu_1.Parent = Menu
		Menu_1.Visible = false

		local UICorner = Instance.new("UICorner")
		UICorner.CornerRadius = UDim.new(0.00, 15.00)
		UICorner.Parent = Menu_1

		local Items = Instance.new("ScrollingFrame")
		Items.Name = "Items"
		Items.Active = true
		Items.ScrollingDirection = Enum.ScrollingDirection.Y
		Items.ZIndex = 2
		Items.BorderSizePixel = 0
		Items.CanvasSize = UDim2.new(0.00, 0.00, 1.00, 0.00)
		Items.AutomaticCanvasSize = Enum.AutomaticSize.Y
		Items.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Items.Size = UDim2.new(1.00, 0.00, 0.92, 0.00)
		Items.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Items.ScrollBarThickness = 0
		Items.BackgroundTransparency = 1
		Items.Position = UDim2.new(0.00, 0.00, 0.08, 0.00)
		Items.Parent = Menu_1

		local Realms = Instance.new("TextButton")
		Realms.Name = "Realms"
		Realms.TextWrapped = true
		Realms.BorderSizePixel = 0
		Realms.TextScaled = true
		Realms.BackgroundColor3 = Color3.new(0.21, 0.21, 0.21)
		Realms.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Realms.TextSize = 14
		Realms.Size = UDim2.new(0.00, 200.00, 0.00, 50.00)
		Realms.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Realms.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Realms.Text = "Realms"
		Realms.Parent = Items
		Realms.LayoutOrder = 2

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
		UICorner_1.Parent = Realms

		local UIGridLayout = Instance.new("UIGridLayout")
		UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIGridLayout.CellSize = UDim2.new(0.33, 0.00, 0.33, 0.00)
		UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		UIGridLayout.Parent = Items

		local Resync = Instance.new("TextButton")
		Resync.Name = "Resync"
		Resync.TextWrapped = true
		Resync.BorderSizePixel = 0
		Resync.TextScaled = true
		Resync.BackgroundColor3 = Color3.new(0.21, 0.21, 0.21)
		Resync.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Resync.TextSize = 14
		Resync.Size = UDim2.new(0.00, 200.00, 0.00, 50.00)
		Resync.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Resync.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Resync.Text = "Resync Badges"
		Resync.Parent = Items
		Resync.LayoutOrder = 0

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
		UICorner_1.Parent = Resync

		local FastTravel = Instance.new("TextButton")
		FastTravel.Name = "FastTravel"
		FastTravel.TextWrapped = true
		FastTravel.BorderSizePixel = 0
		FastTravel.TextScaled = true
		FastTravel.BackgroundColor3 = Color3.new(0.21, 0.21, 0.21)
		FastTravel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		FastTravel.TextSize = 14
		FastTravel.Size = UDim2.new(0.00, 200.00, 0.00, 50.00)
		FastTravel.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		FastTravel.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		FastTravel.Text = "Fast Travel"
		FastTravel.Parent = Items
		FastTravel.LayoutOrder = 1

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
		UICorner_1.Parent = FastTravel

		local Credits = Instance.new("TextButton")
		Credits.Name = "Credits"
		Credits.TextWrapped = true
		Credits.BorderSizePixel = 0
		Credits.TextScaled = true
		Credits.BackgroundColor3 = Color3.new(0.21, 0.21, 0.21)
		Credits.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Credits.TextSize = 14
		Credits.Size = UDim2.new(0.00, 200.00, 0.00, 50.00)
		Credits.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Credits.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Credits.Text = "Credits"
		Credits.Parent = Items
		Credits.LayoutOrder = 5

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
		UICorner_1.Parent = Credits

		local Settings = Instance.new("TextButton")
		Settings.Name = "Settings"
		Settings.TextWrapped = true
		Settings.BorderSizePixel = 0
		Settings.TextScaled = true
		Settings.BackgroundColor3 = Color3.new(0.21, 0.21, 0.21)
		Settings.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Settings.TextSize = 14
		Settings.Size = UDim2.new(0.00, 200.00, 0.00, 50.00)
		Settings.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Settings.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Settings.Text = "Settings"
		Settings.Parent = Items
		Settings.LayoutOrder = 3

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
		UICorner_1.Parent = Settings

		local Useless = Instance.new("TextButton")
		Useless.Name = "Useless"
		Useless.TextWrapped = true
		Useless.BorderSizePixel = 0
		Useless.TextScaled = true
		Useless.BackgroundColor3 = Color3.new(0.21, 0.21, 0.21)
		Useless.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Useless.TextSize = 14
		Useless.Size = UDim2.new(0.00, 200.00, 0.00, 50.00)
		Useless.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Useless.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Useless.Text = ""
		Useless.Parent = Items
		Useless.LayoutOrder = 4

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
		UICorner_1.Parent = Useless

		local TextLabel = Instance.new("TextLabel")
		TextLabel.TextWrapped = true
		TextLabel.Interactable = false
		TextLabel.BorderSizePixel = 0
		TextLabel.TextScaled = true
		TextLabel.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		TextLabel.TextSize = 14
		TextLabel.Size = UDim2.new(0.94, 0.00, 0.17, 0.00)
		TextLabel.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		TextLabel.Text = "The Useless Button™ is a registered trademark of The Menu 8000™"
		TextLabel.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		TextLabel.BackgroundTransparency = 1
		TextLabel.Position = UDim2.new(0.03, 0.00, 0.83, 0.00)
		TextLabel.Parent = Useless

		local TextLabel_1 = Instance.new("TextLabel")
		TextLabel_1.TextWrapped = true
		TextLabel_1.Interactable = false
		TextLabel_1.BorderSizePixel = 0
		TextLabel_1.TextScaled = true
		TextLabel_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		TextLabel_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		TextLabel_1.TextSize = 14
		TextLabel_1.Size = UDim2.new(0.94, 0.00, 0.83, 0.00)
		TextLabel_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		TextLabel_1.Text = "The Useless Button™"
		TextLabel_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		TextLabel_1.BackgroundTransparency = 1
		TextLabel_1.Position = UDim2.new(0.03, 0.00, 0.00, 0.00)
		TextLabel_1.Parent = Useless

		local Title = Instance.new("TextLabel")
		Title.Name = "Title"
		Title.TextWrapped = true
		Title.ZIndex = 5
		Title.BorderSizePixel = 0
		Title.TextScaled = true
		Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
		Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Title.AnchorPoint = Vector2.new(0.50, 0.00)
		Title.TextXAlignment = Enum.TextXAlignment.Left
		Title.TextSize = 14
		Title.Size = UDim2.new(0.90, 0.00, 0.08, 0.00)
		Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Title.Text = "The Menu 8000™"
		Title.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Title.BackgroundTransparency = 1
		Title.Position = UDim2.new(0.50, 0.00, 0.00, 0.00)
		Title.Parent = Menu_1

		local Pattern = Instance.new("ImageLabel")
		Pattern.Name = "Pattern"
		Pattern.ScaleType = Enum.ScaleType.Tile
		Pattern.ImageTransparency = 0.800000011920929
		Pattern.Image = "rbxassetid://121480522"
		Pattern.TileSize = UDim2.new(0.00, 45.00, 0.00, 45.00)
		Pattern.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Pattern.BackgroundTransparency = 1
		Pattern.Parent = Menu_1

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
		UICorner_1.Parent = Pattern

		local Open = Instance.new("TextButton")
		Open.Name = "Open"
		Open.TextWrapped = true
		Open.BorderSizePixel = 0
		Open.TextScaled = true
		Open.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
		Open.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		Open.AnchorPoint = Vector2.new(0.50, 0.00)
		Open.TextSize = 14
		Open.Size = UDim2.new(0.08, 0.00, 0.04, 0.00)
		Open.TextColor3 = Color3.new(1.00, 1.00, 1.00)
		Open.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
		Open.Text = "Open Menu"
		Open.Position = UDim2.new(0.05, 0.00, 0.94, 0.00)
		Open.Parent = Menu

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(1.00, 0.00)
		UICorner_1.Parent = Open

		local Pattern_1 = Instance.new("ImageLabel")
		Pattern_1.Name = "Pattern"
		Pattern_1.ScaleType = Enum.ScaleType.Tile
		Pattern_1.ImageTransparency = 0.800000011920929
		Pattern_1.Image = "rbxassetid://121480522"
		Pattern_1.TileSize = UDim2.new(0.00, 45.00, 0.00, 45.00)
		Pattern_1.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
		Pattern_1.BackgroundTransparency = 1
		Pattern_1.Parent = Open

		local UICorner_1 = Instance.new("UICorner")
		UICorner_1.CornerRadius = UDim.new(1.00, 0.00)
		UICorner_1.Parent = Pattern_1
		
		local Tabs = {}
		
		local function CreateMenuTab(Title_Func:string)
			local MenuTab = Instance.new("Frame")
			MenuTab.Name = Title_Func
			MenuTab.AnchorPoint = Vector2.new(0.50, 0.00)
			MenuTab.Size = UDim2.new(1,0,1,0)
			MenuTab.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			MenuTab.Position = UDim2.new(0.50, 0.00, 0.10, 0.00)
			MenuTab.BorderSizePixel = 0
			MenuTab.BackgroundColor3 = Color3.new(0.18, 0.18, 0.18)
			MenuTab.Parent = Menu_1
			MenuTab.Visible = false
			MenuTab.BackgroundTransparency = 1

			local UICorner_1 = Instance.new("UICorner")
			UICorner_1.CornerRadius = UDim.new(0.00, 15.00)
			UICorner_1.Parent = MenuTab

			local Items_1 = Instance.new("ScrollingFrame")
			Items_1.Name = "Items"
			Items_1.Active = true
			Items_1.ScrollingDirection = Enum.ScrollingDirection.Y
			Items_1.ZIndex = 2
			Items_1.BorderSizePixel = 0
			Items_1.CanvasSize = UDim2.new(0.00, 0.00, 1.00, 0.00)
			Items_1.AutomaticCanvasSize = Enum.AutomaticSize.Y
			Items_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Items_1.Size = UDim2.new(1.00, 0.00, 0.92, 0.00)
			Items_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Items_1.ScrollBarThickness = 0
			Items_1.BackgroundTransparency = 1
			Items_1.Position = UDim2.new(0.00, 0.00, 0.08, 0.00)
			Items_1.Parent = MenuTab

			local UIGridLayout_1 = Instance.new("UIGridLayout")
			UIGridLayout_1.SortOrder = Enum.SortOrder.LayoutOrder
			UIGridLayout_1.CellSize = UDim2.new(1.00, 0.00, 0.20, 0.00)
			UIGridLayout_1.Parent = Items_1

			local Title_1 = Instance.new("TextLabel")
			Title_1.Name = "Title"
			Title_1.TextWrapped = true
			Title_1.ZIndex = 5
			Title_1.BorderSizePixel = 0
			Title_1.TextScaled = true
			Title_1.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Title_1.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Title_1.AnchorPoint = Vector2.new(0.50, 0.00)
			Title_1.TextXAlignment = Enum.TextXAlignment.Left
			Title_1.TextSize = 14
			Title_1.Size = UDim2.new(0.90, 0.00, 0.08, 0.00)
			Title_1.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Title_1.Text = Title_Func
			Title_1.TextColor3 = Color3.new(1.00, 1.00, 1.00)
			Title_1.BackgroundTransparency = 1
			Title_1.Position = UDim2.new(0.50, 0.00, -0.10, 0.00)
			Title_1.Parent = MenuTab
			Title_1.TextYAlignment = Enum.TextYAlignment.Top
			
			local Back = Instance.new("TextButton")
			Back.Name = "Back"
			Back.TextWrapped = true
			Back.ZIndex = 2
			Back.BorderSizePixel = 0
			Back.TextScaled = true
			Back.BackgroundColor3 = Color3.new(0.21, 0.21, 0.21)
			Back.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Back.AnchorPoint = Vector2.new(1.00, 0.00)
			Back.TextSize = 14
			Back.Size = UDim2.new(0.3, 0.00, 1, 0.00)
			Back.TextColor3 = Color3.new(1.00, 1.00, 1.00)
			Back.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Back.Text = "Back"
			Back.BackgroundTransparency = 1
			Back.Position = UDim2.new(1, 0.00, 0.00, 0.00)
			Back.Parent = Title_1
			Back.TextXAlignment = Enum.TextXAlignment.Right
			Back.TextYAlignment = Enum.TextYAlignment.Top
			
			Back.MouseButton1Click:Connect(function()
				MenuTab.Visible = false
				Items.Visible = true
				Title.Visible = true
			end)
			
			table.insert(Tabs, MenuTab)
			
			return MenuTab
		end
				
		local function SwitchToMenuTab(Tab:UIBase)
			Items.Visible = false
			Title.Visible = false
			Tab.Visible = true
		end
		
		local function AddSetting(Name, Description, Class, Default, Tab)
			if Class == "Boolean" then
				local Boolean = Instance.new("Frame")
				Boolean.Name = Name
				Boolean.Size = UDim2.new(0.00, 100.00, 0.00, 100.00)
				Boolean.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Boolean.Position = UDim2.new(0.00, 0.00, 0.02, 0.00)
				Boolean.BorderSizePixel = 0
				Boolean.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
				Boolean.Parent = Tab.Items

				local UICorner = Instance.new("UICorner")
				UICorner.CornerRadius = UDim.new(0.10, 0.00)
				UICorner.Parent = Boolean

				local Title = Instance.new("TextLabel")
				Title.Name = "Title"
				Title.TextWrapped = true
				Title.BorderSizePixel = 0
				Title.TextScaled = true
				Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Title.TextXAlignment = Enum.TextXAlignment.Left
				Title.TextSize = 14
				Title.Size = UDim2.new(0.74, 0.00, 0.40, 0.00)
				Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Title.Text = Name
				Title.TextColor3 = Color3.new(1.00, 1.00, 1.00)
				Title.BackgroundTransparency = 1
				Title.Position = UDim2.new(0.03, 0.00, 0.00, 0.00)
				Title.Parent = Boolean

				local Desc = Instance.new("TextLabel")
				Desc.Name = "Desc"
				Desc.TextWrapped = true
				Desc.BorderSizePixel = 0
				Desc.TextScaled = true
				Desc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Desc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Desc.TextXAlignment = Enum.TextXAlignment.Left
				Desc.TextSize = 14
				Desc.Size = UDim2.new(0.74, 0.00, 0.60, 0.00)
				Desc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Desc.Text = Description
				Desc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
				Desc.BackgroundTransparency = 1
				Desc.Position = UDim2.new(0.03, 0.00, 0.40, 0.00)
				Desc.Parent = Boolean

				local Toggle = Instance.new("Frame")
				Toggle.Name = "Toggle"
				Toggle.AnchorPoint = Vector2.new(0.50, 0.50)
				Toggle.Size = UDim2.new(0.16, 0.00, 0.70, 0.00)
				Toggle.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Toggle.Position = UDim2.new(0.85, 0.00, 0.50, 0.00)
				Toggle.BorderSizePixel = 0
				Toggle.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Toggle.Parent = Boolean

				local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
				UIAspectRatioConstraint.Parent = Toggle

				local UICorner_1 = Instance.new("UICorner")
				UICorner_1.CornerRadius = UDim.new(1.00, 1.00)
				UICorner_1.Parent = Toggle

				local Filler = Instance.new("Frame")
				Filler.Name = "Filler"
				Filler.AnchorPoint = Vector2.new(0.50, 0.50)
				Filler.Size = UDim2.new(0.80, 0.00, 0.80, 0.00)
				Filler.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Filler.Position = UDim2.new(0.50, 0.00, 0.50, 0.00)
				Filler.BorderSizePixel = 0
				Filler.BackgroundColor3 = Color3.new(0.38, 1.00, 0.35)
				Filler.Parent = Toggle
				Filler.Visible = Default

				local UIAspectRatioConstraint_1 = Instance.new("UIAspectRatioConstraint")
				UIAspectRatioConstraint_1.Parent = Filler

				local UICorner_1 = Instance.new("UICorner")
				UICorner_1.CornerRadius = UDim.new(1.00, 1.00)
				UICorner_1.Parent = Filler

				local Interact = Instance.new("TextButton")
				Interact.Name = "Interact"
				Interact.BorderSizePixel = 0
				Interact.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Interact.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				Interact.TextSize = 14
				Interact.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
				Interact.TextColor3 = Color3.new(0.00, 0.00, 0.00)
				Interact.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Interact.Text = ""
				Interact.BackgroundTransparency = 1
				Interact.Parent = Toggle

				local Value = Instance.new("BoolValue")
				Value.Name = "Value"
				Value.Parent = Boolean
				Value.Value = Default
				
				Interact.MouseButton1Click:Connect(function()
					Value.Value = not Value.Value
					game.ReplicatedStorage:WaitForChild("FindTheItemsResources").UpdateSetting:FireServer(Name, Value.Value)
					require(script.Parent.Settings).SetSetting(Name, Value.Value)
					
					if Value.Value then
						Filler.Visible = true
					else
						Filler.Visible = false
					end
				end)
				
				Value.Changed:Connect(function()
					Filler.Visible = Value.Value
				end)
			elseif Class == "String" then
				local String = Instance.new("Frame")
				String.Name = Name
				String.Size = UDim2.new(0.00, 100.00, 0.00, 100.00)
				String.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				String.Position = UDim2.new(0.00, 0.00, 0.02, 0.00)
				String.BorderSizePixel = 0
				String.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
				String.Parent = Tab.Items

				local UICorner = Instance.new("UICorner")
				UICorner.CornerRadius = UDim.new(0.10, 0.00)
				UICorner.Parent = String

				local Title = Instance.new("TextLabel")
				Title.Name = "Title"
				Title.TextWrapped = true
				Title.BorderSizePixel = 0
				Title.TextScaled = true
				Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Title.TextXAlignment = Enum.TextXAlignment.Left
				Title.TextSize = 14
				Title.Size = UDim2.new(0.63, 0.00, 0.40, 0.00)
				Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Title.Text = Name
				Title.TextColor3 = Color3.new(1.00, 1.00, 1.00)
				Title.BackgroundTransparency = 1
				Title.Position = UDim2.new(0.03, 0.00, 0.00, 0.00)
				Title.Parent = String

				local Desc = Instance.new("TextLabel")
				Desc.Name = "Desc"
				Desc.TextWrapped = true
				Desc.BorderSizePixel = 0
				Desc.TextScaled = true
				Desc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Desc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Desc.TextXAlignment = Enum.TextXAlignment.Left
				Desc.TextSize = 14
				Desc.Size = UDim2.new(0.63, 0.00, 0.60, 0.00)
				Desc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Desc.Text = Description
				Desc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
				Desc.BackgroundTransparency = 1
				Desc.Position = UDim2.new(0.03, 0.00, 0.40, 0.00)
				Desc.Parent = String

				local TextBox = Instance.new("TextBox")
				TextBox.TextWrapped = true
				TextBox.BorderSizePixel = 0
				TextBox.TextScaled = true
				TextBox.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				TextBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextBox.AnchorPoint = Vector2.new(0.00, 0.50)
				TextBox.TextSize = 14
				TextBox.Size = UDim2.new(0.314, 0,0.667, 0)
				TextBox.TextColor3 = Color3.new(0.00, 0.00, 0.00)
				TextBox.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				TextBox.Text = Default
				TextBox.TextXAlignment = Enum.TextXAlignment.Left
				TextBox.Position = UDim2.new(0.66, 0.00, 0.50, 0.00)
				TextBox.Parent = String

				local UICorner_1 = Instance.new("UICorner")
				UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
				UICorner_1.Parent = TextBox

				local Value = Instance.new("StringValue")
				Value.Name = "Value"
				Value.Parent = String
				Value.Value = Default
				
				Value.Changed:Connect(function()
					TextBox.Text = tostring(Value.Value)
				end)
				
				TextBox.FocusLost:Connect(function()
					Value.Value = TextBox.Text
					TextBox.Text = Value.Value
					game.ReplicatedStorage:WaitForChild("FindTheItemsResources").UpdateSetting:FireServer(Name, Value.Value)
					require(script.Parent.Settings).SetSetting(Name, Value.Value)
				end)
				
				TextBox:GetPropertyChangedSignal("Text"):Connect(function()
					Value.Value = TextBox.Text
				end)
			elseif Class == "Integer" then
				local Int = Instance.new("Frame")
				Int.Name = Name
				Int.Size = UDim2.new(0.00, 100.00, 0.00, 100.00)
				Int.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Int.Position = UDim2.new(0.00, 0.00, 0.02, 0.00)
				Int.BorderSizePixel = 0
				Int.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
				Int.Parent = Tab.Items

				local UICorner = Instance.new("UICorner")
				UICorner.CornerRadius = UDim.new(0.10, 0.00)
				UICorner.Parent = Int

				local Title = Instance.new("TextLabel")
				Title.Name = "Title"
				Title.TextWrapped = true
				Title.BorderSizePixel = 0
				Title.TextScaled = true
				Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Title.TextXAlignment = Enum.TextXAlignment.Left
				Title.TextSize = 14
				Title.Size = UDim2.new(0.63, 0.00, 0.40, 0.00)
				Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Title.Text = Name
				Title.TextColor3 = Color3.new(1.00, 1.00, 1.00)
				Title.BackgroundTransparency = 1
				Title.Position = UDim2.new(0.03, 0.00, 0.00, 0.00)
				Title.Parent = Int

				local Desc = Instance.new("TextLabel")
				Desc.Name = "Desc"
				Desc.TextWrapped = true
				Desc.BorderSizePixel = 0
				Desc.TextScaled = true
				Desc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Desc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Desc.TextXAlignment = Enum.TextXAlignment.Left
				Desc.TextSize = 14
				Desc.Size = UDim2.new(0.63, 0.00, 0.60, 0.00)
				Desc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Desc.Text = Description
				Desc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
				Desc.BackgroundTransparency = 1
				Desc.Position = UDim2.new(0.03, 0.00, 0.40, 0.00)
				Desc.Parent = Int

				local TextBox = Instance.new("TextBox")
				TextBox.TextWrapped = true
				TextBox.BorderSizePixel = 0
				TextBox.TextScaled = true
				TextBox.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				TextBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextBox.AnchorPoint = Vector2.new(0.00, 0.50)
				TextBox.TextSize = 14
				TextBox.Size = UDim2.new(0.239, 0,0.667, 0)
				TextBox.TextColor3 = Color3.new(0.00, 0.00, 0.00)
				TextBox.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				TextBox.Text = tostring(Default)
				TextBox.TextXAlignment = Enum.TextXAlignment.Left
				TextBox.Position = UDim2.new(0.66, 0.00, 0.50, 0.00)
				TextBox.Parent = Int

				local UICorner_1 = Instance.new("UICorner")
				UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
				UICorner_1.Parent = TextBox

				local Up = Instance.new("TextButton")
				Up.Name = "Up"
				Up.BorderSizePixel = 0
				Up.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Up.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Up.TextSize = 14
				Up.Size = UDim2.new(0.06, 0.00, 0.32, 0.00)
				Up.TextColor3 = Color3.new(0.00, 0.00, 0.00)
				Up.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Up.Text = "🔼"
				Up.Position = UDim2.new(0.91, 0.00, 0.17, 0.00)
				Up.Parent = Int

				local UICorner_1 = Instance.new("UICorner")
				UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
				UICorner_1.Parent = Up

				local Down = Instance.new("TextButton")
				Down.Name = "Down"
				Down.BorderSizePixel = 0
				Down.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Down.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Down.TextSize = 14
				Down.Size = UDim2.new(0.06, 0.00, 0.32, 0.00)
				Down.TextColor3 = Color3.new(0.00, 0.00, 0.00)
				Down.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Down.Text = "🔽"
				Down.Position = UDim2.new(0.91, 0.00, 0.52, 0.00)
				Down.Parent = Int

				local UICorner_1 = Instance.new("UICorner")
				UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
				UICorner_1.Parent = Down

				local Value = Instance.new("IntValue")
				Value.Name = "Value"
				Value.Parent = Int
				Value.Value = Default
				
				Value.Changed:Connect(function()
					TextBox.Text = tostring(Value.Value)
				end)
				
				Up.MouseButton1Click:Connect(function()
					Value.Value += 1
					game.ReplicatedStorage:WaitForChild("FindTheItemsResources").UpdateSetting:FireServer(Name, Value.Value)
					require(script.Parent.Settings).SetSetting(Name, Value.Value)
				end)
				
				Down.MouseButton1Click:Connect(function()
					Value.Value -= 1
					game.ReplicatedStorage:WaitForChild("FindTheItemsResources").UpdateSetting:FireServer(Name, Value.Value)
					require(script.Parent.Settings).SetSetting(Name, Value.Value)
				end)
				
				TextBox.FocusLost:Connect(function()
					local succ, err = pcall(function()
						Value.Value = math.round(tonumber(TextBox.Text))
					end)
					
					
					if succ then
						game.ReplicatedStorage:WaitForChild("FindTheItemsResources").UpdateSetting:FireServer(Name, Value.Value)
						require(script.Parent.Settings).SetSetting(Name, Value.Value)
					else
						TextBox.Text = Value.Value
					end
				end)
				
				TextBox:GetPropertyChangedSignal("Text"):Connect(function()
					local succ, err = pcall(function()
						Value.Value = math.round(tonumber(TextBox.Text))
					end)


					if not succ then
						TextBox.Text = Value.Value
					end
				end)
				
				local succ, err = pcall(function()
					Value.Value = math.round(tonumber(TextBox.Text))
				end)


				if not succ then
					TextBox.Text = Value.Value
				end
			elseif Class == "Number" then
				local Number = Instance.new("Frame")
				Number.Name = Name
				Number.Size = UDim2.new(0.00, 100.00, 0.00, 100.00)
				Number.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Number.Position = UDim2.new(0.00, 0.00, 0.02, 0.00)
				Number.BorderSizePixel = 0
				Number.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
				Number.Parent = Tab.Items

				local UICorner = Instance.new("UICorner")
				UICorner.CornerRadius = UDim.new(0.10, 0.00)
				UICorner.Parent = Number

				local Title = Instance.new("TextLabel")
				Title.Name = "Title"
				Title.TextWrapped = true
				Title.BorderSizePixel = 0
				Title.TextScaled = true
				Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Title.TextXAlignment = Enum.TextXAlignment.Left
				Title.TextSize = 14
				Title.Size = UDim2.new(0.63, 0.00, 0.40, 0.00)
				Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Title.Text = Name
				Title.TextColor3 = Color3.new(1.00, 1.00, 1.00)
				Title.BackgroundTransparency = 1
				Title.Position = UDim2.new(0.03, 0.00, 0.00, 0.00)
				Title.Parent = Number

				local Desc = Instance.new("TextLabel")
				Desc.Name = "Desc"
				Desc.TextWrapped = true
				Desc.BorderSizePixel = 0
				Desc.TextScaled = true
				Desc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Desc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Desc.TextXAlignment = Enum.TextXAlignment.Left
				Desc.TextSize = 14
				Desc.Size = UDim2.new(0.63, 0.00, 0.60, 0.00)
				Desc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Desc.Text = Description
				Desc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
				Desc.BackgroundTransparency = 1
				Desc.Position = UDim2.new(0.03, 0.00, 0.40, 0.00)
				Desc.Parent = Number

				local TextBox = Instance.new("TextBox")
				TextBox.TextWrapped = true
				TextBox.BorderSizePixel = 0
				TextBox.TextScaled = true
				TextBox.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				TextBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextBox.AnchorPoint = Vector2.new(0.00, 0.50)
				TextBox.TextSize = 14
				TextBox.Size = UDim2.new(0.239, 0,0.667, 0)
				TextBox.TextColor3 = Color3.new(0.00, 0.00, 0.00)
				TextBox.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				TextBox.Text = tostring(Default)
				TextBox.TextXAlignment = Enum.TextXAlignment.Left
				TextBox.Position = UDim2.new(0.66, 0.00, 0.50, 0.00)
				TextBox.Parent = Number

				local UICorner_1 = Instance.new("UICorner")
				UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
				UICorner_1.Parent = TextBox

				local Up = Instance.new("TextButton")
				Up.Name = "Up"
				Up.BorderSizePixel = 0
				Up.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Up.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Up.TextSize = 14
				Up.Size = UDim2.new(0.06, 0.00, 0.32, 0.00)
				Up.TextColor3 = Color3.new(0.00, 0.00, 0.00)
				Up.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Up.Text = "🔼"
				Up.Position = UDim2.new(0.91, 0.00, 0.17, 0.00)
				Up.Parent = Number

				local UICorner_1 = Instance.new("UICorner")
				UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
				UICorner_1.Parent = Up

				local Down = Instance.new("TextButton")
				Down.Name = "Down"
				Down.BorderSizePixel = 0
				Down.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				Down.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Down.TextSize = 14
				Down.Size = UDim2.new(0.06, 0.00, 0.32, 0.00)
				Down.TextColor3 = Color3.new(0.00, 0.00, 0.00)
				Down.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Down.Text = "🔽"
				Down.Position = UDim2.new(0.91, 0.00, 0.52, 0.00)
				Down.Parent = Number

				local UICorner_1 = Instance.new("UICorner")
				UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
				UICorner_1.Parent = Down

				local Value = Instance.new("NumberValue")
				Value.Name = "Value"
				Value.Parent = Number
				Value.Value = Default
				
				Value.Changed:Connect(function()
					TextBox.Text = tostring(Value.Value)
				end)
				
				Up.MouseButton1Click:Connect(function()
					Value.Value += 1
					game.ReplicatedStorage:WaitForChild("FindTheItemsResources").UpdateSetting:FireServer(Name, Value.Value)
					require(script.Parent.Settings).SetSetting(Name, Value.Value)
				end)

				Down.MouseButton1Click:Connect(function()
					Value.Value -= 1
					game.ReplicatedStorage:WaitForChild("FindTheItemsResources").UpdateSetting:FireServer(Name, Value.Value)
					require(script.Parent.Settings).SetSetting(Name, Value.Value)
				end)

				TextBox.FocusLost:Connect(function()
					local succ, err = pcall(function()
						Value.Value = tonumber(TextBox.Text)
					end)


					if succ then
						game.ReplicatedStorage:WaitForChild("FindTheItemsResources").UpdateSetting:FireServer(Name, Value.Value)
						require(script.Parent.Settings).SetSetting(Name, Value.Value)
					else
						TextBox.Text = Value.Value
					end
				end)
				
				TextBox:GetPropertyChangedSignal("Text"):Connect(function()
					local succ, err = pcall(function()
						Value.Value = tonumber(TextBox.Text)
					end)


					if not succ then
						TextBox.Text = Value.Value
					end
				end)
				
				local succ, err = pcall(function()
					Value.Value = tonumber(TextBox.Text)
				end)


				if not succ then
					TextBox.Text = Value.Value
				end
			end	
		end
		
		local function AddButton(Name, Description, Action, Tab, ButtonText)
			local Button = Instance.new("Frame")
			Button.Name = "Button"
			Button.Size = UDim2.new(0.00, 100.00, 0.00, 100.00)
			Button.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Button.Position = UDim2.new(0.00, 0.00, 0.02, 0.00)
			Button.BorderSizePixel = 0
			Button.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
			Button.Parent = Tab.Items

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0.10, 0.00)
			UICorner.Parent = Button

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.TextWrapped = true
			Title.BorderSizePixel = 0
			Title.TextScaled = true
			Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.TextSize = 14
			Title.Size = UDim2.new(0.63, 0.00, 0.40, 0.00)
			Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Title.Text = Name
			Title.TextColor3 = Color3.new(1.00, 1.00, 1.00)
			Title.BackgroundTransparency = 1
			Title.Position = UDim2.new(0.03, 0.00, 0.00, 0.00)
			Title.Parent = Button

			local Desc = Instance.new("TextLabel")
			Desc.Name = "Desc"
			Desc.TextWrapped = true
			Desc.BorderSizePixel = 0
			Desc.TextScaled = true
			Desc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Desc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Desc.TextXAlignment = Enum.TextXAlignment.Left
			Desc.TextSize = 14
			Desc.Size = UDim2.new(0.63, 0.00, 0.60, 0.00)
			Desc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Desc.Text = Description
			Desc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
			Desc.BackgroundTransparency = 1
			Desc.Position = UDim2.new(0.03, 0.00, 0.40, 0.00)
			Desc.Parent = Button

			local Interact = Instance.new("TextButton")
			Interact.Name = ButtonText
			Interact.TextWrapped = true
			Interact.BorderSizePixel = 0
			Interact.TextScaled = true
			Interact.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Interact.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Interact.AnchorPoint = Vector2.new(0.00, 0.50)
			Interact.TextSize = 14
			Interact.Size = UDim2.new(0.00, 200.00, 0.00, 65.00)
			Interact.TextColor3 = Color3.new(0.00, 0.00, 0.00)
			Interact.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Interact.Text = "Interact"
			Interact.Position = UDim2.new(0.66, 0.00, 0.50, 0.00)
			Interact.Parent = Button
			
			Interact.MouseButton1Click:Connect(Action)
			
			local UICorner_1 = Instance.new("UICorner")
			UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
			UICorner_1.Parent = Interact
			
			return Button
		end

		local function ChangeOpenButton(text)
			Open.MaxVisibleGraphemes = string.len(Open.Text)

			local OpenButton = TweenService:Create(
				Open,
				TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
				{MaxVisibleGraphemes = 0}
			)

			OpenButton:Play()

			OpenButton.Completed:Connect(function()
				Open.Text = text
				local ShowOpenButton = TweenService:Create(
					Open,
					TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
					{MaxVisibleGraphemes = string.len(text)}
				)
				ShowOpenButton:Play()
			end)
		end
		
		local function AddRealmButton(Name, RealmInfo, Tab, Unlocked)
			local Realm = Instance.new("Frame")
			Realm.Name = Name
			Realm.Size = UDim2.new(0.00, 100.00, 0.00, 100.00)
			Realm.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Realm.Position = UDim2.new(0.00, 0.00, 0.02, 0.00)
			Realm.BorderSizePixel = 0
			Realm.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
			Realm.Parent = Tab.Items
			Realm.LayoutOrder = RealmInfo.Sort

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0.10, 0.00)
			UICorner.Parent = Realm

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.TextWrapped = true
			Title.BorderSizePixel = 0
			Title.TextScaled = true
			Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.TextSize = 14
			Title.Size = UDim2.new(0.51, 0.00, 0.40, 0.00)
			Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Title.Text = Name
			Title.TextColor3 = Color3.new(1.00, 1.00, 1.00)
			Title.BackgroundTransparency = 1
			Title.Position = UDim2.new(0.15, 0.00, 0.00, 0.00)
			Title.Parent = Realm

			local Desc = Instance.new("TextLabel")
			Desc.Name = "Desc"
			Desc.TextWrapped = true
			Desc.BorderSizePixel = 0
			Desc.TextScaled = true
			Desc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Desc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Desc.TextXAlignment = Enum.TextXAlignment.Left
			Desc.TextSize = 14
			Desc.Size = UDim2.new(0.51, 0.00, 0.60, 0.00)
			Desc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Desc.Text = RealmInfo.Hint
			Desc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
			Desc.BackgroundTransparency = 1
			Desc.Position = UDim2.new(0.15, 0.00, 0.40, 0.00)
			Desc.Parent = Realm

			local Teleport = Instance.new("TextButton")
			Teleport.Name = "Teleport"
			Teleport.TextWrapped = true
			Teleport.BorderSizePixel = 0
			Teleport.TextScaled = true
			Teleport.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Teleport.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Teleport.AnchorPoint = Vector2.new(0.00, 0.50)
			Teleport.TextSize = 14
			Teleport.Size = UDim2.new(0.29, 0.00, 0.74, 0.00)
			Teleport.TextColor3 = Color3.new(0.00, 0.00, 0.00)
			Teleport.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Teleport.Text = "Enter"
			Teleport.Position = UDim2.new(0.68, 0.00, 0.50, 0.00)
			Teleport.Parent = Realm
			Teleport.Interactable = Unlocked

			local UICorner_1 = Instance.new("UICorner")
			UICorner_1.CornerRadius = UDim.new(0.10, 0.00)
			UICorner_1.Parent = Teleport

			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.BorderSizePixel = 0
			Icon.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Icon.Image = RealmInfo.Icon
			Icon.Size = UDim2.new(0.11, 0.00, 0.80, 0.00)
			Icon.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Icon.Position = UDim2.new(0.03, 0.00, 0.13, 0.00)
			Icon.Parent = Realm
			
			if Unlocked == false then
				Teleport.Visible = false
				Desc.Size = UDim2.new(0.8, 0.00, 0.60, 0.00)
				Title.Size = UDim2.new(0.8, 0.00, 0.40, 0.00)
			end

			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			UIAspectRatioConstraint.Parent = Icon

			local UICorner_1 = Instance.new("UICorner")
			UICorner_1.CornerRadius = UDim.new(1.00, 0.00)
			UICorner_1.Parent = Icon
			
			Teleport.MouseButton1Click:Connect(function()
				local Loading = Instance.new("ScreenGui")
				Loading.Name = "Loading"
				Loading.IgnoreGuiInset = true
				Loading.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
				Loading.ScreenInsets = Enum.ScreenInsets.None
				Loading.Parent = game.Players.LocalPlayer.PlayerGui

				local Background = Instance.new("Frame")
				Background.Name = "Background"
				Background.Size = UDim2.new(1.00, 0.00, 1.00, 0.00)
				Background.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				Background.BorderSizePixel = 0
				Background.BackgroundColor3 = Color3.new(0.10, 0.10, 0.10)
				Background.Parent = Loading

				local TextLabel = Instance.new("TextLabel")
				TextLabel.TextWrapped = true
				TextLabel.BorderSizePixel = 0
				TextLabel.AnchorPoint = Vector2.new(0.5,0.5)
				TextLabel.TextScaled = true
				TextLabel.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
				TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextLabel.TextSize = 14
				TextLabel.Size = UDim2.new(1,0,1,0)
				TextLabel.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
				TextLabel.Text = "Entering realm..."
				TextLabel.TextColor3 = Color3.new(1.00, 1.00, 1.00)
				TextLabel.BackgroundTransparency = 1
				TextLabel.Position = UDim2.new(0.5,0,0.5,0)
				TextLabel.Parent = Background
				
				game.ReplicatedStorage:WaitForChild("FindTheItemsResources").TeleportRealm:FireServer(Name)
			end)
		end
		
		local function AddText(Name, Description, EntryIcon, Tab)
			local TextFrame = Instance.new("Frame")
			TextFrame.Name = Name
			TextFrame.Size = UDim2.new(0.00, 100.00, 0.00, 100.00)
			TextFrame.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			TextFrame.Position = UDim2.new(0.00, 0.00, 0.02, 0.00)
			TextFrame.BorderSizePixel = 0
			TextFrame.BackgroundColor3 = Color3.new(0.08, 0.08, 0.08)
			TextFrame.Parent = Tab.Items

			local UICorner = Instance.new("UICorner")
			UICorner.CornerRadius = UDim.new(0.10, 0.00)
			UICorner.Parent = TextFrame

			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.TextWrapped = true
			Title.BorderSizePixel = 0
			Title.TextScaled = true
			Title.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Title.TextXAlignment = Enum.TextXAlignment.Left
			Title.TextSize = 14
			Title.Size = UDim2.new(0.8, 0.00, 0.40, 0.00)
			Title.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Title.Text = Name
			Title.TextColor3 = Color3.new(1.00, 1.00, 1.00)
			Title.BackgroundTransparency = 1
			Title.Position = UDim2.new(0.15, 0.00, 0.00, 0.00)
			Title.Parent = TextFrame

			local Desc = Instance.new("TextLabel")
			Desc.Name = "Desc"
			Desc.TextWrapped = true
			Desc.BorderSizePixel = 0
			Desc.TextScaled = true
			Desc.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Desc.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Desc.TextXAlignment = Enum.TextXAlignment.Left
			Desc.TextSize = 14
			Desc.Size = UDim2.new(0.8, 0.00, 0.60, 0.00)
			Desc.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Desc.Text = Description
			Desc.TextColor3 = Color3.new(1.00, 1.00, 1.00)
			Desc.BackgroundTransparency = 1
			Desc.Position = UDim2.new(0.15, 0.00, 0.40, 0.00)
			Desc.Parent = TextFrame

			local Icon = Instance.new("ImageLabel")
			Icon.Name = "Icon"
			Icon.BorderSizePixel = 0
			Icon.BackgroundColor3 = Color3.new(1.00, 1.00, 1.00)
			Icon.Image = EntryIcon
			Icon.Size = UDim2.new(0.11, 0.00, 0.80, 0.00)
			Icon.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Icon.Position = UDim2.new(0.03, 0.00, 0.13, 0.00)
			Icon.Parent = TextFrame
			
			local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
			UIAspectRatioConstraint.Parent = Icon

			local UICorner_1 = Instance.new("UICorner")
			UICorner_1.CornerRadius = UDim.new(1.00, 0.00)
			UICorner_1.Parent = Icon
		end
		
		local function AddSeperator(Tab)
			local Frame = Instance.new("Frame")
			Frame.Name = "Seperator"
			Frame.Size = UDim2.new(1,0,0.05,0)
			Frame.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Frame.BorderSizePixel = 0
			Frame.BackgroundTransparency = 1
			Frame.Parent = Tab.Items
		end
		
		local function AddHeader(Text, Tab)
			local Label = Instance.new("TextLabel")
			Label.Name = "Seperator"
			Label.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			Label.TextScaled = true
			Label.TextWrapped = true
			Label.Size = UDim2.new(1,0,0.05,0)
			Label.BorderColor3 = Color3.new(0.00, 0.00, 0.00)
			Label.BorderSizePixel = 0
			Label.BackgroundTransparency = 1
			Label.Parent = Tab.Items
			Label.Text = Text
			Label.TextColor3 = Color3.new(1,1,1)
			Label.TextXAlignment = Enum.TextXAlignment.Center
		end
		
		local Opened = false
		local OpenCooldown = false
		
		if require(script.Parent.Parent.Configurations.FastTravelPoints) ~= nil and require(script.Parent.Parent.Configurations.FastTravelPoints) ~= {} then
			local FastTravelTab = CreateMenuTab("Fast Travel")
			FastTravel.MouseButton1Click:Connect(function()
				SwitchToMenuTab(FastTravelTab)
			end)
			
			local FastTravelPoints = require(script.Parent.Parent.Configurations.FastTravelPoints)

			for i, v in FastTravelPoints do
				AddButton(i, ("Teleport to %s"):format(tostring(i)), function()
					if game.Players.LocalPlayer.Character then
						game.Players.LocalPlayer.Character:PivotTo(CFrame.new(v))
					end
				end, FastTravelTab, "Teleport")
			end
		end

		local RealmsTab = CreateMenuTab("Realms")
		local SettingsTab = CreateMenuTab("Settings")
		local CreditsTab = CreateMenuTab("Credits")
		
		Resync.MouseButton1Click:Connect(function()
			game.ReplicatedStorage:WaitForChild("FindTheItemsResources").ResyncBadges:FireServer()
		end)
		
		Realms.MouseButton1Click:Connect(function()
			SwitchToMenuTab(RealmsTab)
			
			for i, v in RealmsTab.Items:GetChildren() do
				if v:IsA("Frame") then
					v:Destroy()
				end
			end
			
			local UnlockedRealms = game.ReplicatedStorage:WaitForChild("FindTheItemsResources").RequestRealms:InvokeServer()
			
			for i, v in require(script.Parent.Parent.Configurations.Realms) do
				if UnlockedRealms[i] == true then
					AddRealmButton(i, v, RealmsTab, true)
				else
					AddRealmButton(i, v, RealmsTab, false)
				end
			end
		end)
		
		Settings.MouseButton1Click:Connect(function()
			SwitchToMenuTab(SettingsTab)
		end)
		
		Credits.MouseButton1Click:Connect(function()
			SwitchToMenuTab(CreditsTab)
		end)
		
		local Positions = {}
		
		for i, v in require(script.Parent.Parent.Configurations.Credits) do
			if not Positions[v.Role] then
				Positions[v.Role] = {}
				Positions[v.Role][v.UID] = v
			else
				Positions[v.Role][v.UID] = v
			end
		end
		
		for i, v in Positions do
			AddHeader(i, CreditsTab)
			for i2, v2 in v do
				local Thumbnail = "rbxassetid://9994130132"
				pcall(function()
					Thumbnail = game.Players:GetUserThumbnailAsync(v2.UID, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
				end)
				AddText(v2.Name, v2.Role, Thumbnail, CreditsTab)
			end
			AddSeperator(CreditsTab)
		end
		
		local Thumbnail = "rbxassetid://9994130132"
		pcall(function()
			Thumbnail = game.Players:GetUserThumbnailAsync(1194829482, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size180x180)
		end)
		
		AddHeader("Find The Items Kit", CreditsTab)
		AddText("meteorbee", "Creator of the Find The Items kit", Thumbnail, CreditsTab)

		local SavedSettings = game.ReplicatedStorage:WaitForChild("FindTheItemsResources").RequestSettings:InvokeServer()
		
		local SettingsTable = require(script.Parent.Parent.Configurations.Settings)
		
		for i, v in SettingsTable do
			if SavedSettings[i] == nil then
				AddSetting(i, v.Desc, v.Class, v.Default, SettingsTab)
				require(script.Parent.Settings).SetSetting(i, v.Default)
			else
				AddSetting(i, v.Desc, v.Class, SavedSettings[i], SettingsTab)
				require(script.Parent.Settings).SetSetting(i, SavedSettings[i])
			end
		end
				
		Open.MouseButton1Click:Connect(function()
			if OpenCooldown then return end
			OpenCooldown = true
			task.delay(1, function()
				OpenCooldown = false
			end)
			Opened = not Opened

			if Opened then
				local OpenTween = TweenService:Create(
					Menu_1,
					TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
					{Position = UDim2.new(0.50, 0.00, 0.50, 0.00)}
				)

				Menu_1.Visible = true

				OpenTween:Play()

				OpenTween.Completed:Connect(function()
					ChangeOpenButton("Close Menu")
				end)
			else
				local CloseTween = TweenService:Create(
					Menu_1,
					TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
					{Position = UDim2.new(0.50, 0.00, 1.50, 0.00)}
				)

				CloseTween:Play()

				CloseTween.Completed:Connect(function()
					Menu_1.Visible = false
					ChangeOpenButton("Open Menu")
				end)
			end
		end)
		
	end)
	
	if not succ then
		warn("Error with the menu:",err)
	end
end

return Shared