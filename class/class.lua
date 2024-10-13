local class = {}

local mt_class = {}


mt_class.__call =

	function(t, shape, config)
		if type(shape) == "Shape" or type(shape) == "Object" then
			for k, v in pairs(t) do
				shape[k] = v
			end

			local init = t["init"]
		
			if init then
				if type(init) ~= "function" then
					error("'init' need to be a function")
				end

				init(shape, config)
			end

			return shape
		elseif type(shape) == "table" then
			local newClass = {}
			for k, v in pairs(t) do
				newClass[k] = v
			end
		
			for k, v in pairs(shape) do
				newClass[k] = v
			end
		
			setmetatable(newClass, mt_class)
		
			return newClass
		end
	end

local mt = {
    __call = function(_, myClass)
		setmetatable(myClass, mt_class)
		return myClass
	end
}


setmetatable(class, mt)

return class
