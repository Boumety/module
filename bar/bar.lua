mod = {}

local DEFAULT_CONFIG = {
    margin = 8,
    colorBar = Color.Red,
    colorBg = Color.Black,
    width = 500,
    height = 50,
    position = Number2(8,8),
    -- Min is always 0, might change to support negatives numbers
    min = 0,
    max = 100,
    value = 0,
	time = 0.5,
}

local conf = require("config")
local ui = require("uikit")
local ease = require("ease")

mod.createBar = function(self, config)
    config = conf:merge(DEFAULT_CONFIG, config)
	config.min = 0
	
    local bg = ui:createFrame(config.colorBg)
    bg.Width = config.width
    bg.Height = config.height
	bg.pos.X = config.position.X
	bg.pos.Y = config.position.Y
	
    local bar = ui:createFrame(config.colorBar)

	bar:setParent(bg)
	
    if config.value > config.max then config.value = config.max end
    bar.multiplier = config.value / config.max
    bar.Width = bar.multiplier * config.width - config.margin
    bar.Height = bg.Height - config.margin
	bar.pos.X = config.margin / 2
    bar.pos.Y = config.margin / 2


	bg.updateValue = function(self, value, time, callback)
		if type(value) ~= "number" then
            if type(value) ~= "integer" then
			    error("'value' should be a number or an integer")
            end
		end
		local time = time or config.time
	    bar.multiplier = value / config.max
		ease:cancel()
		ease:inSine(bar, time).Width = bar.multiplier * config.width - config.margin
	end

	bg.updateConfig = function(self, newConfig)
		config = conf:merge(config, newConfig)

        bg.Color = config.colorBg
        bar.Color = config.colorBar
        
        bg.Width = config.width
        bg.Height = config.height
	    bg.pos.X = config.position.X
	    bg.pos.Y = config.position.Y
	
        if config.value > config.max then config.value = config.max end
        bar.multiplier = config.value / config.max
        bar.Width = bar.multiplier * config.width - config.margin
        bar.Height = bg.Height - config.margin
	    bar.pos.X = config.margin / 2
        bar.pos.Y = config.margin / 2
	end
	
    return bg
end


return mod
