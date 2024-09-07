local mod = {}
local classes = {}

function mod.createClass(_, name, config)
	if classes[name] then
		error("'" .. name .. "' already exist")
	end

	classes[name] = config
end

function mod.inherit(_, obj, name)
	if not classes[name] then
		error("'" .. name .. "' is a not a valid class")
	end

	for k, v in pairs(classes[name]) do
		obj[k] = v
	end
end

return mod
