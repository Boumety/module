-- AMBIENCE SETUP (begin) --

require("ambience"):set({
	sky = {
		skyColor = Color(0,0,0),
		horizonColor = Color(0,0,0),
		abyssColor = Color(0,0,0),
		lightColor = Color(0,0,0),
		lightIntensity = 0.600000,
	},
	fog = {
		color = Color(0,0,0),
		near = 255,
		far = 700,
		lightAbsorbtion = 0.400000,
	},
	sun = {
		color = Color(0,0,0),
		intensity = 1.000000,
		rotation = Number3(1.061161, 3.089219, 0.000000),
	},
	ambient = {
		skyLightFactor = 0.100000,
		dirLightFactor = 0.200000,
	}
})

-- AMBIENCE SETUP (end) --
