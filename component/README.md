# Component

```lua
Modules = {
  component = "github.com/Boumety/module/component:699f1fe"
}
```
Create and add components to an object. Components can be use to not have repeating code, for example, you can create one health component and add it to the player and the enemy.

`component:createComponent(name, config)` Create a component 'name' (the first letter need to be in lowercase) that have he table 'config'.
This component can then be added later on.
In config, `Enter` will be called when the component is added to the object and `Object` is the object.

`component:addComponent(obj, name, config)` Add a pre existing component 'name' to and object. The config is optional and can be use to modify values.

### Example:

```lua
Client.OnStart = function()
    createComponent("healthComponent", {
        Object = nil,
        Enter = function()
        end,

        Health = 100,

        Damage = function(self, amount)
            self.Health = self.Health - amount
            if self.Health <= 0 then
                self:Delete()
            end
        end,

        Delete = function(self)
            self.Object:SetParent(nil)
        end,
    })
end

createZombie = function()
    -- other stuff
    addComponent(zombie, "healthComponent", {Health = 50})
end

Pointer.Click = function(pe)
    local ray = Ray(pe.Position, pe.Direction)
    local impact = ray:Cast(CollisionGroups(4))
    if not impact then return end
    
    local healthComponent = impact.Object.healthComponent
    healthComponent:Damage(50)
end
```
