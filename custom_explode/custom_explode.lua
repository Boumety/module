local explode = {
}

local hierarchyActions = require("hierarchyactions")

local mt = {
    __call = function(_, shape, speed, timer)
    local queue = {}
	hierarchyActions:applyToDescendants(shape, { includeRoot = true }, function(o)
		if type(o) == "Shape" or type(o) == "MutableShape" then
			local s = Shape(o)
			World:AddChild(s)

			s.Scale = o.LossyScale
			s.Position = o.Position
			s.Rotation = o.Rotation

			s.Physics = true
			s.CollisionGroups = CollisionGroups(4)
			s.CollidesWithGroups = Map.CollisionGroups + CollisionGroups(3)
			s.Bounciness = 0.1

			local v = Number3(0, 0, 1) * (50 + math.random() * speed)
			v:Rotate(Number3(math.random() * -math.pi, math.random() * math.pi * 2, 0))
			s.Velocity = v

        table.insert(queue, s)

			-- s.rot = s.Rotation:Copy()

			-- s.Tick = function(o, dt)
			-- 	print(o.rot)
			-- 	o.rot.Y = o.rot.Y * dt * 10
			-- 	o.rot.X = o.rot.X * dt * 10
			-- 	o.Rotation = o.rot
			-- end

      if timer then
			  Timer(timer, function()
			  	s:RemoveFromParent()
			  end)
          end
		end
	end)
    return queue
	end
}


setmetatable(explode, mt)
return explode
