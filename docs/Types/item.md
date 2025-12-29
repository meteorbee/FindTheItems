```luau title="ItemType.lua" linenums="1"
type Item = {
  Hitbox: BasePart?,
  DisplayName: string,
  ID: string,
  Rarity: string,
  Location: string,
  Desc: string,
  Icon: string,
  Creator: string,
  Realm: string,
  Hint: string,
  Badge: number,

  Pickup: (Player, Item) -> boolean
}
```