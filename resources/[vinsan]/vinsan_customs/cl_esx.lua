ESX = nil
isDead = false
Whitelisted = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(10)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(playerData)
	ESX.PlayerData = playerData

	if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'ambulance' then
		Whitelisted = true
	else
		Whitelisted = false
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData = ESX.GetPlayerData()

	if ESX.PlayerData.job.name == 'police' or ESX.PlayerData.job.name == 'ambulance' then
		Whitelisted = true
	else
		Whitelisted = false
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('esx:onPlayerSpawn', function(data)
	isDead = false
end)

AddEventHandler('playerSpawned', function(data)
	isDead = false
end)