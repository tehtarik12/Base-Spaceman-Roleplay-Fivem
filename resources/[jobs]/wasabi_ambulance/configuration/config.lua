-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

local seconds, minutes = 1000, 60000
Config = {}

--------------------------------------------------------------
-- TO MODIFY NOTIFICATIONS TO YOUR OWN CUSTOM NOTIFICATIONS:--
------------ Navigate to client/cl_customize.lua -------------
--------------------------------------------------------------
Config.ambulanceJob = 'ambulance' -- If you need rename your ambulancejob to something else? Likely will stay as is
Config.MuteDeadPlayers = false -- If a player is dead, should he be muted?
Config.Anticheat = false -- DOES NOT APPLY TO QBCORE -- Should the player be punished if he triggers 'esx_ambulancejob:revive'? / Edit it in server/sv_customize.lua
Config.DeathLogs = false -- Enable death logs via Discord webhook?(Set up in configuration/deathlogs.lua)
Config.ReviveLogs = false -- Enable admin revive logs via Discord webhook? (Linked specifically to admin revives / will not log ALL revives)
Config.LogIPs = false -- If Config.DeathLogs/Config.ReviveLogs enabled, do you want to logs IP addresses as well?
Config.BagProp = `xm_prop_x17_bag_med_01a`
Config.UseRadialMenu = false -- Enable use of radial menu built in to ox_lib? (REQUIRES OX_LIB 3.0 OR HIGHER - Editable in client/radial.lua)
Config.MobileMenu = { -- Enabling this will use ox_lib menu rather than ox_lib context menu!
    enabled = true, -- Use a mobile menu from ox_lib rather than context? (Use arrow keys to navigate menu rather than mouse)
    position = 'bottom-right'-- Choose where menu is positioned. Options : 'top-left' or 'top-right' or 'bottom-left' or 'bottom-right'
}
Config.policeCanTreat = {
    enabled = true, -- Police can treat patients?
    jobs = { -- Police / other jobs
        'police',
    --    'sheriff', 
    }
}

-- Enabled keys while dead
-- https://docs.fivem.net/docs/game-references/controls/
Config.EnabledKeys = {
    1, -- Camera Pan(Mouse)
    2, -- Camera Tilt(Mouse)
    38, -- E Key
    46, -- E Key
    47, -- G Key
    245 -- T Key
    --249 -- N Key (default key to speak while dead)
}

-- Position for the draw Text while you are dead
Config.MessagePosition = {
    respawn = { x = 0.5, y = 0.8 },
    bleedout = { x = 0.5, y = 0.8 },
    distress = { x = 0.175, y = 0.805 }
}

-- Dead animation
Config.DeathAnimation = {
    anim = 'mini@cpr@char_b@cpr_def',
    lib = 'cpr_pumpchest_idle'
}

-- 3rd party scripts
Config.wasabi_crutch = { -- If you use wasabi_crutch: https://store.wasabiscripts.com/category/2080869
    -- Crutch Settings
    crutchInMedbag = { -- Enabled? Item name? REQUIRES WASABI_CRUTCH
        enabled = true,
        item = 'crutch'
    },
    crutchInJobMenu = true, -- Crutch menu accessible from job menu if true. REQUIRES WASABI_CRUTCH
    crutchOnBleedout = { -- Place crutch for certain amount of time if they fully bleedout to hospital
        enabled = true, -- Requires wasabi_crutch
        duration = 10 -- How long stuck with crutch after respawn(In minutes)
    },
    crutchOnCheckIn = { -- Place crutch for certain amount of time if they check in to hospital REQUIRES WASABI_CRUTCH
        enabled = true, -- Requires wasabi_crutch
        duration = 10 -- How long stuck with crutch after check-in(In minutes)
    },
    -- Chair settings
    chairInMedbag = { -- Enabled? Item name? REQUIRES WASABI_CRUTCH
        enabled = false,
        item = 'wheelchair'
    },
    chairInJobMenu = false -- Chair menu accessible from job menu if true. REQUIRES WASABI_CRUTCH
}

Config.phoneDistress = 'gks' -- Options: 'gks' (GKS Phone - ESX ONLY) / 'qs' (qs-smartphone) / 'd-p' (d-phone) WILL REPLACE BUILT IN DISPATCH WITH PHONE DISPATCH / Add additonal dispatch in client/cl_customize.lua
Config.customCarlock = false -- If you use wasabi_carlock OR qb-carlock(Or want to add your own key system to client/cl_customize.lua)
Config.MythicHospital = false -- If you use that old injury script by mythic. (Added per request to reset injuries on respawn)
Config.AdvancedParking = false -- If you use AdvancedParking (Deletes vehicles with their exports)

Config.jobMenu = 'F7' -- Default job menu key
Config.billingSystem = 'okok' -- Current options: 'esx' (For esx_billing) / 'qb' (For qbcore users) 'okok' (For okokBilling) / 'pefcl' (For NPWD billing system) (Easy to add more in editable client - SET TO false IF UNDESIRED) or of course false to disable
Config.skinScript = 'appearance' -- Current options: 'esx' (For esx_skin) / 'appearance' (For wasabi-fivem-appearance) / 'qb' (For qb-clothing) / 'Custom' for any clothing script (editable in cl_customize.lua)
Config.targetSystem = true -- Target system for targetting players, medbags, and stretcher(If disabled with replace with menus/3D text) (Compatible out of the box with qTarget, qb-target, and ox_target)

Config.RespawnTimer = 40 * minutes -- Time before optional respawn
Config.BleedoutTimer = 20 * minutes -- Time before it forces respawn

Config.removeItemsOnDeath = true -- Remove items on death?
Config.Inventory = 'ox' --Options include: 'ox' - (ox_inventory) / 'qb' - (QBCore qb-inventory) 'mf' - (mf-inventory) / 'qs' (qs-inventory) / 'other' (whatever else can customize in client/cl_customize.lua)

Config.AntiCombatLog = { --  When enabled will kill player who logged out while dead
    enabled = false, --  enabled?
    notification = {
        enabled = true, -- enabled notify of wrong-doings??
        title = 'Logged While Dead',
        desc = 'You last left dead and now have returned dead'
    }
}

Config.CompleteDeath = { --DOES NOT APPLY TO QBCORE --  When enabled players can no longer use their character after x deaths
                         --DOES NOT APPLY TO QBCORE --  ONLY SUPPORTS esx_multicharacter / You can edit it in server/sv_customize.lua
    enabled = false, -- enabled?
    maxDeaths = 100, -- Max 255
}

Config.Bandages = {
    enabled = true, -- Useable bandages? (Leave false if ox_inventory because they're built in)
    item = 'perban', -- YOU MUST ADD THIS ITEM TO YOUR ITEMS, IT DOES NOT COME IN INSTALLATION(COMES WITH QBCORE BY DEFAULT AS ITEM)
    hpRegen = 20, -- Percentage of health it replenishes (30% by default)
    duration = 7 * seconds -- Time to use
}

Config.EMSItems = {
    revive = {
        item = 'medikit', -- Item used for reviving
        remove = true -- Remove item when using?
    },
    heal = {
        item = 'medikit', -- Item used for healing
        duration = 5 * seconds, -- Time to use
        remove = true -- Remove item when using?
    },
   sedate = {
       item = 'sedative', -- Item used to sedate players temporarily
        duration = 8 * seconds, -- Time sedative effects last
       remove = true -- Remove item when using?
   },
    medbag = 'medbag', -- Medbag item name used for getting supplies to treat patient
    stretcher = 'stretcher' -- Item used for stretcher
}

Config.ReviveRewards = {
    enabled = true, -- Enable cash rewards for reviving
    paymentAccount = 'money', -- If you have old ESX 1.1 you may need to switch to 'cash'
    no_injury = 5000, -- If above enabled, how much reward for fully treated patient with no injury in diagnosis
    burned = 5000,  -- How much if player is burned and revived without being treated
    beat = 5000, -- So on, so forth
    stabbed = 5000,
    shot = 5000,
}

Config.ReviveHealth = { -- How much health to deduct for those revived without proper treatment
    shot = 0, -- Ex. If player is shot and revived without having the gunshots treated; they will respond with 60 health removed
    stabbed = 0,
    beat = 0,
    burned = 0
}

Config.TreatmentTime = 9 * seconds -- Time to perform treatment

Config.TreatmentItems = {
    shot = 'tweezers',
    stabbed = 'suturekit',
    beat = 'icepack',
    burned = 'burncream'
}

Config.lowHealthAlert = {
    enabled = true,
    health = 140, -- Notify when at HP (200 full health / 100 is death)
    notification = {
        title = 'ATTENTION',
        description = 'You are in bad health. You should see a doctor soon!'
    }
}

Config.Locations = {
    Pillbox = {
        RespawnPoint = { -- When player dies and bleeds out; they will revive at nearest hospital; Define the coords of this hospital here.
            coords = vec3(324.15, -583.14, 44.20),
            heading = 332.22
        },

        Blip = {
            Enabled = true,
            Coords = vec3(324.15, -583.14, 44.20),
            Sprite = 61,
            Color = 2,
            Scale = 1.0,
            String = 'Pillbox Hospital'
        },

        clockInAndOut = {
            enabled = false, -- Enable clocking in and out at a set location? (If using ESX you must have a off duty job for Config.ambulanceJob with same grades - example in main _install_first directory)
            coords = vec3(334.75, -580.24, 43.28), -- Location of where to go on and off duty(If not using target)
            label = '[E] - Go On/Off Duty', -- Text to display(If not using target)
            distance = 3.0, -- Distance to display text UI(If not using target)
            target = {
                enabled = false, -- If enabled, the location and distance above will be obsolete
                label = 'Go On/Off Duty',
                coords = vec3(334.75, -580.24, 43.28),
                heading = 337.07,
                width = 2.0,
                length = 1.0,
                minZ = 43.28-0.9,
                maxZ = 43.28+0.9
            }
        },

        PersonalLocker = {
            enabled = false, -- Enable personal locker(stash) - THIS IS CURRENTLY ONLY AVALIABLE IN QBCORE
            coords = vec3(298.6, -598.45, 43.28), -- Location of where to access personal locker (If target is disabled)
            label = '[E] - Access Personal Locker', -- Text to display(If not using target)
            distance = 1.5, -- Distance to display text UI(If not using target)
            target = {
                enabled = false, -- If enabled, the location and distance above will be obsolete
                label = 'Access Locker',
                coords = vec3(298.6, -598.45, 43.28),
                heading = 70.18,
                width = 2.0,
                length = 1.0,
                minZ = 43.28-0.9,
                maxZ = 43.28+0.9
            }
        },


        BossMenu = {
            Enabled = true, -- Enabled boss menu?
            Coords = vec3(335.59, -594.33, 43.21), -- Location of boss menu (If not using target)
            Label = '[E] - Access Boss Menu', -- Text UI label string (If not using target)
            Distance = 2.5, -- Distance to allow access/prompt with text UI (If not using target)
            Target = {
                enabled = false, -- Enable Target? (Can be customized in cl_customize.lua the target system)
                label = 'Access Boss Menu',
                coords = vec3(335.59, -594.33, 43.21),
                heading = 269.85,
                width = 2.0,
                length = 1.0,
                minZ = 43.21-0.9,
                maxZ = 43.21+0.9
            }
        },

        CheckIn = { -- Hospital check-in
            Enabled = false, -- Enabled?
            Ped = 's_m_m_scientist_01', -- Check in ped
            Coords = vec3(308.58, -595.31, 43.28-0.9), -- Coords of ped
            Distance = 4.85,
            Heading = 63.26, -- Heading of ped
            Cost = 3000, -- Cost of using hospital check-in. Set to false for free
            MaxOnDuty = 3, -- If this amount or less you can use, otherwise it will tell you that EMS is avaliable(Set to false to always enable check-in)
            PayAccount = 'bank', -- Account dead player pays from to check-in
            Label = '[E] - Check In', -- label
            HotKey = 38, -- Default: 38 (E)
        },

        Cloakroom = {
            Enabled = false, --DOES NOT APPLY TO QBCORE --  Set to false if you don't want to use (Compatible with esx_skin & wasabi fivem-appearance fork)
            Coords = vec3(300.6, -597.7, 42.1), -- Coords of cloakroom
            Label = '[E] - Change Clothes', -- String of text ui of cloakroom
            HotKey = 38, -- Default: 38 (E)
            Range = 1.5, -- Range away from coords you can use.
            Uniforms = { -- Uniform choices
                [1] = { -- Order it will display
                    label = 'Medic', -- Name of outfit that will display in menu
                    minGrade = 0, -- Min grade level that can access? Set to 0 or false for everyone to use
                    male = { -- Male variation
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 5,   ['torso_2'] = 2,
                        ['arms'] = 5,
                        ['pants_1'] = 6,   ['pants_2'] = 1,
                        ['shoes_1'] = 16,   ['shoes_2'] = 7,
                        ['helmet_1'] = 44,  ['helmet_2'] = 7,
                    },
                    female = {
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 4,   ['torso_2'] = 14,
                        ['arms'] = 4,
                        ['pants_1'] = 25,   ['pants_2'] = 1,
                        ['shoes_1'] = 16,   ['shoes_2'] = 4,
                    }
                },
                [2] = {
                    label = 'Doctor',
                    minGrade = 1, -- Min grade level that can access? Set to 0 or false for everyone to use
                    male = {
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 5,   ['torso_2'] = 2,
                        ['arms'] = 5,
                        ['pants_1'] = 6,   ['pants_2'] = 1,
                        ['shoes_1'] = 16,   ['shoes_2'] = 7,
                        ['helmet_1'] = 44,  ['helmet_2'] = 7,
                    },
                    female = {
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 4,   ['torso_2'] = 14,
                        ['arms'] = 4,
                        ['pants_1'] = 25,   ['pants_2'] = 1,
                        ['shoes_1'] = 16,   ['shoes_2'] = 4,
                    }
                },
            }
        },

        MedicalSupplies = { -- EMS Shop for supplies
            Enabled = true, -- If set to false, rest of this table do not matter
            Ped = 'a_f_y_business_02', -- Ped to target
            Coords = vec3(306.63, -601.44, 43.28-0.95), -- Coords of ped/target
            Heading = 337.64, -- Heading of ped
            Supplies = { -- Supplies
                { item = 'medikit', label = 'Medical Kit', price = 5000 },
                { item = 'crutch', label = 'Tongkat Sakit', price = 1000 },
				
            }
        },

        Vehicles = { -- Vehicle Garage
            Enabled = false, -- Enable? False if you have you're own way for medics to obtain vehicles.
            Zone = {
                coords = vec3(298.54, -606.79, 43.27), -- Area to prompt vehicle garage
                range = 5.5, -- Range it will prompt from coords above
                label = '[E] - Access Garage',
                return_label = '[E] - Return Vehicle'
            },
            Spawn = {
                land = {
                    coords = vec3(296.16, -607.67, 43.25),
                    heading = 68.43
                },
                air = {
                    coords = vec3(351.24, -587.67, 74.55),
                    heading =  289.29
                }
            },
            Options = {
                ['ambulance'] = { -- Car/Helicopter/Vehicle Spawn Code/Model Name
                    label = 'Ambulance',
                    category = 'land', -- Options are 'land' and 'air'
                },
                ['dodgeems'] = { -- Car/Helicopter/Vehicle Spawn Code/Model Name
                    label = 'Dodge Charger',
                    category = 'land', -- Options are 'land' and 'air'
                },
                ['polmav'] = { -- Car/Helicopter/Vehicle Spawn Code/Model Name
                    label = 'Maverick',
                    category = 'air', -- Options are 'land' and 'air'
                },
            }
        },
    }
}

--[[ IMPORTANT THIS COULD BREAK SOMETHING ]]--
Config.DisableDeathAnimation = false -- Really, really, REALLY do not recommend setting this to true and it was added per request	