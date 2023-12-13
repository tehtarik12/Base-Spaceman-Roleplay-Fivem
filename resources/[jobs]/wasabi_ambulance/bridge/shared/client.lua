-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

local timeouts = {}

SetTimeout = function(msec, cb)
    timeouts[#timeouts + 1] = {
        time = GetGameTimer() + msec,
        cb = cb
    }
    return #timeouts
end

ClearTimeout = function(i)
    timeouts[i] = nil
end

GetIdentifier = function(target)
    return lib.callback.await('wasabi_ambulance:getIdentifier', 100)
end

AddRadialItems = function()
    if HasGroup(Config.ambulanceJob) then
        if Framework == 'qb' then
            if PlayerData.job.onduty then
                lib.addRadialItem({
                    {
                        id = 'ems_general',
                        label = 'EMS',
                        icon = 'ambulance',
                        menu = 'ems_menu'
                    },
                })
            else
                lib.removeRadialItem('ems_general')
            end
        else
            lib.addRadialItem({
                {
                    id = 'ems_general',
                    label = 'EMS',
                    icon = 'ambulance',
                    menu = 'ems_menu'
                },
            })
        end
    else
        lib.removeRadialItem('ems_general')
    end
end