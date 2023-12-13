RegisterNetEvent('vinsan_jobs:putInVehicle')
AddEventHandler('vinsan_jobs:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if (xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance') then
		TriggerClientEvent('vinsan_jobs:putInVehicle', target)
	else
		print(('vinsan_jobs: %s attempted to put in vehicle (not whitelist)!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('vinsan_jobs:OutVehicle')
AddEventHandler('vinsan_jobs:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if (xPlayer.job.name == 'police' or xPlayer.job.name == 'ambulance') then
		TriggerClientEvent('vinsan_jobs:OutVehicle', target)
	else
		print(('vinsan_jobs: %s attempted to drag out from vehicle (not whitelist)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('vinsan_jobs:Duty')
AddEventHandler('vinsan_jobs:Duty', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local gsub = string.gsub(xPlayer.job.name, 'off', '')

    if gsub == xPlayer.job.name then
        xPlayer.setJob('off' .. xPlayer.job.name, xPlayer.job.grade)
        xPlayer.showNotification('Anda telah off duty!')
    else
        local job = string.gsub(xPlayer.job.name, 'off', '')
        xPlayer.setJob(job, xPlayer.job.grade)
        xPlayer.showNotification('Anda telah on duty!')
    end
end)