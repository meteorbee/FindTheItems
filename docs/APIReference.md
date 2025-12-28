# API Reference

## FindTheItems.new() : FindTheItems 
**Signature:** `FindTheItems.new() -> FindTheItems`
<span class="md-tag md-tag--secondary">Server Only</span>
This creates a new FindTheItems class
```luau
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()
```

## FindTheItems:InitializeItemsIn(dir: Folder) 
**Signature:** `FindTheItems:InitializeItemsIn(dir)`
<span class="md-tag md-tag--secondary">Server Only</span>
Run this to initialize all the items in dir.
```luau
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:InitializeItemsIn(game.ReplicatedStorage.Items)
```

## FindTheItems:GiveItem(plr: Player, item: Item) 
**Signature:** `FindTheItems:GiveItem(plr, item)`
<span class="md-tag md-tag--secondary">Server Only</span>
Gives an item to a player
```luau
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:InitializeItemsIn(game.ReplicatedStorage.Items)
FindTheItems:GiveItem(game.Players.ImTembee2, require(game.ReplicatedStorage.Items.MyItem))
```

## ClientModule.Init() 
**Signature:** `ClientModule.Init()`
<span class="md-tag md-tag--secondary">Client Only</span>
Gives an item to a player
```luau
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:InitializeItemsIn(game.ReplicatedStorage.Items)
FindTheItems:GiveItem(game.Players.ImTembee2, require(game.ReplicatedStorage.Items.MyItem))
```


