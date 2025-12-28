# API Reference

## FindTheItems.new() : FindTheItems 
<span class="md-tag md-tag--primary">Server Only</span>
This creates a new FindTheItems class
```lua
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()
```

## FindTheItems:InitializeItemsIn(dir: Folder) 
<span class="md-tag md-tag--primary">Server Only</span>
Run this to initialize all the items in dir.
```lua
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:InitializeItemsIn(game.ReplicatedStorage.Items)
```