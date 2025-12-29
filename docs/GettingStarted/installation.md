Start by importing the RBXM file into ReplicatedStorage

(1) Step 1
(2) Step 2
{ .annotate }

1. ![Guide](../Resources/Installation-1.png)
2. ![Guide](../Resources/Installation-2.png)

Then make an Items folder in ReplicatedStorage. Name this something like Items, or Creatures, or whatever you'll be collecting in your game

(1) Step 1
(2) Step 2
{ .annotate }

1. ![Guide](../Resources/Installation-3.png)
2. ![Guide](../Resources/Installation-4.png)

Them make a Script in ServerScriptService, Name this something like "FindTheItems" or Creatures, or whatever you'll be collecting in your game. Then put the following code into the script

```luau title="FindTheItems.lua" linenums="1"
local ITEMSPATH = game.ReplicatedStorage.Items -- Replace with the path for your items folder

local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:InitializeItemsIn(ITEMSPATH)
```

(1) Step 1
(2) Step 2
(3) Step 3
{ .annotate }

1. ![Guide](../Resources/Installation-5.png)
2. ![Guide](../Resources/Installation-6.png)
3. ![Guide](../Resources/Installation-7.png)

Then make a script in StarterPlayer/StarterPlayerScripts called FindTheItemsClient or Creatures, or whatever you'll be collecting in your game. Then put the following code into the script

```luau title="FindTheItemsClient.lua" linenums="1"
local FindTheItemsClient = require(game.ReplicatedStorage:WaitForChild("FindTheItems").ClientModule)

FindTheItemsClient.Init()
```

(1) Step 1
(2) Step 2
(3) Step 3
{ .annotate }

1. ![Guide](../Resources/Installation-8.png)
2. ![Guide](../Resources/Installation-9.png)
3. ![Guide](../Resources/Installation-10.png)