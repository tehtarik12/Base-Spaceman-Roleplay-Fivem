local spawnedWeeds = 0
local WeedPlants = {}
local isPickingUp = false
local isProcessing = false
local busy = false

exports['qtarget']:AddTargetModel(`prop_weed_01`, {
	options = {
		{
			event = "simplefarmer:harvestweed",
			icon = "fas fa-cannabis",
			label = "Harvest Crop",
		},
	},
	distance = 2.0
}) 

RegisterNetEvent('simplefarmer:harvestweed', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #WeedPlants, 1 do
		if type(WeedPlants[i]) ~= 'table' then
			if GetDistanceBetweenCoords(coords, GetEntityCoords(WeedPlants[i]), false) < 1.2 then
				nearbyObject, nearbyID = WeedPlants[i], i
			end
		end
	end
	if nearbyObject and IsPedOnFoot(playerPed) then
		if not isPickingUp and not busy then
		busy = true
		isPickingUp = true
		ESX.ShowNotification('Harvesting crop...')
		TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
		Wait(2000)
		ClearPedTasks(playerPed)
		Wait(1000)
		DeleteObject(nearbyObject) 
		table.remove(WeedPlants, nearbyID)
		spawnedWeeds = spawnedWeeds - 1
		TriggerServerEvent('vinsan_drug:getItem', 'kecubungmentah')
		isPickingUp = false
		busy = false
	else 
		ESX.ShowHelpNotification('do not spamming!', 'error')
		end
	else
		ESX.ShowNotification('crop cant be harvested', 'error')
	end
end)

CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, cfg.blip['Kecubung'].blip, true) < 25 then
			SpawnWeedPlants()
			Wait(1000)
		else
			Wait(1000)
		end
	end
end)

CreateThread(function()
	while true do
        cas = 1000
		local playerPed = PlayerPedId()
        local Coords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(WeedPlants) do
            if type(v) == 'table' and v.planted == false then
                local dist = #(Coords - v.coord)
                if dist < 20 then
                    cas = 5
                    DrawMarker(2, v.coord.x, v.coord.y, v.coord.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 150, 30, 30, 222, false, false, false, true, false, false, false)
					if dist < 2 then
						ESX.ShowHelpNotification('Plant Kecubung')
						if IsControlJustPressed(0, 38) and dist < 2 then
							WeedPlants[k].planted = true
							ESX.ShowNotification('Planting crop...')
							TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
							Wait(2000)
							ClearPedTasks(playerPed)
							SetTimeout(6500, function()
								SpawnObjectWeed('prop_weed_01', v.coord, function(obj)
									WeedPlants[k] = obj
								end)
							end)
							Wait(250)
						end
					end
                end
            end
        end

        Wait(cas)
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(WeedPlants) do
			if type(v) ~= 'table' then DeleteObject(v) end
		end
	end
end)

function SpawnObjectWeed(model, coords, cb)
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

function SpawnWeedPlants()
	while spawnedWeeds < 15 do
		Wait(1)
		local WeedCoords = GenerateWeedCoords()
        table.insert(WeedPlants, {coord = WeedCoords, planted = false})
		spawnedWeeds = spawnedWeeds + 1
	end
end 

function ValidateWeedCoord(plantCoord)
	if spawnedWeeds > 0 then
		local validate = true
		for k, v in pairs(WeedPlants) do
            local coord
            if type(v) == 'table' then coord = v.coord else
                coord = GetEntityCoords(v)
            end
			if GetDistanceBetweenCoords(plantCoord, coord, true) < 10 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, cfg.blip['Kecubung'].blip, false) > 75 then
			validate = false
		end
		return validate
	else
		return true
	end
end

function GenerateWeedCoords()
	while true do
		Wait(1000)
		local WeedCoordX, WeedCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)
		WeedCoordX = cfg.blip['Kecubung'].blip.x + modX
		WeedCoordY = cfg.blip['Kecubung'].blip.y + modY
		local coordZ = GetCoordZWeed(WeedCoordX, WeedCoordY)
		local coord = vector3(WeedCoordX, WeedCoordY, coordZ)
		if ValidateWeedCoord(coord) then
			return coord
		end
	end
end

function GetCoordZWeed(x, y)
	local groundCheckHeights = { 87.0, 88.0, 89.0, 90, 91.0, 92.0, 93.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 53.85
end