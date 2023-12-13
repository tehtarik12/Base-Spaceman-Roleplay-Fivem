cfg = {
    esxLegacy = true,

    PedList = {
        'g_m_y_lost_02',
        'a_m_m_prolhost_01',
        'a_m_m_hillbilly_01',
    },

    blip = {
		['Kecubung'] = {
            process = vector3(1443.547, 6332.374, 23.97217),
            processname = "Proses Kecubung",
            process2 = nil,
            processname2 = nil,
            blip = nil,
            blipname = nil,
        },
        
        ['Micin'] = {
            process = vector3(848.5359, -2504.2715, 40.7195),
            processname = "Proses Micin",
            process2 = nil,
            processname2 = nil,
            blip = nil,
            blipname = nil,
        },
        
        ['sell'] = {
            selllocation = {
                ['Kecubung'] = {vector3(2352.712, 2523.561, 47.67981), 303.3071, 'Penadah Kecubung'},
                ['MICIN'] = {vector3(93.0216, 3755.3586, 40.7732), 162.6537, 'Penadah Micin'},
            },
        },

    },

    price = {
        ['kecubungjadi'] = 10000,
        ['micinjadi'] = 12000,
    },

    translation = {
        ['Kecubung'] = "[E] Proses Kecubung",
        ['Micin'] = "[E] Proses Micin",
    },
}


Config =
{
    Blip = {
        Coords  = vector3(2918.4, 621.7978, 1.612427),
        Coords2 = vector3(-390.3165, 2555.472, 90.9165),
        Sprite  = 310,
        Display = 4,
        Scale   = 0.8,
        Colour  = 1
    },
}

Notify = function(msg)
    ESX.ShowNotification(msg)
end