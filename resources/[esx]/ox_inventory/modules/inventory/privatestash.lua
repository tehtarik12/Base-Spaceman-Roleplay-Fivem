local ox_inventory = exports.ox_inventory
local PrivateStash = {
    {
        -- Perumnas 1
        identifier = 'char1:110000141c7f7ab',
        stash = {
            coords = vec3(894.6770, -626.4950, 58.4391),
            target = {
                loc = vec3(894.6770, -626.4950, 58.4391),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 55.17,
                maxZ = 63.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },

    {
        -- Perumnas 2
        identifier = '',
        stash = {
            coords = vec3(1325.96, -523.8989, 72.43225),
            target = {
                loc = vec3(1325.96, -523.8989, 72.43225),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 71.17,
                maxZ = 73.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },

    {
        -- Perumnas 3
        identifier = '',
        stash = {
            coords = vec3(1350.936, -535.3714, 73.88135),
            target = {
                loc = vec3(1350.936, -535.3714, 73.88135),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 71.17,
                maxZ = 74.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },

    {
        -- Perumnas 4
        identifier = '',
        stash = {
            coords = vec3(1370.862, -543.9297, 74.67322),
            target = {
                loc = vec3(1370.862, -543.9297, 74.67322),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 72.17,
                maxZ = 75.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },

    {
        -- Perumnas 5
        identifier = '',
        stash = {
            coords = vec3(1398.752, -563.0637, 74.48792),
            target = {
                loc = vec3(1398.752, -563.0637, 74.48792),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 72.17,
                maxZ = 75.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },

    {
        -- Perumnas 6
        identifier = 'char1:1100001192fcff3',
        stash = {
            coords = vec3(1396.589, -598.8132, 74.47107),
            target = {
                loc = vec3(1396.589, -598.8132, 74.47107),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 72.17,
                maxZ = 75.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },

    {
        -- Perumnas 7
        identifier = '',
        stash = {
            coords = vec3(1369.319, -618.1187, 74.70691),
            target = {
                loc = vec3(1369.319, -618.1187, 74.70691),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 72.17,
                maxZ = 75.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },

    {
        -- Perumnas 8
        identifier = 'char1:11000010db0b0a9',
        stash = {
            coords = vec3(1340.598, -609.2967, 74.69006),
            target = {
                loc = vec3(1340.598, -609.2967, 74.69006),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 72.17,
                maxZ = 75.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },

    {
        -- Perumnas 9
        identifier = 'char1:110000141c7f7ab',
        stash = {
            coords = vec3(1320.462, -594.5802, 73.24097),
            target = {
                loc = vec3(1320.462, -594.5802, 73.24097),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 71.17,
                maxZ = 74.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },

    {
        -- Perumnas 10
        identifier = '',
        stash = {
            coords = vec3(1299.679, -585.8637, 71.72449),
            target = {
                loc = vec3(1299.679, -585.8637, 71.72449),
                length = 4.0,
                width = 4.0,
                heading = 0,
                minZ = 69.17,
                maxZ = 72.17,
                label = 'Buka Brankas'
            },
            name = 'Brankas Pribadi',
            label = 'Brankas Pribadi',
            owner = false,
            slots = 350,
            weight = 10000000
        },
    },


}

Citizen.CreateThread(function()
    for k,v in pairs(PrivateStash) do
        exports['qtarget']:AddBoxZone(v.stash.name..v.identifier, v.stash.target.loc, 1.5, 1.5, {
            name=v.stash.name..v.identifier,
            heading=v.stash.target.heading,
            minZ=v.stash.target.minZ,
            maxZ=v.stash.target.maxZ,
            }, {
                options = {
                    {
                        action = function()
                            if ox_inventory:openInventory('stash', v.stash.name) == false then
                                TriggerServerEvent('ox:privatestash', v)
                                ox_inventory:openInventory('stash', v.stash.name)
                            end
                        end,
                        icon = "fas fa-warehouse",
                        label = v.stash.target.label,
                        canInteract = function()
                            return ESX.GetPlayerData().identifier == v.identifier
                        end,
                    },
                },
                distance = 3.5
        })
    end
end)