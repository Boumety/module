# Class

```lua
  Modules = {
    class = "github.com/Boumety/module/class"
  }
```

Create classes that you can make objects inherit from. It allows you to not repeat code.

`class:createClass(name, config)` Create a class 'name' that has 'config' (table). You can put in the config functions like Tick.

`class:inherit(obj, name)` Make an object inherit the config of a class 'name'.

### Example: 

```lua
Client.OnStart = function()
  class:createClass("plant", {
    grow = function(self)
      self:SetParent(nil)
  
      local chunk = Shape(Items.voxels.wheat_chunk)
      chunk:SetParent(World)
      chunk.Position = self.Position
    end,
  })

  local wheat = Shape(Items.voxels.wheat)
  class:inherit(wheat, "plant")

  wheat:SetParent(World)
end

CLient.Action1 = function()
  wheat:grow()
end
```
