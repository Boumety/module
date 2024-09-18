local component = {}

local mt_component = {}


mt_component.__call =
	function(t, component)
		local o = Object()
		for k, v in pairs(t) do
			o[k] = v
		end
		return o
	end

local mt = {
    __call = function(_, myComponent)
		setmetatable(myComponent, mt_component)
		return myComponent
	end
}


setmetatable(component, mt)

return class
