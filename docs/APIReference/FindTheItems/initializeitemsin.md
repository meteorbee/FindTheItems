<span class="md-tag md-tag--secondary">Server Only</span>
<span class="md-tag md-tag--secondary">V1.0</span>

Arguments (1) | Returns (2)
{ .annotate }

1. [dir: Folder](https://create.roblox.com/docs/reference/engine/classes/Folder)
2. nil

Run this to initialize all the items in dir.
```luau title="Example Code" linenums="1" hl_lines="4"
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:InitializeItemsIn(game.ReplicatedStorage.Items) -- (1)!
```

1. All Instances in the folder should be modulescripts with a table inside of type [Item](../Types/item.md)