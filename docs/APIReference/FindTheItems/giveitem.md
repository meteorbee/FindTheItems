<span class="md-tag md-tag--secondary">Server Only</span>
<span class="md-tag md-tag--secondary">V1.0</span>

Arguments (1) | Returns (2)
{ .annotate }

1. [plr: Player](https://create.roblox.com/docs/reference/engine/classes/Player), [item: Item](/FindTheItems/Types/item)
2. nil

Gives an item to a player
```luau title="Example Code" linenums="1" hl_lines="5"
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:InitializeItemsIn(game.ReplicatedStorage.Items)
FindTheItems:GiveItem(game.Players.ImTembee2, require(game.ReplicatedStorage.Items.MyItem))
```