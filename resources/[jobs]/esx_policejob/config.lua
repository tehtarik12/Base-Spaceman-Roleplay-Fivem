Config                            = {}

Config.DrawDistance               = 10.0 -- How close do you need to be for the markers to be drawn (in GTA units).
Config.MarkerType                 = {WeaponsArmories = 21, Armories = 21, BossActions = 22, Vehicles = 36, Helicopters = 34}
Config.MarkerSize                 = {x = 1.5, y = 1.5, z = 0.5}
Config.MarkerColor                = {r = 50, g = 50, b = 204}

Config.EnablePlayerManagement     = true -- Enable if you want society managing.
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- Enable if you're using esx_identity.
Config.EnableESXOptionalneeds     = false -- Enable if you're using esx_optionalneeds
Config.EnableLicenses             = true -- Enable if you're using esx_license.

Config.EnableHandcuffTimer        = true -- Enable handcuff timer? will unrestrain player after the time ends.
Config.HandcuffTimer              = 10 * 60000 -- 10 minutes.

Config.EnableJobBlip              = false -- Enable blips for cops on duty, requires esx_society.
Config.EnableCustomPeds           = false -- Enable custom peds in cloak room? See Config.CustomPeds below to customize peds.

Config.EnableESXService           = false -- Enable esx service?
Config.MaxInService               = -1 -- How many people can be in service at once? Set as -1 to have no limit

Config.Locale                     = 'en'

Config.OxInventory                = ESX.GetConfig().OxInventory

Config.JailPositions = {
	["Cell1"] = { ["x"] = 1761.2130, ["y"] = 2486.1765, ["z"] = 45.8177, ["h"] = 266.45669555664 },
	["Cell2"] = { ["x"] = 1761.2130, ["y"] = 2486.1765, ["z"] = 45.8177, ["h"] = 266.45669555664  },
	["Cell3"] = { ["x"] = 1761.2130, ["y"] = 2486.1765, ["z"] = 45.8177, ["h"] = 266.45669555664  },
	["Boiling Broke"] = { ["x"] = 1848.3607, ["y"] = 2586.1504, ["z"] = 45.6720, ["h"] = 85.039367675781 }
}

Config.Cutscene = {
	["PhotoPosition"] = { ["x"] = 402.91567993164, ["y"] = -996.75970458984, ["z"] = -99.000259399414, ["h"] = 186.22499084473 },

	["CameraPos"] = { ["x"] = 402.88830566406, ["y"] = -1003.8851318359, ["z"] = -97.419647216797, ["rotationX"] = -15.433070763946, ["rotationY"] = 0.0, ["rotationZ"] = -0.31496068835258, ["cameraId"] = 0 },
}

Config.ServiceExtensionOnEscape		= 8
Config.ServiceLocation 				= {x =  170.43, y = -990.7, z = 30.09}
Config.ReleaseLocation				= {x = 427.33, y = -979.51, z = 30.2}

Config.ServiceLocations = {
	{ type = "cleaning", coords = vector3(170.0, -1006.0, 29.34) },
	{ type = "cleaning", coords = vector3(177.0, -1007.94, 29.33) },
	{ type = "cleaning", coords = vector3(181.58, -1009.46, 29.34) },
	{ type = "cleaning", coords = vector3(189.33, -1009.48, 29.34) },
	{ type = "cleaning", coords = vector3(195.31, -1016.0, 29.34) },
	{ type = "cleaning", coords = vector3(169.97, -1001.29, 29.34) },
	{ type = "cleaning", coords = vector3(164.74, -1008.0, 29.43) },
	{ type = "cleaning", coords = vector3(163.28, -1000.55, 29.35) },
	{ type = "gardening", coords = vector3(181.38, -1000.05, 29.29) },
	{ type = "gardening", coords = vector3(188.43, -1000.38, 29.29) },
	{ type = "gardening", coords = vector3(194.81, -1002.0, 29.29) },
	{ type = "gardening", coords = vector3(198.97, -1006.85, 29.29) },
	{ type = "gardening", coords = vector3(201.47, -1004.37, 29.29) }
}

--[[Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 146, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 119, ['pants_1']  = 3,
			['pants_2']  = 7,   ['shoes_1']  = 12,
			['shoes_2']  = 12,  ['chain_1']  = 0,
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 3,   ['tshirt_2'] = 0,
			['torso_1']  = 38,  ['torso_2']  = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 120,  ['pants_1'] = 3,
			['pants_2']  = 15,  ['shoes_1']  = 66,
			['shoes_2']  = 5,   ['chain_1']  = 0,
			['chain_2']  = 0
		}
	}
} ]]

Config.PoliceStations = {
	LSPD = {

		Blip = {
			Coords  = vector3(438.4435, -983.6000, 30.6895),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Armories = {
			vector3(458.4966, -988.8518, 30.6896)
		},

		WeaponsArmories = {
			vector3(0,0,0)
		},

		BossActions = {
			vector3(449.5634, -973.2752, 30.6896)
		}

	},

	SSPD = {

		Blip = {
			Coords  = vector3(1856.479, 3681.771, 34.26746),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Armories = {
			vector3(1855.714, 3699.218, 34.25061)
		},

		WeaponsArmories = {
			vector3(0,0,0)
		},

		BossActions = {
			vector3(1861.82, 3689.261, 34.25061)
		}

	},

	PBPD = {

		Blip = {
			Coords  = vector3(-435.4945, 6022.773, 31.48718),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},

		Armories = {
			vector3(-445.8823, 6009.2607, 31.7164)
		},

		WeaponsArmories = {
			vector3(0,0,0)
		},

		BossActions = {
			vector3(-447.2835, 6014.11, 36.49158)
		}

	}
}