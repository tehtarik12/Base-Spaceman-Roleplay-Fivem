local spawnedMicins = 0
local micinPlants = {}
local isPickingUp, isProcessing = false, false

CreateThread(function()
	while true do
		Wait(700)
		local coords = GetEntityCoords(PlayerPedId())

		if #(coords - Config.CircleZones.MicinField.coords) < 50 then
			SpawnMicinPlants()
		end
	end
end)

-- CreateThread(function()
-- 	while true do
-- 		local wait = 1000
-- 		local playerPed = PlayerPedId()
-- 		local coords = GetEntityCoords(playerPed)

-- 		if #(coords - Config.CircleZones.MicinProcessing.coords) < 1 then
-- 			wait = 2
-- 			if not isProcessing then
-- 				ESX.ShowHelpNotification(_U('micin_processprompt'))
-- 			end

-- 			if IsControlJustReleased(0, 38) and not isProcessing then
-- 				if Config.LicenseEnable then
-- 					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasProcessingLicense)
-- 						if hasProcessingLicense then
-- 							ProcessMicin()
-- 						else
-- 							OpenBuyLicenseMenu('micin_processing')
-- 						end
-- 					end, GetPlayerServerId(PlayerId()), 'micin_processing')
-- 				else
-- 					ESX.TriggerServerCallback('esx_drugs:cannabis_count', function(xCannabis)
-- 						ProcessMicin(xCannabis)
-- 					end)
					
-- 				end
-- 			end
-- 		end
-- 		Wait(wait)
-- 	end
-- end)

-- function ProcessMicin(xCannabis)
-- 	isProcessing = true
-- 	ESX.ShowNotification(_U('micin_processingstarted'))
--   TriggerServerEvent('esx_drugs:processCannabis')
-- 	if(xCannabis <= 3) then
-- 		xCannabis = 0
-- 	end
--   local timeLeft = (Config.Delays.MicinProcessing * xCannabis) / 1000
-- 	local playerPed = PlayerPedId()

-- 	while timeLeft > 0 do
-- 		Wait(1000)
-- 		timeLeft = timeLeft - 1

-- 		if #(GetEntityCoords(playerPed) - Config.CircleZones.MicinProcessing.coords) > 4 then
-- 			ESX.ShowNotification(_U('micin_processingtoofar'))
-- 			TriggerServerEvent('esx_drugs:cancelProcessing')
-- 			TriggerServerEvent('esx_drugs:outofbound')
-- 			break
-- 		end
-- 	end

-- 	isProcessing = false
-- end

CreateThread(function()
	while true do
		Wait(0)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID

		for i=1, #micinPlants, 1 do
			if #(coords - GetEntityCoords(micinPlants[i])) < 1.5 then
				nearbyObject, nearbyID = micinPlants[i], i
			end
		end

		if nearbyObject and IsPedOnFoot(playerPed) then
			if not isPickingUp then
				ESX.ShowHelpNotification(_U('micin_pickupprompt'))
			end

			if IsControlJustReleased(0, 38) and not isPickingUp then
				isPickingUp = true

				ESX.TriggerServerCallback('esx_drugs:canPickUp', function(canPickUp)
					if canPickUp then
						TaskStartScenarioInPlace(playerPed, 'world_human_gardener_plant', 0, false)
						canPickUp = false
						Wait(2000)
						ClearPedTasks(playerPed)
						Wait(1000)
		
						ESX.Game.DeleteObject(nearbyObject)
		
						table.remove(micinPlants, nearbyID)
						spawnedMicins = spawnedMicins - 1
		
						TriggerServerEvent('esx_drugs:pickedUpCannabis2')
						Wait(2000)
					else
						ESX.ShowNotification(_U('micin_inventoryfull'))
					end
					
					canPickUp = true
					isPickingUp = false
				end, 'micinmentah')
			end
		else
			Wait(500)
		end
	end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(micinPlants) do
			ESX.Game.DeleteObject(v)
		end
	end
end)

function SpawnMicinPlants()
	while spawnedMicins < 100 do
		Wait(0)
		local micinCoords = GenerateMicinCoords()

		ESX.Game.SpawnLocalObject('bkr_prop_coke_fullmetalbowl_02', micinCoords, function(obj)
			PlaceObjectOnGroundProperly(obj)
			FreezeEntityPosition(obj, true)

			table.insert(micinPlants, obj)
			spawnedMicins = spawnedMicins + 1
		end)
	end
end

function ValidateMicinCoord(plantCoord)
	if spawnedMicins > 0 then
		local validate = true

		for k, v in pairs(micinPlants) do
			if #(plantCoord - GetEntityCoords(v)) < 5 then
				validate = false
			end
		end

		if #(plantCoord - Config.CircleZones.MicinField.coords) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function GenerateMicinCoords()
	while true do
		Wait(0)

		local micinCoordX, micinCoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(-45, 45)

		Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(-45, 45)

		micinCoordX = Config.CircleZones.MicinField.coords.x + modX
		micinCoordY = Config.CircleZones.MicinField.coords.y + modY

		local coordZ = GetCoordZ(micinCoordX, micinCoordY)
		local coord = vector3(micinCoordX, micinCoordY, coordZ)

		if ValidateMicinCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = { 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0, 56.0, 57.0, 58.0 }

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end
