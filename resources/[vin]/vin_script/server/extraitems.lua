local ox_inventory = exports.ox_inventory

ESX.RegisterUsableItem('lockpick', function(source, item, data)
    local xPlayer = ESX.GetPlayerFromId(source)
    local lockpick = ox_inventory:Search(xPlayer.source, 'slots', 'lockpick')[1]

    xPlayer.showNotification('Kamu Tidak Dapat Menggunakan item Ini!')
end) 

ESX.RegisterUsableItem('armor', function(source, item)
    TriggerClientEvent('vinsan_core:bulletproof', source, 'armor')
end)

ESX.RegisterUsableItem('rompi', function(source, item)
    TriggerClientEvent('vinsan_core:bulletproof', source, 'rompi')
end)

ESX.RegisterUsableItem('kecubungjadi', function(source, item)
    TriggerClientEvent('vinsan_core:bulletproof', source, 'kecubungjadi')
end)

ESX.RegisterUsableItem('micinjadi', function(source, item)
    TriggerClientEvent('vinsan_core:bulletproof', source, 'micinjadi')
	TriggerClientEvent('vin-script:onMicin', source)
end)

ESX.RegisterUsableItem('gummy', function(source, item)
    TriggerClientEvent('vinsan_core:bulletproof', source, 'gummy')
end)

RegisterNetEvent('vinsan_core:removeItem')
AddEventHandler('vinsan_core:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)
end)