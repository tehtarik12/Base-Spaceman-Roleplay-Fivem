-----------------For support, scripts, and more----------------
--------------- https://discord.gg/wasabiscripts  -------------
---------------------------------------------------------------

--Customize notifications
RegisterNetEvent('wasabi_crutch:notify', function(title, desc, style, icon)
    lib.notify({
        title = title,
        description = desc,
        duration = 3500,
        type = style,
        icon = (icon or false)
    })
end)

-- Custom Car lock
AddCarKeys = function(plate) -- Edit carlock function to implement custom carlock
    if Framework == 'qb' then
        if GetResourceState('wasabi_carlock') == 'running' then
            exports.wasabi_carlock:GiveKeys(plate) -- Leave like this if using wasabi_carlock
        else
            TriggerEvent('vehiclekeys:client:SetOwner', plate)
        end
    elseif Framework == 'esx' then
        exports.wasabi_carlock:GiveKeys(plate) -- Leave like this if using wasabi_carlock
    end
end

