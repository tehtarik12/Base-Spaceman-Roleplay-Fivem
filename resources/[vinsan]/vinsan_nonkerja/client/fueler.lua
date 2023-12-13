local spawnedOils = 0
local OilPlants = {}
local isPickingUp = false
local isProcessing = false

CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, cfg.blip['oil'].blip, true) < 75 then
			SpawnOilPlants()
			Wait(1000)
		else
			Wait(1000)
		end
	end
end)

-- CreateThread(function()
-- 	while true do
--         cas = 1000
-- 		local playerPed = PlayerPedId()
--         local Coords = GetEntityCoords(PlayerPedId())

--         for k,v in pairs(OilPlants) do
-- 			local dist = #(Coords - v)
-- 			if dist < 20 then
-- 				cas = 5
-- 				DrawMarker(2, v.x, v.y, v.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 150, 30, 30, 222, false, false, false, true, false, false, false)
-- 				if dist < 2 then
-- 					ESX.ShowHelpNotification('Drill for Oil')
-- 					if IsControlJustPressed(0, 38) and dist < 2 then
-- 						ESX.ShowNotification('Drilling...')
-- 						TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_CONST_DRILL', 0, false)
-- 						Wait(6500)
-- 						ClearPedTasks(playerPed)
-- 						ClearAreaOfObjects(Coords, 2.0, 0)
-- 						TriggerServerEvent('vinsan_jobs:getItem', 'minyakmentah')
-- 						table.remove(OilPlants, k)
-- 						spawnedOils = spawnedOils - 1
-- 						Wait(250)
-- 					end
-- 				end
-- 			end
--         end

--         Wait(cas)
-- 	end
-- end)

CreateThread(function()
	while true do
		local Sleep = 1500

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #OilPlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(OilPlants[i]), false) < 3.0 then
				nearbyObject, nearbyID = OilPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
			Sleep = 0
			if not isPickingUp then
				ESX.ShowHelpNotification('[E] Untuk Mengambil Minyak')
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true
				ESX.ShowNotification('Mengambil...')
				FreezeEntityPosition(PlayerPedId(), true)

				-- local model = ESX.Streaming.RequestModel(`prop_tool_drill`)
				-- local axe = CreateObject(`prop_tool_drill`, GetEntityCoords(PlayerPedId()), true, false, false)
				working = true
				AttachEntityToEntity(axe, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.09, 0.03, -0.02, -78.0, 13.0, 28.0, false, true, true, true, 0, true)
				SetCurrentPedWeapon(PlayerPedId(), `WEAPON_UNARMED`)
				-- local dict = ESX.Streaming.RequestAnimDict('melee@hatchet@streamed_core')
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_CONST_DRILL', 0, false)
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
				-- DeleteObject(axe)
				FreezeEntityPosition(PlayerPedId(), false)
				ClearPedTasks(playerPed)
				
				Wait(1000)
				DeleteObject(nearbyObject) 
				table.remove(OilPlants, nearbyID)
				spawnedOils = spawnedOils - 1
				TriggerServerEvent('vinsan_jobs:getItem', 'minyakmentah')

				isPickingUp = false
			end
		end
	Wait(Sleep)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(OilPlants) do
			DeleteObject(v)
		end
	end
end)

function SpawnObjectOil(model, coords, cb)
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

function SpawnOilPlants()
	while spawnedOils < 15 do
		Wait(1)
		local OilCoords = GenerateOilCoords()
		SpawnObjectStone('p_oil_slick_01', OilCoords, function(obj)
			table.insert(OilPlants, obj)
			spawnedOils = spawnedOils + 1
		end)
	end
end 

function ValidateOilCoord(plantCoord)
	if spawnedOils > 0 then
		local validate = true
		for k, v in pairs(OilPlants) do
			if GetDistanceBetweenCoords(plantCoord, v, true) < 10 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, cfg.blip['oil'].blip, false) > 75 then
			validate = false
		end
		return validate
	else
		return true
	end
end

function GenerateOilCoords()
	while true do
		Wait(1000)
		local OilCoordX, OilCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)
		OilCoordX = cfg.blip['oil'].blip.x + modX
		OilCoordY = cfg.blip['oil'].blip.y + modY
		local coordZ = GetCoordZOil(OilCoordX, OilCoordY)
		local coord = vector3(OilCoordX, OilCoordY, coordZ)
		if ValidateOilCoord(coord) then
			return coord
		end
	end
end

function GetCoordZOil(x, y)
	local groundCheckHeights = { 45, 46.0, 47.0, 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 53.85
end