Config = {}

Config.Locale = 'en'

Config.EnableVersionCheck = true -- If set to true you'll get a print in server console when your resource is out of date

-- If using split garages on first start all vehicles will default to legion garage. after that they will restore at the last garage you put it in.
Config.RestoreVehicles = false

-- Send Null Garage to impound 
Config.SetImpoundVehicle = true 

Config.TeleportToVehicle = true -- enable this if you have issues with vehicle mods not setting properly.

-- Default garage zone name the vehicles will be restored to
-- Ignore if not using split garages
Config.DefaultGarage = 'walkot'

-- Setting to true will only allow you take out the vehicle from a garage you put it in
Config.SplitGarages = true

Config.DefaultGaragePed = `s_m_y_airworker`

Config.DefaultImpoundPed = `s_m_y_construct_01`

Config.Blip = {
    Car = 50,
    Boat = 471,
    Aircraft = 572
}

Config.BlipColors = {
    Car = 3,
    Boat = 3,
    Aircraft =3 
}

Config.ImpoundPrices = {
    -- These are vehicle classes
    [0] = 300, -- Compacts
    [1] = 500, -- Sedans
    [2] = 500, -- SUVs
    [3] = 800, -- Coupes
    [4] = 1200, -- Muscle
    [5] = 800, -- Sports Classics
    [6] = 1500, -- Sports
    [7] = 2500, -- Super
    [8] = 300, -- Motorcycles
    [9] = 500, -- Off-road
    [10] = 1000, -- Industrial
    [11] = 500, -- Utility
    [12] = 600, -- Vans
    [13] = 100, -- Cylces
    [14] = 2800, -- Boats
    [15] = 3500, -- Helicopters
    [16] = 3800, -- Planes
    [17] = 500, -- Service
    [18] = 0, -- Emergency
    [19] = 100, -- Military
    [20] = 1500, -- Commercial
    [21] = 0 -- Trains (lol)
}

Config.PayInCash = true -- whether you want to pay impound price in cash, otherwise uses bank

Config.Impounds = {
    {
        label = "Car Impound",
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(409.25, -1623.08, 28.29, 228.84),
        zone = {name = 'innocence', x = 408.02, y = -1637.08, z = 29.29, l = 31.6, w = 26.8, h = 320, minZ = 28.29, maxZ = 32.29}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        blip = {
            scale = 0.8,
            sprite = 285,
            colour = 3
        },
        spawns = {
            vector4(411.4716, -1636.8604, 29.5645, 228.8444),
            vector4(409.2838, -1639.1593, 29.5670, 225.7191),
            vector4(399.1451, -1635.8022, 29.5665, 142.0577),
        }
    },
    -- {
    --     type = 'boat',
    --     pedCoords = vector4(-462.92, -2443.44, 5.00, 322.40),
    --     zone = {name = 'lsboat_impound', x = -451.72, y = -2440.42, z = 6.0, l = 22.6, w = 29.4, h = 325, minZ = 5.0, maxZ = 9.0},
    --     spawns = {
    --         vector4(-493.48, -2466.38, -0.06, 142.26),
    --         vector4(-471.09, -2483.94, 0.28, 152.74),
    --     }
    -- },
    -- {
    --     type = 'aircraft',
    --     pedCoords = vector4(1758.29, 3297.50, 40.15, 148.27),
    --     zone = {name = 'sandy_air', x = 1757.71, y = 3296.72, z = 41.15, l = 14.4, w = 18.0, h = 50, minZ = 40.13, maxZ = 44.13},
    --     spawns = {
    --         vector4(1753.72, 3272.12, 41.99, 105.71),
    --         vector4(1746.85, 3252.57, 42.30, 105.58),
    --     }
    -- },
    --[[
        TEMPLATE:
        {
            label = "", -- Display label for the impound (Optional)
            type = 'car', -- can be 'car', 'boat' or 'aircraft',
            ped = `ped_model_name` -- Define the model model you want to use for the impound (Optional)
            pedCoords = vector4(x, y, z, h), -- Ped MUST be inside the create zone
            zone = {name = 'somename', x = X, y = X, z = X, l = X, w = X, h = X, minZ = X, maxZ = x}, -- l is length of the box zone, w is width, h is heading, take all walues from generated zone from /pzcreate
            blip = { -- Define specific blip setting for this impound (Optional)
                scale = 0.8,
                sprite = 285,
                colour = 3
            },
            spawns = { -- You can have as many as you'd like
                vector4(x, y, z, h),
                vector4(x, y, z, h)
            }
        },
    ]]
}

Config.Garages = {
    {
        label = 'Garasi Kota',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-283.2543, -888.8652, 30.0806, 89.2409), -- The Ped MUST be inside the PolyZone
        zone = {name = 'kota', x = -299.6603, y = -891.9414, z = 30.0806, l = 20.0, w = 40.8, h = 31, minZ = 29.29, maxZ = 32.29}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
            vector4(-289.4732, -887.1520, 31.0806, 168.6920),
            vector4(-296.9715, -885.4932, 31.0806, 167.9580),
            vector4(-303.7202, -883.8427, 31.0806, 171.6350),
        }
    },
    {
        label = 'Garasi Import',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(764.5184, -3202.9016, 5.0802, 277.3384), -- The Ped MUST be inside the PolyZone
        zone = {name = 'import', x = 767.6921, y= -3202.8682, z =5.9005, l = 30.0, w = 40.8, h = 31, minZ = 1.29, maxZ = 10.29}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
            vector4(757.7169, -3195.0605, 6.6396, 268.6890),
            vector4(771.3622, -3213.3347, 6.4676, 179.7937),
            vector4(776.9607, -3213.4331, 6.4676, 0.8735),
        }
    },
    {
        label = 'Garasi Balai Kota',
        type = 'car',
        pedCoords = vector4(-532.4769, -267.7295, 34.3798, 202.1642),
        zone = {name = 'walkot', x = -531.92, y = -270.58, z = 34.21, l = 20.0, w = 20.0, h = 0, minZ = 34.15, maxZ = 38.35},
        spawns = {
            vector4(-531.5811, -270.2472, 35.2150, 110.6379),
        }
    },
    {
        label = 'Garasi Perumnas',
        type = 'car',
        pedCoords = vector4(1035.138, -765.2176, 56.99194, 147.4016),
        zone = {name = 'perumnas', x = 1035.138, y = -765.2176, z = 56.99194, l = 50.0, w = 50.0, h = 0, minZ = nil, maxZ =nil}, 
        spawns = {
            vector4(1022.98, -779.8549, 57.13257, 308.9764),
        }
    },
    
    {
        label = 'Garasi Paleto',
        type = 'car',
        pedCoords = vector4(140.62, 6613.02, 31.06, 183.37),
        zone = {name = 'paleto', x = 152.63, y = 6600.21, z = 30.84, l = 28.2, w = 27.2, h = 0, minZ = 30.84, maxZ = 34.84},
        spawns = {
            vector4(145.55, 6601.92, 31.67, 357.80),
            vector4(150.56, 6597.71, 31.67, 359.00),
            vector4(155.55, 6592.92, 31.67, 359.57),
            vector4(145.90, 6613.97, 31.64, 0.60),
            vector4(151.04, 6609.26, 31.69, 357.50),
            vector4(155.84, 6602.45, 31.86, 0.47),
        }
    },
    {
        label = 'Garasi Sandy Shore',
        type = 'car',
        pedCoords = vector4(1697.248, 3595.741, 34.59851, 303.3071),
        zone = {name = 'ss', x = 1696.945, y = 3595.741, z = 34.59851, l = 20.0, w = 40.8, h = 31, minZ = nil, maxZ = nil},
        spawns = {
            vector4(1694.927, 3606.079, 34.67175, 212.5984),
        }
    },
    {
        label = 'Garasi Rumah Sakit',
        type = 'car',
        pedCoords = vector4(298.8116, -611.9025, 42.4487, 67.5023),
        zone = {name = 'rs', x = 298.8116, y = -611.9025, z = 43.4487, l = 30.0, w = 40.8, h = 31, minZ = nil, maxZ = nil},
        spawns = {
            vector4(290.8603, -609.9804, 43.6382, 69.2602),
        }
    },

    --------------- KAPAL

    -- {
    --     label = 'Highway Pier Garage',
    --     type = 'boat',
    --     pedCoords = vector4(-3428.27, 967.34, 7.35, 269.47),
    --     zone = {name = 'pier', x = -3426.48, y =  968.89, z = 8.35, l = 31.2, w = 39.2, h = 0, minZ = nil, maxZ = nil},
    --     spawns = {
    --         vector4(-3444.37, 952.64, 1.02, 98.70),
    --         vector4(-3441.02, 965.30, 0.17, 87.18),
    --     }
    -- },

    -- {
    --     label = 'L.S.M.Y.C',
    --     type = 'boat',
    --     pedCoords = vector4(-720.2437, -1324.3734, 0.5963, 136.2645),
    --     zone = {name = 'lsymc', x = -728.2803, y = -1331.6746, z = 1.5963, l = 31.2, w = 39.2, h = 0, minZ = nil, maxZ = nil},
    --     spawns = {
    --         vector4(-724.2203, -1329.2137, 0.3360, 228.3682),
    --         vector4(-730.3675, -1335.2556, 0.3602, 229.7064),
    --     }
    -- },
    ------------------- PESAWAT
    --[[{
        label = 'LSIA Garage',
        type = 'aircraft',
        pedCoords = vector4(-941.43, -2954.87, 12.95, 151.00),
        zone = {name = 'lsia', x = -968.31, y = -2992.47, z = 13.95, l = 94.4, w = 84.6, h = 330, minZ = nil, maxZ = nil},
        spawns = {
            vector4(-958.57, 2987.20, 13.95, 58.19),
            vector4(-971.89, 3008.83, 13.95, 59.47),
            vector4(-984.30, 3025.04, 13.95, 58.52),
        }
    }, ]]

    -------------------- JOB GARAGE

    {
        label = 'Heli Police Garage',
        type = 'aircraft',
        job = 'police',
        ped = `s_m_m_security_01`,
        pedCoords = vector4(463.1604, -981.9824, 42.6864, 87.87402),
        zone = {name = 'lspdheli', x = 463.1604, y=-981.9824, z=42.6864, l = 10, w = 30, h = 0, minZ = nil, maxZ = nil},
        spawns = {
            vector4(449.9341, -981.3362, 43.88867, 90.70866)
        }
    },

    -- {
    --     label = 'SSPD Heli Police Garage',
    --     type = 'aircraft',
    --     job = 'police',
    --     ped = `s_m_y_uscg_01`,
    --     pedCoords = vector4(1839.7637, 3690.6802, 38.6630, 84.3376),
    --     zone = {name = 'sspdheli', x = 1831.7439, y=3690.9265, z=38.7391, l = 15, w = 15, h = 0, minZ = nil, maxZ = nil},
    --     spawns = {
    --         vector4(1831.7423, 3690.9268, 38.7391, 25.5451)
    --     }
    -- },

    -- {
    --     label = 'PBPD Heli Police Garage',
    --     type = 'aircraft',
    --     job = 'police',
    --     ped = `s_m_y_uscg_01`,
    --     pedCoords = vector4(-467.2464, 5997.7642, 30.2587, 135.4743),
    --     zone = {name = 'pbpdpdheli', x = -475.2433, y=5988.4146, z=30.3367, l = 20, w = 20, h = 0, minZ = nil, maxZ = nil},
    --     spawns = {
    --         vector4(-480.9223, 5993.0508, 30.3367, 309.8634),
    --         vector4(-469.8076, 5980.7017, 30.3367, 317.6586)
    --     }
    -- },

    {
        label = 'Police Garage',
        type = 'car',
        job = 'police',
        ped = `s_m_y_cop_01`,
        pedCoords = vector4(458.6374, -1022.281, 27.26892, 90.70866),
        zone = {name = 'mrpd', x = 458.6374, y= -1022.281, z = 27.26892, l = 20, w = 40, h = 0, minZ = nil, maxZ = nil}, 
        spawns = {
            vector4(427.4769, -1027.437, 29.06079, 90.70866)
            -- vector4(442.5637, -1025.5530, 29.0, 1.7611),
            -- vector4(438.6664, -1027.0088, 29.0, 3.1104),
            -- vector4(434.8707, -1026.6675, 29.0, 3.9030),
            -- vector4(431.6170, -1026.7904, 29.0, 0.9789),
            -- vector4(427.3045, -1027.6506, 29.0, 5.8251)
        }
    },

    

    -- {
    --     label = 'SSPD Police Garage',
    --     type = 'car',
    --     job = 'police',
    --     ped = `s_m_y_cop_01`,
    --     pedCoords = vector4(1873.2944, 3698.0300, 32.4261, 117.8698),
    --     zone = {name = 'sspd', x = 1868.7203, y= 3696.4321, z=33.5544, l = 30, w = 40, h = 0, minZ = 31.03, maxZ = 35.03},
    --     spawns = {
    --         vector4(1868.5653, 3694.5320, 33.6113, 208.3439),
    --         vector4(1863.0498, 3703.7837, 33.4582, 213.5157)
    --     }
    -- },

    -- {
    --     label = 'PBPD Police Garage',
    --     type = 'car',
    --     job = 'police',
    --     ped = `s_m_y_cop_01`,
    --     pedCoords = vector4(376.37, -1622.81, 28.29, 231.13),
    --     zone = {name = 'pbpd', x = -467.4064, y =6026.5615, z=30.3405, l = 50, w = 50, h = 0, minZ = 29.03, maxZ = 33.03},
    --     spawns = {
    --         vector4(379.3, -1627.78, 29.56, 317.24),
    --         -- vector4(1863.0498, 3703.7837, 33.4582, 213.5157)
    --     }
    -- },


    {
        label = 'Pillbox Helicopter Garage',
        type = 'car',
        job = 'ambulance',
        ped = `s_m_m_doctor_01`,
        pedCoords = vector4(338.1585, -589.8749, 73.1656, 294.1248),
        zone = {name = 'pillbox', x = 338.1585, y=-589.8749, z=74.1656, l = 25, w = 25, h = 0, minZ = nil, maxZ = nil},
        spawns = {
            vector4(350.9602, -587.6190, 74.5297, 72.1323)
        }
    },

    
    --[[{
        label = 'Sandy Shores Medical Centre Helicopter Garage',
        type = 'aircraft',
        job = 'ambulance',
        ped = `s_m_m_doctor_01`,
        pedCoords = vector4(1830.7830, 3671.3145, 39.4045, 68.0615),
        zone = {name = 'ssmcheli', x = 1822.7623, y=3673.5078, z=40.2791, l = 15, w = 15, h = 0, minZ = nil, maxZ = nil},
        spawns = {
            vector4(1822.7623, 3673.5078, 40.2791, 298.5716)
        }
    },]]--

    {
        label = 'Pillbox Ambulance Garage',
        type = 'car',
        job = 'ambulance',
        ped = `s_m_m_doctor_01`,
        pedCoords = vector4(300.3723, -572.7722, 42.2627, 117.2096),
        zone = {name = 'pillbox', x = 300.3723, y = -572.7722, z = 43.2627, l = 25, w = 25, h = 0, minZ = nil, maxZ = nil},
        spawns = {
            vector4(285.2098, -564.1761, 43.3649, 30.1322)
        }
    },

    --[[{
        label = 'Sandy Shores Ambulance Garage',
        type = 'car',
        job = 'ambulance',
        ped = `s_m_m_doctor_01`,
        pedCoords = vector4(1836.6040, 3668.1570, 32.6794, 215.7787),
        zone = {name = 'ssmc', x = 1836.6040, y = 3668.1570, z = 32.6794, l = 25, w = 25, h = 0, minZ = 31.74, maxZ = 34.74},
        spawns = {
            vector4(1835.3147, 3664.4331, 33.7299, 207.3740),
            vector4(1831.9177, 3662.4199, 33.8892, 208.4245),
            vector4(1828.6525, 3660.9238, 33.8738, 215.2174),
            vector4(1825.3737, 3659.2834, 33.9782, 212.3284),
        }
    },]]--
    --[[
        TEMPLATE:
        {
            label = '', -- name that will be displayed in menus
            type = 'car', -- can be 'car', 'boat' or 'aircraft',
            job = 'jobName', -- Set garage to be only accessed and stored into by a job (Optional)
            -- If you want multiple jobs and grades you can do job = {['police'] = 0, ['mechanic'] = 3}
            ped = `ped_model_name`, -- Define the model model you want to use for the garage (Optional)
            pedCoords = vector4(x, y, z, h), -- Ped MUST be inside the create zone
            zone = {name = 'somename', x = X, y = X, z = X, l = X, w = X, h = X, minZ = X, maxZ = x}, -- l is length of the box zone, w is width, h is heading, take all walues from generated zone from /pzcreate
            blip = { -- Define specific blip setting for this garage (Optional)
                scale = 0.8,
                sprite = 357,
                colour = 3
            },
            spawns = { -- You can have as many as you'd like
                vector4(x, y, z, h),
                vector4(x, y, z, h)
            }
        },
    ]]
    {
        label = 'Garasi Casino',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-351.178, 221.1824, 84.77734, 192.7559), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Casino', x = -351.178, y = 221.1824, z = 85.77734, l = 20.0, w = 40.8, h = 31, minZ = 80, maxZ = 90}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
            vector4(-349.9253, 218.0308, 86.70398, 272.126),
        },
        hideblip = false
    },
    {
        label = 'Perumnas 2',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1335.969, -530.9934, 71.43225, 70.86614), -- The Ped MUST be inside the PolyZone
        zone = {name = 'perumnas2', x = 1335.969, y = -530.9934, z = 71.43225, l = 20.0, w = 40.8, h = 31, minZ = 60, maxZ = 73}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
            vector4(1317.007, -537.9165, 72.21313, 158.7402),
        },
        hideblip = true
    },
    {
        label = 'Perumnas 3',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1351.385, -541.9385, 72.88135, 65.19685), -- The Ped MUST be inside the PolyZone
        zone = {name = 'perumnas3', x = 1351.385, y = -541.9385, z = 72.88135, l = 20.0, w = 40.8, h = 31, minZ = 60, maxZ = 76}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
            vector4(1353.02, -554.5582, 74.37, 155.9055),
        },
        hideblip = true
    },
    {
        label = 'Perumnas 4',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1380.752, -550.6813, 73.67322, 65.19685), -- The Ped MUST be inside the PolyZone
        zone = {name = 'perumnas4', x = 1380.752, y = -550.6813, z = 73.67322, l = 20.0, w = 40.8, h = 31, minZ = 60, maxZ = 76}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
            vector4(1362.119, -554.5582, 74.60583, 155.9055),
        },
        hideblip = true
    },
    {
        label = 'Perumnas 5',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1394.743, -568.1143, 73.48792, 28.34646), -- The Ped MUST be inside the PolyZone
        zone = {name = 'perumnas5', x = 1394.743, y = -568.1143, z = 73.48792, l = 20.0, w = 40.8, h = 31, minZ = 60, maxZ = 76}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
            vector4(1387.345, -578.0176, 74.60583, 110.5512),
        },
        hideblip = true
    },
    {
        label = 'Perumnas 6',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1390.391, -597.9165, 73.47107, 325.9843), -- The Ped MUST be inside the PolyZone
        zone = {name = 'perumnas6', x = 1390.391, y = -597.9165, z = 73.47107, l = 20.0, w = 40.8, h = 31, minZ = 60, maxZ = 76}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(1378.167, -596.4396, 74.5553, 48.18897),
        },
        hideblip = true
    },
	{
        label = 'Perumnas 7',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1366.233, -612.5275, 73.70691, 269.2914), -- The Ped MUST be inside the PolyZone
        zone = {name = 'perumnas7', x = 1366.233, y = -612.5275, z = 73.70691, l = 20.0, w = 40.8, h = 31, minZ = 60, maxZ = 76}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(1359.837, -601.0813, 74.5553, 0),
        },
        hideblip = true
    },
	{
        label = 'Perumnas 8',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1337.196, -604.1274, 73.69006, 325.9843), -- The Ped MUST be inside the PolyZone
        zone = {name = 'perumnas8', x = 1337.196, y = -604.1274, z =  73.69006, l = 20.0, w = 40.8, h = 31, minZ = 60, maxZ = 76}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(1347.468, -604.8264, 74.57214, 328.8189),
        },
        hideblip = true
    },
	{
        label = 'Perumnas 9',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1320.132, -587.9209, 72.24097, 249.4488), -- The Ped MUST be inside the PolyZone
        zone = {name = 'perumnas9', x = 1320.132, y = -587.9209, z = 73.24097, l = 20.0, w = 40.8, h = 31, minZ = 60, maxZ = 76}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(1319.275, -573.9692, 73.13989, 337.3228),
        },
        hideblip = true
    },
	
	{
        label = 'Perumnas 14',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(905.5412, -622.9399, 57.0487, 227.6179), -- The Ped MUST be inside the PolyZone
        zone = {name = 'perumnas14', x = 905.5412, y = -622.93991, z = 57.0487, l = 20.0, w = 40.8, h = 31, minZ = 50, maxZ = 62}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(907.3179, -625.2391, 58.3207, 315.4595),
        },
        hideblip = true
    },
	{
        label = 'Garasi Pantai',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-1194.7678, -1499.2976, 3.3681, 307.3032), -- The Ped MUST be inside the PolyZone
        zone = {name = 'garasipantai', x = -1195.7983, y = -1499.3920, z =  4.3610, l = 20.0, w = 40.8, h = 31, minZ = 1, maxZ = 5}, -- The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-1189.2633, -1495.5363, 4.6498, 214.3168),
        },
        hideblip = false
    },
	
	{
        label = 'Garasi Groove Street Gang',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(96.7104, -1956.5023, 19.7400, 333.3185), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Groove Street Gang', x = 99.4873, y = -1951.1038, z =  20.5967, l = 20.0, w = 40.8, h = 31, minZ = 18, maxZ = 22}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(95.7385, -1944.5967, 20.9659, 34.3553),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi The Cribs',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(1372.4443, -2090.1772, 50.9989, 36.1650), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi The Cribs', x = 1372.4443, y = -2090.1772, z =  51.9989, l = 20.0, w = 40.8, h = 31, minZ = 49, maxZ = 55}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(1369.3846, -2084.8833, 52.2711, 38.9882),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi The Dosmon',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(330.1309, -2016.6179, 20.9623, 142.7500), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi The Dosmon', x = 330.1309, y = -2016.6179, z =  21.9623, l = 20.0, w = 40.8, h = 31, minZ = 20, maxZ = 30}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(322.7421, -2023.9889, 21.1563, 141.3687),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi El Natanielie Fam',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-1924.0809, 2054.4429, 139.8315, 259.6200), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi El Natanielie Fam', x = -1924.0809, y = 2054.4429, z = 140.8315, l = 20.0, w = 40.8, h = 31, minZ = 135 , maxZ = 145}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-1918.2539, 2056.2629, 141.0081, 256.8580),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi ExBerabe2',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(980.6268, -129.4752, 73.0611, 240.2038), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi ExBerabe2', x = 980.6268, y = -129.4752, z = 74.0611, l = 20.0, w = 40.8, h = 31, minZ = 70, maxZ = 75}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(978.3164, -115.2092, 73.8644, 135.7247),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi Revenge',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(6.2201, 543.5340, 174.3616, 333.5595), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Revenge', x = 6.2201, y = 543.5340, z = 175.3616, l = 20.0, w = 40.8, h = 31, minZ = 170, maxZ = 180}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(2.3167, 547.9233, 175.0059, 125.9010),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi Gordline',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-100.7090, 831.8626, 234.7238, 12.8760), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Gordline', x = -100.7090, y = 831.8626, z = 234.7238, l = 20.0, w = 40.8, h = 31, minZ = 230, maxZ = 240}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-105.2832, 835.3762, 235.9512, 10.4128),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi Rumah Dika',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-3215.2168, 826.5579, 7.9309, 304.5659), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Rumah Dika', x = -3215.2168, y = 826.5579, z = 8.9309, l = 20.0, w = 40.8, h = 31, minZ = 5, maxZ = 10}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-3211.6614, 833.4714, 9.2041, 212.9154),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi Rumah Stz',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-806.9836, 804.9521, 201.1861, 17.61047), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Rumah Stz', x = -806.9836, y = 804.9521, z = 202.186, l = 20.0, w = 40.8, h = 31, minZ = 198, maxZ = 204}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-813.0713, 810.4354, 202.2398, 23.4421),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi Tongkrongan Sinners',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-393.4540, 289.0606, 83.8913, 267.3944), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Tongkrongan Sinners', x = -393.4540, y = 289.0606, z = 84.8913, l = 20.0, w = 40.8, h = 31, minZ = 80, maxZ = 87}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-389.2746, 288.0730, 85.1485, 177.8199),
        },
        hideblip = true
    },
	
		{
        label = 'Garasi Umum Kanpol',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(411.9012, -984.5531, 28.4169, 90.8490), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Umum Kanpol', x = 411.9012, y = -984.553, z = 29.4169, l = 20.0, w = 40.8, h = 31, minZ = 25, maxZ = 35}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(407.6337, -979.4290, 29.2688, 48.0334),
        },
        hideblip = false
    },
	
	{
        label = 'Garasi Asahie House',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-681.2885, 901.6290, 229.5754, 323.1619), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Asahie House', x = -681.2885, y = 901.6290, z = 230.5754, l = 20.0, w = 40.8, h = 31, minZ = 229, maxZ = 235}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-667.7422, 911.5811, 230.2119, 320.9145),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi Nikola House',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-1017.6887, 818.4003, 171.3868, 188.3627), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Nikola House', x = -1017.6887, y = 818.4003, z = 172.3868, l = 20.0, w = 40.8, h = 31, minZ = 170, maxZ = 175}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-1021.6349, 811.6493, 171.6436, 190.9429),
        },
        hideblip = true
    },
	
	
	{
        label = 'Garasi Tongkrongan Gordline',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-3041.6438, 105.1490, 10.5533, 319.5868), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Tongkrongan Gordline', x = -3041.6438, y = 105.1490, z = 11.5533, l = 20.0, w = 40.8, h = 31, minZ = 9, maxZ = 15}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-3034.2390, 102.6673, 11.8841, 319.8912),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi Matthew',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-1460.4672, -44.1233, 53.6857, 220.7460), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Matthew', x = -1460.4672, y = -44.1233, z = 54.6857, l = 20.0, w = 40.8, h = 31, minZ = 51, maxZ = 56}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-1450.7097, -53.2669, 53.0666, 247.6709),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi Arsha',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-1236.7042, 814.8580, 192.3800, 67.6381), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Arsha', x = -1236.7042, y = 814.8580, z = 193.3800, l = 20.0, w = 40.8, h = 31, minZ = 190, maxZ = 197}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-1240.6486, 821.4598, 193.6525, 337.3520),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi Asahie2',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(954.1075, -671.7585, 57.4523, 207.3025), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Asahie2', x = 954.1075, y = -671.7585, z = 58.4523, l = 20.0, w = 40.8, h = 31, minZ = 50, maxZ = 65}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(964.2204, -657.9584, 57.6870, 299.2239),
        },
        hideblip = true
    },
	
	{
        label = 'Garasi RobertNiko',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(904.7954, -483.1309, 58.4363, 110.4171), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi RobertNiko', x = 904.7954, y = -483.1309, z = 59.4363, l = 20.0, w = 40.8, h = 31, minZ = 50, maxZ = 68}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(915.1375, -491.3268, 59.2844, 202.3446),
        },
        hideblip = true
    },
	
		{
        label = 'Garasi Pearls',
        type = 'car', -- car, boat or aircraft
        pedCoords = vector4(-1832.3693, -1213.2933, 12.0177, 147.7625), -- The Ped MUST be inside the PolyZone
        zone = {name = 'Garasi Pearls', x = -1832.3693, y = -1213.2933, z = 13.0177, l = 20.0, w = 40.8, h = 31, minZ = 10, maxZ = 15}, --  The zone is only here for the ped to not have the impound option everywhere in the world
        spawns = {
           vector4(-1835.3148, -1215.3823, 13.0177, 239.7556),
        },
        hideblip = false
    },
}
  
-- BoxZone:Create(vector3(228.68, -789.15, 30.59), 52.4, 43.6, {
--     name="legion",
--     heading=340,
--     --debugPoly=true,
--     minZ=28.99,
--     maxZ=32.99
--   })
