local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local isDead, isBusy = false, false

Citizen.CreateThread(function()
	exports.qtarget:Vehicle({
		options = {
			{
				event = "kcmcity_mechanicjob:TargetAction",
				type = 'hijack_vehicle',
				icon = "fas fa-sign-out-alt",
				label = "Membobol Kendaraan [MECH]",
				job = 'mechanic',
			},
			{
				event = "kcmcity_mechanicjob:TargetAction",
				type = 'fix_vehicle',
				icon = "fas fa-sign-out-alt",
				label = "Memperbaiki Kendaraan [MECH]",
				job = 'mechanic',
			},
			{
				event = "kcmcity_mechanicjob:TargetAction",
				type = 'clean_vehicle',
				icon = "fas fa-sign-out-alt",
				label = "Membersihkan Kendaraan [MECH]",
				job = 'mechanic',
			},
			{
				event = "kcmcity_mechanicjob:TargetAction",
				type = 'impound',
				icon = "fas fa-sign-out-alt",
				label = "Impound Vehicle [MECH]",
				job = 'mechanic',
			},
		},
		distance = 2
	})
end)

function OpenMechanicActionsMenu()
	local elements = {
		{label = _U('vehicle_list'),   value = 'vehicle_list'},
		{label = 'Mechanic Stash',   value = 'mechanic_stash'},
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mechanic_actions', {
		title    = _U('mechanic'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then
			if Config.EnableSocietyOwnedVehicles then

				local elements = {}

				ESX.TriggerServerCallback('esx_society:getVehiclesInGarage', function(vehicles)
					for i=1, #vehicles, 1 do
						table.insert(elements, {
							label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
							value = vehicles[i]
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
						title    = _U('service_vehicle'),
						align    = 'top-right',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value

						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						end)

						TriggerServerEvent('esx_society:removeVehicleFromGarage', 'mechanic', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'mechanic')

			else

				local elements = {
					{label = _U('flat_bed'),  value = 'flatbed'},
					{label = _U('tow_truck'), value = 'f450towtruk'},
				}

				if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'boss' or ESX.PlayerData.job.grade_name == 'vice_boss' or ESX.PlayerData.job.grade_name == 'experimente') then
					table.insert(elements, {label = 'SlamVan', value = 'slamvan3'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'top-right',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 35.9216, function(vehicle)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						end)
					else
						ESX.TriggerServerCallback('esx_service:enableService', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 35.9216, function(vehicle)
									local playerPed = PlayerPedId()
									TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'mechanic')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenMechanicActionsMenu()
				end)

			end
		elseif data.current.value == 'mechanic_stash' then
			exports.ox_inventory:openInventory('stash', {id = 'society_mechanic', owner = nil})

		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end

AddEventHandler('kcmcity_mechanicjob:TargetAction', function(data)
	local vehicle = data.entity
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local type = data.type
	
	--local xPlayer = ESX.GetPlayerFromId(source)

	if type == 'hijack_vehicle' then
		TriggerEvent('esx_mechanicjob:onHijack', vehicle)
	elseif type == 'impound' then
		TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
		Citizen.Wait(10000)
		ClearPedTasks(playerPed)
		ImpoundVehicleMech(vehicle)
	elseif type == 'fix_vehicle' then
		if DoesEntityExist(vehicle) then
			isBusy = true

			local count = exports.ox_inventory:Search('count', 'repairkit')
			if count >= 1 then
				exports.rprogress:Custom({
					Type = 'linear',
					Async = true,
					canCancel = false,       -- Allow cancelling
					x = 0.5,                -- Position on x-axis
					y = 0.9,                -- Position on y-axis
					From = 0,               -- Percentage to start from
					To = 100,               -- Percentage to end
					Duration = 20000,        -- Duration of the progress
					Radius = 60,            -- Radius of the dial
					Stroke = 10,            -- Thickness of the progress dial
					Cap = 'butt',           -- or 'round'
					Padding = 0,            -- Padding between the progress dial and the background dial
					MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
					Rotation = 0,           -- 2D rotation of the dial in degrees
					Width = 300,            -- Width of bar in px if Type = 'linear'
					Height = 40,            -- Height of bar in px if Type = 'linear'
					ShowTimer = true,       -- Shows the timer countdown within the radial dial
					ShowProgress = true,   -- Shows the progress % within the radial dial    
					Easing = "easeLinear",
					Label = "Memperbaiki kendaraan",
					LabelPosition = "right",
					Color = "rgba(255, 255, 255, 1.0)",
					BGColor = "rgba(0, 0, 0, 0.4)",
					Animation = {
						scenario = "PROP_HUMAN_BUM_BIN",
					},
					DisableControls = {
						Mouse = false,
						Player = true,
						Vehicle = true
					},
					onComplete = function(cancelled)
						if not cancelled then
							SetVehicleFixed(vehicle)
							SetVehicleDeformationFixed(vehicle)
							SetVehicleUndriveable(vehicle, false)
							SetVehicleEngineOn(vehicle, true, true)
							ClearPedTasksImmediately(playerPed)
							TriggerServerEvent('vinsan_core:removeItem', 'repairkit')
							ESX.ShowNotification(_U('vehicle_repaired'))
						end
						isBusy = false
						ClearPedTasks(PlayerPedId())
					end
				})
			else
				ESX.ShowNotification('Anda tidak memiliki Repairkit!')
			end
		else
			ESX.ShowNotification(_U('no_vehicle_nearby'))
		end
	elseif type == 'clean_vehicle' then
		if DoesEntityExist(vehicle) then
			isBusy = true

			exports.rprogress:Custom({
				Type = 'linear',
				Async = true,
				canCancel = false,       -- Allow cancelling
				x = 0.5,                -- Position on x-axis
				y = 0.9,                -- Position on y-axis
				From = 0,               -- Percentage to start from
				To = 100,               -- Percentage to end
				Duration = 10000,        -- Duration of the progress
				Radius = 60,            -- Radius of the dial
				Stroke = 10,            -- Thickness of the progress dial
				Cap = 'butt',           -- or 'round'
				Padding = 0,            -- Padding between the progress dial and the background dial
				MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
				Rotation = 0,           -- 2D rotation of the dial in degrees
				Width = 300,            -- Width of bar in px if Type = 'linear'
				Height = 40,            -- Height of bar in px if Type = 'linear'
				ShowTimer = true,       -- Shows the timer countdown within the radial dial
				ShowProgress = true,   -- Shows the progress % within the radial dial    
				Easing = "easeLinear",
				Label = "Membersihkan kendaraan",
				LabelPosition = "right",
				Color = "rgba(255, 255, 255, 1.0)",
				BGColor = "rgba(0, 0, 0, 0.4)",
				Animation = {
					scenario = "WORLD_HUMAN_MAID_CLEAN",
				},
				DisableControls = {
					Mouse = false,
					Player = true,
					Vehicle = true
				},
				onComplete = function(cancelled)
					if not cancelled then
						SetVehicleDirtLevel(vehicle, 0)
						ClearPedTasksImmediately(playerPed)
						ESX.ShowNotification(_U('vehicle_cleaned'))
					end
					isBusy = false
					ClearPedTasks(PlayerPedId())
				end
			})
		else
			ESX.ShowNotification(_U('no_vehicle_nearby'))
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onHijack')
AddEventHandler('esx_mechanicjob:onHijack', function(setvehicle)
	local playerPed = PlayerPedId()
	local vehicle = ESX.Game.GetVehicleInDirection()
	local coords = GetEntityCoords(playerPed)

	if setvehicle then vehicle = setvehicle end

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification(_U('inside_vehicle'), 'error')
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true

		exports.rprogress:Custom({
			Type = 'linear',
			Async = true,
			canCancel = false,       -- Allow cancelling
			x = 0.5,                -- Position on x-axis
			y = 0.9,                -- Position on y-axis
			From = 0,               -- Percentage to start from
			To = 100,               -- Percentage to end
			Duration = 15000,        -- Duration of the progress
			Radius = 60,            -- Radius of the dial
			Stroke = 10,            -- Thickness of the progress dial
			Cap = 'butt',           -- or 'round'
			Padding = 0,            -- Padding between the progress dial and the background dial
			MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
			Rotation = 0,           -- 2D rotation of the dial in degrees
			Width = 300,            -- Width of bar in px if Type = 'linear'
			Height = 40,            -- Height of bar in px if Type = 'linear'
			ShowTimer = true,       -- Shows the timer countdown within the radial dial
			ShowProgress = true,   -- Shows the progress % within the radial dial    
			Easing = "easeLinear",
			Label = "Membobol kendaraan",
			LabelPosition = "right",
			Color = "rgba(255, 255, 255, 1.0)",
			BGColor = "rgba(0, 0, 0, 0.4)",
			Animation = {
				scenario = "WORLD_HUMAN_WELDING",
			},
			DisableControls = {
				Mouse = false,
				Player = true,
				Vehicle = true
			},
			onComplete = function(cancelled)
				if not cancelled then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('vehicle_unlocked'))
				end
				isBusy = false
				ClearPedTasks(PlayerPedId())
			end
		})
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'), 'error')
	end
end)

RegisterNetEvent('esx_mechanicjob:onEnginekit')
AddEventHandler('esx_mechanicjob:onEnginekit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) and isBusy == false then
			isBusy = true

			
			exports.rprogress:Custom({
				Type = 'linear',
				Async = true,
				canCancel = false,       -- Allow cancelling
				x = 0.5,                -- Position on x-axis
				y = 0.9,                -- Position on y-axis
				From = 0,               -- Percentage to start from
				To = 100,               -- Percentage to end
				Duration = 10000,        -- Duration of the progress
				Radius = 60,            -- Radius of the dial
				Stroke = 10,            -- Thickness of the progress dial
				Cap = 'butt',           -- or 'round'
				Padding = 0,            -- Padding between the progress dial and the background dial
				MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
				Rotation = 0,           -- 2D rotation of the dial in degrees
				Width = 300,            -- Width of bar in px if Type = 'linear'
				Height = 40,            -- Height of bar in px if Type = 'linear'
				ShowTimer = true,       -- Shows the timer countdown within the radial dial
				ShowProgress = true,   -- Shows the progress % within the radial dial    
				Easing = "easeLinear",
				Label = "Memakai Enginekit",
				LabelPosition = "right",
				Color = "rgba(255, 255, 255, 1.0)",
				BGColor = "rgba(0, 0, 0, 0.4)",
				Animation = {
					animationDictionary = "mini@repair", -- https://alexguirre.github.io/animations-list/
					animationName = "fixing_a_ped",
				},
				DisableControls = {
					Mouse = false,
					Player = true,
					Vehicle = true
				},
				onComplete = function(cancelled)
					if not cancelled then
						SetVehicleEngineHealth(vehicle, 700.0)
						SetVehicleUndriveable(vehicle, false)
						ClearPedTasksImmediately(playerPed)
						SetVehicleEngineOn(vehicle, true, true, true)
						ESX.ShowNotification(_U('veh_repaired'))
					end
					isBusy = false
					ClearPedTasks(PlayerPedId())
				end
			})

		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onRepairkit')
AddEventHandler('esx_mechanicjob:onRepairkit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) and isBusy == false then
			isBusy = true

			exports.rprogress:Custom({
				Type = 'linear',
				Async = true,
				canCancel = false,       -- Allow cancelling
				x = 0.5,                -- Position on x-axis
				y = 0.9,                -- Position on y-axis
				From = 0,               -- Percentage to start from
				To = 100,               -- Percentage to end
				Duration = 10000,        -- Duration of the progress
				Radius = 60,            -- Radius of the dial
				Stroke = 10,            -- Thickness of the progress dial
				Cap = 'butt',           -- or 'round'
				Padding = 0,            -- Padding between the progress dial and the background dial
				MaxAngle = 360,         -- Maximum sweep angle of the dial in degrees
				Rotation = 0,           -- 2D rotation of the dial in degrees
				Width = 300,            -- Width of bar in px if Type = 'linear'
				Height = 40,            -- Height of bar in px if Type = 'linear'
				ShowTimer = true,       -- Shows the timer countdown within the radial dial
				ShowProgress = true,   -- Shows the progress % within the radial dial    
				Easing = "easeLinear",
				Label = "Memakai Repairkit",
				LabelPosition = "right",
				Color = "rgba(255, 255, 255, 1.0)",
				BGColor = "rgba(0, 0, 0, 0.4)",
				Animation = {
					animationDictionary = "mini@repair", -- https://alexguirre.github.io/animations-list/
					animationName = "fixing_a_ped",
				},
				DisableControls = {
					Mouse = false,
					Player = true,
					Vehicle = true
				},
				onComplete = function(cancelled)
					if not cancelled then
						SetVehicleFixed(vehicle)
						SetVehicleDeformationFixed(vehicle)
						SetVehicleUndriveable(vehicle, false)
						ClearPedTasksImmediately(playerPed)
						SetVehicleEngineOn(vehicle, true, true, true)
						ESX.ShowNotification(_U('veh_repaired'))
					end
					isBusy = false
					ClearPedTasks(PlayerPedId())
				end
			})
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('esx_mechanicjob:hasEnteredMarker', function(zone)
	if zone == 'MechanicActions' then
		CurrentAction     = 'mechanic_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'BossAction' then
		CurrentAction     = 'boss_action'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'Garage' then
		CurrentAction     = 'mechanic_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('veh_stored')
			CurrentActionData = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('esx_mechanicjob:hasExitedMarker', function(zone)
	CurrentAction = nil
	CurrentActionMsg = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.MechanicActions.Pos.x, Config.Zones.MechanicActions.Pos.y, Config.Zones.MechanicActions.Pos.z)

	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(' '.._U('mechanic'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
CreateThread(function()
	while true do
		local Sleep = 2000

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			Sleep = 500
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.Zones) do
				if v.Type ~= -1 and #(coords - v.Pos) < Config.DrawDistance then
					Sleep = 0
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end
			end
		end
		Wait(Sleep)
	end
end)

-- Enter / Exit marker events
CreateThread(function()
	while true do
		local Sleep = 1000

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(#(coords - v.Pos) < v.Size.x) then
					Sleep = 0
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_mechanicjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_mechanicjob:hasExitedMarker', LastZone)
			end
		end
		Wait(Sleep)
	end
end)

-- Key Controls
CreateThread(function()
	while true do
		local letSleep = 5000

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then
			letSleep = 1000
		if CurrentAction then
			letSleep = 0
			ESX.ShowHelpNotification(CurrentActionMsg)
			
			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'mechanic_actions_menu' then
					OpenMechanicActionsMenu()
				elseif CurrentAction == 'boss_action' and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then 
					TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
						menu.close()
					end, {wash = false})
				elseif CurrentAction == 'delete_vehicle' then
					ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				CurrentAction = nil
			end
		end
	end
		
		Wait(letSleep)
	end
end)

function ImpoundVehicleMech(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle)
	ESX.ShowNotification('Kendaraan berhasil di impound')
end

AddEventHandler('esx:onPlayerDeath', function(data) isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)