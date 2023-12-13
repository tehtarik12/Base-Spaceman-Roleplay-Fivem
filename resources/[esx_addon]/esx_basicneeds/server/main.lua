Citizen.CreateThread(function()
	Citizen.Wait(10)
	for k,v in pairs(Config.Food) do
		ESX.RegisterUsableItem(k, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)

			TriggerClientEvent('esx_basicneeds:onUse', source, v.type, v.add, k)
		end)
	end
end)

RegisterServerEvent('esx_depencies:removeFood')
AddEventHandler('esx_depencies:removeFood', function(name)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem(name, 1)
end)

ESX.RegisterCommand('heal', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('esx_basicneeds:healPlayer')
	args.playerId.showNotification('You have been healed.')
end, true, {help = 'Heal a player, or yourself - restores thirst, hunger and health.', validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

AddEventHandler('txAdmin:events:healedPlayer', function(eventData)
	if GetInvokingResource() ~= "monitor" or type(eventData) ~= "table" or type(eventData.id) ~= "number" then
		return
	end

	TriggerClientEvent('esx_basicneeds:healPlayer', eventData.id)
end)