local TimerEnabled = false

RegisterCommand('tackle', function()
	if ESX and ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
		if not TimerEnabled and IsControlPressed(0, 61) and (not IsPedInAnyVehicle(PlayerPedId()) and not IsPedRagdoll(PlayerPedId()) and IsPedOnFoot(PlayerPedId())) then
			local closestPlayer, distance = ESX.Game.GetClosestPlayer()
			if (closestPlayer ~= -1 and IsPedOnFoot(GetPlayerPed(closestPlayer))) and (distance ~= -1 and distance < 2) then
				TriggerServerEvent('essentials:tackle', GetPlayerServerId(closestPlayer))
				TriggerEvent("essentials:tackleanimation")

				TimerEnabled = true
				Citizen.Wait(10000)
				TimerEnabled = false
			else
				TriggerEvent("essentials:tackleanimation")
				TimerEnabled = true
				Citizen.Wait(5000)
				TimerEnabled = false
			end
		end
	end
end)

RegisterNetEvent('essentials:tackled')
AddEventHandler('essentials:tackled', function()
	SetPedToRagdoll(PlayerPedId(), math.random(2000,5000), math.random(2000,5000), 0, 0, 0, 0) 

	TimerEnabled = true
	Citizen.Wait(5000)
	TimerEnabled = false
end)

AddEventHandler('essentials:tackleanimation', function()
	if not IsPedRagdoll(PlayerPedId()) then
		local lPed = PlayerPedId()
		RequestAnimDict("swimming@first_person@diving")
		while not HasAnimDictLoaded("swimming@first_person@diving") do
			Citizen.Wait(1)
		end
		
		if IsEntityPlayingAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 3) then
			ClearPedSecondaryTask(lPed)
		else
			TaskPlayAnim(lPed, "swimming@first_person@diving", "dive_run_fwd_-45_loop", 8.0, -8, -1, 49, 0, 0, 0, 0)
			Citizen.Wait(200)
			ClearPedSecondaryTask(lPed)
			SetPedToRagdoll(PlayerPedId(), math.random(1000,3000), math.random(1000,3000), 0, 0, 0, 0)
		end
	end
end)

RegisterKeyMapping('tackle', '[SC] Tackle', 'keyboard', 'G')