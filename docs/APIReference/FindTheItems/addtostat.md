<span class="md-tag md-tag--secondary">Server Only</span>
<span class="md-tag md-tag--secondary">V1.0</span>

Arguments (1) | Returns (2)
{ .annotate }

1. [plr: Player](https://create.roblox.com/docs/reference/engine/classes/Player), stat: string, value: number
2. nil

Adds value to a stat for both a players year and alltime scopes
```luau title="Example Code" linenums="1" hl_lines="5"
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

local Playtime = FindTheItems:AddToStat(game.Players.ImTembee2, "Playtime", 10)
```
