local isHandcuffed = false
DecorRegister('zipped', 2)

Citizen.CreateThread(function()
    exports['qtarget']:Player{
        options = {
            {
                icon = "fas fa-hands",
                label = "Zipties",
                canInteract = function(entity)
                    if exports.ox_inventory:Search('count', 'zipties') > 0 and (not DecorExistOn(entity, 'zipped') or not DecorGetBool(entity, 'zipped')) then
                        return true
                    end
                    return false
                end,
				action = function(entity)
					local playerPed = PlayerPedId()
					local targetserverid = 0
				
					for k,player in ipairs(GetActivePlayers()) do
						local tped = GetPlayerPed(player)
				
						if DoesEntityExist(tped) and (tped ~= playerPed and entity == tped) then
							targetserverid = GetPlayerServerId(player)
							break
						end
					end

					if targetserverid ~= 0 then TriggerServerEvent('vinsan_jobs:handcuffserver', targetserverid, true) end
				end
            },
            {
                icon = "fas fa-hands",
                label = "Unzipties",
                canInteract = function(entity)
					local playerPed = PlayerPedId()

					if DecorExistOn(entity, 'zipped') and DecorGetBool(entity, 'zipped') then
						return true
					end

					return false
                end,
				action = function(entity)
					local playerPed = PlayerPedId()
					local targetserverid = 0
				
					for k,player in ipairs(GetActivePlayers()) do
						local tped = GetPlayerPed(player)
				
						if DoesEntityExist(tped) and (tped ~= playerPed and entity == tped) then
							targetserverid = GetPlayerServerId(player)
							break
						end
					end

					if targetserverid ~= 0 then TriggerServerEvent('vinsan_jobs:handcuffserver', targetserverid, false) end
				end
            },
        },
        distance = 2.5,
    }
end)

RegisterNetEvent('vinsan_jobs:handcuff')
AddEventHandler('vinsan_jobs:handcuff', function(targetid, ishandcuffed)
	local playerPed = PlayerPedId()
	local targetped = GetPlayerPed(GetPlayerFromServerId(targetid))
	if ishandcuffed then
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'cuff', 0.2)
	else
		local playerheading = GetEntityHeading(targetped)
		local playerlocation = GetEntityForwardVector(targetped)
		local playerCoords = GetEntityCoords(targetped)
		local x, y, z   = table.unpack(playerCoords + playerlocation * 1.0)
		SetEntityCoords(playerPed, x, y, z - 1.0)
		SetEntityHeading(playerPed, playerheading)
		Citizen.Wait(250)
		RequestAnimDict('mp_arresting')

		while not HasAnimDictLoaded('mp_arresting') do
			Citizen.Wait(10)
		end
		TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'uncuff', 0.2)
		TaskPlayAnim(playerPed, 'mp_arresting', 'b_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
		Citizen.Wait(5500)
		ClearPedTasks(playerPed)
	end

	if ishandcuffed then
		local dict = 'anim@move_m@prisoner_cuffed'
		RequestAnimDict(dict)
		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(100)
		end

		TaskPlayAnim(playerPed, dict, 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

		SetEnableHandcuffs(playerPed, true)
		DisablePlayerFiring(playerPed, true)
		SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true) -- unarm player
		SetPedCanPlayGestureAnims(playerPed, false)

		DecorSetBool(playerPed, 'zipped', true)
		isHandcuffed = true
	else
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		DecorSetBool(playerPed, 'zipped', false)
		isHandcuffed = false
	end
end)

RegisterNetEvent('vinsan_jobs:handcuffAnim')
AddEventHandler('vinsan_jobs:handcuffAnim', function(target)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

	RequestAnimDict('mp_arresting')

	while not HasAnimDictLoaded('mp_arresting') do
		Citizen.Wait(10)
	end
	TaskPlayAnim(playerPed, 'mp_arresting', 'a_uncuff', 8.0, -8,-1, 2, 0, 0, 0, 0)
	Citizen.Wait(5500)
	ClearPedTasks(playerPed)
end)

RegisterNetEvent('vinsan_jobs:putInVehicle')
AddEventHandler('vinsan_jobs:putInVehicle', function()
	local playerPed = PlayerPedId()
	local vehicle, distance = ESX.Game.GetClosestVehicle()

	if vehicle and distance < 5 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
		end
	end
end)

RegisterNetEvent('vinsan_jobs:OutVehicle')
AddEventHandler('vinsan_jobs:OutVehicle', function()
	local playerPed = PlayerPedId()

	if IsPedSittingInAnyVehicle(playerPed) then
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		TaskLeaveVehicle(playerPed, vehicle, 64)
	end
end)

-- Handcuff
CreateThread(function()
	while true do
		Wait(0)
		local playerPed = PlayerPedId()

		if isHandcuffed then
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon

			DisableControlAction(0, 288,  true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job

			DisableControlAction(0, 26, true) -- Disable looking behind
			DisableControlAction(0, 73, true) -- Disable clearing animation
			DisableControlAction(2, 199, true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 243, true)  -- Disable radioa
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee

			if IsEntityPlayingAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('anim@move_m@prisoner_cuffed', function()
					TaskPlayAnim(playerPed, 'anim@move_m@prisoner_cuffed', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Wait(500)
		end
	end
end)