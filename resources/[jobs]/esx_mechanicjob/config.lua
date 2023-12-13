Config                            = {}
Config.Locale                     = 'en'

Config.DrawDistance               = 10.0 -- How close you need to be in order for the markers to be drawn (in GTA units).
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true -- Enable society managing.
Config.EnableSocietyOwnedVehicles = false
Config.OxInventory                = ESX.GetConfig().OxInventory

Config.Zones = {
	BossAction = {
		Pos   = vector3(-340.6179, -157.3353, 44.5871),
		Size  = { x = 0.5, y = 0.5, z = 0.2 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},

	Garage = {
		Pos   = vector3(0,0,0 ),
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	MechanicActions = {
		Pos   = vector3(-321.3290, -144.0562, 39.0157),
		Size  = { x = 1.0, y = 1.0, z = 0.5 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},

	VehicleSpawnPoint = {
		Pos   = vector3(-383.5340, -107.9087, 38.9749),
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = -1
	},

	VehicleDeleter = {
		Pos   = vector3(-378.0937, -108.8139, 37.6978),
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	}
}