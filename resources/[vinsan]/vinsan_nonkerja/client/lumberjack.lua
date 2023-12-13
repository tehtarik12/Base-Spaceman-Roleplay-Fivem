local spawnedTrees = 0
local TreePlants = {}
local isPickingUp = false
local isProcessing = false


CreateThread(function()
	while true do
		local Sleep = 1500

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #TreePlants, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(TreePlants[i]), false) < 3.0 then
				nearbyObject, nearbyID = TreePlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
			Sleep = 0
			if not isPickingUp then
				ESX.ShowHelpNotification('[E] Untuk Menebang')
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true
				ESX.ShowNotification('Chop...')
				FreezeEntityPosition(PlayerPedId(), true)

				local model = ESX.Streaming.RequestModel(`prop_tool_fireaxe`)
				local axe = CreateObject(`prop_tool_fireaxe`, GetEntityCoords(PlayerPedId()), true, false, false)
				working = true
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
				table.remove(TreePlants, nearbyID)
				spawnedTrees = spawnedTrees - 1
				TriggerServerEvent('vinsan_jobs:getItem', 'batangkayu')

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
		if GetDistanceBetweenCoords(coords, cfg.blip['tree'].blip, true) < 75 then
			SpawnTreePlants()
			Wait(1000)
		else
			Wait(1000)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(TreePlants) do
			DeleteObject(v)
		end
	end
end)

function SpawnObjectTree(model, coords, cb)
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

function SpawnTreePlants()
	while spawnedTrees < 5 do
		Wait(1)
		local TreeCoords = GenerateTreeCoords()
		SpawnObjectTree('test_tree_forest_trunk_01', TreeCoords, function(obj)
			table.insert(TreePlants, obj)
			spawnedTrees = spawnedTrees + 1
		end)
	end
end 

function ValidateTreeCoord(plantCoord)
	if spawnedTrees > 0 then
		local validate = true
		for k, v in pairs(TreePlants) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 20 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, cfg.blip['tree'].blip, false) > 75 then
			validate = false
		end
		return validate
	else
		return true
	end
end

function GenerateTreeCoords()
	while true do
		Wait(1000)
		local TreeCoordX, TreeCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-35, 35)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-35, 35)
		TreeCoordX = cfg.blip['tree'].blip.x + modX
		TreeCoordY = cfg.blip['tree'].blip.y + modY
		local coordZ = GetCoordZTree(TreeCoordX, TreeCoordY)
		local coord = vector3(TreeCoordX, TreeCoordY, coordZ)
		if ValidateTreeCoord(coord) then
			return coord
		end
	end
end

function GetCoordZTree(x, y)
	local groundCheckHeights = { 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 53.85
end