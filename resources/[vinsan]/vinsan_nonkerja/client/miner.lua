local spawnedStones = 0
local StonePlants = {}
local isPickingUp = false
local isProcessing = false

CreateThread(function()
	while true do
		local Sleep = 1500

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		
		for i=1, #StonePlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(StonePlants[i]), false) < 3.0 then
				nearbyObject, nearbyID = StonePlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
			Sleep = 0
			if not isPickingUp then
				ESX.ShowHelpNotification('[E] Tambang Batu')
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true

				ESX.ShowNotification('Mining...')
				FreezeEntityPosition(PlayerPedId(), true)
		
				local model = ESX.Streaming.RequestModel(`prop_tool_pickaxe`)
				local axe = CreateObject(`prop_tool_pickaxe`, GetEntityCoords(PlayerPedId()), true, false, false)
				AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
				SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`)
				local dict = ESX.Streaming.RequestAnimDict('melee@hatchet@streamed_core')
				CreateThread(function()
					while isPickingUp do
						TaskPlayAnim(PlayerPedId(), 'melee@hatchet@streamed_core', 'plyr_rear_takedown_b', 8.0, -8.0, -1, 2, 0, false, false, false)
						Wait(2500)
					end
				end)
				if lib.progressCircle({
					duration = 6500,
					position = 'bottom',
					useWhileDead = false,
					canCancel = false,
					disable = {
						move = true,
					},
				}) then 
			end
				isPickingUp = false
				DeleteObject(axe)
				FreezeEntityPosition(PlayerPedId(), false)
				ClearPedTasks(playerPed)
				
				Wait(1000)
				DeleteObject(nearbyObject) 
				table.remove(StonePlants, nearbyID)
				spawnedStones = spawnedStones - 1
				TriggerServerEvent('vinsan_jobs:getItem', 'batukasar')

				isPickingUp = false

			end
		end
	Wait(Sleep)
	end
end)

RegisterNetEvent('simplefarmer:harvestRock', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #StonePlants, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(StonePlants[i]), false) < 3.0 then
			nearbyObject, nearbyID = StonePlants[i], i
		end
	end
	if nearbyObject and IsPedOnFoot(playerPed) then
		if not isPickingUp then
		isPickingUp = true
		ESX.ShowNotification('Mining...')
		FreezeEntityPosition(PlayerPedId(), true)

		local model = ESX.Streaming.RequestModel(`prop_tool_pickaxe`)
		local axe = CreateObject(`prop_tool_pickaxe`, GetEntityCoords(PlayerPedId()), true, false, false)
		AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
		SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`)
		local dict = ESX.Streaming.RequestAnimDict('melee@hatchet@streamed_core')
		CreateThread(function()
			while isPickingUp do
				TaskPlayAnim(PlayerPedId(), 'melee@hatchet@streamed_core', 'plyr_rear_takedown_b', 8.0, -8.0, -1, 2, 0, false, false, false)
				Wait(2500)
			end
		end)
		Wait(6500)
		isPickingUp = false
		DeleteObject(axe)
		FreezeEntityPosition(PlayerPedId(), false)
		ClearPedTasks(playerPed)
		
		Wait(1000)
		DeleteObject(nearbyObject) 
		table.remove(StonePlants, nearbyID)
		spawnedStones = spawnedStones - 1
		TriggerServerEvent('vinsan_jobs:getItem', 'batukasar')
	else
		ESX.ShowNotification('Do not Spamming!', 'error')
	end
	else
		ESX.ShowNotification('Rock cant be mined', 'error')
	end
end)

CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, cfg.blip['stone'].blip, true) < 75 then
			SpawnStonePlants()
			Wait(1000)
		else
			Wait(1000)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(StonePlants) do
			DeleteObject(v)
		end
	end
end)

function SpawnObjectStone(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    if cb then
        cb(obj)
    end
end

function SpawnStonePlants()
	while spawnedStones < 5 do
		Wait(1)
		local StoneCoords = GenerateStoneCoords()
		SpawnObjectStone('prop_rock_1_c', StoneCoords, function(obj)
			table.insert(StonePlants, obj)
			spawnedStones = spawnedStones + 1
		end)
	end
end 

function ValidateStoneCoord(plantCoord)
	if spawnedStones > 0 then
		local validate = true
		for k, v in pairs(StonePlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 20 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, cfg.blip['stone'].blip, false) > 75 then
			validate = false
		end
		return validate
	else
		return true
	end
end

function GenerateStoneCoords()
	while true do
		Wait(1000)
		local StoneCoordX, StoneCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)
		StoneCoordX = cfg.blip['stone'].blip.x + modX
		StoneCoordY = cfg.blip['stone'].blip.y + modY
		local coordZ = GetCoordZStone(StoneCoordX, StoneCoordY)
		local coord = vector3(StoneCoordX, StoneCoordY, coordZ)
		if ValidateStoneCoord(coord) then
			return coord
		end
	end
end

function GetCoordZStone(x, y)
	local groundCheckHeights = { 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 53.85
end