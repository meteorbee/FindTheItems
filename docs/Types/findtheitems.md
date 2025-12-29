```luau title="FindTheItemsType.lua" linenums="1"
type FindTheItems = {
  PlayerAdded: RBXScriptConnection, -- (1)!
  PlayerRemoving: RBXScriptConnection, -- (2)!
  
  InitializeItemsIn: (self: FindTheItems, Folder?) -> (), --(3)!
  SetupResources: (self: FindTheItems) -> (),
  GiveItem: (self: FindTheItems, Player, Item) -> (), -- (4)!
  PlayerOwnsItem: (self: FindTheItems, Player, string) -> (), -- (5)!
  SetStat: (self: FindTheItems, Player, string, any, "Year" | "AllTime") -> (), -- (6)!
  GetStat: (self: FindTheItems, Player, string, "Year" | "AllTime") -> (any), -- (7)!
  AddToStat: (self: FindTheItems, Player, string, any) -> (), -- (8)
}
```

1. [RBXScriptConnection](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptConnection)
2. [RBXScriptConnection](https://create.roblox.com/docs/reference/engine/datatypes/RBXScriptConnection)
3. [Folder](https://create.roblox.com/docs/reference/engine/classes/Folder)
4. [Player](https://create.roblox.com/docs/reference/engine/classes/Player), [Item](./item.md)
5. [Player](https://create.roblox.com/docs/reference/engine/classes/Player), [string]()
6. [Player](https://create.roblox.com/docs/reference/engine/classes/Player), [string](), [any](https://luau.org/typecheck/basic-types#any-type), "Year" | "AllTime"
7. [Player](https://create.roblox.com/docs/reference/engine/classes/Player), [string](), "Year" | "AllTime"
8. [Player](https://create.roblox.com/docs/reference/engine/classes/Player), [string]()