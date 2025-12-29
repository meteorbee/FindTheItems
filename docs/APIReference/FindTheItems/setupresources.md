<span class="md-tag md-tag--secondary">Server Only</span>
<span class="md-tag md-tag--secondary">V1.0</span>

Arguments (1) | Returns (2)
{ .annotate }

1. None
2. nil

Creates the FindTheItemsResources folder. It also connect all the created events.
It is NOT recommended to run this unless you are modding the kit.
```luau title="Example Code" linenums="1" hl_lines="4"
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:SetupResource()
```