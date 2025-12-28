local Shared = {}

function Shared.Init()
	print("Initializing meteorbee's Find The Items kit!")
	
	task.spawn(function()
		repeat
			local succ1, err1 = pcall(function()
				game:GetService("StarterGui"):SetCore("BadgeNotificationsEnabled", false)
			end)
			task.wait(0.1)
		until succ1
	end)
	
	local succ, err = pcall(function()
		require(script.Parent.Client.CreateGUIs).CreateNotifications()
		require(script.Parent.Client.CreateGUIs).CreateDex()
		require(script.Parent.Client.CreateGUIs).CreateMenu()
	end)
	
	if not succ then
		warn("An error occured while initializing client:", err)
	end
end

return Shared 
