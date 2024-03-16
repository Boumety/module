# Data tracker

This module will track the data of all incoming players. All the data can then be read. ⚠ Please follow the instructions to setup this module ⚠

### Usage

First, you need to use initialize the module.

```lua
Modules = {
	data = "github.com/Boumety/module/data"
}

Client.OnStart = function()
    data:init() -- You can give a name to the data tracker but it is recommended to keep the default one
end
```

When you see the print, you can then __remove__ `data:init()`.
Now use at the start of your script `data:setPlayerData()` to keep track of incoming player.

```lua
Modules = {
	data = "github.com/Boumety/module/data"
}

Client.OnStart = function()
    data:setPlayerData() -- No need to use a parameter, it will take Player.Username by default
end
```

You also need to save the data when the Player is about to leave. For example:

```lua
Modules = {
    data = "github.com/Boumety/module/data"
}

Client.OnStart = function()
	save = function()
		data:setPlayerData()
	end

	Menu:AddDidBecomeActiveCallback(save)

	save()
end
```

Last thing, if you want to read the data of a Player you can use the following example:

```lua
Modules = {
    data = "github.com/Boumety/module/data"
}

Client.OnStart = function()
  read = function(d) -- d contain all of the informations in a table
    -- Read data of the player, for example: print(d.username)
  end

	save = function()
		data:setPlayerData()
	end

	Menu:AddDidBecomeActiveCallback(save)

  save()

  data:getPlayerData(Player.Username, read) -- Take the data of Player.Username
end
```

### Functions

If you use the default data tracker, do not use the `name` parameter for each function.

`data:init(name)` Create a data tracker, it is best advised to use the default name without givign a parameter.

`date:delete(name)` Delete a data tracker.

`data:setPlayerData(username, name)` Save the data of the current player (can save the data of a specific Player by using its username).

`data:getPlayerData(username, callback, name)` Take the data of a player, you must use a callback with a parameter that will contain the information.

`data:getAllData(callback, name)` Take all of the data, you must use a callback with a parameter that will contain the information.

### Informations

`d.username`

`d.userID`

`d.first_connection`

`d.last_connection`

`d.playtime`

`d.nb` How many time did the player joined your world

`d.average_session`
