<span class="md-tag md-tag--secondary">Server Only</span>
<span class="md-tag md-tag--secondary">V1.0</span>

Arguments (1) | Returns (2)
{ .annotate }

1. [plr: Player](https://create.roblox.com/docs/reference/engine/classes/Player), stat: string, scope: "Year" | "AllTime"
2. [any](https://luau.org/typecheck/basic-types#any-type)

Gets a stat from a player
```luau title="Example Code" linenums="1" hl_lines="5"
local FindTheItemsKit = require(game.ReplicatedStorage.FindTheItems)
local FindTheItems = FindTheItemsKit.new()

local Playtime = FindTheItems:GetStat(game.Players.ImTembee2, "Playtime", "Year")
print(Playtime)
```

```title="Output"
1234  -  Server
```