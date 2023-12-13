ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('claim_starterpack:checkClaim', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
        local claimed = json.decode(result[1].starterpack)
        cb(claimed)
	end)
end)

RegisterServerEvent('claim_starterpack:setVehicle')
AddEventHandler('claim_starterpack:setVehicle', function (vehicleProps, playerID)
	local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem('ktp', 1)
    xPlayer.addInventoryItem('baksospageti', 10)
    xPlayer.addInventoryItem('jusjeruk', 10)
    xPlayer.addInventoryItem('classic_phone', 1)
    xPlayer.addInventoryItem('radio', 1)
	
	MySQL.Async.execute('INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `stored`, `last_garage`, `garage`) VALUES (@owner, @plate, @vehicle, @stored, @last_garage, @garage)',
	{
		['@owner']   = xPlayer.identifier,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
		['@stored']  = 1,
		['@last_garage'] = "walkot",
		['@garage'] = "walkot"
    }, function ()
        MySQL.Async.execute('UPDATE `users` SET starterpack = 1 WHERE identifier = @identifier',
        {
            ['@identifier']   = xPlayer.identifier
        }, function ()
        end)
	end)
end)