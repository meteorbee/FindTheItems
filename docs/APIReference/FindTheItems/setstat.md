<span class="md-tag md-tag--secondary">Server Only</span>
<span class="md-tag md-tag--secondary">V1.0</span>

Arguments (1) | Returns (2)
{ .annotate }

1. [plr: Player](https://create.roblox.com/docs/reference/engine/classes/Player), stat: string, value: number, scope: "Year" | "AllTime"
2. nil

Sets a stat for a player
```luau title="Example Code" linenums="1" hl_lines="5"
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

FindTheItems:SetStat(game.Players.ImTembee2, "Playtime", 1234, "Year")
```