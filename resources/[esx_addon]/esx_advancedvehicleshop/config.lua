Config = {}
Config.Locale = 'en'

Config.Main = {
	DrawDistanceE = 20, -- Enter Marker Draw Distance
	DrawDistanceR = 0, -- Resell Marker Draw Distance
	PlateUseSpace = false, -- true = 'LLL  NNN' | false = 'LLLLNNNN' | Where L is a Random Letter & N is a Random Number.
	MaxMigrates = 6, -- Higher Value will cause Deadlocks on the Database. 
	LegacyFuel = false,
	Financing = false, -- WIP Feature | Keep false for now
	Limit = false -- WIP Feature | Keep false for now
}

-- Shop = true means Use Shop | false means doesn't Use Shop
-- Blips = true means Turn on Blips | false means Turns off Blips
-- License = Requires a License to Buy Vehicles
-- ResellPerc = The Resell % of Vehicles Sold | Example: $10,000 / 50% = $5,000 Back
-- Enter = Marker for Accessing the Shop
-- Inside & InsideH = The Location for Viewing Vehicles & Heading
-- Outside & OutsideH = The Spawn Location for Purchased Vehicles
-- Outside2 & OutsideH2 = The Spawn Location for Purchased Helis (Only for Division Shop)
-- Resell = The Marker for Selling Vehicles
-- Resell2 = The Marker for Selling Helis (Only for Division Shop)

Config.Ambulance = {
	Shop = true,
	Blips = true,
	Blip = {Sprite = 326, Color = 1, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 255, g = 0, b = 0, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 255, g = 0, b = 0, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(294.7593, -600.9034, 43.3040),
			Inside = vector3(323.5067, -553.0425, 28.3901),
			Outside = vector3(278.8232, -611.4832, 42.8458),
			Resell = vector3(0,0,0),
			InsideH =  277.7246,
			OutsideH =  70.9389,
		}
	}
}

Config.Police = {
	Shop = true,
	Blips = true,
	Blip = {Sprite = 326, Color = 3, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 0, g = 0, b = 255, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 0, g = 0, b = 255, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(458.8352, -1008.079, 28.25208),
			Inside = vector3(449.1033, -1023.969, 27.89819),
			Outside = vector3(435.4418, -1025.789, 28.16772),
			-- Resell = vector3(485.47, -1097.45, 28.2),
			InsideH = 2.834646,
			OutsideH = 2.834646
		}
	}

}



Config.Division = {
	Shop = true,
	Blips = true,
	Blip = {Sprite = 326, Color = 3, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 0, g = 0, b = 255, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 0, g = 0, b = 255, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(-700.6022, -1401.587, 5.487915),
			Inside = vector3(-745.6352, -1469.288, 5.201416),
			Outside = vector3(-724.4967, -1443.93, 5.201416),
			Outside2 = vector3(-724.4967, -1443.93, 5.201416),
			-- Resell = vector3(458.58, -1104.11, 28.2),
			-- Resell2 = vector3(476.74, -1106.44, 42.08),
			InsideH = 323.1496,
			OutsideH = 138.8976,
			OutsideH2 = 177.21
		}
	},
	Heli1 = 'polmav',
	Heli2 = 'maverick'
}

Config.Mechanic = {
	Shop = false,
	Blips = false,
	Blip = {Sprite = 326, Color = 17, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 255, g = 165, b = 0, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 255, g = 165, b = 0, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(0.37, -1658.99, 28.48),
			Inside = vector3(-17.27, -1658.88, 38.62),
			Outside = vector3(-48.61, -1690.86, 28.43),
			Resell = vector3(-17.96, -1680.72, 28.49),
			InsideH = 46.47,
			OutsideH = 297.7
		}
	}
}

Config.Taxi = {
	Shop = false,
	Blips = false,
	Blip = {Sprite = 326, Color = 17, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 255, g = 165, b = 0, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 255, g = 165, b = 0, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(0.37, -1658.99, 28.48),
			Inside = vector3(-17.27, -1658.88, 38.62),
			Outside = vector3(-48.61, -1690.86, 28.43),
			Resell = vector3(-17.96, -1680.72, 28.49),
			InsideH = 46.47,
			OutsideH = 297.7
		}
	}
}

Config.Aircraft = {
	Shop = false,
	Blips = false,
	Blip = {Sprite = 90, Color = 4, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 145, g = 0, b = 255, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 145, g = 0, b = 255, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(-941.6, -2956.1, 12.9),
			Inside = vector3(-1874.7, -3137.5, 14.9), -- vector3(-1075.0, -2933.2, 14.5),
			Outside = vector3(-965.2, -2983.5, 14.5),
			Resell = vector3(-1003.2, -2920.7, 12.9),
			InsideH = 333.95, -- 59.9
			OutsideH = 59.9
		}
	}
}

Config.Boat = {
	Shop = false,
	Blips = false,
	Blip = {Sprite = 410, Color = 3, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 0, g = 17, b = 255, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 0, g = 17, b = 255, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(-806.46, -1350.9, 4.22),
			Inside = vector3(-816.15, -1421.98, -0.4),
			Outside = vector3(-782.05, -1421.35, -0.4),
			Resell = vector3(-769.14, -1378.04, -0.4),
			InsideH = 138.4,
			OutsideH = 141.35
		}
	}
}

Config.Car = {
	Shop = true,
	Blips = true,
	Blip = {Sprite = 326, Color = 0, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 0,
	Markers = {
		Enter = {Type = 20, r = 0, g = 255, b = 0, x = 1.0, y = 1.0, z = 0.5}, -- Standard Size Circle.
		Resell = {Type = 20, r = 0, g = 255, b = 0, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(-55.04, -1095.87, 26.42),
			Inside = vector3(-47.5, -1097.2, 25.4),
			Outside = vector3(-26.8, -1083.5, 26.6),
			Resell = vector3(0.0, 0.0, 0.0),
			InsideH = -20.0,
			OutsideH = 70.68
		}
	}
}

Config.Truck = {
	Shop = false,
	Blips = false,
	Blip = {Sprite = 67, Color = 2, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 0, g = 255, b = 0, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 0, g = 255, b = 0, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(-23.47, -1660.45, 28.48),
			Inside = vector3(-24.82, -1650.54, 28.48),
			Outside = vector3(-55.05, -1685.02, 28.49),
			Resell = vector3(-29.7, -1674.8, 28.49),
			InsideH = 140.62,
			OutsideH = 321.05
		}
	}
}

-- You will need to Setup your Own Stuff for the VIP Shops. I will NOT be providing support to help with this.
Config.VIPAircraft = {
	Shop = false,
	Blips = false,
	Blip = {Sprite = 326, Color = 5, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 255, g = 222, b = 0, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 255, g = 222, b = 0, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(0.0, 0.0, 0.0),
			Inside = vector3(0.0, 0.0, 0.0),
			Outside = vector3(0.0, 0.0, 0.0),
			Resell = vector3(0.0, 0.0, 0.0),
			InsideH = 0.0,
			OutsideH = 0.0
		}
	}
}

Config.VIPBoat = {
	Shop = false,
	Blips = false,
	Blip = {Sprite = 326, Color = 5, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 255, g = 222, b = 0, x = 1.5, y = 1.5, z = 1.0}, -- Standard Size Circle.
		Resell = {Type = 20, r = 255, g = 222, b = 0, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(0.0, 0.0, 0.0),
			Inside = vector3(0.0, 0.0, 0.0),
			Outside = vector3(0.0, 0.0, 0.0),
			Resell = vector3(0.0, 0.0, 0.0),
			InsideH = 0.0,
			OutsideH = 0.0
		}
	}
}

Config.VIPCar = {
	Shop = true,
	Blips = false,
	Blip = {Sprite = 326, Color = 5, Display = 4, Scale = 0.8},
	License = false,
	ResellPerc = 50,
	Markers = {
		Enter = {Type = 20, r = 255, g = 222, b = 0, x = 0.5, y = 0.5, z = 0.3}, -- Standard Size Circle.
		Resell = {Type = 20, r = 255, g = 222, b = 0, x = 3.0, y = 3.0, z = 1.0} -- Medium Size Circle.
	},
	Locations = {
		Los_Santos = {
			Enter = vector3(116.7429, -128.0571, 60.48572),
			Inside = vector3(113.6967, -147.0462, 60.04175),
			Outside = vector3(134.8747, -134.4396, 54.90845),
			Resell = vector3(0.0, 0.0, 0.0),
			InsideH =  294.8032,
			OutsideH = 155.9055
		}
	}
}
