local class = {}

local mt_class = {}


mt_class.__call =

	function(t, shape, config)
		if type(shape) == "Shape" or type(shape) == "Object" then
			for k, v in pairs(t) do
				shape[k] = config[k] or v
			end

			local init = config["init"] or t["init"]
			if init then
				if type(init) ~= "function" then
					error("'init' need to be a function")
				end

				init(shape)
			end

			return shape
		elseif type(shape) == "table" then
			for k, v in pairs(shape) do
				t[k] = v
			end

			return t
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
