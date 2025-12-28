local RunService = game:GetService("RunService")

if RunService:IsServer() == false then
	error("FindTheItems' server util module is running on the client!")
end

local Shared = {}

return Shared