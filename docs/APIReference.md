# API Reference

## Server
### FindTheItems.new() : FindTheItems 
<span class="md-tag md-tag--secondary">Server Only</span>
This creates a new FindTheItems class
```luau title="FindTheItemsServer.lua" linenums="1" hl_lines="3"
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)

local FindTheItems = FindTheItemsKit.new()
```

### FindTheItems:InitializeItemsIn(dir: Folder) 
<span class="md-tag md-tag--secondary">Server Only</span>
Run this to initialize all the items in dir.
```luau title="FindTheItemsServer.lua" linenums="1" hl_lines="4"
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:InitializeItemsIn(game.ReplicatedStorage.Items)
```

### FindTheItems:GiveItem(plr: Player, item: Item) 
<span class="md-tag md-tag--secondary">Server Only</span>
Gives an item to a player
```luau title="FindTheItemsServer.lua" linenums="1" hl_lines="5"
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:InitializeItemsIn(game.ReplicatedStorage.Items)
FindTheItems:GiveItem(game.Players.ImTembee2, require(game.ReplicatedStorage.Items.MyItem))
```

## Client
### ClientModule.Init() 
<span class="md-tag md-tag--secondary">Client Only</span>
Initializes all client-related things
```luau title="FindTheItemsClient.lua" linenums="1" hl_lines="3"
local FindTheItemsClient = require(game.ReplicatedStorage.FindTheItems.ClientModule)

FindTheItemsClient.Init()
```


