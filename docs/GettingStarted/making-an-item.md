Items are modulescripts in the Items folder you make earlier. They are formatted like this

```luau title="MyAwesomeItem.lua" linenums="1"
return {
	Hitbox = nil, -- (1)!
	DisplayName = "My Awesome Item", -- (2)!
	ID = "MY_AWESOME_ITEM", -- (3)!
	Rarity = "Easy", -- (4)!
	Location = "Grasslands", -- (5)!
	Desc = "My Awesome Description!", -- (6)!
	Icon = "rbxassetid://14564074061", -- (7)!
	Realm = "Mainlands", -- (8)!
	Hint = "???", -- (9)!
	Badge = 0, -- (10)!
	Creator = game.Players:GetNameFromUserIdAsync(game.CreatorId), -- (11)!
	Pickup = function(Player:Player, Info:Item) : boolean
		return true
	end -- (12)!
}
```

1. The [BasePart](https://create.roblox.com/docs/reference/engine/classes/BasePart) the player touches to collect the Item.
2. The Item's name for searching and the way its displayed in the dex.
3. The ID used for data storage, the convention is SCREAMING_SNAKE_CASE, any letters in the ID will automatically be turned into capital letters. So snake_case is saved as SNAKE_CASE.
4. The [Difficulty](making-difficulties.md) of your item.
5. The area your item is found in.
6. The items Dex entry.
7. The icon for the item in the dex.
8. The [Realm](making-realms) your item is found in.
9. The hint for your item. This is shown to the player when they don't have it unlocked.
10. The BadgeID for your item, setting this to 0 will not award a badge on collection. Adding the BadgeID later will require players to resync their badges.
11. The UserID of the Items creator.
12. The function that runs when the player tries to pick it up, use this to add custom behaviour. Returning true picks it up, false ignores it.
