local Gudang = {
    {
        id = 'gudangkota',
        label = 'Gudang Kota',
        slots = 250,
        weight = 5000000,
        owner = true
    },
    {
        id = 'gudangpaleto',
        label = 'Gudang Sandy',
        slots = 250,
        weight = 5000000,
        owner = true
    }
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for k,v in pairs(Gudang) do
            exports.ox_inventory:RegisterStash(v.id, v.label, v.slots, v.weight, v.owner)
        end
    end
end)

--=====================
-- Praryo Locker Room
--=====================

ESX.RegisterServerCallback('pyrp_locker:checkLocker', function(source, cb, lockerId)
	local pyrp = source
	local xPlayer = ESX.GetPlayerFromId(pyrp)
	MySQL.Async.fetchAll('SELECT * FROM owned_gudangs WHERE lockerName = @lockerId AND identifier = @identifier', { ['@lockerId'] = lockerId, ['@identifier'] = xPlayer.identifier }, function(result) 
		if result[1] ~= nil then
			cb(true)
		else
			cb(false)
		end	
	end)
end)

--===========================
-- Locker Start/Stop Renting
--===========================

RegisterServerEvent('pyrp_locker:startRentingLocker')
AddEventHandler('pyrp_locker:startRentingLocker', function(lockerId, lockerName) 
	local pyrp = source
	local xPlayer = ESX.GetPlayerFromId(pyrp)
	if xPlayer.getMoney() >= Config.DailyRentPrice then
		MySQL.Async.execute('INSERT INTO owned_gudangs (identifier, lockerName) VALUES (@identifier, @lockerId)', {
			['@identifier'] = xPlayer.identifier,
			['@lockerId'] = lockerId
		})
		xPlayer.removeMoney(Config.DailyRentPrice)
		TriggerClientEvent('esx:showNotification', pyrp, "Kamu mulai menyewa " ..lockerName.. ". Kamu akan dikenakan biaya $ID"..Config.DailyRentPrice.." .")
	else
		TriggerClientEvent('esx:showNotification', pyrp, "Kamu tidak punya cukup uang untuk menyewa gudang.")
	end
end)

RegisterServerEvent('pyrp_locker:stopRentingLocker')
AddEventHandler('pyrp_locker:stopRentingLocker', function(lockerId, lockerName) 
	local pyrp = source
	local xPlayer = ESX.GetPlayerFromId(pyrp)
	MySQL.Async.fetchAll('SELECT * FROM owned_gudangs WHERE lockerName = @lockerId AND identifier = @identifier', { ['@lockerId'] = lockerId, ['@identifier'] = xPlayer.identifier }, function(result)
		if result[1] ~= nil then
			MySQL.Async.execute('DELETE from owned_gudangs WHERE lockerName = @lockerId AND identifier = @identifier', {
				['@lockerId'] = lockerId,
				['@identifier'] = xPlayer.identifier
			})
			TriggerClientEvent('esx:showNotification', pyrp, "Kamu membatalkan sewa gudang ini.")
		else
			TriggerClientEvent('esx:showNotification', pyrp, "Kamu tidak bisa mempunyai gudang ini.")
		end
	end)
end)