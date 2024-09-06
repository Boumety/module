# Groups

```lua
Modules = {
	groups = "github.com/Boumety/module/groups"
}
```

`groups:addToGroup(obj, name)` Add an object (obj) to the group "name" (string). If the group doesn't exist it will automatically create it.

`groups:callGroup(name, funcName)` Call the function "funcName" (string) of all objects in the group "name" (string). If an object doesn't have this function it is simply ignored.

This module can be useful to do the same action for multiple objects in just one line of code (instead of yourself creating a specific table and looping over it)

### Example

```lua
Modules = {
	groups = "github.com/Boumety/module/groups"
}

Client.OnStart = function()
  local myObject = Object()
  myObject.delete = function() myObject:SetParent(nil) end

  groups:addToGroup(myObject, "Objects")
end

Client.Action1 = function()
  groups:callGroup("Objects", "delete")
end
```
