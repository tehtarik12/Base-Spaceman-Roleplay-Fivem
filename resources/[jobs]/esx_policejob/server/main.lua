local stash = {
    id = 'society_police',
    label = 'Police Stash',
    slots = 500,
    weight = 10000000,
    owner = station
}

local evidance = {

	id = 'police_evidance',
	label = 'Police Evidance',
	slots = 500,
	weight = 10000000,
	owner = station

}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight, stash.owner)
		exports.ox_inventory:RegisterStash(evidance.id, evidance.label, evidance.slots, evidance.weight, evidance.owner)
    end
end)

if Config.EnableESXService then
	if Config.MaxInService ~= -1 then
		TriggerEvent('esx_service:activateService', 'police', Config.MaxInService)
	end
end

TriggerEvent('esx_phone:registerNumber', 'police', _U('alert_police'), true, true)
TriggerEvent('esx_society:registerSociety', 'police', 'Police', 'society_police', {type = 'public'})

local handcuffed = {}
local ox_inventory = exports.ox_inventory
RegisterNetEvent('esx_policejob:handcuff')
AddEventHandler('esx_policejob:handcuff', function(target, forcestate)
    local xPlayer = ESX.GetPlayerFromId(source)
	local ishandcuffed = false

	if handcuffed[target] == nil then
		handcuffed[target] = true
		ishandcuffed = true
	else
		handcuffed[target] = nil
	end

    if forcestate then
        ishandcuffed = forcestate
        handcuffed[target] = forcestate
    end

    TriggerClientEvent('esx_policejob:handcuff', target, source, ishandcuffed, xPlayer.job.name)
    TriggerClientEvent('esx_policejob:handcuffAnim', source, target, ishandcuffed)
end)

RegisterNetEvent('vinsan_jobs:handcuffserver')
AddEventHandler('vinsan_jobs:handcuffserver', function(target, forcestatus)
    local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromId(target)

	if handcuffed[target] == nil and forcestatus == true then
		local zipties = ox_inventory:Search(xPlayer.source, 'slots', 'zipties')[1]

		if zipties and zipties.metadata and zipties.metadata.durability >= 0 then
			zipties.metadata.durability = zipties.metadata.durability - math.random(30,50)

			ox_inventory:SetMetadata(xPlayer.source, zipties.slot, zipties.metadata)
	
			handcuffed[target] = 'badside'
			TriggerClientEvent('vinsan_jobs:handcuff', target, source, true)
			TriggerClientEvent('vinsan_jobs:handcuffAnim', source, target)
		elseif zipties.metadata.durability <= 0 then
			ox_inventory:RemoveItem(xPlayer.source, 'zipties', 1, {durability = 0})
		end
	elseif handcuffed[target] == 'badside' and forcestatus == false then
		handcuffed[target] = nil
		TriggerClientEvent('vinsan_jobs:handcuff', target, source, false)
		TriggerClientEvent('vinsan_jobs:handcuffAnim', source, target)
	end
end)


RegisterNetEvent('esx_policejob:drag')
AddEventHandler('esx_policejob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'police' or xPlayer.job.name == 'fama' or xPlayer.job.name == 'famb' or xPlayer.job.name == 'famc' or xPlayer.job.name == 'famd' or xPlayer.job.name == 'fame' or xPlayer.job.name == 'fame' or xPlayer.job.name == 'famf' or xPlayer.job.name == 'famg' then
		TriggerClientEvent('esx_policejob:drag', target, source)
	else
		print(('esx_policejob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

ESX.RegisterServerCallback('esx_policejob:getFineList', function(source, cb, category)
	MySQL.query('SELECT * FROM fine_types WHERE category = ?', {category},
	function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_policejob:getVehicleInfos', function(source, cb, plate)
	local retrivedInfo = {
		plate = plate
	}
		MySQL.scalar('SELECT owner FROM owned_vehicles WHERE plate = ?', {plate},
		function(owner)
			if owner then
				local xPlayer = ESX.GetPlayerFromIdentifier(owner)
				if xPlayer then
					retrivedInfo.owner = xPlayer.getName()
				end
			end
			cb(retrivedInfo)
		end)
end)