ESX = nil
RegisterServerEvent("JobActivity:event")
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('JobActivity:event', function(type)
    if type == 'refresh' then
        TriggerClientEvent('JobActivity:updateBlip', -1)
    elseif type == 'refresh_veh' then
        TriggerClientEvent('JobActivity:updateVeh', -1, source)
    end
end)

TriggerEvent('es:addCommand', 'refreshblip', function(source)
    TriggerClientEvent('JobActivity:updateBlip', source)
end)