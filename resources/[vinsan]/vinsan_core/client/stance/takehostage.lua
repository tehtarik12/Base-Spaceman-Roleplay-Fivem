-----------------------------------------------------------------
--TakeHostage by Robbster, do not redistrbute without permission--
------------------------------------------------------------------

local holdingHostageInProgress = false
local takeHostageAnimNamePlaying = ""
local takeHostageAnimDictPlaying = ""
local takeHostageControlFlagPlaying = 0
local beingHeldHostage = false 
local holdingHostage = false 

RegisterCommand("takehostage",function()
	takeHostage()
end)

RegisterCommand("th",function()
	takeHostage()
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	if holdingHostage then
        holdingHostage = false
        holdingHostageInProgress = false 
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestPlayer ~= -1 and closestDistance <= 3.0 then
			TriggerServerEvent("cmg3_animations:stop", GetPlayerServerId(closestPlayer))
            Wait(100)
            releaseHostage()
		end
	end
end)

function takeHostage()
	if IsEntityPlayingAnim(PlayerPedId(), 'dead', 'dead_a', 3) then return end
    local ret, hash = GetCurrentPedWeapon(PlayerPedId())

	if ret and not holdingHostageInProgress and not holdingHostage and not beingHeldHostage then
        local player = PlayerPedId()
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
		lib = 'anim@gangops@hostage@'
		anim1 = 'perp_idle'
		lib2 = 'anim@gangops@hostage@'
		anim2 = 'victim_idle'
		distans = 0.11
		distans2 = -0.24
		height = 0.0
		spin = 0.0		
		length = 100000
		controlFlagMe = 49
		controlFlagTarget = 49
		animFlagTarget = 50
		attachFlag = true
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer ~= -1 and closestDistance <= 3.0 then
			holdingHostageInProgress = true
			holdingHostage = true
			TriggerServerEvent('cmg3_animations:sync', GetPlayerServerId(closestPlayer), lib, lib2, anim1, anim2, distans, distans2, height, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget, attachFlag)
		else
            ESX.ShowNotification({text = "Tidak ada pemain disekitar!", type = 'error'})
		end
    elseif holdingHostageInProgress and holdingHostage then
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
	end
end

RegisterNetEvent('cmg3_animations:syncTarget')
AddEventHandler('cmg3_animations:syncTarget', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag,animFlagTarget,attach)
	local playerPed = PlayerPedId()
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	if holdingHostageInProgress then
		holdingHostageInProgress = false
	else
		holdingHostageInProgress = true
	end
	beingHeldHostage = true

	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end

	if spin == nil then spin = 180.0 end

	if attach then
		AttachEntityToEntity(PlayerPedId(), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	end

	if controlFlag == nil then controlFlag = 0 end

	if animation2 == "victim_fail" then
		SetEntityHealth(PlayerPedId(),0)
		DetachEntity(PlayerPedId(), true, false)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		beingHeldHostage = false
		holdingHostageInProgress = false
	elseif animation2 == "shoved_back" then
        DetachEntity(PlayerPedId(), true, false)
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
		holdingHostageInProgress = false
		beingHeldHostage = false
	else
		TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	end
	takeHostageAnimNamePlaying = animation2
	takeHostageAnimDictPlaying = animationLib
	takeHostageControlFlagPlaying = controlFlag
end)

RegisterNetEvent('cmg3_animations:syncMe')
AddEventHandler('cmg3_animations:syncMe', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = PlayerPedId()
	ClearPedSecondaryTask(PlayerPedId())

	RequestAnimDict(animationLib)
	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end

	if controlFlag == nil then controlFlag = 0 end

	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)
	takeHostageAnimNamePlaying = animation
	takeHostageAnimDictPlaying = animationLib
	takeHostageControlFlagPlaying = controlFlag

	if animation == "perp_fail" then 
		SetPedShootsAtCoord(PlayerPedId(), 0.0, 0.0, 0.0, 0)
		holdingHostageInProgress = false 
	end
	if animation == "shove_var_a" then 
		Wait(900)
		ClearPedSecondaryTask(PlayerPedId())
		holdingHostageInProgress = false 
	end
end)

RegisterNetEvent('cmg3_animations:cl_stop')
AddEventHandler('cmg3_animations:cl_stop', function()
	holdingHostageInProgress = false
	beingHeldHostage = false 
	holdingHostage = false 
	ClearPedSecondaryTask(PlayerPedId())
	DetachEntity(PlayerPedId(), true, false)
end)

Citizen.CreateThread(function()
	while true do
		if holdingHostage or beingHeldHostage then 
			if not IsEntityPlayingAnim(PlayerPedId(), takeHostageAnimDictPlaying, takeHostageAnimNamePlaying, 3) then
				TaskPlayAnim(PlayerPedId(), takeHostageAnimDictPlaying, takeHostageAnimNamePlaying, 8.0, -8.0, 100000, takeHostageControlFlagPlaying, 0, false, false, false)
				Citizen.Wait(0)
			end
		end
		Wait(2000)
	end
end)

Citizen.CreateThread(function()
	while true do
		local letsleep = 2000
		if holdingHostage then
			letsleep = 0
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisablePlayerFiring(PlayerPedId(),true)

			local playerCoords = GetEntityCoords(PlayerPedId())
			DrawText3D(playerCoords.x,playerCoords.y,playerCoords.z,"Press [G] to release, [H] to kill")
			if IsDisabledControlJustPressed(0,47) then --release
				holdingHostage = false
				holdingHostageInProgress = false 
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent("cmg3_animations:stop", GetPlayerServerId(closestPlayer))
                    Wait(100)
                    releaseHostage()
                end
			elseif IsDisabledControlJustPressed(0,74) then --kill
				local ret, hash = GetCurrentPedWeapon(PlayerPedId())
				if not ret or GetAmmoInPedWeapon(PlayerPedId(), hash) <= 0 then
					ESX.ShowNotification({text = "Anda membutuhkan senjata dengan amunisi untuk menyandera!", type = 'error'})
					return
				end
				holdingHostage = false
				holdingHostageInProgress = false
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestPlayer ~= -1 and closestDistance <= 3.0 then
				    TriggerServerEvent("cmg3_animations:stop", GetPlayerServerId(closestPlayer))
				    killHostage()
                end
			end
		end

		if beingHeldHostage then 
			letsleep = 0
			DisableControlAction(0,21,true) -- disable sprint
			DisableControlAction(0,24,true) -- disable attack
			DisableControlAction(0,25,true) -- disable aim
			DisableControlAction(0,47,true) -- disable weapon
			DisableControlAction(0,58,true) -- disable weapon
			DisableControlAction(0,263,true) -- disable melee
			DisableControlAction(0,264,true) -- disable melee
			DisableControlAction(0,257,true) -- disable melee
			DisableControlAction(0,140,true) -- disable melee
			DisableControlAction(0,141,true) -- disable melee
			DisableControlAction(0,142,true) -- disable melee
			DisableControlAction(0,143,true) -- disable melee
			DisableControlAction(0,75,true) -- disable exit vehicle
			DisableControlAction(27,75,true) -- disable exit vehicle  
			DisableControlAction(0,22,true) -- disable jump
			DisableControlAction(0,32,true) -- disable move up
			DisableControlAction(0,268,true)
			DisableControlAction(0,33,true) -- disable move down
			DisableControlAction(0,269,true)
			DisableControlAction(0,34,true) -- disable move left
			DisableControlAction(0,270,true)
			DisableControlAction(0,35,true) -- disable move right
			DisableControlAction(0,271,true)
		end

		Wait(letsleep)
	end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    if onScreen then
        SetTextScale(0.19, 0.19)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 55)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function releaseHostage()
	local player = PlayerPedId()	
	lib = 'reaction@shove'
	anim1 = 'shove_var_a'
	lib2 = 'reaction@shove'
	anim2 = 'shoved_back'
	distans = 0.11 --Higher = closer to camera
	distans2 = -0.24 --higher = left
	height = 0.0
	spin = 0.0		
	length = 100000
	controlFlagMe = 120
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('cmg3_animations:sync', GetPlayerServerId(closestPlayer), lib, lib2, anim1, anim2, distans, distans2, height, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget, attachFlag)
	end
end 

function killHostage()
	local player = PlayerPedId()	
	lib = 'anim@gangops@hostage@'
	anim1 = 'perp_fail'
	lib2 = 'anim@gangops@hostage@'
	anim2 = 'victim_fail'
	distans = 0.11 --Higher = closer to camera
	distans2 = -0.24 --higher = left
	height = 0.0
	spin = 0.0		
	length = 0.2
	controlFlagMe = 168
	controlFlagTarget = 0
	animFlagTarget = 1
	attachFlag = false
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('cmg3_animations:sync', GetPlayerServerId(closestPlayer), lib, lib2, anim1, anim2, distans, distans2, height, length, spin, controlFlagMe, controlFlagTarget, animFlagTarget, attachFlag)
	end	
end