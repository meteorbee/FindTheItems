local RunService = game:GetService("RunService")
local Datastore = game:GetService("DataStoreService"):GetDataStore("FindTheItemsKit:PlayerSaves")
local Config = require(script.Parent.Parent.Configurations.Saving)

if RunService:IsServer() == false then
	error("FindTheItems' datastorage module is running on the client!")
end

if RunService:IsStudio() then
	if Config.SeperateTestingAndProductionEnviroments == true then
		Config.Key = "Testing"
	end
end

local CurrentPlayers = {}

local Shared = {}

function Shared.AddPlayer(plr:Player)
	local succ, err = pcall(function()
		local PlayerData = Datastore:GetAsync(Config.Key..":"..tostring(plr.UserId))
		if PlayerData == nil or PlayerData == {} then
			PlayerData = require(script.SaveTemplate)
			PlayerData.StorageInfo.FirstSave = tick()
		end
		for i, v in require(script.Parent.Parent.Configurations.Realms) do
			if v.UnlockedByDefault then
				PlayerData.Realms[i] = true
			end
		end
		CurrentPlayers[tostring(plr.UserId)] = PlayerData
	end)
	if not succ then
		warn(err)
	end
end

function Shared.GetPlayerData(plr:Player)
	return CurrentPlayers[tostring(plr.UserId)]
end

function Shared.SetPlayerData(plr:Player, data:any)
	CurrentPlayers[tostring(plr.UserId)] = data
end

function Shared.SavePlayer(plr:Player)
	local succ, err = pcall(function()
		local Save = CurrentPlayers[tostring(plr.UserId)]
		
		Save.StorageInfo.LastSave = tick()
		Datastore:SetAsync(Config.Key..":"..tostring(plr.UserId), Save)
	end)
	if not succ then
		warn(err)
	end
end

function Shared.RemoveAndSaveForPlayer(plr:Player)
	Shared.SavePlayer(plr)
	CurrentPlayers[tostring(plr.UserId)] = nil
end

function Shared.RemovePlayer(plr:Player)
	CurrentPlayers[tostring(plr.UserId)] = nil
end

return Shared