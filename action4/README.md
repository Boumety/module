# Action 4

This module will create a forth button on mobile called Action4.
For pc you can use the `shift` key (on pc the button won't be shown)
Action4 behave exactly like Action2 and Action3

### Usage: 

```lua
Modules = {
	action4 = "github.com/Boumety/modules/action4"
}

Client.OnStart = function()
    myFunc1 = function()
        -- Called when action4 is pressed
    end

    myFunc2 = function()
        -- Called when action4 is released
    end

    action4:press(myFunc1) -- Will call myFunc1 on press
    action4:release(myFunc2) -- Will call myFunc2 on release
end
```

### Functions:
`action4:press(func)` Call func when Action4 is pressed

`action4:release(func)` Call func when Action4 is released

⚠ Action4 will automatically be shown/hidden when the Pointer is shown/hidden

`action4:show()` Show the Action4 button (if it has already been created)

`action4:hide()` Hide the Action4 button

`action4:setButtonIcon(string)` Change the icon of Action4 (must be astring)
