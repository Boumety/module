mod = {}

local SIZE = 16
local FRAME_COLOR = Color(200, 200, 200, 180)
local FILL_COLOR = Color(255, 255, 255, 180)
local PRESS_SCALE = 0.95
local ICON_ON_COLOR = Color(255, 255, 255)
local ICON_OFF_COLOR = Color(160, 160, 160)
local ACTION_BTN_SCREEN_PADDING = 8
local ACTION_1_BTN_SIZE = 18
local SPACE_BETWEEN_BTNS = 1

local position = Number2(-ACTION_BTN_SCREEN_PADDING - ACTION_1_BTN_SIZE + SIZE - SPACE_BETWEEN_BTNS, ACTION_BTN_SCREEN_PADDING + ACTION_1_BTN_SIZE - SIZE + SPACE_BETWEEN_BTNS)

local pointers = {
down = 1,
up = 2,}

local pointer = pointers.down

local created = false
local list = {press=false,release=false}
local btn = nil
local icon = nil
local btnShape = nil

local control = require("controls")
local ui = require("uikit")

local createButton = function()
    if created == false then
        created = true
        btnShape = MutableShape()
        
	    local sizeMinusOne = SIZE - 1
	    local framePaletteIndex = btnShape.Palette:AddColor(FRAME_COLOR)
	    local fillPaletteIndex = btnShape.Palette:AddColor(FILL_COLOR)

	    for x = 0, sizeMinusOne do
		    for y = 0, sizeMinusOne do
			    if x == 0 or x == sizeMinusOne or y == 0 or y == sizeMinusOne then
			    	btnShape:AddBlock(framePaletteIndex, x, y, 0)
			    else
			    	btnShape:AddBlock(fillPaletteIndex, x, y, 0)
			    end
	    	end
	    end

	    btnShape:GetBlock(0, 0, 0):Remove()
	    btnShape:GetBlock(0, sizeMinusOne, 0):Remove()
	    btnShape:GetBlock(sizeMinusOne, 0, 0):Remove()
	    btnShape:GetBlock(sizeMinusOne, sizeMinusOne, 0):Remove()

	    btnShape:GetBlock(1, 1, 0):Replace(framePaletteIndex)
	    btnShape:GetBlock(1, sizeMinusOne - 1, 0):Replace(framePaletteIndex)
	    btnShape:GetBlock(sizeMinusOne - 1, 1, 0):Replace(framePaletteIndex)
	    btnShape:GetBlock(sizeMinusOne - 1, sizeMinusOne - 1, 0):Replace(framePaletteIndex)

	    icon = MutableShape()
	    local colorIndex = icon.Palette:AddColor(Color(160, 160, 160))
	    local offset = 0
	    for _ = 1, 1 do
	    	for y = 0, 3 do
	    		icon:AddBlock(colorIndex, offset, y, 0)
		    end
	    	offset = offset + 2
	    end

        icon:AddBlock(colorIndex, offset, 3, 0)
        icon:AddBlock(colorIndex, offset+1, 2, 0)
        icon:AddBlock(colorIndex, offset+1, 1, 0)
        icon:AddBlock(colorIndex, offset+2, 0, 0)
        icon:AddBlock(colorIndex, offset+3, 1, 0)
        icon:AddBlock(colorIndex, offset+3, 2, 0)
        icon:AddBlock(colorIndex, offset+4, 3, 0)

	    icon.Pivot = { icon.Width * 0.5, icon.Height * 0.5, icon.Depth * 0.5 }
	    btnShape:AddChild(icon)
	    icon.LocalPosition = { btnShape.Width * 0.5, btnShape.Height * 0.5, 0 }
            
	    btn = ui:createShape(btnShape, { doNotFlip = true })

	    btn.icon = icon
        
        btn.parentDidResize = function()
            btn.pos.X = control:getActionButton(2).Position.X - SPACE_BETWEEN_BTNS * ui.kShapeScale
		    btn.pos.Y = control:getActionButton(3).Position.Y + SPACE_BETWEEN_BTNS * ui.kShapeScale
		    btn.object.Scale = control:getActionButton(2).object.Scale
        end
        btn:parentDidResize()

        local listener = LocalEvent:Listen(LocalEvent.Name.PointerUp, function()
            if pointer == pointers.down then
                pointer = pointers.up

                btn.pivot.Scale = 1.0

	            if btn.icon ~= nil then
		            if btn.icon.Color then
			            btn.icon.Color = ICON_OFF_COLOR
		            else
			            btn.icon.Palette[1].Color = ICON_OFF_COLOR
		            end
	            end
            end
		end)

        local shown = LocalEvent:Listen(LocalEvent.Name.PointerShown, function()
            btn:show()
        end)

        local hidden = LocalEvent:Listen(LocalEvent.Name.PointerHidden, function()
            btn:hide()
        end)
    end
end

mod.show = function()
    if created then return end
    btn:show()
end

mod.hide = function()
    if created == false then return end
    btn:hide()
end

mod.setButtonIcon = function(self, shapeOrString)
    if Client.IsPc == true then return end
	if created == nil then
		return
	end
	if type(shapeOrString) ~= "string" then
        error("'shapeOrString' should be a string")
    end
    btn.shape:RemoveChildren()

	local s
        
		s = Text()
		s.Text = shapeOrString
		s.Color = ICON_OFF_COLOR
		s.BackgroundColor = Color(0, 0, 0, 0)
		s.IsUnlit = true
		s.Layers = btn.shape.Layers
		s.Scale = 5
		btn.shape:AddChild(s)
		s.LocalPosition = { btn.shape.Width * 0.5, btn.shape.Height * 0.5, -50 }
		s.MaxDistance = 9999


	btn.icon = s
end

mod.press = function(self, callback)
	if list.press == true then error("Action4 has already been created") end
    if callback == nil then
		error("'callback' should not be nil")
	end
    
	if type(callback) ~= "function" then
		error("'callback' should be a function")
	end

    local action = callback
    list.press = true
    if Client.IsPC == true then
        local pressed = LocalEvent:Listen(LocalEvent.Name.KeyboardInput, function(_,_,modifiers,down)
		    if down == false then return end
		    if modifiers ~= 4 then return end

		    action()
	    end)
    end

    if Client.IsMobile == true then
        createButton()
        btn.onPress = function()
            	btn.pivot.Scale = PRESS_SCALE
            	pointer = pointers.down

            	if btn.icon ~= nil then
		        	if btn.icon.Color then
			        	btn.icon.Color = ICON_ON_COLOR
		        	else
			        	btn.icon.Palette[1].Color = ICON_ON_COLOR
		        	end
	        	end

	       		Client:HapticFeedback()

            	action()
        end
    end
end

mod.release = function(self, callback)
	if list.release == true then error("Action4 has already been created") end
    if callback == nil then
		error("'callback' should not be nil")
	end
    
	if type(callback) ~= "function" then
		error("'callback' should be a function")
	end

    local release = callback
    list.release = true
    if Client.IsPC == true then
        local released = LocalEvent:Listen(LocalEvent.Name.KeyboardInput, function(_,_,modifiers,down)
		    if down == true then return end
		    if modifiers ~= 4 then return end

		    release()
	    end)
    end

    if Client.IsMobile == true then
        createButton()
        btn.onRelease = function()
            pointer = pointers.up

            btn.pivot.Scale = 1.0

	        if btn.icon ~= nil then
		        if btn.icon.Color then
			        btn.icon.Color = ICON_OFF_COLOR
		        else
			        btn.icon.Palette[1].Color = ICON_OFF_COLOR
		        end
	        end
            release()
        end
    end
end

return mod
