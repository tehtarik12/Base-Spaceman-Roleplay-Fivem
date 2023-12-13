CreateThread(function()
    while true do
        local cas = 1000
        local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())
        if ESX and ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name then
            for k,v in pairs(Config.Location) do
                if v[2] == nil or (v[2] and v[2][ESX.PlayerData.job.name]) then
                    local pos = v[1]
                    local dist = #(Coords - pos)
                    if dist < 3 then
                        cas = 5
                        ESX.ShowFloatingHelpNotification('[ALT] to on/off duty', v[1])
                    end
                end
            end
        end
        Wait(cas)
    end
end)



ShowFloatingHelpNotification = function(msg, pos)
    AddTextEntry('text', msg)
    SetFloatingHelpTextWorldPosition(1, pos.x, pos.y, pos.z)
    SetFloatingHelpTextStyle(2, 1, 25, -1, 3, 0)
    BeginTextCommandDisplayHelp('text')
    EndTextCommandDisplayHelp(2, false, false, -1)
end


-- Ambulance
-- exports['qtarget']:AddTargetModel({-1339628889}, {
--     options = {
--         {
--             type = 'server',
--             event = 'vinsan_jobs:Duty',
--             icon = "fas fa-clipboard",
--             label = "On/Off Duty",
-- 			--index = 'ambulance',
-- 			job = {
--                 ["ambulance"] = 0,
-- 				["offambulance"] = 0,
--             }
--         },
--     },
--     distance = 2.0
-- })


-- Test Ambulance
exports['qtarget']:AddBoxZone("AmbulanceDuty", vector3(306.9725, -595.0955, 43.2840), 1.10, 1.10, {
	name="AmbulanceDuty",
	heading=252.1247,
	debugPoly=false,
	minZ=40,
	maxZ=45,
	}, {
    options = {
		{
            type = 'server',
            event = 'vinsan_jobs:Duty',
            icon = "fas fa-clipboard",
            label = "On/Off Duty",
			--index = 'mechanic',
			job = {
                ["ambulance"] = 0,
				["offambulance"] = 0,
            }
        },
    },
    distance = 5.0
})

-- Police departement
-- exports['qtarget']:AddTargetModel({-824819003}, {
--     options = {
-- 		{
--             type = 'server',
--             event = 'vinsan_jobs:Duty',
--             icon = "fas fa-clipboard",
--             label = "On/Off Duty",
-- 			--index = 'police',
-- 			job = {
--                 ["police"] = 0,
-- 				["offpolice"] = 0,
--             }
--         },
--     },
--     distance = 2.0
-- })


-- Police Duty
exports['qtarget']:AddBoxZone("PoliceDuty", vector3(440.9472, -981.1534, 30.6896), 3.10, 3.10, {
	name="PoliceDuty",
	heading=274.9606,
	debugPoly=false,
	minZ=29,
	maxZ=31,
	}, {
    options = {
		{
            type = 'server',
            event = 'vinsan_jobs:Duty',
            icon = "fas fa-clipboard",
            label = "On/Off Duty",
			--index = 'mechanic',
			job = {
                ["police"] = 0,
				["offpolice"] = 0,
            }
        },
    },
    distance = 5.0
})

-- Mechanic Kota
exports['qtarget']:AddBoxZone("MechanicLocker", vector3(1-323.3873, -147.7281, 39.0157), 4, 4, {
	name="MechanicLocker",
	heading= 3.1372,
	debugPoly=false,
	minZ=37,
	maxZ=42,
	}, {
    options = {
		{
            type = 'server',
            event = 'vinsan_jobs:Duty',
            icon = "fas fa-clipboard",
            label = "On/Off Duty",
			--index = 'mechanic',
			job = {
                ["mechanic"] = 0,
				["offmechanic"] = 0,
            }
        },
    },
    distance = 5.0
})

-- Mechanic SS
exports['qtarget']:AddBoxZone("MechanicDuty", vector3(126.0840, -3007.8254, 7.0409), 4, 4, {
	name="MechanicDuty",
	heading=11.0,
	debugPoly=false,
	minZ=40,
	maxZ=42,
	}, {
    options = {
		{
            type = 'server',
            event = 'vinsan_jobs:Duty',
            icon = "fas fa-clipboard",
            label = "On/Off Duty",
			--index = 'mechanic',
			job = {
                ["mechanic"] = 0,
				["offmechanic"] = 0,
            }
        },
    },
    distance = 5.0
})

-- Pedagang
exports['qtarget']:AddBoxZone("PedagangCashier", vector3(-1837.6094, -1191.0513, 14.3092), 1.10, 1.10, {
	name="PedagangCashier",
	heading= 106.9201,
	debugPoly=false,
	minZ=13,
	maxZ=18,
	}, {
    options = {
		{
            type = 'server',
            event = 'vinsan_jobs:Duty',
            icon = "fas fa-clipboard",
            label = "On/Off Duty",
			job = {
                ["pedagang"] = 0,
				["offpedagang"] = 0,
            }
        },
    },
    distance = 5.0
})