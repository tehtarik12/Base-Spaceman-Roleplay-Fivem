Config = {}

-- SEPEDA

Config.BikeList = {
    {label = 'Tribike - $15', value = 'tribike2', price = 15},
    {label = 'scorcher - $15', value = 'scorcher', price = 15},
    {label = 'Cruiser - $15', value = 'cruiser', price = 15},
    {label = 'BMX - $10', value = 'bmx', price = 10}
}

Config.MarkerZonesSepeda = { 
  {x = -713.2683, y = -1291.8975, z = 4.1020, h = 178.61},
  {x = -274.5363, y = -904.3384, z = 30.20068, h = 70.86614},
}
---------------------

Config.DailyRentPrice = 300

Config.LockerBlips = {
    ["Locker1"] = {
        name = "Gudang Kota",
        mapBlip = {x = -1604.308, y = -832.4044, z = 10.07104, color = 2, sprite = 357, size = 0.8}
    },  
    ["Locker2"] = {
        name = "Gudang Sandy",
        mapBlip = {x = 387.2571, y = 3584.756, z= 33.29016, color = 2, sprite = 357, size = 0.8}
    },
}

Config.Lockers = {
	["gudangkota"] = {
		locker_name = 'Gudang Kota',
		location = vector3(-1604.308, -832.4044, 10.07104),
	},
    ["gudangpaleto"] = {
		locker_name = 'Gudang Sandy',
		location = vector3(387.2571, 3584.756, 33.29016),
	},
}