ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand('claimstarterpack', function(source, args)
    ESX.TriggerServerCallback('claim_starterpack:checkClaim', function(claimed)
        if claimed == 1 then
			if Config.useMythicNotify then
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = Config.Lang['already_claimed'] })
			else
				ESX.ShowNotification(Config.Lang['already_claimed'])
			end
        else
            TriggerEvent('claim_starterpack:spawnVehicle', Config.vehicle)
        end
    end)
end)

AddEventHandler('claim_starterpack:spawnVehicle', function(model)
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local carExist  = false

	ESX.Game.SpawnVehicle(model, coords, 0.0, function(vehicle) --get vehicle info
		if DoesEntityExist(vehicle) then
			carExist = true
			SetEntityVisible(vehicle, false, false)
			SetEntityCollision(vehicle, false)
			
			local newPlate     = exports.esx_advancedvehicleshop:GeneratePlate()
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
			vehicleProps.plate = newPlate
			TriggerServerEvent('claim_starterpack:setVehicle', vehicleProps)
			ESX.Game.DeleteVehicle(vehicle)	
			if Config.useMythicNotify then
				TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = Config.Lang['success_claim'] })
			else
				ESX.ShowNotification(Config.Lang['success_claim'])
			end
		end		
	end)
	
	Wait(2000)
	if not carExist then
		if Config.useMythicNotify then
			TriggerEvent('mythic_notify:client:SendAlert', { type = 'inform', text = Config.Lang['not_exists'] })
		else
			ESX.ShowNotification(Config.Lang['not_exists'])
		end
	end
end)