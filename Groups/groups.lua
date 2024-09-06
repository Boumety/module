local mod = {}
local groups = {}

function mod.addToGroup(object, name)
   if not groups[name] then
      groups[name] = {}
   end

   local group = groups[name]
   table.insert(group, object)
end

function mod.callGroup(name, funcName)
   local group = groups[name]

   if not group then
      error("'" .. name .. "'" .. " is not a valid group")
   end

   for _, obj in pairs(group) do
      local func = obj[funcName]
      if func then 
         func()
      end
   end
end

return mod
