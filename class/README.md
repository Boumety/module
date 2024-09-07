# Class

```lua
  Modules = {
    class = "github.com/Boumety/module/class:61a1b49"
  }
```

Create classes that you can make objects inherit from. It allows you to not repeat code.

`class(config)` This function return a class using config (table). You can then create then create objects that inherit that class. Check example below.
You can use 'init' that is called when the object is created.

### Example: 

```lua
Client.OnStart = function()
	plant = class({
		grow = function(self)
			self:SetParent(nil)
		end,
	})

	plant = plant(Shape(Items.voxels.wheat))
	plant:grow()
end
```
