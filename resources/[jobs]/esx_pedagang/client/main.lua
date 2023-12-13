local HasAlreadyEnteredMarker, CurrentActionData = false, {}
local LastZone, CurrentAction, CurrentActionMsg

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

--[[function OpenMobilePedagangActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pedagang', {
		title    = 'Menu Pedagang',
		align    = 'top-right',
		elements = {
			{label = 'Billing', value = 'billing'},
	}}, function(data, menu)
		if isBusy then return end

		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if closestPlayer == -1 or closestDistance > 1.5 then
			ESX.ShowNotification({type = 'error', text = _U('no_players')})
		else
			if data.current.value == 'billing' then
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
					title = 'Jumlah Pembayaran:'
				}, function(data2, menu2)
					local amount = tonumber(data2.value)
	
					if amount == nil or amount < 0 then
						ESX.ShowNotification('Jumlah tidak valid!')
					else
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer == -1 or closestDistance > 3.0 then
							ESX.ShowNotification(_U('no_players'))
						else
							menu2.close()
							TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_pedagang', 'Pedagang', amount)
						end
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end ]]

function OpenCloakroomPEDAGANG()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pedagang_cloakroom', {
		title    = _U('cloakroom_menu'),
		align    = 'bottom-right',
		elements = {
			{label = _U('wear_citizen'), value = 'wear_citizen'},
			{label = _U('wear_work'),    value = 'wear_work'}
	}}, function(data, menu)
		if data.current.value == 'wear_citizen' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
				TriggerEvent('skinchanger:loadSkin', skin)
			end)
		elseif data.current.value == 'wear_work' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('skinchanger:loadClothes', skin, Config.Cloakroom[tostring(ESX.PlayerData.job.grade)].male)
				else
					TriggerEvent('skinchanger:loadClothes', skin, Config.Cloakroom[tostring(ESX.PlayerData.job.grade)].female)
				end
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'cloakroom'
		CurrentActionMsg  = _U('cloakroom_prompt')
		CurrentActionData = {}
	end)
end

function OpenPedagangAction()
	ESX.UI.Menu.CloseAll()
	local elements = {
		--{label = 'Akses Brankas', value = 'brankas'}
	}

	if (ESX.PlayerData.job.grade_name == 'vice_boss' or ESX.PlayerData.job.grade_name == 'boss') then
		table.insert(elements, {label = 'Boss Action', value = 'boss_action'})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pedagang_action', {
		title    = 'Pedagang',
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'boss_action' then
			TriggerEvent('esx_society:openBossMenu', 'pedagang', function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'brankas' then
			exports.ox_inventory:openInventory('stash', {id = 'society_pedagang', owner = nil})
		end
	end, function(data, menu)
		menu.close()
	end)
end

function OpenVehicleSpawnerMenuPEDAGANG()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
		title    = _U('spawn_veh'),
		align    = 'bottom-right',
		elements = Config.AuthorizedVehicles
	}, function(data, menu)
		if not ESX.Game.IsSpawnPointClear(Config.Zones.VehicleSpawnPoint.Pos, 5.0) then
			ESX.ShowNotification('Tempat kendaraan terhalangi')
			return
		end

		menu.close()
		ESX.Game.SpawnVehicle(data.current.model, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
			local playerPed = PlayerPedId()
			local plate = 'PDG' .. math.random(1000, 99999)
			SetVehicleNumberPlateText(vehicle, plate)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		end)
	end, function(data, menu)
		CurrentAction     = 'vehicle_spawner'
		CurrentActionMsg  = _U('spawner_prompt')
		CurrentActionData = {}

		menu.close()
	end)
end

function DeleteJobVehiclePEDAGANG()
	local playerPed = PlayerPedId()

	if IsInAuthorizedVehiclePEDAGANG() then
		ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
	else
		ESX.ShowNotification('Khusus pedagang!!')
	end
end

function IsInAuthorizedVehiclePEDAGANG()
	local playerPed = PlayerPedId()
	local vehModel  = GetEntityModel(GetVehiclePedIsIn(playerPed, false))

	for i=1, #Config.AuthorizedVehicles, 1 do
		if vehModel == GetHashKey(Config.AuthorizedVehicles[i].model) then
			return true
		end
	end
	
	return false
end

AddEventHandler('esx_pedagangjob:hasEnteredMarker', function(zone)
	if zone == 'VehicleSpawner' then
		CurrentAction     = 'vehicle_spawner'
		CurrentActionMsg  = _U('spawner_prompt')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()
		local vehicle   = GetVehiclePedIsIn(playerPed, false)

		if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('store_veh')
			CurrentActionData = { vehicle = vehicle }
		end
	elseif zone == 'PedagangActions' then
		CurrentAction     = 'pedagang_actions_menu'
		CurrentActionMsg  = _U('press_to_open')
		CurrentActionData = {}

	elseif zone == 'Cloakroom' then
		CurrentAction     = 'cloakroom'
		CurrentActionMsg  = _U('cloakroom_prompt')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_pedagangjob:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

--Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(vector3( Config.Zones.PedagangActions.Pos.x, Config.Zones.PedagangActions.Pos.y, Config.Zones.PedagangActions.Pos.z))

	SetBlipSprite (blip, 628)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 9)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName('Cafe')
	EndTextCommandSetBlipName(blip)
end)

-- Enter / Exit marker events, and draw markers
Citizen.CreateThread(function()
	while true do
		local letSleep = 5000

		if ESX and ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name == 'pedagang' then
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker, currentZone = false
			letSleep = 1000

			for k,v in pairs(Config.Zones) do
				local distance = #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z))

				if v.Type ~= -1 and distance < Config.DrawDistance then
					letSleep = 0

					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, false, 2, v.Rotate, nil, nil, false)
				end

				if distance < v.Size.x then
					isInMarker, currentZone = true, k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker, LastZone = true, currentZone
				TriggerEvent('esx_pedagangjob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_pedagangjob:hasExitedMarker', LastZone)
			end
		end

		Citizen.Wait(letSleep)
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		local letSleep = 5000

		if ESX and ESX.PlayerData and ESX.PlayerData.job and ESX.PlayerData.job.name == 'pedagang' then
			letSleep = 1000
			if CurrentAction and not isDead then
				ESX.ShowHelpNotification(CurrentActionMsg)
				letSleep = 0
				if IsControlJustReleased(0, 38) then
					if CurrentAction == 'pedagang_actions_menu' then
						OpenPedagangAction()
					elseif CurrentAction == 'cloakroom' then
						OpenCloakroomPEDAGANG()
					elseif CurrentAction == 'vehicle_spawner' then
						OpenVehicleSpawnerMenuPEDAGANG()
					elseif CurrentAction == 'delete_vehicle' then
						DeleteJobVehiclePEDAGANG()
					end

					CurrentAction = nil
				end
			end
		end

		Citizen.Wait(letSleep)
	end
end)

--[[AddEventHandler('vinsan_jobs:OpenF6Menu', function()
	if not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'pedagang' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'pedagang') then
		OpenMobilePedagangActionsMenu()
	end
end) ]]