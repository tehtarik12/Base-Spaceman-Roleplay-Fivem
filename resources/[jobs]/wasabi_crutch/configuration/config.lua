-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------
Config = {}
--------------- General Settings  -------------
Config.menuPosition = 'bottom-right'

-- These resources can trigger "wasabi_crutch:giveCrutch" and "wasabi_crutch:giveChair"
Config.AllowedResources = {
    'esx_ambulancejob',
    --'qb-core',
}


--------------- Injury Assignments  -------------
Config.jobRequirement = { -- Job requirement settings
    enabled = true, -- Require someone to have job to give tools / if false anyone can use(maybe bad idea)
    jobs = { -- Add or remove as many jobs as you would like
        'ambulance',
    }
}

Config.maxAssignTime = { -- Max time someone can be assigned - set false if undesired(In minutes)
    crutch = 1440, -- Crutch / default: 10 minutes(set false if not desired a limit)
    wheelchair = 1440 -- Wheelchair / default: 10 minutes(set false if not desired a limit)
 }


Config.disableOnDeath = { -- On death settings
    crutch = true, -- Set to false if you want them to have crutches for time even if they die.
    wheelchair = true, -- Set to true if you want them to lose wheelchair if they die.
}

Config.usableCrutchItem = { -- Usable item settings
    enabled = true, -- Enable usable crutch item
    maxAssignTime = 1440, -- Max time someone can be assigned crutches - set false if undesired(In minutes)
    item = 'crutch' -- Item to be in your items table
}

Config.usableWheelchairItem = { -- Usable item settings
    enabled = true, -- Enable usable wheelchair item
    maxAssignTime = 1440, -- Max time someone can be assigned wheelchair - set false if undesired(In minutes)
    item = 'wheelchair' -- Item to be in your items table
}

Config.CustomCarKeyScript = false -- Set to true if using wasabi_carlock(Or any others if you customize in cl_customize.lua)
