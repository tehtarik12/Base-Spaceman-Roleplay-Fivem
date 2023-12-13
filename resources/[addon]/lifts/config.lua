Config = {}

Config.Locale = 'en'

Config.AllowSounds = false

Config.MarkerSize = 1.0
Config.MarkerColor = {
    R = 0,
    B = 195,
    G = 255,
    A = 204 -- to convert from range (0,1) to (0,255), simply multiply by 255
}
Config.Lifts = {}

    --from bottom to top (floor)
    Config.Lifts = {
        {vector3(330.4203, -601.0750, 43.2840), vector3(338.8392, -583.9158, 74.1656) -- RUMAH SAKIT
       -- {vector3, vector3, vector3, }, - lift2

    },
	    {vector3(-320.8110, 209.7283, 81.7800), vector3(-303.7219, 192.0896, 144.3726) -- Casino
       -- {vector3, vector3, vector3, }, - lift2

    },
	}