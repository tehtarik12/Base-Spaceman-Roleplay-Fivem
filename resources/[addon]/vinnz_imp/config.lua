Config 					= {}

Config.Impound 			= {
	Name = "MissionRow",
	RetrieveLocation = { X = 472.0502, Y = -1114.1084, Z = 29.3958 },
	StoreLocation = { X = 484.5421, Y = -1093.8611, Z = 29.3967 },
	SpawnLocations = {
		{ x = 471.6013, y = -1095.6285, z = 29.4735 , h = 89.4621 },
		{ x = 471.4921, y = -1092.3947, z = 29.4729, h = 90.0211 },
		{ x = 471.2995, y = -1349.00, z = 29.4756 , h = 91.2583 },
	},
	AdminTerminalLocations = {
		{ x = 830.30, y = -1311.09, z = 28.13 },
		{ x = 440.18, y = -976.00, z = 30.68 }
	}
}

Config.Rules = {
	maxWeeks		= 5,
	maxDays			= 6,
	maxHours		= 24,

	minFee			= 50,
	maxFee 			= 15000,

	minReasonLength	= 10,
}

--------------------------------------------------------------------------------
----------------------- SERVERS WITHOUT ESX_MIGRATE ----------------------------
---------------- This could work, it also could not work... --------------------
--------------------------------------------------------------------------------
-- Should be true if you still have an owned_vehicles table without plate column.
Config.NoPlateColumn = false
-- Only change when NoPlateColumn is true, menu's will take longer to show but otherwise you might not have any data.
-- Try increments of 250
Config.WaitTime = 250