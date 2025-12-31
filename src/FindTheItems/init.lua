-- This is the main module for the Find The Items kit
-- DO NOT TOUCH unless you know what you are doing!!!

-- Types
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

export type FindTheItems = {
	PlayerAdded: RBXScriptConnection,
	PlayerRemoving: RBXScriptConnection,
	
	InitializeItemsIn: (self: FindTheItems, Folder?) -> (),
	SetupResources: (self: FindTheItems) -> (),
	GiveItem: (self: FindTheItems, Player, Item) -> (),
	PlayerOwnsItem: (self: FindTheItems, Player, string) -> (),
	SetStat: (self: FindTheItems, Player, string, any, "Year" | "AllTime") -> (),
	GetStat: (self: FindTheItems, Player, string, "Year" | "AllTime") -> (any),
	AddToStat: (self: FindTheItems, Player, string, any) -> (),
}

-- Modules and Services
local RunService = game:GetService("RunService")
local Util = require(script.Server.Util)
local DataStorage = require(script.Server.DataStorageModule)
local PickupInfo = require(script.Configurations.Pickups)
local Info = require(script.Configurations.Info)

-- Defaults
local DefaultItem:Item = {
	Hitbox = nil,
	DisplayName = "My Awesome Item",
	ID = "MY_AWESOME_ITEM",
	Rarity = "Easy",
	Location = "Grasslands",
	Desc = "My Awesome Description!",
	Icon = "rbxassetid://14564074061",
	Realm = "Mainlands",
	Hint = "???",
	Badge = 0,
	Creator = game.Players:GetNameFromUserIdAsync(game.CreatorId),
	Pickup = function(Player:Player, Info:Item) : boolean
		return true
	end
}

-- Runcontext check
if RunService:IsServer() == false then
	error("FindTheItems' server module is running on the client!")
end

-- Module begins here
local Shared = {}

Shared.__index = Shared

local Initialized:{Item} = nil
local CurrentClass:FindTheItems = nil
local PlayersOnCooldown:{boolean} = {}
local PlayersOnResyncCooldown:{boolean} = {}
local PlayerTimesStarted:{number} = {}

function Shared.new() : FindTheItems
	if RunService:IsServer() == false then
		return
	end
	print("Initializing Find The Items kit version: "..require(script.Version))
	if CurrentClass ~= nil then warn("A FindTheItems class already exists! Make sure there is only one") return end
	
	local self = setmetatable({}, Shared)
	
	-- Connect events
	self.PlayerAdded = game.Players.PlayerAdded:Connect(function(plr)
		DataStorage.AddPlayer(plr)
		PlayerTimesStarted[tostring(plr.UserId)] = tick()
		PlayersOnCooldown[tostring(plr.UserId)] = false
		PlayersOnResyncCooldown[tostring(plr.UserId)] = false
	end)
	
	for i, plr in game.Players:GetPlayers() do
		DataStorage.AddPlayer(plr)
		PlayerTimesStarted[tostring(plr.UserId)] = tick()
		PlayersOnCooldown[tostring(plr.UserId)] = false
		PlayersOnResyncCooldown[tostring(plr.UserId)] = false
	end
	
	self.PlayerRemoving = game.Players.PlayerRemoving:Connect(function(plr)
		Shared:AddToStat(plr, "Playtime", tick() - PlayerTimesStarted[tostring(plr.UserId)])
		DataStorage.RemoveAndSaveForPlayer(plr)
		PlayerTimesStarted[tostring(plr.UserId)] = nil
		PlayersOnCooldown[tostring(plr.UserId)] = nil
		PlayersOnResyncCooldown[tostring(plr.UserId)] = nil
	end)
	
	self:SetupResources()
	
	CurrentClass = self
	
	return self
end

function Shared:SetupResources()
	local InstanceFolder = Instance.new("Folder")
	InstanceFolder.Parent = game.ReplicatedStorage
	InstanceFolder.Name = "FindTheItemsResources"

	local RequestItemsEvent = Instance.new("RemoteFunction")
	RequestItemsEvent.Parent = InstanceFolder
	RequestItemsEvent.Name = "RequestItems"
	
	local RequestSettingsEvent = Instance.new("RemoteFunction")
	RequestSettingsEvent.Parent = InstanceFolder
	RequestSettingsEvent.Name = "RequestSettings"
	
	local RequestRealmsEvent = Instance.new("RemoteFunction")
	RequestRealmsEvent.Parent = InstanceFolder
	RequestRealmsEvent.Name = "RequestRealms"
	
	local ShowNotificationEvent = Instance.new("RemoteEvent")
	ShowNotificationEvent.Parent = InstanceFolder
	ShowNotificationEvent.Name = "ShowNotification"
	
	local TeleportRealmEvent = Instance.new("RemoteEvent")
	TeleportRealmEvent.Parent = InstanceFolder
	TeleportRealmEvent.Name = "TeleportRealm"

	local ResyncBadgesEvent = Instance.new("RemoteEvent")
	ResyncBadgesEvent.Parent = InstanceFolder
	ResyncBadgesEvent.Name = "ResyncBadges"
	
	local UpdateSettingEvent = Instance.new("RemoteEvent")
	UpdateSettingEvent.Parent = InstanceFolder
	UpdateSettingEvent.Name = "UpdateSetting"
	
	ResyncBadgesEvent.OnServerEvent:Connect(function(plr)
		if PlayersOnResyncCooldown[tostring(plr.UserId)] == true then ShowNotificationEvent:FireClient(plr, "Resync", "You are on resync cooldown, wait up to 1 minute and retry.") return end
		PlayersOnResyncCooldown[tostring(plr.UserId)] = true
		task.delay(60, function()
			PlayersOnResyncCooldown[tostring(plr.UserId)] = false
		end)
		local succ, err = pcall(function()
			local UserData = DataStorage.GetPlayerData(plr)
			
			for i, v in UserData.UnlockedItems do
				if Initialized[i] then
					if Initialized[i].Badge ~= 0 and Initialized[i].Badge ~= nil then
						game:GetService("BadgeService"):AwardBadgeAsync(plr.UserId, Initialized[i].Badge)
					end
				end
			end
		end)
	end)
	
	TeleportRealmEvent.OnServerEvent:Connect(function(plr, realm)
		local UserData = DataStorage.GetPlayerData(plr)
		
		if UserData.Realms[realm] then
			local Loading = Instance.new("ScreenGui")
			Loading.Name = "Loading"
			Loading.IgnoreGuiInset = true
			Loading.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			Loading.ScreenInsets = Enum.ScreenInsets.None
			
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

			local succ, err = pcall(function()
				game:GetService("TeleportService"):Teleport(require(script.Configurations.Realms)[realm].PlaceID, plr, nil, Loading)
			end)
			
			if not succ then
				warn(err)
			end
		end
	end)
	
	RequestSettingsEvent.OnServerInvoke = function(plr)
		local UserData = DataStorage.GetPlayerData(plr)
		local Settings = UserData.Settings or {}
		return Settings
	end
	
	RequestRealmsEvent.OnServerInvoke = function(plr)
		local UserData = DataStorage.GetPlayerData(plr)
		
		local Realms = UserData.Realms or {}
		return Realms
	end
	
	UpdateSettingEvent.OnServerEvent:Connect(function(plr, setting, value)
		local UserData = DataStorage.GetPlayerData(plr)
		
		UserData.Settings[setting] = value
		
		DataStorage.SetPlayerData(plr, UserData)
	end)
	
	RequestItemsEvent.OnServerInvoke = function(plr)
		local BuiltTable = {}
		local UserData = DataStorage.GetPlayerData(plr)
		
		local succ, err = pcall(function()
			for i, v:Item in Initialized do
				local Build = v

				if UserData.UnlockedItems[v.ID] then
					Build.Owned = true
				else
					Build.Owned = false
				end

				BuiltTable[v.ID] = Build
			end
			
			local Looptable = BuiltTable

			for i, v in UserData.UnlockedItems do
				if Looptable[i] == nil then
					local Missing:Item = {
						Hitbox = nil,
						DisplayName = "Missing Item",
						ID = "MISSING_ITEM",
						Rarity = "Missing",
						Location = "???",
						Desc = ("This %s could not be found. This could be due to it being removed from the game, but still there in your save file. Your %s is safe. The %s's ID was: %s."):format(Info.ItemNames, Info.ItemNames, Info.ItemNames, tostring(i)),
						Icon = "rbxassetid://9994130132",
						Realm = "???",
						Hint = "???",
						Creator = "???",
						Owned = true,
					}

					BuiltTable[i] = Missing
				end
			end
		end)
		
		if not succ then
			warn(err)
		end
		
		return BuiltTable
	end
end

function Shared:PlayerOwnsItem(plr:Player, id:string)
	local PlayerData = DataStorage.GetPlayerData(plr)
	if PlayerData.UnlockedItems[id] then
		return true
	else
		return false
	end
end

function Shared:SetStat(plr: Player, stat: string, value: any, scope: "Year" | "AllTime")
	local PlayerData = DataStorage.GetPlayerData(plr)

	if scope == "AllTime" then
		PlayerData.Stats.AllTime = PlayerData.Stats.AllTime or {}
		PlayerData.Stats.AllTime[stat] = value
		DataStorage.SetPlayerData(plr, PlayerData)
		return
	end
	
	local yearKey = tostring(os.date("!*t").year)
	
	PlayerData.Stats = PlayerData.Stats or {}
	PlayerData.Stats[yearKey] = PlayerData.Stats[yearKey] or {}
	PlayerData.Stats[yearKey][stat] = value
end

function Shared:GetStat(plr: Player, stat: string, scope: "Year" | "AllTime")
	local PlayerData = DataStorage.GetPlayerData(plr)
	if not PlayerData.Stats then
		return nil
	end

	if scope == "AllTime" then
		return PlayerData.Stats.AllTime and PlayerData.Stats.AllTime[stat]
	end

	local yearKey = tostring(os.date("!*t").year)
	return PlayerData.Stats[yearKey] and PlayerData.Stats[yearKey][stat]
end

function Shared:AddToStat(plr: Player, stat: string, value: number)
	local PlayerData = DataStorage.GetPlayerData(plr)
	local yearKey = tostring(os.date("!*t").year)

	PlayerData.Stats = PlayerData.Stats or {}
	PlayerData.Stats.AllTime = PlayerData.Stats.AllTime or {}
	PlayerData.Stats[yearKey] = PlayerData.Stats[yearKey] or {}

	PlayerData.Stats[yearKey][stat] =
		(PlayerData.Stats[yearKey][stat] or 0) + value

	PlayerData.Stats.AllTime[stat] =
		(PlayerData.Stats.AllTime[stat] or 0) + value

	DataStorage.SetPlayerData(plr, PlayerData)
end

function Shared:GiveItem(plr:Player, item:Item)
	local PlayerData = DataStorage.GetPlayerData(plr)
	PlayerData.UnlockedItems[item.ID] = true

	Shared:AddToStat(plr, "ItemsCollected", 1)
	
	local HighestDifficultyAlltime = Shared:GetStat(plr, "HighestDifficulty", "AllTime") or 0
		
	if require(script.Configurations.Rarities)[item.Rarity].Sort > HighestDifficultyAlltime then
		Shared:SetStat(plr, "HighestDifficulty", require(script.Configurations.Rarities)[item.Rarity].Sort, "AllTime")
	end
	
	local HighestDifficultyYear = Shared:GetStat(plr, "HighestDifficulty", "Year") or 0

	if require(script.Configurations.Rarities)[item.Rarity].Sort > HighestDifficultyYear then
		Shared:SetStat(plr, "HighestDifficulty", require(script.Configurations.Rarities)[item.Rarity].Sort, "Year")
	end
	
	game.ReplicatedStorage.FindTheItemsResources.ShowNotification:FireClient(plr, item.DisplayName, ("You got %s. You can now view it in the dex!"):format(item.DisplayName), item.Icon)
	if item.Badge ~= 0 and item.Badge ~= nil then
		game:GetService("BadgeService"):AwardBadgeAsync(plr.UserId, item.Badge)
	end
	DataStorage.SetPlayerData(PlayerData)
end

function Shared:InitializeItemsIn(dir:Folder?)
	local succ, err = pcall(function()
		if Initialized ~= nil then warn("Already initialized items") return end
		Initialized = {}
		-- Loop through the dir
		for i, v in dir:GetChildren() do
			if v:IsA("ModuleScript") then
				local Module:Item = require(v)
				Module.ID = string.upper(Module.ID)
				if Module.Hitbox ~= nil then
					local Connection = Module.Hitbox.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild(PickupInfo.CharacterControllerName) then
							local Player = game.Players:GetPlayerFromCharacter(hit.Parent)
							
							if not Module.Pickup then
								Module.Pickup = function(Player:Player, Info:Item) : boolean
									return true
								end
							end
							
							if Module.Pickup(Player, Module) then
								if PlayersOnCooldown[tostring(Player.UserId)] == true then return end
								PlayersOnCooldown[tostring(Player.UserId)] = true
								task.delay(1, function()
									PlayersOnCooldown[tostring(Player.UserId)] = false
								end)
								if not self:PlayerOwnsItem(Player, Module.ID) then
									Shared:GiveItem(Player, Module)
								else
									warn(Player,"already owns this item")
									game.ReplicatedStorage.FindTheItemsResources.ShowNotification:FireClient(Player, Module.DisplayName, "You already have this "..require(script.Configurations.Info).ItemNames, Module.Icon)
								end
							else
								print("Cannot pick up")
							end
						end
					end)
					Module.Connection = Connection
				end
				table.insert(Initialized, Module)
			else
				warn("Found Instance of class",v,"in the Initialization directory. Make sure that", dir, "only contains modulescripts")
				continue
			end
		end
	end)
	
	if not succ then
		warn("An error occured while initializing items:", err)
	end
end

return Shared