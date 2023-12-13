local spawnedCottons = 0
local CottonPlant = {}
local isPickingUp = false
local isProcessing = false


CreateThread(function()
	while true do
		local Sleep = 1500

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #CottonPlant, 1 do
				if GetDistanceBetweenCoords(coords, GetEntityCoords(CottonPlant[i]), false) < 1.2 then
					nearbyObject, nearbyID = CottonPlant[i], i
				end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
			Sleep = 0
			if not isPickingUp then
				ESX.ShowHelpNotification('[E] Mengambil Kapas')
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true
				ESX.ShowNotification('Harvesting crop...')
				TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
				if lib.progressCircle({
					duration = 4000,
					position = 'bottom',
					useWhileDead = false,
					canCancel = false,
					disable = {
						move = true,
					},
				}) then 
			end
				ClearPedTasks(playerPed)
				FreezeEntityPosition(PlayerPedId(), false)
				isPickingUp = false
				Wait(1000)
				DeleteObject(nearbyObject) 
				table.remove(CottonPlant, nearbyID)
				spawnedCottons = spawnedCottons - 1
				TriggerServerEvent('vinsan_jobs:getItem', 'kapas')
				isPickingUp = false
			end
		end
	Wait(Sleep)
	end
end)

CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, cfg.blip['tailor'].blip, true) < 75 then
			SpawnCottonPlant()
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

--         for k,v in pairs(CottonPlant) do
--             if type(v) == 'table' and v.planted == false then
--                 local dist = #(Coords - v.coord)
--                 if dist < 20 then
--                     cas = 5
--                     DrawMarker(2, v.coord.x, v.coord.y, v.coord.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 150, 30, 30, 222, false, false, false, true, false, false, false)
-- 					if dist < 2 then
-- 						ESX.ShowHelpNotification('Plant Cotton')
-- 						if IsControlJustPressed(0, 38) and dist < 2 then
-- 							CottonPlant[k].planted = true
-- 							ESX.ShowNotification('Planting crop...')
-- 							TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
-- 							Wait(6500)
-- 							ClearPedTasks(playerPed)
-- 							SetTimeout(20000, function()
-- 								SpawnObjectCotton('prop_bush_lrg_01e_cr2', v.coord, function(obj)
-- 									CottonPlant[k] = obj
-- 								end)
-- 							end)
-- 							Wait(250)
-- 						end
-- 					end
--                 end
--             end
--         end

--         Wait(cas)
-- 	end
-- end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(CottonPlant) do
			DeleteObject(v)
		end
	end
end)

function SpawnObjectCotton(model, coords, cb)
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

function SpawnCottonPlant()
	while spawnedCottons < 15 do
		Wait(1)
		local CottonCoords = GenerateCottonCoords()
		SpawnObjectStone('prop_snow_bush_01_a', CottonCoords, function(obj)
			table.insert(CottonPlant, obj)
			spawnedCottons = spawnedCottons + 1
		end)
	end
end 

function ValidateCottonCoord(plantCoord)
	if spawnedCottons > 0 then
		local validate = true
		for k, v in pairs(CottonPlant) do
			if GetDistanceBetweenCoords(plantCoord, v, true) < 10 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, cfg.blip['tailor'].blip, false) > 75 then
			validate = false
		end
		return validate
	else
		return true
	end
end

function GenerateCottonCoords()
	while true do
		Wait(1000)
		local CottonCoordX, CottonCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)
		CottonCoordX = cfg.blip['tailor'].blip.x + modX
		CottonCoordY = cfg.blip['tailor'].blip.y + modY
		local coordZ = GetCoordZCotton(CottonCoordX, CottonCoordY)
		local coord = vector3(CottonCoordX, CottonCoordY, coordZ)
		if ValidateCottonCoord(coord) then
			return coord
		end
	end
end

function GetCoordZCotton(x, y)
	local groundCheckHeights = { 10.0, 45, 46.0, 47.0, 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 53.85
end