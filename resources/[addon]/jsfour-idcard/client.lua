local open = false

local plateModel = "prop_fib_badge"
local animDict = "missfbi_s4mop"
local animName = "swipe_card"

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		type = "open",
		array  = data,
		typecard = type
	})
end)

RegisterNetEvent('jsfour-idcard:showBadge')
AddEventHandler('jsfour-idcard:showBadge', function()
    RequestModel(GetHashKey(plateModel))
    while not HasModelLoaded(GetHashKey(plateModel)) do
        Citizen.Wait(100)
    end
	ClearPedSecondaryTask(PlayerPedId())
	RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(100)
    end
    local playerPed = PlayerPedId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 0.0, -5.0)

	ESX.Game.SpawnObject(plateModel, vector3(plyCoords.x, plyCoords.y, plyCoords.z), function(object)
		TaskPlayAnim(playerPed, 1.0, -1, -1, 50, 0, 0, 0, 0)
		TaskPlayAnim(playerPed, animDict, animName, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
		Citizen.Wait(800)
		local boneIndex = GetPedBoneIndex(playerPed, 28422)
		AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
		Citizen.Wait(3000)
		ClearPedSecondaryTask(playerPed)
		ESX.Game.DeleteObject(object)
	end)
end)

-- Key events
Citizen.CreateThread(function()
	while true do
		local letsleep = 1000

		if open then
			letsleep = 0
			if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) then
				SendNUIMessage({
					type = "close"
				})
				open = false
			end
		end

		Wait(letsleep)
	end
end)