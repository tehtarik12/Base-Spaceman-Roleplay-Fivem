TriggerEvent('esx_phone:registerNumber', 'mechanic', _U('mechanic_customer'), true, true)
TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', {type = 'private'})


local stash = {
    id = 'society_mechanic',
    label = 'Mechanic Stash',
    -- slots = 350,
    -- weight = 100000,
	slots = 350,
    weight = 10000000,
    owner = nil
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner)
    end
end)

ESX.RegisterUsableItem('repairkit', function(source)
	local xPlayer  = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'mechanic' then
		xPlayer.removeInventoryItem('repairkit', 1)

		TriggerClientEvent('esx_mechanicjob:onRepairkit', source)
		TriggerClientEvent('esx:showNotification', source, _U('you_used_repair_kit'))
	end
end)

ESX.RegisterUsableItem('enginekit', function(source)
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('enginekit', 1)

	TriggerClientEvent('esx_mechanicjob:onEnginekit', source)
	TriggerClientEvent('esx:showNotification', source, _U('you_used_body_kit'))
end)