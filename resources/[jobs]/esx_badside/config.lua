ConfigBadside = {}

ConfigBadside.DrawDistance               = 100.0
ConfigBadside.MaxInService               = -1
ConfigBadside.EnablePlayerManagement     = true
ConfigBadside.OxInventory                = ESX.GetConfig().OxInventory

ConfigBadside.AuthorizedVehicles = {
	fama = {
		car = {
			dinas = {
				{model = 'kamacho', label = 'Kamacho', price = 0},
				{model = 'sanchez', label = 'Sanchez', price = 0},
			}
		},
	},
	famb= {
		car = {
			dinas = {
				{model = 'Contender', label = 'Contender', price = 0},
				{model = 'Cliffhanger', label = 'Cliffhanger', price = 0},
			}
		},
	},
	famc = {
		car = {
			dinas = {
				{model = 'dubsta', label = 'Contender', price = 0},
				{model = 'bf400', label = 'BF-400', price = 0},
			}
		},
	},
	famd = {
		car = {
			dinas = {
				{model = 'btype3', label = 'Roosevelt', price = 0},
				{model = 'sanchez', label = 'Sanchez', price = 0},
			}
		},
	},
	fame = {
		car = {
			dinas = {
				{model = 'dubsta', label = 'dubsta', price = 0},
				{model = 'sanchez', label = 'sanchez', price = 0},
			}
		},
	},
	famf = {
		car = {
			dinas = {
				{model = 'toros', label = 'toros', price = 0},
				{model = 'Cliffhanger', label = 'Cliffhanger', price = 0},
			}
		},
	},
	famg = {
		car = {
			dinas = {
				{model = 'guardian', label = 'guardian', price = 0},
				{model = 'gargoyle', label = 'gargoyle', price = 0},
			}
		},
	},
}

ConfigBadside.FraksiZones = {
	-- ExBerabeh
	fama = {
		Pos   = { x = 989.2136, y= -136.2423, z= 74.0568 }, -- 
		PosVeh = { x = 979.1970, y= -128.5310, z=74.0635 },  -- Samain dengan Spawner vehicles , , 
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},
	-- Monsaraz
	famb = {
		Pos   = { x = -311.0590, y=211.1605, z= 145.3193},
		PosVeh = { x = -298.9254, y=223.6446, z=87.9454}, -- Samain dengan Spawner vehicles
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},
	-- The Crips	
	famc = {
		Pos   = { x = 1378.9138, y= -2090.3091, z=52.6089}, 
		PosVeh = { x = 1369.2552, y= -2091.7683, z= 51.9989}, -- Samain dengan Spawner vehicles
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},
	-- EL NATANIELIE FAMILIA

	famd = {
		Pos   = { x = -1865.9214, y= 2061.2266, z= 135.4348}, 
		PosVeh = { x = -1925.5193, y=2048.0603, z=140.8316}, -- Samain dengan Spawner vehicles
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},
	--Gordline 224  
	fame = {
		Pos   = { x = -95.0625, y=819.6313, z=231.3369},
		PosVeh = { x = -100.8531, y= 820.0020, z= 235.7249}, -- Samain dengan Spawner vehicles
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},
		-- The Dosmon
	famf = {
		Pos   = { x = 353.3553, y=-2028.7977, z=22.3949}, 
		PosVeh = { x = 339.0104, y=-2023.9751, z=22.0693},--Samain dengan Spawner vehicles
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},
		--Revenge
	famg = {
		Pos   = { x = -1.8780, y= 525.4991, z=170.6349},
		PosVeh = { x = 14.0808, y=542.3513, z=176.0125}, -- Samain dengan Spawner vehicles
		Size  = { x = 1.0, y = 1.0, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 2
	},
}

ConfigBadside.FraksiStations = {			
	fama = {
		Vehicles = {
			{
				Spawner = vector3(979.1970, -128.5310, 74.0635), -- Samain dengan PosVeh
				SpawnPoints = {
					{coords = vector3(973.4442, -124.6945, 74.5473), heading = 146.4782, radius = 6.0},
				}
			},
		},
	},

	famb = {
		Vehicles = {
			{
				Spawner = vector3(-298.8932, 223.4967, 87.9439), -- Samain dengan PosVeh
				SpawnPoints = {
					{coords = vector3(-296.6672, 229.7933, 88.3978), heading = 323.2126, radius = 6.0},
				}
			},
		},
	},

	famc= {   
		Vehicles = {  
			{
				Spawner = vector3(1369.2552, -2091.7683, 51.9989), -- Samain dengan PosVeh
				SpawnPoints = {
					{coords = vector3(1366.7321, -2083.1189, 52.2710), heading = 312.5456, radius = 6.0},
				}
			},
		},
	},

	famd = {
		Vehicles = {
			{
				Spawner = vector3(-1925.5193, 2048.0603, 140.8316), -- Samain dengan PosVeh
				SpawnPoints = {
					{coords = vector3(-1919.6837, 2048.7378, 141.0074), heading = 258.1272, radius = 6.0},
				}
			},
		},
	},

	fame = {
		Vehicles = {
			{
				Spawner = vector3(-100.8531, 820.0020, 235.7249), -- Samain dengan PosVeh
				SpawnPoints = {
					{coords = vector3(-106.6436, 835.5085, 235.9649), heading = 7.0122, radius = 6.0},
				}
			},
		},
	},
	
	famf = {
		Vehicles = {
			{
				Spawner = vector3(339.0104, -2023.9751, 22.0693), -- Samain dengan PosVeh
				SpawnPoints = {
					{coords = vector3(332.1020, -2032.1219, 21.4505), heading = 141.1521, radius = 6.0},
				}
			},
		},
	},
	
	famg = {
		Vehicles = {
			{
				Spawner = vector3(14.0808, 542.3513, 176.0125), -- Samain dengan PosVeh
				SpawnPoints = {
					{coords = vector3(12.6520, 548.6622, 176.3395), heading = 68.3416, radius = 6.0},
				}
			},
		},
	},
}

ConfigBadside.Company = {
	famd = {
		coord = vector3(0,0,0),
		car = {
			{model = 'kamacho', label = 'Kamacho'},
			{model = 'gargoyle', label = 'Gargoyle'},
		},
		Spawner = vector3(-1127.4655, -1458.2076, 4.9292),
		SpawnPoints = {coords = vector3(-1132.2615, -1449.5886, 5.0428), heading = 33.9375, radius = 6.0},
		menu = {
			{label = 'Pizza [Paketan Daging 5x | Adonan 2x | Paketan Minyak 2x]', value = 'pizza', bahan = {paketandaging = 5, adonan = 2, paketanminyak = 2}, give = 5, index = 1},
			{label = 'Lasagna [Paketan Daging 3x | Adonan 2x]', value = 'lasagna', bahan = {paketandaging = 3, adonan = 2}, give = 5, index = 2},
			{label = 'Kue Tiramisu [Paketan Daging 1x | Adonan 4x', value = 'tiramisu', bahan = {paketandaging = 1, adonan = 4}, give = 5, index = 3},

			{label = 'Cola [Mineral 3x | Gula 5x]', value = 'ecola', bahan = {mineral = 3, gula = 5}, give = 5, index = 4},
			{label = 'Beer [Mineral 3x | Gula 10x]', value = 'beer', bahan = {mineral = 3, gula = 10}, give = 5, index = 5},
		}
	}
}