
RegisterServerEvent('esx_pun_carwash:checkMoney')
AddEventHandler('esx_pun_carwash:checkMoney', function(price)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    price = tonumber(price)
    if price < xPlayer.getAccount('bank').money then
        TriggerClientEvent('esx_pun_carwash:clean', _source)
        xPlayer.removeAccountMoney('bank', price)
    elseif price < xPlayer.getMoney() then
        TriggerClientEvent('esx_pun_carwash:clean', _source)
        xPlayer.removeMoney(price)
    elseif price < xPlayer.getAccount('bank').money + xPlayer.getMoney() then
        TriggerClientEvent('esx_pun_carwash:clean', _source)
        local bankPrice = xPlayer.getAccount('bank').money
        xPlayer.removeAccountMoney('bank', bankPrice)
        local cashPrice = price - bankPrice
        xPlayer.removeMoney(cashPrice)
    else
        TriggerClientEvent('esx_pun_carwash:cancel', _source)
    end
end)


RegisterServerEvent('dreamtown_vehicle:engineswap')
AddEventHandler('dreamtown_vehicle:engineswap', function(vehicle, engineaudio)
	TriggerClientEvent('dreamtown_vehicle:engineswap', -1, vehicle, engineaudio, false)
end)

RegisterCommand('engineswap', function(source, args, rawcommand)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() ~= 'user' then
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)

		if vehicle ~= 0 and GetHashKey(args[1]) ~= 0 then
			TriggerClientEvent('dreamtown_vehicle:engineswap', -1, NetworkGetNetworkIdFromEntity(vehicle), args[1], true)
		end
	end
end)

RegisterCommand('antilag', function(source, args, rawcommand)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() ~= 'user' then
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(source), false)

		if vehicle ~= 0 then
			TriggerClientEvent('dreamtown_vehicle:enableantilag', -1, NetworkGetNetworkIdFromEntity(vehicle), true)
		end
	end
end)

RegisterCommand('vehicledebugger', function(source, args, rawcommand)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() ~= 'user' and args[1] and ESX.GetPlayerFromId(args[1]) then
		TriggerClientEvent('vehicledebugger:setallow', args[1])
	end
end)

ESX.RegisterUsableItem('fakeplate', function(source)
	TriggerClientEvent('esx_advancedgarage:onusePlate', source)
end)