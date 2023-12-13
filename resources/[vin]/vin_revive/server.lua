ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('vin_revive:getConnectedEMS', function(source, cb)
	local xPlayers = ESX.GetPlayers()
	local amount = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'ambulance' then
			amount = amount + 1
		end
	end
		
	cb(amount)
		
end)

RegisterServerEvent('vin_revive:setDeathStatus')
AddEventHandler('vin_revive:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})	
end)

RegisterServerEvent('vin_revive:FeeAfterRevive')
AddEventHandler('vin_revive:FeeAfterRevive', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeAccountMoney('bank', Config.Fee)
	xPlayer.showNotification("~r~kamu telah membayar biaya revive sebesar ~g~Rp.".. Config.Fee)
end)
