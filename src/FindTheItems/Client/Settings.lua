local Shared = {}

local Settings = {}

function Shared.GetSetting(name)
	return Settings[name]
end

function Shared.SetSetting(name, val)
	Settings[name] = val
end

return Shared