---wip types

---@class OxShop
---@field name string
---@field label? string
---@field blip? { id: number, colour: number, scale: number }
---@field inventory { name: string, price: number, count?: number, currency?: string }
---@field locations? vector3[]
---@field targets? { loc: vector3, length: number, width: number, heading: number, minZ: number, maxZ: number, distance: number, debug?: boolean, drawSprite?: boolean }[]
---@field groups? string | string[] | { [string]: number }
---@field model? number[]

return {
	General = {
		name = 'Shop',
		blip = {
			id = 59, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'air', price = 1000 },
			{ name = 'roti', price = 1000 },
			{ name = 'radio', price = 2500 },
			{ name = 'classic_phone', price = 5000 },
			{ name = 'notepad', price = 3000 },
		}, locations = {
			vec3(25.7, -1347.3, 29.49),
			vec3(-3038.71, 585.9, 7.9),
			vec3(-3241.47, 1001.14, 12.83),
			vec3(1728.66, 6414.16, 35.03),
			vec3(1697.99, 4924.4, 42.06),
			vec3(1961.48, 3739.96, 32.34),
			vec3(547.79, 2671.79, 42.15),
			vec3(2679.25, 3280.12, 55.24),
			vec3(2557.94, 382.05, 108.62),
			vec3(373.55, 325.56, 103.56),
			vec3(-707.3934, -914.8879, 19.20361),
			vec3(-47.4307, -1757.5820, 29.6741),
			vec3(1164.2821, -323.7998, 69.1925),
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319),
		}, targets = {
			{ loc = vec3(25.06, -1347.32, 29.5), length = 0.7, width = 0.5, heading = 0.0, minZ = 29.5, maxZ = 29.9, distance = 1.5 },
			{ loc = vec3(-3039.18, 585.13, 7.91), length = 0.6, width = 0.5, heading = 15.0, minZ = 7.91, maxZ = 8.31, distance = 1.5 },
			{ loc = vec3(-3242.2, 1000.58, 12.83), length = 0.6, width = 0.6, heading = 175.0, minZ = 12.83, maxZ = 13.23, distance = 1.5 },
			{ loc = vec3(1728.39, 6414.95, 35.04), length = 0.6, width = 0.6, heading = 65.0, minZ = 35.04, maxZ = 35.44, distance = 1.5 },
			{ loc = vec3(1698.37, 4923.43, 42.06), length = 0.5, width = 0.5, heading = 235.0, minZ = 42.06, maxZ = 42.46, distance = 1.5 },
			{ loc = vec3(1960.54, 3740.28, 32.34), length = 0.6, width = 0.5, heading = 120.0, minZ = 32.34, maxZ = 32.74, distance = 1.5 },
			{ loc = vec3(548.5, 2671.25, 42.16), length = 0.6, width = 0.5, heading = 10.0, minZ = 42.16, maxZ = 42.56, distance = 1.5 },
			{ loc = vec3(2678.29, 3279.94, 55.24), length = 0.6, width = 0.5, heading = 330.0, minZ = 55.24, maxZ = 55.64, distance = 1.5 },
			{ loc = vec3(2557.19, 381.4, 108.62), length = 0.6, width = 0.5, heading = 0.0, minZ = 108.62, maxZ = 109.02, distance = 1.5 },
			{ loc = vec3(373.13, 326.29, 103.57), length = 0.6, width = 0.5, heading = 345.0, minZ = 103.57, maxZ = 103.97, distance = 1.5 },
			{ loc = vec3(-707.3934, -914.8879, 19.20361), length = 0.8, width = 0.8, heading = 0.0, minZ = 15.0, maxZ = 25.97, distance = 1.5 },
			{ loc = vec3(-47.4307, -1757.5820, 29.674), length = 0.8, width = 0.8, heading = 0.0, minZ = 25.0, maxZ = 32.97, distance = 1.5 },
			{ loc = vec3(1164.2821, -323.7998, 69.1925), length = 0.8, width = 0.8, heading = 0.0, minZ = 64.0, maxZ = 73.97, distance = 1.5 },
			{ loc = vec3(1134.9, -982.34, 46.41), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(-1222.33, -907.82, 12.43), length = 0.6, width = 0.5, heading = 32.7, minZ = 12.3, maxZ = 12.7, distance = 1.5 },
			{ loc = vec3(-1486.67, -378.46, 40.26), length = 0.6, width = 0.5, heading = 133.77, minZ = 40.1, maxZ = 40.5, distance = 1.5 },
			{ loc = vec3(-2967.0, 390.9, 15.14), length = 0.7, width = 0.5, heading = 85.23, minZ = 15.0, maxZ = 15.4, distance = 1.5 },
			{ loc = vec3(1165.95, 2710.20, 38.26), length = 0.6, width = 0.5, heading = 178.84, minZ = 38.1, maxZ = 38.5, distance = 1.5 },
			{ loc = vec3(1393.0, 3605.95, 35.11), length = 0.6, width = 0.6, heading = 200.0, minZ = 35.0, maxZ = 35.4, distance = 1.5 },
		}
	},

	--[[Liquor = {
		name = 'Liquor Store',
		blip = {
			id = 93, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
			{ name = 'burger', price = 15 },
		}, locations = {
			vec3(1135.808, -982.281, 46.415),
			vec3(-1222.915, -906.983, 12.326),
			vec3(-1487.553, -379.107, 40.163),
			vec3(-2968.243, 390.910, 15.043),
			vec3(1166.024, 2708.930, 38.157),
			vec3(1392.562, 3604.684, 34.980),
			vec3(-1393.409, -606.624, 30.319)
		}, targets = {
			{ loc = vec3(1134.9, -982.34, 46.41), length = 0.5, width = 0.5, heading = 96.0, minZ = 46.4, maxZ = 46.8, distance = 1.5 },
			{ loc = vec3(-1222.33, -907.82, 12.43), length = 0.6, width = 0.5, heading = 32.7, minZ = 12.3, maxZ = 12.7, distance = 1.5 },
			{ loc = vec3(-1486.67, -378.46, 40.26), length = 0.6, width = 0.5, heading = 133.77, minZ = 40.1, maxZ = 40.5, distance = 1.5 },
			{ loc = vec3(-2967.0, 390.9, 15.14), length = 0.7, width = 0.5, heading = 85.23, minZ = 15.0, maxZ = 15.4, distance = 1.5 },
			{ loc = vec3(1165.95, 2710.20, 38.26), length = 0.6, width = 0.5, heading = 178.84, minZ = 38.1, maxZ = 38.5, distance = 1.5 },
			{ loc = vec3(1393.0, 3605.95, 35.11), length = 0.6, width = 0.6, heading = 200.0, minZ = 35.0, maxZ = 35.4, distance = 1.5 }
		}
	},

	YouTool = {
		name = 'YouTool',
		blip = {
			id = 402, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'lockpick', price = 10 }
		}, locations = {
			vec3(2748.0, 3473.0, 55.67),
			vec3(342.99, -1298.26, 32.51)
		}, targets = {
			{ loc = vec3(2746.8, 3473.13, 55.67), length = 0.6, width = 3.0, heading = 65.0, minZ = 55.0, maxZ = 56.8, distance = 3.0 }
		}
	},]]--

	Ammunation = {
		name = 'Ammunation',
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'WEAPON_KNIFE', price = 20000, license = 'weapon' },
			{ name = 'WEAPON_MACHETE', price = 20000, license = 'weapon' },
			-- { name = 'WEAPON_MUSKET', price = 5000, license = 'weapon' },
			{ name = 'WEAPON_BAT', price = 2500, license = 'weapon' },
			{ name = 'parachute', price = 5000, license = 'weapon' },
			{ name = 'WEAPON_PISTOL', price = 100000, metadata = { registered = true, serial = 'AMMU' }, license = 'weapon' },
		}, locations = {
			vec3(-662.180, -934.961, 21.829),
			vec3(810.25, -2157.60, 29.62),
			vec3(1693.44, 3760.16, 34.71),
			vec3(-330.24, 6083.88, 31.45),
			vec3(252.63, -50.00, 69.94),
			vec3(22.56, -1109.89, 29.80),
			vec3(2567.69, 294.38, 108.73),
			vec3(-1117.58, 2698.61, 18.55),
			vec3(842.44, -1033.42, 28.19)
		}, targets = {
			{ loc = vec3(-660.92, -934.10, 21.94), length = 0.6, width = 0.5, heading = 180.0, minZ = 21.8, maxZ = 22.2, distance = 2.0 },
			{ loc = vec3(808.86, -2158.50, 29.73), length = 0.6, width = 0.5, heading = 360.0, minZ = 29.6, maxZ = 30.0, distance = 2.0 },
			{ loc = vec3(1693.57, 3761.60, 34.82), length = 0.6, width = 0.5, heading = 227.39, minZ = 34.7, maxZ = 35.1, distance = 2.0 },
			{ loc = vec3(-330.29, 6085.54, 31.57), length = 0.6, width = 0.5, heading = 225.0, minZ = 31.4, maxZ = 31.8, distance = 2.0 },
			{ loc = vec3(252.85, -51.62, 70.0), length = 0.6, width = 0.5, heading = 70.0, minZ = 69.9, maxZ = 70.3, distance = 2.0 },
			{ loc = vec3(23.68, -1106.46, 29.91), length = 0.6, width = 0.5, heading = 160.0, minZ = 29.8, maxZ = 30.2, distance = 2.0 },
			{ loc = vec3(2566.59, 293.13, 108.85), length = 0.6, width = 0.5, heading = 360.0, minZ = 108.7, maxZ = 109.1, distance = 2.0 },
			{ loc = vec3(-1117.61, 2700.26, 18.67), length = 0.6, width = 0.5, heading = 221.82, minZ = 18.5, maxZ = 18.9, distance = 2.0 },
			{ loc = vec3(841.05, -1034.76, 28.31), length = 0.6, width = 0.5, heading = 360.0, minZ = 28.2, maxZ = 28.6, distance = 2.0 }
		}
	},

	PoliceShop = {
		name = 'Persenjataan Kepolisian',
		groups = {
			['police'] = 15,
		},
		blip = {
			id = 110, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'WEAPON_FLASHLIGHT', price = 150000, grade = 15 },
			{ name = 'WEAPON_NIGHTSTICK', price = 150000, grade = 15 },
			{ name = 'WEAPON_STUNGUN', price = 150000, metadata = { registered = true, serial = 'POL' }, grade = 15 },
			{ name = 'WEAPON_HEAVYPISTOL', price = 100000, metadata = { registered = true, serial = 'POL' }, grade = 15 },
			{ name = 'WEAPON_APPISTOL', price = 100000, metadata = { registered = true, serial = 'POL' }, grade = 15 },
			{ name = 'WEAPON_SMG_MK2', price = 150000, metadata = { registered = true, serial = 'POL' }, grade = 15 },
			{ name = 'WEAPON_REVOLVER', price = 150000, metadata = { registered = true, serial = 'POL' }, grade = 15 },
			{ name = 'WEAPON_HEAVYSNIPER_MK2', price = 150000, metadata = { registered = true, serial = 'POL' }, grade = 15 },
			{ name = 'WEAPON_BULLPUPRIFLE', price = 150000, metadata = { registered = true, serial = 'POL' }, grade = 15 },
		}, locations = {
			vec3(456.1875, -992.8599, 30.6896)
		}, targets = {
			{ loc = vec3(456.1875, -992.8599, 30.6896), length = 2.0, width = 2.0, heading = 0.0, minZ = 28.0, maxZ = 35.0, distance = 2.0 }
		}
	},
	

	
	Medicine = {
		name = 'Farmasi Paramedis',
		groups = {
			['ambulance'] = 5,
		},
		blip = {
			id = 403, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'perban', price =  800, grade = 0 }
		}, locations = {
			vector3(308.8775, -562.3710, 43.2840)
		}, targets = {
			{ loc = vec3(308.8775, -562.3710, 43.2840), length = 4.0, width = 4.0, heading = 0.0, minZ = 40, maxZ = 45.0, distance = 3.0 }
		}
	},

	BlackMarketArms = {
		name = 'Black Market',
		groups = {
			['fama'] = 0,
			['famb'] = 0,
			['famc'] = 0,
			['famd'] = 0,
			['fame'] = 0,
			['famg'] = 0,
			['famf'] = 0,
		},
		inventory = {
			{ name = 'WEAPON_ASSAULTRIFLE', price = 500000, metadata = { registered = false	}, currency = 'black_money' },
			{ name = 'WEAPON_PISTOL50', price = 135000, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'WEAPON_REVOLVER_MK2', price = 300000, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'WEAPON_HEAVYSNIPER', price = 1000000, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'WEAPON_MICROSMG', price = 190000, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'WEAPON_MINISMG', price = 170000, metadata = { registered = false }, currency = 'black_money' },
			{ name = '45ammo', price = 670, metadata = { registered = false }, currency = 'black_money' },
			{ name = '9ammo', price = 500, metadata = { registered = false }, currency = 'black_money' },
			{ name = '762ammo', price = 800, metadata = { registered = false }, currency = 'black_money' },
			{ name = '556ammo', price = 500, metadata = { registered = false }, currency = 'black_money' },
			{ name = '300ammo', price = 1670, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'at_clip_extended_pistol', price = 500, metadata = { registered = false }, currency = 'black_money' },
			{ name = 'at_clip_extended_smg', price = 500, metadata = { registered = false }, currency = 'black_money' }, 
		}, locations = {
			vec3(1665.4701, -0.4436, 166.1182),
		}, targets = {
			{ loc = vec3(1665.4701, -0.4436, 166.1182), length = 3.0, width = 3.0, heading = 0.0, minZ = 165.0, maxZ = 169.0, distance = 2.0 }
		}
	},

	MarketPlace = {
		name = 'MarketPlace',
		groups = {
			['pedagang'] = 6
		},
		blip = {
			id = 402, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'minyakgoreng', price = 10, grade = 6 },
			{ name = 'adonan', price = 5, grade = 6 },
			{ name = 'gula', price = 5, grade = 6 },
			{ name = 'mineral', price = 5, grade = 6 },
			{ name = 'paketandaging', price = 10, grade = 6 },
			{ name = 'beras', price = 8, grade = 6 },
			{ name = 'garam', price = 8, grade = 6 },
		}, locations = {
			vec3(-591.4418, -1153.398, 22.32092)
		}, targets = {
			{ loc = vec3(-591.4418, -1153.398, 22.32092), length = 0.6, width = 3.0, heading = 65.0, minZ = 21.0, maxZ = 25.8, distance = 3.0 }
		}
	},

	VendingMachineDrinks = {
		name = 'Vending Machine',
		inventory = {
			{ name = 'water', price = 10 },
			{ name = 'cola', price = 10 },
		},
		model = {
			`prop_vend_soda_02`, `prop_vend_fridge01`, `prop_vend_water_01`, `prop_vend_soda_01`
		}
	},
	
	MechanicTools = {
		name = 'Perkakas Mekanik',
		groups = {
			['mechanic'] = 0
		},
		blip = {
			id = 402, colour = 69, scale = 0.8
		}, inventory = {
			{ name = 'enginekit', price = 2500, grade = 3},
			{ name = 'repairkit', price = 8000, grade = 3},
			{ name = 'WEAPON_WRENCH', price = 850, grade = 3},
			{ name = 'WEAPON_FIREEXTINGUISHER', price = 500, grade = 3},
			{ name = 'nitro', price = 2500, grade = 3},
		}, locations = {
			vec3(-319.8270, -137.4739, 39.0157),
		}, targets = {
			{ loc = vec3(-319.8270, -137.4739, 39.0157), length = 2.0, width = 2.0, heading = 0.0, minZ = 27.0, maxZ = 232.0, distance = 2.0 },
		}
	},
}
