local Vehicles = nil

RegisterServerEvent('esx_lscustom:buyMod')
AddEventHandler('esx_lscustom:buyMod', function(price, forced)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	price = tonumber(price)

	--[[
	local societyAccount

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
		societyAccount = account
	end)
	--]]

	if forced and xPlayer.getGroup() ~= 'user' then
		TriggerClientEvent('esx_lscustom:installMod', _source)
		TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
	elseif price < xPlayer.getMoney() then
		TriggerClientEvent('esx_lscustom:installMod', _source)
		TriggerClientEvent('esx:showNotification', _source, _U('purchased'))
		xPlayer.removeMoney(price)
		--societyAccount.addMoney(ESX.Math.Round(price / 100 * 15))
	else
		TriggerClientEvent('esx_lscustom:cancelInstallMod', _source)
		TriggerClientEvent('esx:showNotification', _source, _U('not_enough_money'))
	end
end)

RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	exports.oxmysql:execute('SELECT vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = vehicleProps.plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicleProps.model == vehicle.model then
				exports.oxmysql:execute('UPDATE owned_vehicles SET vehicle = @vehicle WHERE plate = @plate', {
					['@plate'] = vehicleProps.plate,
					['@vehicle'] = json.encode(vehicleProps)
				})
			else
				print(('esx_lscustom: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if Vehicles == nil or not Vehicles then
		exports.oxmysql:execute('SELECT * FROM vs_vipcars UNION SELECT * FROM vs_cars;', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)

RegisterCommand('rechargevehicle', function(source, args, rawCommand)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'mechanic' then
		TriggerClientEvent('esx_lscustom:rechargevehicle', source)
	end
end)

RegisterCommand('modify', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() ~= 'user' then
		TriggerClientEvent('esx_lscustom:forceOpen', source)
	end
end)