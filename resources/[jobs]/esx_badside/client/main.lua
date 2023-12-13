local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local allowed = false


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData.job = job

	RefreshBlipsBADSIDE()
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	RefreshBlipsBADSIDE()
end)

Citizen.CreateThread(function()
	exports.qtarget:Player({
		options = {
			{
				event = "rheein_badside:TargetAction",
				type = 'search',
				icon = "fas fa-heart",
				label = "Search [BAD]",
				job = {
					["fama"] = 0,
					["famb"] = 0,
					["famc"] = 0,
					["famd"] = 0,
					["fame"] = 0,
					["famf"] = 0,
					["famg"] = 0,
				}
			},
		},
		distance = 2
	})
end)

AddEventHandler('rheein_badside:TargetAction', function(data)
	local ped = data.entity
	local type = data.type
	local playerPed = PlayerPedId()
	local targetserverid = 0

	for k,player in ipairs(GetActivePlayers()) do
		local tped = GetPlayerPed(player)

		if DoesEntityExist(tped) and (tped ~= playerPed and ped == tped) then
			targetserverid = GetPlayerServerId(player)
			break
		end
	end

	if type == 'search' then
		OpenBodySearchMenuBadside(targetserverid)
	elseif type == 'handcuff' then
		TriggerServerEvent('esx_policejob:handcuff', targetserverid)
	end
end)

function OpenBodySearchMenuBadside(player)
	if ConfigBadside.OxInventory then
		exports.ox_inventory:openInventory('player', player)
		return ESX.UI.Menu.CloseAll()
	end
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	RefreshBlipsBADSIDE()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	RefreshBlipsBADSIDE()
end)

AddEventHandler('esx_fraksijob:hasEnteredMarker', function(zone)
	if zone == 'FraksiActions' and (ESX.PlayerData.job.grade_name == 'boss') then
		CurrentAction     = 'fraksi_actions_menu'
		CurrentActionMsg  = '[E] Untuk membuka menu'
		CurrentActionData = {}
	elseif zone == 'VehicleSpawnVehicle' then
		CurrentAction     = 'spawn_vehicle'
		CurrentActionMsg  = '[E] Untuk membuka menu'
	elseif zone == 'CompanyMenu' then
		CurrentAction     = 'company_menu'
		CurrentActionMsg  = '[E] Untuk membuka menu'
	elseif zone == 'CompanyVehicle' then
		CurrentAction     = 'company_vehicle'
		CurrentActionMsg  = '[E] Untuk mengakses kendaraan dinas'
	end
end)

AddEventHandler('esx_fraksijob:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
function RefreshBlipsBADSIDE()
	allowed = false
	for k,v in pairs(ConfigBadside.FraksiZones) do
		if ESX.PlayerData.job and ESX.PlayerData.job.name == k then
			allowed = true
		end
	end
end

local spawnedVehicles = {}
local myPlate = {}

function OpenVehicleSpawnerMenuBDS()
	local playerCoords = GetEntityCoords(PlayerPedId())
	local elements = {
		{label = 'Garage', action = 'garage'},
		{label = 'Store Car', action = 'store_garage'},
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = 'Garage',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.action == 'garage' then
			local garage = {}

			if #ConfigBadside.AuthorizedVehicles[ESX.PlayerData.job.name].car.dinas > 0 then
				local allVehicleProps = {}

				if #ConfigBadside.AuthorizedVehicles[ESX.PlayerData.job.name].car.dinas > 0 then
					for k,v in ipairs(ConfigBadside.AuthorizedVehicles[ESX.PlayerData.job.name].car.dinas) do

						local vehicleName = v.label
						local label = ('%s - <span style="color:darkgoldenrod;">DINAS</span>'):format(vehicleName)

						table.insert(garage, {
							label = label,
							model = v.model,
							price = v.price,
							stored = true
						})
					end
				end

				if #garage > 0 then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = 'Garage',
						align    = 'bottom-right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPointBDS(station, part, partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									if data2.current.plate ~= nil then
										local vehicleProps = allVehicleProps[data2.current.plate]
										ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
									else
										local plate = 'FRK' .. math.random(100, 900)
										SetVehicleNumberPlateText(vehicle, plate)
										table.insert(myPlate, plate)
										plate = string.gsub(plate, " ", "")
									end

									ESX.ShowNotification('Car Released')
								end)
							end
						else
							ESX.ShowNotification('Car Released')
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				else
					ESX.ShowNotification('Car Empty')
				end
			else
				ESX.ShowNotification('Car Empty')
			end
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicleBDS(playerCoords)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenCompanyVehicle()
	local playerCoords = GetEntityCoords(PlayerPedId())
	local elements = {
		{label = 'Garage', action = 'garage'},
		{label = 'Store Car', action = 'store_garage'},
	}
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = 'Garage',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.action == 'garage' then
			local garage = {}

			if #ConfigBadside.Company[ESX.PlayerData.job.name].car > 0 then
				local allVehicleProps = {}

				if #ConfigBadside.Company[ESX.PlayerData.job.name].car > 0 then
					for k,v in ipairs(ConfigBadside.Company[ESX.PlayerData.job.name].car) do

						local vehicleName = v.label
						local label = ('%s - <span style="color:darkgoldenrod;">DINAS</span>'):format(vehicleName)

						table.insert(garage, {
							label = label,
							model = v.model,
							stored = true
						})
					end
				end

				if #garage > 0 then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = 'Garage',
						align    = 'bottom-right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							menu2.close()

							ESX.Game.SpawnVehicle(data2.current.model, ConfigBadside.Company[ESX.PlayerData.job.name].SpawnPoints.coords, ConfigBadside.Company[ESX.PlayerData.job.name].SpawnPoints.heading, function(vehicle)
								local plate = 'FRK' .. math.random(100, 900)
								SetVehicleNumberPlateText(vehicle, plate)
								table.insert(myPlate, plate)
								plate = string.gsub(plate, " ", "")
								ESX.ShowNotification('Car Released')
							end)
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				else
					ESX.ShowNotification('Car Empty')
				end
			else
				ESX.ShowNotification('Car Empty')
			end
		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicleBDS(playerCoords)
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenCompanyMenu()
	local playerCoords = GetEntityCoords(PlayerPedId())
	local elements = ConfigBadside.Company[ESX.PlayerData.job.name].menu
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = 'Company Menu',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		TriggerServerEvent('esx_badside:CraftCompany', data.current.index)
	end, function(data, menu)
		menu.close()
	end)
end

function StoreNearbyVehicleBDS(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		ESX.ShowNotification('Car Empty')
		return
	end

	for i=1, #myPlate, 1 do
		for t=1, #vehiclePlates, 1 do
			if myPlate[i] == vehiclePlates[t].plate then
				local vehicleId = vehiclePlates[t]
				ESX.Game.DeleteVehicle(vehicleId.vehicle)
				table.remove(myPlate, i)
			end
		end
	end
end

function GetAvailableVehicleSpawnPointBDS(station, part, partNum)
	local spawnPoints = ConfigBadside.FraksiStations[ESX.PlayerData.job.name].Vehicles[1].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification('Car Empty')
		return false
	end
end

function WaitForVehicleToLoadBDS(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName('Car Empty')
		EndTextCommandBusyspinnerOn(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)
			DisableAllControlActions(0)
		end

		BusyspinnerOff()
	end
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if allowed then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true
			for k,v in pairs(ConfigBadside.FraksiZones) do
				if ESX.PlayerData.job.name == k and v.Type ~= -1 then
					if (ESX.PlayerData.job.grade_name == 'vice_boss' or ESX.PlayerData.job.grade_name == 'boss') then
						if #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < ConfigBadside.DrawDistance then
							DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
							letSleep = false
						end
					end
					if #(coords - vector3(v.PosVeh.x, v.PosVeh.y, v.PosVeh.z)) < ConfigBadside.DrawDistance then
						DrawMarker(v.Type, v.PosVeh.x, v.PosVeh.y, v.PosVeh.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
						letSleep = false
					end 
				end
			end

			for k,v in pairs(ConfigBadside.Company) do
				if ESX.PlayerData.job.name == k then
					if #(coords - v.coord) < ConfigBadside.DrawDistance then
						DrawMarker(2, v.coord, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 204, 204, 0, 100, false, true, 2, false, nil, nil, false)
						letSleep = false
					end
					if #(coords - v.Spawner) < ConfigBadside.DrawDistance then
						DrawMarker(2, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 204, 204, 0, 100, false, true, 2, false, nil, nil, false)
						letSleep = false
					end 
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if allowed then
			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(ConfigBadside.FraksiZones) do
				if ESX.PlayerData.job and ESX.PlayerData.job.name == k then
					if #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < v.Size.x then
						isInMarker  = true
						currentZone = 'FraksiActions'
					elseif #(coords - vector3(v.PosVeh.x, v.PosVeh.y, v.PosVeh.z)) < v.Size.x then
						isInMarker  = true
						currentZone = 'VehicleSpawnVehicle'
					end
				end
			end

			for k,v in pairs(ConfigBadside.Company) do
				if ESX.PlayerData.job and ESX.PlayerData.job.name == k then
					if #(coords - v.coord) < 1.0 then
						isInMarker  = true
						currentZone = 'CompanyMenu'
					elseif #(coords - v.Spawner) < 1.0 then
						isInMarker  = true
						currentZone = 'CompanyVehicle'
					end
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_fraksijob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_fraksijob:hasExitedMarker', LastZone)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if allowed then
			if CurrentAction then
				ESX.ShowHelpNotification(CurrentActionMsg)
				if IsControlJustReleased(0, 38) and allowed then
					if CurrentAction == 'fraksi_actions_menu' and (ESX.PlayerData.job.grade_name == 'vice_boss' or ESX.PlayerData.job.grade_name == 'boss') then
						TriggerEvent('esx_society:openBossMenu', ESX.PlayerData.job.name, function(data, menu)
							menu.close()
						end)
					elseif CurrentAction == 'spawn_vehicle' then
						OpenVehicleSpawnerMenuBDS()
					elseif CurrentAction == 'company_menu' then
						OpenCompanyMenu()
					elseif CurrentAction == 'company_vehicle' then
						OpenCompanyVehicle()
					end
					CurrentAction = nil
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

--[[AddEventHandler('vinsan_jobs:OpenF6Menu', function()
	if not isDead and allowed and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'badside_actions') then
		OpenPoliceActionsMenuBADSIDE()
	end
end) ]]