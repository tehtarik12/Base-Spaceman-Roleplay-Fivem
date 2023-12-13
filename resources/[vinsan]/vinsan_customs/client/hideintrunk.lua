local inside = false

local offsets = {
	[1] = { ["name"] = "vic", ["yoffset"] = 0.0, ["zoffset"] = -0.5 },
	[2] = { ["name"] = "taxi", ["yoffset"] = 0.0, ["zoffset"] = -0.5 },
    [3] = { ["name"] = "buccaneer", ["yoffset"] = 0.5, ["zoffset"] = 0.0 },
    [4] = { ["name"] = "peyote", ["yoffset"] = 0.35, ["zoffset"] = -0.15 },
    [5] = { ["name"] = "regina", ["yoffset"] = 0.2, ["zoffset"] = -0.35 },
    [6] = { ["name"] = "pigalle", ["yoffset"] = 0.2, ["zoffset"] = -0.15 },
    [7] = { ["name"] = "glendale", ["yoffset"] = 0.0, ["zoffset"] = -0.35 },
}

Citizen.CreateThread(function()
    exports['qtarget']:AddTargetBone({'boot'}, {
        options = {
            {
                icon = "fas fa-sign-in-alt",
                label = "Get in Trunk",
				action = function(entity)
					local playerPed = PlayerPedId()
					local targetvehicle = entity
				
					TriggerEvent('blue_vehicle:hideintrunk', targetvehicle)
				end,
            },
        },
        distance = 2.5,
    })
end)


RegisterNetEvent('blue_vehicle:hideintrunk')
AddEventHandler('blue_vehicle:hideintrunk', function(currentvehicle)
	local player = PlayerPedId()
	local vehicle = currentvehicle or ESX.Game.GetVehicleInDirection()

	if DoesEntityExist(vehicle) and IsEntityAVehicle(vehicle) and not inside and GetVehiclePedIsIn(player, false) == 0 then
		local OffSet = TrunkOffset(vehicle)
		local lockStatus = GetVehicleDoorLockStatus(vehicle)

		if lockStatus == 4 or lockStatus == 2 then
			ESX.ShowNotification('This vehicle is locked', 'error')
		elseif GetVehicleDoorAngleRatio(vehicle, 5) ~= 0.0 then
			inside = true
			local d1,d2 = GetModelDimensions(GetEntityModel(vehicle))

			if OffSet > 0 then
				AttachEntityToEntity(player, vehicle, 0, -0.1,(d1["y"]+0.85) + offsets[OffSet]["yoffset"],(d2["z"]-0.87) + offsets[OffSet]["zoffset"], 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
			else
				AttachEntityToEntity(player, vehicle, 0, -0.1,d1["y"]+0.85,d2["z"]-0.87, 0, 0, 40.0, 1, 1, 1, 1, 1, 1)
			end

			local dict = "fin_ext_p1-7"
        	local anim = "cs_devin_dual-7"

			SetBlockingOfNonTemporaryEvents(player, true)      
        	SetPedSeeingRange(player, 0.0)     
       		SetPedHearingRange(player, 0.0)        
        	SetPedFleeAttributes(player, 0, false)     
        	SetPedKeepTask(player, true)
			ClearPedTasks(player)

			Streaming(dict, function()
				TaskPlayAnim(player, dict, anim, 8.0, 8.0, -1, 1, 999.0, 0, 0, 0)
			end)

			if not (IsEntityPlayingAnim(player, dict, anim, 3) == 1) then
		    	Streaming(dict, function()
					TaskPlayAnim(player, dict, anim, 1.0, -1, -1, 49, 0, 0, 0, 0)
		    	end)
			end

			while inside do
				Citizen.Wait(1)

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

				d1,d2 = GetModelDimensions(GetEntityModel(vehicle))

            	local DropPosition = GetOffsetFromEntityInWorldCoords(vehicle, 0.0,d1["y"]-0.2,0.0)

				SetTextFont(4)
				SetTextScale(0.45, 0.45)
				SetTextColour(185, 185, 185, 255)
				SetTextDropshadow(0, 0, 0, 0, 255)
				SetTextDropShadow()
				SetTextOutline()
				BeginTextCommandDisplayText('STRING')
				AddTextComponentSubstringPlayerName('Tekan [~b~E~s~] untuk keluar dari bagasi')
				EndTextCommandDisplayText(0.435, 0.745)

				if not DoesEntityExist(vehicle) or isDead then
					DetachEntity(player)
					ClearPedTasks(player)

					inside = false
					break
				end

           	 	if IsDisabledControlJustReleased(0,206) then
					if GetVehicleDoorAngleRatio(vehicle, 5) ~= 0.0 and not (lockStatus == 4 or lockStatus == 2) then
						DetachEntity(player)
						ClearPedTasks(player)

						inside = false
						break
					else
						ESX.ShowNotification('The trunk is closed', 'error')
					end
				end
			end

			DetachEntity(player)

			if DoesEntityExist(vehicle) then
				DropPosition = GetOffsetFromEntityInWorldCoords(vehicle, 0.0,d1["y"]-0.5,0.0)
				SetEntityCoords(player,DropPosition["x"],DropPosition["y"],DropPosition["z"])
			end
		else
			ESX.ShowNotification('The trunk is closed', 'error')
		end
	end
end)

function TrunkOffset(veh)
    for i=1,#offsets do
        if GetEntityModel(veh) == GetHashKey(offsets[i]["name"]) then
            return i
        end
    end
    return 0
end

function Streaming(animDict, cb)
	if not HasAnimDictLoaded(animDict) then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(1)
		end
	end
	if cb ~= nil then
		cb()
	end
end
