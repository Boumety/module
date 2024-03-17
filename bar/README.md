# Bar

This module allow you to quickly create simple bar that you can fully customize. Once you have a bar, you can smoothly change it.

![Bar.png](https://raw.githubusercontent.com/Boumety/module/main/bar/img/Bar.png)

### Usage

How to create a bar:

```lua
Modules = {
	bar = "github.com/Boumety/module/bar"
}

Client.OnStart = function()
    --[[
    Default config:
    local DEFAULT_CONFIG = {
        margin = 8,
        colorBar = Color.Red,
        colorBg = Color.Black,
        width = 500,
        height = 50,
        position = Number2(16,16),
        -- Min is always 0, might change to support negatives numbers
        min = 0,
        max = 100,
        value = 0,
	    time = 0.5,
    }
    ]]--

    myBar = bar:createBar() -- Create a bar in myBar that you can then for example move with myBar.pos like you would do with a simple uikit frame
end
```

You can then smoothly change value with `myBar:updateValue()`:

```lua
Modules = {
	bar = "github.com/Boumety/module/bar"
}

Client.OnStart = function()
    myBar = bar:createBar({max = 100, value = 100,})

    myBar:updateValue(50)
end
```

### Example

You can use this module to create a health bar:

```lua
Modules = {
	bar = "github.com/Boumety/module/bar"
}

Client.OnStart = function()
    maxHealth = 100
    health = 100

    hit = function(damage)
        health = health - damage
        healthBar:updateValue(health)
    end

    healthBar = bar:createBar({max = maxHealth, value = health,})

    hit(50)
end
```

### Functions

`myName = bar:createBar(config)` Create a bar, you can customize it with `config`.

`myName:updateValue(value, time, callback)` Smoothly change the value of the bar with `value`, time and callback are optional.

`myName:updateConfig(newConfig)` Change the config of `myBar`. For example, to change its max value.
