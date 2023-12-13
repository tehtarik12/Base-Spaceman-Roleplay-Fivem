local carryingBackInProgress = false
local carryAnimNamePlaying = ""
local carryAnimDictPlaying = ""
local carryControlFlagPlaying = 0
local piggyBackInProgress = false
local piggyBackAnimNamePlaying = ""
local piggyBackAnimDictPlaying = ""
local piggyBackControlFlagPlaying = 0

AddEventHandler('esx:onPlayerDeath', function(data)
	if piggyBackInProgress then
		piggyBackInProgress = false
		ClearPedSecondaryTask(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent("cmg2_animations:stop", GetPlayerServerId(closestPlayer))
		end
	end

	if carryingBackInProgress then
		carryingBackInProgress = false
		ClearPedSecondaryTask(PlayerPedId())
		DetachEntity(PlayerPedId(), true, false)
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent("CarryPeople:stop", GetPlayerServerId(closestPlayer))
		end
	end
end)

RegisterCommand("carry2",function(source, args)
	if not IsEntityPlayingAnim(PlayerPedId(), 'dead', 'dead_a', 3) then
		if not piggyBackInProgress then
			local player = PlayerPedId()	
			lib = 'random@shop_tattoo'
			anim1 = '_idle_a'
			distans = 0.15
			distans2 = 0.0
			height = 0.8
			spin = 0.0		
			length = 100000
			controlFlagMe = 49
			controlFlagTarget = 33
			animFlagTarget = 1
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
				piggyBackInProgress = true
				TriggerServerEvent('cmg2_animations:sync', GetPlayerServerId(closestPlayer), lib, anim1, distans, distans2, height, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget)
			else 
				ESX.ShowNotification({text = "Tidak ada pemain disekitar!", type = 'error'})
			end
		else
			piggyBackInProgress = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent("cmg2_animations:stop", GetPlayerServerId(closestPlayer))
			end
		end
	end
end,false)

RegisterNetEvent('cmg2_animations:syncTarget')
AddEventHandler('cmg2_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	piggyBackInProgress = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	piggyBackAnimNamePlaying = animation2
	piggyBackAnimDictPlaying = animationLib
	piggyBackControlFlagPlaying = controlFlag
end)

RegisterNetEvent('cmg2_animations:syncMe')
AddEventHandler('cmg2_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Citizen.Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	piggyBackAnimNamePlaying = animation
	piggyBackAnimDictPlaying = animationLib
	piggyBackControlFlagPlaying = controlFlag
end)

RegisterNetEvent('cmg2_animations:cl_stop')
AddEventHandler('cmg2_animations:cl_stop', function()
	piggyBackInProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

RegisterCommand("carry",function(source, args)
	if not IsEntityPlayingAnim(PlayerPedId(), 'dead', 'dead_a', 3) then
		if not carryingBackInProgress then
			local player = PlayerPedId()	
			lib = 'missfinale_c2mcs_1'
			anim1 = 'fin_c2_mcs_1_camman'
			lib2 = 'nm'
			anim2 = 'firemans_carry'
			distans = 0.15
			distans2 = 0.27
			height = 0.63
			spin = 0.0		
			length = 100000
			controlFlagMe = 49
			controlFlagTarget = 33
			animFlagTarget = 1
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
				carryingBackInProgress = true
				TriggerServerEvent('CarryPeople:sync', GetPlayerServerId(closestPlayer), lib, lib2, anim1, anim2, distans, distans2, height, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget)
			else
				ESX.ShowNotification({text = "Tidak ada pemain disekitar!", type = 'error'})
			end
		else
			carryingBackInProgress = false
			ClearPedSecondaryTask(PlayerPedId())
			DetachEntity(PlayerPedId(), true, false)
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 3.0 then
				TriggerServerEvent("CarryPeople:stop", GetPlayerServerId(closestPlayer))
			end
		end
	end
end,false)

RegisterNetEvent('CarryPeople:syncTarget')
AddEventHandler('CarryPeople:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(PlayerPedId(), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation2
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('CarryPeople:syncMe')
AddEventHandler('CarryPeople:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Citizen.Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	carryAnimNamePlaying = animation
	carryAnimDictPlaying = animationLib
	carryControlFlagPlaying = controlFlag
end)

RegisterNetEvent('CarryPeople:cl_stop')
AddEventHandler('CarryPeople:cl_stop', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if carryingBackInProgress then 
			if not IsEntityPlayingAnim(PlayerPedId(), carryAnimDictPlaying, carryAnimNamePlaying, 3) then
				TaskPlayAnim(PlayerPedId(), carryAnimDictPlaying, carryAnimNamePlaying, 8.0, -8.0, 100000, carryControlFlagPlaying, 0, false, false, false)
			end
		end
		if piggyBackInProgress then 
			if not IsEntityPlayingAnim(PlayerPedId(), piggyBackAnimDictPlaying, piggyBackAnimNamePlaying, 3) then
				TaskPlayAnim(PlayerPedId(), piggyBackAnimDictPlaying, piggyBackAnimNamePlaying, 8.0, -8.0, 100000, piggyBackControlFlagPlaying, 0, false, false, false)
			end
		end
		Wait(2000)
	end
end)