local PlayerData    = {}
local isInVehicle   = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        isInVehicle = IsPedInAnyVehicle(PlayerPedId(), true)
    end
end)

Citizen.CreateThread(function()
    while true do
        local letSleep = 5000
        local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
        local ped = GetPlayerPed(-1)
        local vehicleClass = GetVehicleClass(vehicle)
        
        if isInVehicle then
            letSleep = 0
            if vehicleClass == 18 and GetPedInVehicleSeat(vehicle, -1) == ped then
                if ESX.PlayerData.job.name ~= nil and ESX.PlayerData.job.name~= 'police' and ESX.PlayerData.job.name ~= 'ambulance' and ESX.PlayerData.job.name ~= 'mechanic' then
                    ClearPedTasksImmediately(ped)
                    TaskLeaveVehicle(ped,vehicle,0)
                end
            end
            if vehicleClass == 15 and GetPedInVehicleSeat(vehicle, -1) == ped then
                if ESX.PlayerData.job.name ~= nil and ESX.PlayerData.job.name ~= 'police' and ESX.PlayerData.job.name ~= 'ambulance' and ESX.PlayerData.job.name ~= 'mechanic' then
                    ClearPedTasksImmediately(ped)
                    TaskLeaveVehicle(ped,vehicle,0)
                end
            end
            if vehicleClass == 16 and GetPedInVehicleSeat(vehicle, -1) == ped then
                if ESX.PlayerData.job.name ~= nil and ESX.PlayerData.job.name ~= 'police' and ESX.PlayerData.job.name ~= 'ambulance' and ESX.PlayerData.job.name ~= 'mechanic' then
                    ClearPedTasksImmediately(ped)
                    TaskLeaveVehicle(ped,vehicle,0)
                    Citizen.Wait(1000)
                end
            end
        end
        Citizen.Wait(letSleep)
    end
end)