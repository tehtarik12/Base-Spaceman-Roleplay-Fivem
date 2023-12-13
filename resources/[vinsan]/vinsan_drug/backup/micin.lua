local spawnedMicins = 0
local MicinPlants = {}
local isPickingUp = false
local isProcessing = false
local busy = false

exports['qtarget']:AddTargetModel(`bkr_prop_meth_tray_02a`, {
	options = {
		{
			event = "simplefarmer:harvestmicin",
			icon = "fas fa-cannabis",
			label = "Harvest Crop",
		},
	},
	distance = 2.0
}) 

RegisterNetEvent('simplefarmer:harvestmicin', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID

	for i=1, #MicinPlants, 1 do
		if type(MicinPlants[i]) ~= 'table' then
			if GetDistanceBetweenCoords(coords, GetEntityCoords(MicinPlants[i]), false) < 1.2 then
				nearbyObject, nearbyID = MicinPlants[i], i
			end
		end
	end
	if nearbyObject and IsPedOnFoot(playerPed) then
		if not isPickingUp and not busy then
		busy = true
		isPickingUp = true
		ESX.ShowNotification('Harvesting crop...')
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_BUM_WASH', 0, false)
		Wait(2000)
		ClearPedTasks(playerPed)
		Wait(1000)
		DeleteObject(nearbyObject) 
		table.remove(MicinPlants, nearbyID)
		spawnedMicins = spawnedMicins - 1
		TriggerServerEvent('vinsan_drug:getItem2', 'micinmentah')
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
		if GetDistanceBetweenCoords(coords, cfg.blip['Micin'].blip, true) < 75 then
			SpawnMicinPlants()
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

        for k,v in pairs(MicinPlants) do
            if type(v) == 'table' and v.planted == false then
                local dist = #(Coords - v.coord)
                if dist < 20 then
                    cas = 5
                    DrawMarker(2, v.coord.x, v.coord.y, v.coord.z + 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 150, 30, 30, 222, false, false, false, true, false, false, false)
					if dist < 2 then
						ESX.ShowHelpNotification('Menabur Micin')
						if IsControlJustPressed(0, 38) and dist < 2 then
							MicinPlants[k].planted = true
							ESX.ShowNotification('Sedang Menabur...')
							TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_BUM_WASH', 0, false)
							Wait(2000)
							ClearPedTasks(playerPed)
							SetTimeout(6500, function()
								SpawnObjectMicin('bkr_prop_meth_tray_02a', v.coord, function(obj)
									MicinPlants[k] = obj
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
		for k, v in pairs(MicinPlants) do
			if type(v) ~= 'table' then DeleteObject(v) end
		end
	end
end)

function SpawnObjectMicin(model, coords, cb)
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

function SpawnMicinPlants()
	while spawnedMicins < 15 do
		Wait(1)
		local MicinCoords = GenerateMicinCoords()
        table.insert(MicinPlants, {coord = MicinCoords, planted = false})
		spawnedMicins = spawnedMicins + 1
	end
end 

function ValidateMicinCoord(plantCoord)
	if spawnedMicins > 0 then
		local validate = true
		for k, v in pairs(MicinPlants) do
            local coord
            if type(v) == 'table' then coord = v.coord else
                coord = GetEntityCoords(v)
            end
			if GetDistanceBetweenCoords(plantCoord, coord, true) < 10 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, cfg.blip['Micin'].blip, false) > 75 then
			validate = false
		end
		return validate
	else
		return true
	end
end

function GenerateMicinCoords()
	while true do
		Wait(1000)
		local MicinCoordX, MicinCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)
		MicinCoordX = cfg.blip['Micin'].blip.x + modX
		MicinCoordY = cfg.blip['Micin'].blip.y + modY
		local coordZ = GetCoordZMicin(MicinCoordX, MicinCoordY)
		local coord = vector3(MicinCoordX, MicinCoordY, coordZ)
		if ValidateMicinCoord(coord) then
			return coord
		end
	end
end

function GetCoordZMicin(x, y)
	local groundCheckHeights = { 87.0, 88.0, 89.0, 90, 91.0, 92.0, 93.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 53.85
end