local mod = {}

local components = {}

local conf = require("config")

function mod.createComponent(name, config)
	if components[name] then
		error("'" .. name .. "' already exist")
	end

	components[name] = config
end

function mod.addComponent(obj, name, config)
	if not components[name] then
		error("'" .. name .. "' is a not a valid component")
	end

	local component = components[name]

	config = conf:merge(component, config)

	obj[name] = config

	obj[name].Object = obj

	if component.Enter then
		if type(component.Enter) ~= "function" then
			error("'Enter' should be a function")
		end

		component:Enter()
	end
end

return mod
